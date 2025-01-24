org 100h        ; Define a origem do programa para a execução no endereço 100h,
                 ; padrão para programas .COM no DOS.

; Início do programa
mov AH, 2        ; Define a função 2 do interrupt 21h, que exibe um caractere na tela.
mov DL, 'O'      ; Carrega o caractere 'O' no registrador DL, que será exibido.
int 21h          ; Chama o interrupt 21h para executar a função definida (mostrar o caractere).

mov DL, 'I'      ; Carrega o caractere 'I' no registrador DL.
int 21h          ; Exibe o caractere 'I' na tela.

mov DL, ','      ; Carrega o caractere ',' no registrador DL.
int 21h          ; Exibe o caractere ',' na tela.

mov DL, ' '      ; Carrega o caractere de espaço no registrador DL.
int 21h          ; Exibe o espaço na tela.

mov DL, 'M'      ; Carrega o caractere 'M' no registrador DL.
int 21h          ; Exibe o caractere 'M' na tela.

mov DL, 'U'      ; Carrega o caractere 'U' no registrador DL.
int 21h          ; Exibe o caractere 'U' na tela.

mov DL, 'N'      ; Carrega o caractere 'N' no registrador DL.
int 21h          ; Exibe o caractere 'N' na tela.

mov DL, 'D'      ; Carrega o caractere 'D' no registrador DL.
int 21h          ; Exibe o caractere 'D' na tela.

mov DL, 'O'      ; Carrega o caractere 'O' no registrador DL.
int 21h          ; Exibe o caractere 'O' na tela.

END              ; Indica o fim do programa para o montador.
