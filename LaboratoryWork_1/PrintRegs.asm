

ORG 7c00h    
    
 axRegister equ 071Fh
 cxRegister equ 0CAEh
 dxRegister equ 0DD5Ch
 bxRegister equ 0AACAh
 bpRegister equ 00EEAh
 siRegister equ 0FFC3h
 diRegister equ 000B5h

    NEXT equ 0Dh, 0Ah

    ZERO equ "0"
    magicConst equ 0Fh
    
    	
	mov ax, 1003h
	mov bx, 0
	int 10h

	mov ax, axRegister
	mov cx, cxRegister
	mov dx, dxRegister
	mov bx, bxRegister
	mov bp, bpRegister
    mov si, siRegister
	mov di, diRegister
	
    call PrintRegistersProcedure
	    
ret

DefineAl:
    mov al, dl
	and al, magicConst
	add al, ZERO
ret

DoLetterProcedure:
    cmp al, "9"
	jl is_letter	
	add al, 7
	is_letter:
ret

WriteInTheRegisterProcedure:
   shr dx, 4
   mov [ds:bx + di + str_Regs], al
   dec di
ret

FinalProcedure:
    mov bh, 0
	mov bl, 0F0h
	mov dx, 0
	push cs
	pop es
	mov bp, str_Regs
	mov cx, str_Regs_end - str_Regs
	mov ax, 1301h
	int 10h
ret

PrintRegistersProcedure:
	pusha
    mov cx, 8
	mov bx, (str_Regs_end - str_Regs - 5)
	POP_loop:
		pop dx
		mov di, 3
		hex_loop:
			
			call DefineAl
			
			call DoLetterProcedure

			call WriteInTheRegisterProcedure
			
		jns hex_loop ; (SF=0)

		sub bx, 10
	loop POP_loop

	call FinalProcedure
ret

str_Regs db "AX:0000h", NEXT, "CX:0000h", NEXT, "DX:0000h", NEXT, "BX:0000h", NEXT, "SP:0000h", NEXT, "BP:0000h", NEXT, "SI:0000h", NEXT, "DI:0000h"
str_Regs_end: