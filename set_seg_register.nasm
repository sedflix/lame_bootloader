;; ax containes the values to be repeated
set_seg_register:
    mov ds, ax                    
    mov fs, ax
    mov gs, ax
    mov ss, ax
    ret