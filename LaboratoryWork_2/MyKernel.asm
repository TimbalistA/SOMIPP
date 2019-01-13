

ORG 7c00h     


; CONSTANTS

    NewLine equ 0ah, 0dh
    
    STUDENT_ID_REGISTER equ 14
    START_KERNEL_PROCESS equ (7c00h + 3 * 256 * STUDENT_ID_REGISTER)
    DEFINED_KERNEL_SECTOR equ (3 * STUDENT_ID_REGISTER)   
;

    
macro HEXADECIMAL argument{
	d = argument
	repeat 4
		tmp = ((d / 1000h) + 30h)
		if tmp>39h
			db (tmp+7)
		else
			db tmp
		end if
		d = (d * 10h) mod 10000h
	end repeat
}                    

org START_KERNEL_PROCESS

nop ;t0x90 intergriy check number
jmp GO
MSG db "Kernel was loaded into RAM to address "
HEXADECIMAL START_KERNEL_PROCESS
db "h", NewLine
				
db "Press '2' to start the kernel", NewLine
db 0

RETRY db "Try again", NewLine, 0

GO:
	
	

    axRegister equ 09EFh
  cxRegister equ 0CACh
  dxRegister equ 0DDECh
  bxRegister equ 0AACEh
  bpRegister equ 00EFAh
  siRegister equ 0F0C3h
  diRegister equ 000BCh

  newLine equ 0Dh, 0Ah

  zeroASCII equ "0"
  limitHexa equ 0Fh
  DecimalBS equ 10 


jmp start

STR1 DB "Vlad has done this!", 0
strlength equ $ - STR1          

STR2 db "V", 007h, "l", 007h, "a", 007h, "d", 007h, " ", 007h, "h", 007h, "a", 007h, "s", 007h, " ", 007h, "d", 007h, "o", 007h, "n", 007h, "e", 007h, " ", 007h, "t", 007h, "h", 007h, "i", 007h, "s", 007h, "!", 007h


start:
    

    push cs
	pop ds

    mov bx, MSG
	call Teletype_String_procedure
	get_character:
		mov ah, 0000h
		int 16h

	cmp al, "2"
	je get_character_equ_two
		mov bx, RETRY
		call Teletype_String_procedure
		jmp get_character
	get_character_equ_two:
	







   
   
mov dh, 2
mov dl, 10
mov bh, 0
mov ah, 2
int 10h       
   
mov cx, strlength          ; int 10h 0eh
mov di, 0
mov ah, 0eh
   
Test1Case1:
    mov al, [STR1 + di]
    int 10h
    inc di
loop Test1Case1  

;
;

mov ah, 2  
add dh, 2
mov dl, 10
int 10h

mov ah, 0EH                ; int 10h 0eh 
mov di, 0
Test1Case2:
    mov al, [STR1 + di]
    cmp al, 0
    JE Test1Case2end
    int 10h
    inc di
jmp Test1Case2
Test1Case2end:

;
;
;
;            
;           
;            
;            
;            
;            
;           

mov cx, strlength
mov di, 0


mov ah, 2  
add dh, 2
mov dl, 10
int 10h

Test2Case1:                ; int 10h 0ah
    
    mov ah, 2  
    int 10h
    inc dl
    
    push cx    
    mov cx, 1
    mov al, [STR1 + di] 
    mov ah, 0ah
    int 10h
    
    inc di    
    
    pop cx
    ;mov cx, di
loop Test2Case1  

;
;

mov ah, 2
mov dl, 10  
add dh, 2
int 10h


mov ah, 0eh                ; int 10h 0ah
mov di, 0

Test2Case2:
    mov al, [STR1 + di]
    cmp al, 0
    JE Test2Case2end
    int 10h
    inc di
jmp Test2Case2
Test2Case2end:

;
;
;
;
;
;
;
;
;
;

mov cx, strlength

mov ah, 2  
add dh, 2
mov dl, 10
int 10h 
mov di, 0

Test3Case1:                ; int 10h 09h
    
    mov ah, 2  
    int 10h
    inc dl
    
    push cx    
    mov cx, 1
    mov al, [STR1 + di] 
    mov bl, 0111b 
    mov ah, 09h
    int 10h
    
    inc di    
    
    pop cx
    ;mov cx, di
loop Test3Case1
 
;
;   
    
    mov ah, 2
    mov dl, 10 
    add dh, 2
    int 10h
    
    mov di, 0 
    mov cx, 1 
    
Test3Case2:                  ; int 10h 09h
	mov al,  [STR1 + di]

	cmp al, 0
	je Test3Case2end

	mov ah, 09h
	int 10h
        
	inc di
	inc dl
	mov ah, 2
	int 10h   
	
	jmp Test3Case2
Test3Case2end:
	
;
;
;
;
;
;
;
;
;
;   
   
    mov al, 1                   ; int 10h 13h
	mov bh, 0
	mov bl, 0111b
	mov cx, TMPend - TMP ; calculate message size. 
	mov dl, 10
	add dh, 2
	push cs
	pop es
	mov bp, TMP
	mov ah, 13h
	int 10h
	jmp TMPend
	TMP db "Vlad has done this!"
	TMPend:

;
;
;
;
;
;
;
;
;
;


    add dh, 2                  ; int 10h 1302h
    mov dl, 10
	mov bp, STR2
	mov ax, 1302h
	int 10h

;
;
;
;
;
;
;
;
;
;

	add dh, 2                 ; int 10h 1303h
	mov al, 10
	mov bp, STR2
	mov ax, 1303h
	int 10h

;
;
;
;
;
;
;
;
;


    add dh, 2
    mov dl, 10
    mov bh, 0
    mov ah, 2
    int 10h 

    mov cx, 0
    mov di, 0

    mov al, 0      
    mov ah, 0eh
start_loop:
    int 10h

    call InFormOfTable
 
    inc al

    cmp al, 0
    jne start_loop
end_loop:
    

 
 
 
 add dh, 2
    mov dl, 10
    mov bh, 0
    mov ah, 2       
    mov ax, 1003h ; int 10 03h
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

 
 

STOP:
	mov ah, 0000h
	int 16h
	jmp STOP



    
	    
ret       

str_ShowRegisters db "AX:0000h", newLine, "CX:0000h", newLine, "DX:0000h", newLine, "BX:0000h", newLine, "SP:0000h", newLine, "BP:0000h", newLine, "SI:0000h", newLine, "DI:0000h"
str_ShowRegisters_end: 


Teletype_String_procedure: ;bx already points to string that should be displayed
    mov ah, 0eh
    xor di, di  ; 0
    traverse_string:
        mov al, [bx + di] ; di is the index of the character      
        cmp al, 0 ; al once will be zero, because each string for this procedure will be NULL-terminated
        je traverse_string_end
        int 10h ;displaying the actual character
        inc di  ; if everything OK, the index is incremented
        jmp traverse_string
    traverse_string_end:
ret


DefineAl:
    mov al, dl
	and al, limitHexa
	add al, zeroASCII
ret

DoLetterProcedure:
    cmp al, "9"
	jl is_letter	
	add al, 7
	is_letter:
ret

WriteInTheRegisterProcedure:
   shr dx, 4
   mov [ds:bx + di + str_ShowRegisters], al
   dec di
ret

FinalProcedure:
    mov bh, 0
	mov bl, 0F0h
	mov dx, 0
	push cs
	pop es
	mov bp, str_ShowRegisters
	mov cx, str_ShowRegisters_end - str_ShowRegisters
	mov ax, 1301h
	int 10h
ret

PrintRegistersProcedure:
	pusha
    mov cx, 8
	mov bx, (str_ShowRegisters_end - str_ShowRegisters - 5)
	POP_loop:
		pop dx
		mov di, 3
		hex_loop:
			
			call DefineAl
			
			call DoLetterProcedure

			call WriteInTheRegisterProcedure
			
		jns hex_loop ; (SF=0)

		sub bx, DecimalBS
	loop POP_loop

	call FinalProcedure
ret


InFormOfTable:
   push ax
    mov al, 32
    int 10h
    int 10h
    int 10h
    pop ax
ret 
   
