org 100h
jmp start

vec1 db 9, 9, 9, 9       ; Vetor 1
vec2 db 9, 9, 9, 9       ; Vetor 2

resultado dw 0h

label1 db "Vetor 1 = [ $"
label2 db "Vetor 2 = [ $"
label3 db "Produto = $"
label4 db " ]$"
label5 db ", $" 
quebra_lin db 0x0D, 0x0A, '$'   ; Quebra de linha

start:
    lea si, vec1          ; Carrega o endereço base de vec1
    lea bp, vec2          ; Carrega o endereço base de vec2
    
    mov cx, 4             ; Loop para 4 elementos

produto:
    mov al, [si]          ; Carrega um byte de vec1
    mov bl, [bp]          ; Carrega 1 byte de vec1
    mul bl
             
              
    add [resultado], ax          
    
    mov [di], al          ; Armazena a soma em vec3
    inc si                ; Avança para o próximo elemento de vec1
    inc bp                ; Avança para o próximo elemento de vec2
    
loop produto                  ; Repetir até CX = 0


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

    ; Imprime Produto
    lea dx, label3
    mov ah, 9
    int 21h  
    
    mov ax, 0
    
    mov dx, 0
    
    mov ax, [resultado]
    
    call imprime_3d

 

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
    push dx               ; Salva DX

    and al, 0Fh           ; Mantém apenas os 4 bits menos significativos
    cmp al, 9
    jg hex_conversion
    add al, 48            ; Converte 0-9 para ASCII ('0' = 48)
    jmp print_char

hex_conversion:
    add al, ('A' - 10)    ; Converte 10-15 para 'A'-'F'

print_char:
    mov ah, 2             ; Configura a função 2 do DOS (saída de caractere)
    mov dl, al            ; Move o caractere ASCII para DL
    int 21h               ; Exibe o caractere

    pop dx                ; Restaura DX
    ret


imprime_3d:


    mov BX, 100
    
    div BX        ; Divide AX por 100 - separar a centena
    
    mov BX, AX    ; Centena para BX
    
    mov CX, DX    ; Dezena e unidade para CL 
    
    push CX       ; Guarda dezena e unidade na pilha
    
    
    
    mov AH, 2     ; Funcionalidade da interrupcao 
    
    mov DL, AL
    
    add DL, 48    ; Converte a centena para ASCII
    
    int 21h       ; Imprime a centena  
    
    
    pop CX        ; Recupera dezena e unidade da pilha
    
    mov AX, CX    ; Move dez e unid para AX
    
    
    mov DL, 10     
    
    mov AH, 0
    
    div DL        ; Divide AX por 10 - separa a dezena
    
    mov DL, AL    ; Dezena para AL
    
    mov CL, AH    ; Unidade para CL
    
    mov AH, 2     ; Funcionalidade da interrupcao
    
    add DL, 48    ; Converte a dezena para ASCII
    
    int 21h       ; Imprime a dezena
    
    
    add CL, 48    ; Converte a unidade para ASCII
    
    mov DL, CL    ; Imprime a unidade
    
    int 21h
    
    ret
