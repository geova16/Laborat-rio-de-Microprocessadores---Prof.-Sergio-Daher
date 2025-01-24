org 100h
 
ini:
 
; Lê o primeiro número
mov AH, 1          ; Configura a função de leitura de caractere (int 21h, AH=1)
int 21h            ; Lê o caractere digitado do teclado
sub AL, 48         ; Converte o caractere ASCII para um número decimal (0 a 9)
mov BL, AL         ; Armazena o primeiro número em BL

; Lê o segundo número
mov AH, 1          ; Configura a função de leitura de caractere novamente
int 21h            ; Lê o segundo caractere digitado
sub AL, 48         ; Converte o segundo caractere ASCII para um número decimal
mov BH, AL         ; Armazena o segundo número em BH

; Calcula a soma dos dois números
add BL, BH         ; Soma os valores armazenados em BL e BH
mov AL, BL         ; Move o resultado da soma para AL

; Converte o resultado para ASCII
add AL, 48         ; Converte o número decimal em caractere ASCII 

mov CL, AL

; Exibe o resultado
mov AH, 2          ; Configura a função de exibição de caractere (int 21h, AH=2)

mov DL, '='        
int 21h            ; Exibe o caractere na tela
mov DL, ' '        
int 21h            ; Exibe o caractere na tela

mov DL, CL
int 21h


mov DL, ' '
mov AH, 2  
int 21h

jmp ini

; Fim do programa
ret
