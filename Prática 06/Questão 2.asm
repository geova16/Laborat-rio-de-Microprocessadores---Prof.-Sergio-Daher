org 100h         

INICIO:
    mov AH,1       ;Funcionalidade de ler um carctere atraves do I/O do teclado
    int 21h        ;Chama a interrupcao que lera o caractere e armazena em AL
                
    add AL, 17     ;Soma 17 ao caractere (intervalo entre 0 e A na tabela ASCII)
               
    mov DL,AL      ;Copia o caractere lido de AL para DL a fim de ser impresso  
    
    mov AH, 2      ;Funcionalidade de imprimir caractere armazenado em DL
    int 21h        ;Chama a interrupcao para imprimir o caractere na tela 

JMP INICIO

END
