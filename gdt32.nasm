; Setting up GDT for 32 BIT MODE
GDT32:

    .Null: equ $ - GDT32
        dd 0x0, 0x0

    .Code: equ $ - GDT32
        dw 0xffff, 0x0      
        db 0x0, 10011010b, 11001111b, 0x0

    .Data: equ $ - GDT32
        dw 0xffff, 0x0
        db 0x0, 10010010b, 11001111b, 0x0

    .Pointer:                    
        dw $ - GDT32 - 1             
        dd GDT32         