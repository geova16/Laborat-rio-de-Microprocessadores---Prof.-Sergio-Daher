org 100h
; Define a origem do código em 100h, padrão para programas .COM no DOS.

key:
; Rótulo que marca o início do loop de espera por entrada.

mov AH, 6h
; Configura o registrador AH com o valor 6.
; A interrupção 21h com AH = 6 é usada para "Leitura de teclado sem eco".
; Verifica se uma tecla foi pressionada sem bloquear a execução.

mov DL, 0FFh
; Define o valor de DL como 0FFh (-1 em decimal).
; Necessário para a função 6h funcionar como "leitura sem espera".

int 21h
; Chama a interrupção 21h para executar a função configurada.

jz key
; Verifica o flag ZF (Zero Flag).
; Se nenhuma tecla foi pressionada (ZF = 1), o programa volta ao início (`key`).
; Isso cria um loop contínuo até que uma tecla seja pressionada.

mov AH, AL
; Move o valor de AL (caractere da tecla pressionada) para AH.
; Este valor será usado mais tarde nas comparações.

xor AL, 'y'
; Realiza uma operação XOR entre o caractere pressionado (AL) e o caractere `'y'` (121 ASCII).
; O resultado será 0 se a tecla pressionada for `'y'`.

jne letran
; Se o resultado da XOR não for zero (tecla pressionada não foi `'y'`), salta para o rótulo `letran`.

mov AH, 2
; Configura o registrador AH com o valor 2.
; A interrupção 21h com AH = 2 é usada para exibir caracteres no console.

mov DL, 'S'
; Define o valor de DL como `'S'` (83 em ASCII).

int 21h
; Exibe o caractere `'S'` no console.

mov DL, 'I'
int 21h
; Exibe o caractere `'I'` no console.

mov DL, 'M'
int 21h
; Exibe o caractere `'M'` no console.

ret
; Retorna ao sistema operacional, finalizando o programa.

;---

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
; Exibe `'N'` no console.

mov DL, 'A'
int 21h
; Exibe `'A'` no console.

mov DL, 'O'
int 21h
; Exibe `'O'` no console.

mov AH, 0
; Configura o registrador AH para esperar entrada de tecla.

int 16h
; Aguarda que o usuário pressione qualquer tecla antes de continuar.

letray:
; Rótulo final.

ret
; Retorna ao sistema operacional, finalizando o programa.
