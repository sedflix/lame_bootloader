[bits 32]

print32:

    pusha
    mov edx, edi
    mov ah, 0x0f

    print32_loop:
        mov al, [ebx]

        cmp al, 0
        je doneee

        mov [edx], ax
        add ebx, 1
        add edx, 2

        jmp print32_loop

    doneee:
        popa
        ret
        
