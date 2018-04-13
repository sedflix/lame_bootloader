org 0x7c00 ; BIOS boot origin 
; TODO: See where to disable to interrupts
; TODO: See where to do things with A10
main:

    ; SETTING UP STACK
    mov bp, 0x9000
    mov sp, bp

    ; PRINTING in 16 BIT MODE
    ; mov bx, MSG_1
    ; call print16

    call switch_to_pm

[ BITS 16 ]
%include "print16.nasm"
%include "gdt32.nasm"


switch_to_pm:
    
    cli

    ;==============================================================================
    ;PREPARING TO ENTER PROTECTED MODE 

    ; Loading DT for 32 bit
    lgdt [GDT32.Pointer] 

    ; Changing CR0 bit to represent the shift to protected mode
    mov eax, cr0
    or eax, 0x1 ;
    mov cr0, eax

    ;==============================================================================
    ;ENTERS PROTECTED MODE 

    jmp GDT32.Code:ProtectedModeCode


[ BITS 32 ]
%include "print32.nasm"
%include "gdt64.nasm"
%include "set_seg_register.nasm"
%include "paging.nasm"

ProtectedModeCode:

    ; Setting up all the segment value for protected mode
    mov ax, GDT32.Data
    call set_seg_register

    ; Printing in Protected Mode
    mov edi, 0xb8000
    mov ebx, MSG_2
    call print32

    jmp switch_to_long_mode


    ;==============================================================================
    ;PREPARING TO ENTER LONG MODE 

switch_to_long_mode:

    call setup_paging               ; Sets up Paging        

    lgdt [GDT64.Pointer]            ;Loads 64 bit GDT table

    ;==============================================================================
    ;ENTERS LONG MODE 

    jmp GDT64.Code:RealModeCode; Jumps to 64 bit code


[ BITS 64 ]
%include "print64.nasm"
%include "print_register.nasm"


RealModeCode:

    ; Setting up all the segment value                     
    mov ax, GDT64.Data
    call set_seg_register          


    ; CLEARS SCREEN
    ; PRINTS "I'm in Long Mode"
    mov rbx, 0xb8000
    mov rsi, MSG_3
    mov r10, 2000
    call print64

    ; PRINTING THE CONTENT OF REGISTER cr3
    mov rbx, 0xb8500 ; Starting printing postion in Video Buffer
    call print_register
    
    hlt


MSG_2 db "In protected mode",0
MSG_1 db "In real", 0
MSG_3 db "I'm in the long mode"

times 510 - ($-$$) db 0 
dw 0xaa55