#start=thermometer.exe#

org 100h

jmp start    

quebra_lin db 0x0d, 0x0a, '$'
fa db ' ', 0xF8, 'F $'
ce db ' ', 0xF8, 'C $'

start: 
    in al, 125       ; le o valor do endereco i/o 125 (temperatura) 
    push ax 
    push ax       
    call print_decimal_3d
    
    lea dx, ce 
    mov ah, 9
    int 21h              ; imprime " c"
  
    pop ax 
    call converte   
    call print_decimal_3d 
    
    lea dx, fa 
    mov ah, 9
    int 21h              ; imprime " f"
    
    ;lea dx, quebra_lin 
    ;mov ah, 9
    ;int 21h              ; quebra de linha
    
    mov ah, 2
    
    mov dl, 0x0D
    
    int 21h
    
    pop ax
    cmp al, 22      ; compara a temperatura com 22
    jl low         ; se temperatura < 22, vai para "low"
    cmp al, 55      ; se 22 <= temperatura <= 55, continua
    jle ok    
    jg high       

low:      
    mov al, 1     
    out 127, al   ; liga o queimador (aumenta a temperatura)
    jmp ok        

high:    
    mov al, 0 
    out 127, al   ; desliga o queimador (diminui a temperatura)

ok: 
    jmp start 


print_decimal_3d:
    push ax
    push bx
    push cx
    push dx

    mov cx, 10         ; base 10
    mov bx, 0          ; contador de digitos armazenados

convert_loop:
    mov dx, 0          ; limpa dx antes da divisao
    div cx             ; ax / 10, resultado em ax, resto em dx
    add dl, '0'        ; converte numero para caractere ascii
    push dx            ; armazena o caractere na pilha
    inc bx             ; incrementa contador de digitos
    test ax, ax        ; verifica se ax e zero
    jnz convert_loop   ; se nao for zero, continua dividindo

print_loop:
    pop dx             ; recupera digito convertido
    mov ah, 02h
    int 21h            ; imprime caractere
    dec bx             ; decrementa contador de caracteres
    jnz print_loop     ; continua imprimindo ate esvaziar a pilha

    pop dx
    pop cx
    pop bx
    pop ax
    ret             


converte:
    push bx
    push cx
    push dx
    
    mov ah, 0      
    mov bx, 9      
    mul bx         ; ax = ax * 9
    
    mov bx, 5      
    div bx         ; ax = ax / 5
    
    add al, 32     ; ax = ax + 32
    
    pop dx
    pop cx
    pop bx
    ret    

