[bits 64]

COLOR equ 0x01

print64:

    pusha
    mov rdx, rdi
    mov ah, COLOR

    print64_loop:
        mov al, [rbx]

        cmp al, 0
        je doneee64

        mov [rdx], ax
        add rbx, 1
        add rdx, 2

        jmp print64_loop

    doneee64:
        popa
        ret
        
