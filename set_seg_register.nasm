; ax containes the values to be repeated in all other segment register
set_seg_register:
    mov ds, ax                    
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ret