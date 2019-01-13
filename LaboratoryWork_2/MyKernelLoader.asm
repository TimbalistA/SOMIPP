

ORG 7c00h

; CONSTANTS

    NewLine equ 0ah, 0dh
    
    STUDENT_ID_REGISTER equ 14
    START_KERNEL_PROCESS equ (7c00h + 3 * 256 * STUDENT_ID_REGISTER)
    DEFINED_KERNEL_SECTOR equ (3 * STUDENT_ID_REGISTER)   
;  
;
jmp start                               

MSG db "BootLoader developed by student Ganusceac Vlad", NewLine
    db "Press '1' to start loading the kernel to RAM",NewLine, 0
    
RETRY db "Try again", NewLine, 0         

ConnectionError db "Intergrity check failed", NewLine, 0


start:

    mov bx, MSG
    call Teletype_String_procedure

    get_character:
        mov ah, 00h
        int 16h

    cmp al, '1'
    je get_character_equ_one
        mov bx, RETRY
        call Teletype_String_procedure
        jmp get_character
    get_character_equ_one:

    mov ax, 07c0h
    mov ss, ax
    mov sp, 03feh

    xor ax, ax ; 0
    mov ds, ax ; 0

    mov ax, 0003h
    ; 80x25 video mode 
    int 10h 

    ; 
    mov ah, 02h
    mov al, 10  ; read function & sectors to be read.
    mov ch, ((DEFINED_KERNEL_SECTOR - 1) / 36)  ; CYLINDER SECTOR

if (DEFINED_KERNEL_SECTOR mod 18)=0
    mov cl, 18
else
    mov cl, (DEFINED_KERNEL_SECTOR mod 18)
end if
    mov dh, ((DEFINED_KERNEL_SECTOR - 1) / 18) mod 2 ; HEAD SECTOR 

    mov bx, 0800h
    mov es, bx
    mov bx, START_KERNEL_PROCESS

    int 13h

    cmp byte [es:START_KERNEL_PROCESS], 090h  ; nop (0x90) is the first byte of kernel
    je integrity_check_ok
        mov bx, ConnectionError
        call Teletype_String_procedure
    integrity_check_ok:
    jmp 0800h:START_KERNEL_PROCESS
ret

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