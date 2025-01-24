org 100h

loop_entrada:

mov AH, 6h
; Configura o registrador AH com o valor 6.
; A interrupção 21h com AH = 6 é usada para "Leitura de teclado sem eco".
; Verifica se uma tecla foi pressionada sem bloquear a execução.

mov DL, 0FFh
; Define o valor de DL como 0FFh (-1 em decimal).
; Necessário para a função 6h funcionar como "leitura sem espera".

int 21h
; Chama a interrupção 21h para executar a função configurada.

jz loop_entrada
; Verifica o flag ZF (Zero Flag).
; Se nenhuma tecla foi pressionada (ZF = 1), o programa volta ao rotulo loop_entrada.
; Isso cria um loop contínuo até que uma tecla seja pressionada.
 
 
 
 

mov AH, AL
; Move o valor de AL (caractere da tecla pressionada) para AH.


xor AL, 'y'
; Realiza uma operação XOR entre o caractere pressionado (AL) e o caractere `'y'` (121 ASCII).
; O resultado será 0 se a tecla pressionada for `'y'`.

jne letran
; Se o resultado da XOR não for zero (tecla pressionada não foi `'y'`), salta para o rótulo `letran`.




mov AH, 2
; A interrupção 21h com AH = 2 é usada para exibir caracteres no console.

mov DL, 'S'
int 21h

mov DL, 'I'
int 21h

mov DL, 'M'
int 21h


jmp jump1
 
 
 

letran:
; Rótulo para processar se a tecla pressionada não foi `'y'`.

xor AH, 'n'
; Realiza uma operação XOR entre o caractere pressionado (AH) e `'n'` (110 ASCII).
; O resultado será 0 se a tecla pressionada for `'n'`.

jne letray
; Se o resultado não for 0 (tecla pressionada não foi `'n'`), salta para `letray`.

mov AH, 2
; Configura AH para exibir caracteres.

mov DL, 'N'
int 21h

mov DL, 'A'
int 21h

mov DL, 'O'
int 21h  


jump1:

jmp loop_entrada

letray:


ret
