; RESOURCES: https://wiki.osdev.org/Setting_Up_Long_Mode#Setting_up_the_Paging

setup_paging:
    
    mov edi, 0x3000    ; Set the destination index to 0x1000.
    mov cr3, edi       ; Set control register 3 to the destination index.
    xor eax, eax       ; Nullify the A-register.
    
    ; x86 uses a page size of 4096 bytes
    mov ecx, 4096      ; Set the C-register to 4096.
    rep stosd          ; Clear the memory.
    mov edi, cr3       ; Set the destination index to control register 3.

    mov DWORD [edi], 0x4003      ; Set the uint32_t at the destination index to 0x2003.
    add edi, 0x1000              ; Add 0x1000 to the destination index.
    mov DWORD [edi], 0x5003      ; Set the uint32_t at the destination index to 0x3003.
    add edi, 0x1000              ; Add 0x1000 to the destination index.
    mov DWORD [edi], 0x6003      ; Set the uint32_t at the destination index to 0x4003.
    add edi, 0x1000              ; Add 0x1000 to the destination index.

    mov ebx, 0x00000003          ; Set the B-register to 0x00000003.

    ; Each table contains 512 entries
    ; Each entry is of 8 bytes
    ; 512 * 8 = 4096 bytes (the size of page table)
    mov ecx, 512                 ; Set the C-register to 512.
 
    .SetEntry:
        mov DWORD [edi], ebx         ; Set the uint32_t at the destination index to the B-register.
        add ebx, 0x1000              ; Add 0x1000 to the B-register.
        add edi, 8                   ; Add eight to the destination index.
        loop .SetEntry               ; Set the next entry.

;     section .bss
;         align 4096
;         p4_table:
;             resb 4096
;         p3_table:
;             resb 4096
;         p2_table:
;             resb 4096
;         stack_bottom:
;             resb 64
;         stack_top:

; set_up_page_tables:
;     ; map first P4 entry to P3 table
;     mov eax, p3_table
;     or eax, 0b11 ; present + writable
;     mov [p4_table], eax

;     ; map first P3 entry to P2 table
;     mov eax, p2_table
;     or eax, 0b11 ; present + writable
;     mov [p3_table], eax
;      ; TODO map each P2 entry to a huge 2MiB page
;     ; map each P2 entry to a huge 2MiB page
;     mov ecx, 0         ; counter variable

; .map_p2_table:
;     ; map ecx-th P2 entry to a huge page that starts at address 2MiB*ecx
;     mov eax, 0x200000  ; 2MiB
;     mul ecx            ; start address of ecx-th page
;     or eax, 0b10000011 ; present + writable + huge
;     mov [p2_table + ecx * 8], eax ; map ecx-th entry

;     inc ecx            ; increase counter
;     cmp ecx, 512       ; if counter == 512, the whole P2 table is mapped
;     jne .map_p2_table  ; else map the next entry

;     ; map first P4 entry to P3 table
;     mov eax, p3_table
;     or eax, 0b11 ; present + writable
;     mov [p4_table], eax

;     ; map first P3 entry to P2 table
;     mov eax, p2_table
;     or eax, 0b11 ; present + writable
;     mov [p3_table], eax


;     mov eax, p4_table
;     mov cr3, eax

    mov eax, cr4                 ; Set the A-register to control register 4.
    or eax, 1 << 5               ; Set the PAE-bit, which is the 6th bit (bit 5).
    mov cr4, eax                 ; Set control register 4 to the A-register.

    mov ecx, 0xC0000080          ; Set the C-register to 0xC0000080, which is the EFER MSR.
    rdmsr                        ; Read from the model-specific register.
    or eax, 1 << 8               ; Set the LM-bit which is the 9th bit (bit 8).
    wrmsr   

    mov eax, cr0                 ; Set the A-register to control register 0.
    or eax, 1 << 31              ; Set the PG-bit, which is the 32nd bit (bit 31).
    mov cr0, eax                 ; Set control register 0 to the A-register.

    ret