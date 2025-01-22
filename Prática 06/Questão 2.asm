org 100h         

mov AH,1       ;funcionalidade de ler um carctere atraves do I/O do teclado
int 21h        ;chama a interrupcao que lera o caractere e armazena em AL
            
add AL, 17     ;Soma 17 ao caractere (intervalo entre 0 e A na tabela ASCII)
           
mov DL,AL      ;copia o caractere lido de AL para DL a fim de ser impresso  

mov AH, 2      ;Funcionalidade de imprimir caractere armazenado em DL
int 21h        ;Chama a interrupcao para imprimir o caractere na tela 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h    

mov AH, 1
int 21h
add AL, 17
mov DL, AL
mov AH, 2
int 21h 

mov AH, 0
int 16h
ret
