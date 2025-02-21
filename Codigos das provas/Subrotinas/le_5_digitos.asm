org 100h

jmp start

num db 0,0,0,0,0


le_5_digitos: 

    ; le 5 digitos no teclado e armazena am ax
    
    push bx
    push cx
    push dx
    mov ax, 0    

    start:
        lea si, num
        mov cx, 5
    le_looping: 
        mov ah, 1
        int 21h 
        sub al, 48
        mov [si], al 
        inc si
    loop le_looping
    
    multiplica:  
        dec si
        mov dx, 0
        mov bx, 1
        mov di, 0
        mov cx, 5 
    rotina:
        mov al, [si]
        mov ah, 0
        mul bx
        add di, ax
        mov ax, 10
        mul bx
        mov bx, ax
        dec si
        loop rotina   
        mov ax, di 
        
        pop dx
        pop cx
        pop bx
        
        ret
