print16:
    pusha 
    
    mov ah, 0x0e

    print_loop:
        mov al, [bx] 
        
        cmp al, 0  ; loop til al == 0; then ends. 
        je return_back

        int 0x10 ; if al != 0; then print
        
        add bx, 1 ; i++
        jmp print_loop

    return_back:
        ; printing '\n'
        
        mov al, 0x0a 
        int 0x10
        mov al, 0x0d 
        int 0x10

        
        popa
        ret