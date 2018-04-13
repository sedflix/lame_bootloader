; Printing in 64 Bit Mode
; RSI - INPUT
; r10 - number of values
; RBX - Starting position in the video frame
print64:
    mov r9, 1 ; Counter set to one

    print64_loop:
        lodsb
        or al,al
        cmp r9, r10
        je doneee64

        or rax,0x0f00
        mov qword [rbx], rax
        
        add rbx,2 ; Video Buffer Counter Update
        add r9, 1 ; Print Counter Update
        jmp print64_loop

    doneee64:
        ret
        
