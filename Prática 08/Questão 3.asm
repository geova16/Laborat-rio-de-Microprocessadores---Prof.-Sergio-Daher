org 100h
jmp start

vec1 db 9, 2, 5, 6       ; Vetor 1
vec2 db 9, 9, 3, 1       ; Vetor 2
vec3 db ?, ?, ?, ?       ; Vetor onde será armazenada a soma

label1 db "Vetor 1 = [ $"
label2 db "Vetor 2 = [ $"
label3 db "Soma = [ $"
label4 db " ]$"
label5 db ", $"
quebra_lin db 0x0D, 0x0A, '$'   ; Quebra de linha

start:
    lea si, vec1          ; Carrega o endereço base de vec1
    lea bx, vec2          ; Carrega o endereço base de vec2
    lea di, vec3          ; Carrega o endereço base de vec3
    mov cx, 4             ; Loop para 4 elementos

sum:
    mov al, [si]          ; Carrega um byte de vec1
    add al, [bx]          ; Soma com o correspondente em vec2
    mov [di], al          ; Armazena a soma em vec3
    inc si                ; Avança para o próximo elemento de vec1
    inc bx                ; Avança para o próximo elemento de vec2
    inc di                ; Avança para o próximo elemento de vec3
loop sum                  ; Repetir até CX = 0


principal:
    ; Imprime Vetor 1
    lea dx, label1
    mov ah, 9
    int 21h

    lea si, vec1
    mov cx, 4
    call imprime_vet

    lea dx, label4
    mov ah, 9
    int 21h

    lea dx, quebra_lin
    mov ah, 9
    int 21h

    ; Imprime Vetor 2
    lea dx, label2
    mov ah, 9
    int 21h

    lea si, vec2
    mov cx, 4
    call imprime_vet

    lea dx, label4
    mov ah, 9
    int 21h

    lea dx, quebra_lin
    mov ah, 9
    int 21h

    ; Imprime Soma
    lea dx, label3
    mov ah, 9
    int 21h

    lea si, vec3
    mov cx, 4
    call imprime_vet

    lea dx, label4
    mov ah, 9
    int 21h

    lea dx, quebra_lin
    mov ah, 9
    int 21h

.EXIT  


imprime_vet:
    
    mov al, [si]          ; Carrega o byte atual de vec1, vec2 ou vec3
    
    call converte_e_imprime

    inc si                ; Avança para o próximo elemento

    lea dx, label5        ; Imprime ", "
    
    mov ah, 9
    
    int 21h

loop imprime_vet           ; Decrementa CX e repete se ainda houver elementos
ret


converte_e_imprime:

    cmp al, 9
    
    jg imprime_2d 
    
    add al, 48            ; Converte 0-9 para ASCII ('0' = 48)
    
    mov dl, al
    
    mov ah, 2
    
    int 21h 
    
    ret

imprime_2d: 

    mov ah, 0
    
    ;sub al,48 
    
    mov dl,10  
    
    div dl   
    
    mov dl,al 
    
    push ax
    
    mov ah,2 
    
    add dl,48 
    
    int 21h  
    
    pop ax
    
    mov dl,ah 
    
    add dl,48 
    
    mov ah, 2
    
    int 21h 
     
     
    ret
