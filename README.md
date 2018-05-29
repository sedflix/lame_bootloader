Name: Siddharth Yadav
Roll Number: 2016268

## Usage 

```
nasm -f bin boot.nasm & qemu-system-x86_64 boot
```
This will open a window with the following things printed in it:
- I'm in the long mode
- Value of CR3 register

## Implementation

I've tried my best to make the code modular as possible. 
- print16.nasm: Printing in Real Mode 
- print32.nasm: Printing in Protected Mode
- print64.nasm: Printing in Long Mode 
- print_register.nasm: Print value of 64 bit register in binary
- gdt32.nasm: contains lame gdt for for protected mode
- gdt64.nasm: contains lame gdt for for long mode
- paging.nasm:setups paging and enable paging and also enables 64 bit mode

`boot.nasm` is the main file. It is will commented to show the order in which things happens.  