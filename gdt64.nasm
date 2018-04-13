; GDT for 64 BIT MODE
; Reference: https://wiki.osdev.org/Setting_Up_Long_Mode#Entering_the_64-bit_Submode
GDT64: 

    .Null: equ $ - GDT64 
        ; ; NULL Descriptor         
        ; dw 0xFFFF, 0
        ; ; Limit, Base - low                    
        ; db 0, 0, 1, 0
        ; ; Base - middle, Access, Granularity, Base - 
        dq 0 

    .Code: equ $ - GDT64
        ; dw 0, 0
        ; ; Limit, Base - low      
        ; db 0, 10011010b, 10101111b, 0
        ; ; Base - middle, Access(X/R),(Granularity |flag for 64 bit | limit 19 - 16), Base - high
        dq (1<<43) | (1<<44) | (1<<47) | (1<<53) ; code segment

    .Data: equ $ - GDT64
        dw 0,0
        ; Limit, Base - low                      
        db 0, 10010010b, 00000000b, 0       
        ; Base - middle, Access(R/W),Granularity, Base - high  

    .Pointer:
        dw $ - GDT64 - 1
        ; Limit
        dq GDT64
        ; Base