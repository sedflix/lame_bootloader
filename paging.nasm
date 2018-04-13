; RESOURCES: https://wiki.osdev.org/Setting_Up_Long_Mode#Setting_up_the_Paging

setup_paging:
    
    ; PML4T
    mov edi, 0x3000
    ; Base addres of top page table set to 0x3000
    mov cr3, edi


    xor eax, eax
    ; set eax to 0
    
    ; x86 uses a page size of 4096 bytes
    ; Each table contains 512 entries
    ; Each entry is of 8 bytes
    ; 512 * 8 = 4096 bytes (the size of page table)
    mov ecx, 4096 
    rep stosd           
    ; Clear the memory.
    mov eax, cr3

    ; DECLARING LAME PAGE TABLE AND CONNECTIONs
    ;  PML4T[0] -> PDPT[0] -> PDT[0] 00x4000-> PT[0] -> 2 MiB
    ;  0x3000 -> PML4T[0] -> 0x4003 
    ;  0x4000 -> PDT[0] -> 0x5003


    ; PDPT
    mov dword [eax], 0x4000 | 3  ; 2nd top level page table base address
    add eax, 4096  
    
    ; PDT           
    mov dword [eax], 0x5000 | 3   ; 3rd top level page table base address
    add eax, 4096   

    ; PT
    mov dword [eax], 0x6000 | 3     ; page table base address
    add eax, 4096             

    ; first page
    mov ebx, 0x00000003          ; Set the B-register to 0x00000003.

    mov ecx, 512
 
    ; Initialise Pages for first 2MiB
    ; At present eax points to base address of PT.
    SetPageEntry:
        mov dword [eax], ebx                   
        add eax, 8      ; each page entry is of 8 bytes
        add ebx, 0x1000  
        loop SetPageEntry             


    mov ecx, 0xC0000080          
    rdmsr
    ; Read MSR specified by ECX into EDX:EAX.                   
    or eax, 1 << 8               
    wrmsr   

    ; Will set PAE bit (which the bit 5) in CR4
    mov edi, cr4                
    or edi, 1 << 5               
    mov cr4, edi    

    ; Eanble PG-bit in CR0 which is the 31 bit
    mov edi, cr0              
    or edi, 1 << 31             
    mov cr0, edi

    ret