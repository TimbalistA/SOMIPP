;include 'MACRO\PROC32.INC'

ORG 7c00h

jmp start

STR1 DB "Timbalist Ana", 0
strlength equ $ - STR1          

STR2 db "T", 007h, "i", 007h, "m", 007h, "b", 007h, "a", 007h, "l", 007h, "i", 007h, "s", 007h, "t", 007h, " ", 007h, "A", 007h, "n", 007h, "a", 007h


start:
   
call NextCursorPosition      
   
call FirstMethod

call NextCursorPosition

call SecondMethod

call NextCursorPosition

call ThirdMethod   

call NextCursorPosition  

call FourthMethod  

call NextCursorPosition

call FithMethod

call NextCursorPosition

call SixthMethod 
  
call NextCursorPosition
    
call SeventhMethod

call NextCursorPosition
	
call EigthMethod

ret  


NextCursorPosition:
    add dh, 2
    mov dl, 10
    mov bh, 0
    mov ah, 2
    int 10h            
ret       

FirstMethod:
    mov cx, strlength         
    mov di, 0
    mov ah, 0eh
   
    Test1Case1:
        mov al, [STR1 + di]
        int 10h
        inc di
    loop Test1Case1
ret    

SecondMethod:
    mov ah, 0EH 
    mov di, 0
    Test1Case2:
        mov al, [STR1 + di]
        cmp al, 0
        JE Test1Case2end
        int 10h
        inc di
    jmp Test1Case2
    Test1Case2end:
ret

ThirdMethod:
    mov cx, strlength
    mov di, 0
    Test2Case1:
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
    loop Test2Case1
ret        
           
FourthMethod:
    mov ah, 0eh
    mov di, 0
    
    Test2Case2:
        mov al, [STR1 + di]
        cmp al, 0
        JE Test2Case2end
        int 10h
        inc di
    jmp Test2Case2
    Test2Case2end:;
ret

FithMethod:
    mov cx, strlength
    mov di, 0

    Test3Case1:
    
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
    loop Test3Case1
ret       

SixthMethod:
    mov al, 1
	mov bh, 0
	mov bl, 0111b
	mov cx, TMPend - offset TMP
	
	push cs
	pop es
	mov bp, offset TMP
	mov ah, 13h
	int 10h
	jmp TMPend
	TMP db "Timbalist Ana"
	TMPend:                
ret        
 
SeventhMethod:
    mov bp, offset STR2
	mov ax, 1302h
	int 10h
ret

EigthMethod:
    mov bp, offset STR2
	mov ax, 1303h
	int 10h          
ret              



