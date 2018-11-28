ORG 7c00h

mov dl, 10
mov bh, 0
mov ah, 2
int 10h 

xor cx, cx
xor di, di

xor al, al      
mov ah, 0eh

cmp al, 0
je start_traversing

CariageReturnDoNotPrint:
    inc al
start_traversing:

    int 10h

    call TableForm
 
    inc al
    
    cmp al, 13
    je CariageReturnDoNotPrint
    
    cmp al, 0
    jne start_traversing

end_traversing:

ret

TableForm:
    push ax
    mov al, 32 ; printing space character 3 times... 80 % 4 = 0 -> Table Form
    int 10h
    int 10h
    int 10h
    pop ax
ret