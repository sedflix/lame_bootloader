; It prints the value of R9 REGISTER in Long Mode
; RBX: Position to print the content of CR3
; R9 contains the value.

print_register:

	mov rcx, 63 ; number of bits

	printing_loop:
		mov rax, r9
		cmp rcx, 0
		je end_print_register

		mov rdx, 0
		for:
			; right shift cr3 `rcx times`. 
			; aim: to print cr3 register value in proper order 63rd, 62nd..
			; endian stuffs :(
			cmp rdx, rcx:
			je end_for
			
			shr rax, 1
			add rdx, 1
			
			jmp for
		end_for:
		
		; extracting just one last bit aftering shifting
		and rax, 1

		; "0" if 0, "1" if 1 :: Number -> String
		cmp rax, 0
		je .if_true
			mov rax, 0x31
			jmp .end_if 
		.if_true:
			mov rax, 0x30 
		.end_if:

		; PRINTING "0" or "1"
		; SET COLOR HERE
		or rax, 0x0400
		mov [rbx], rax

		add rbx, 2 ; Video buffer counter
		sub rcx, 1 ; number of bits counter
		jmp printing_loop

end_print_register:
	ret

