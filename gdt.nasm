gdt_start:
    dd 0x0, 0x0

gdt_code_seg: 
    dw 0xffff    
    dw 0x0      
    db 0x0       
    db 10011010b 
    db 11001111b 
    db 0x0

gdt_data_seg:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0
gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

SEG_CODE equ gdt_code_seg - gdt_start
SEG_DATA equ gdt_data_seg - gdt_start