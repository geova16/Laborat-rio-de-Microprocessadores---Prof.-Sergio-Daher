org 100h
; Define a origem do programa em 100h, padrão para programas .COM no DOS.

mov AH, 1
; Configura o registrador AH com a função 1.
; A interrupção 21h com AH = 1 lê um caractere do teclado com eco.

int 21h
; Chama a interrupção 21h do DOS para ler o primeiro caractere.
; O caractere digitado é armazenado no registrador AL como um valor ASCII.

sub AL, 48
; Converte o caractere ASCII para um valor decimal.
; Isso é feito subtraindo 48 (valor ASCII de '0') do valor de AL.
; Exemplo: Se o caractere lido for '5' (ASCII 53), AL se torna 5.

mov DL, AL


;--------------------------------------------------------------------------

mov AH, 1
; Configura AH novamente para a função de leitura de caractere do teclado.

int 21h
; Lê o segundo caractere do teclado e armazena seu valor ASCII em AL.

sub AL, 48

add DL, AL 

mov AL, DL

sub DL, 10

sub AL, DL

mov AH, DL

add AL, 48

add AH, 48

mov CH, AL

mov CL, AH 


mov DL, CH

mov AH, 2

int 21h

mov DL, CL

int 21h




.exit
; Fim do programa. `.exit` seria interpretado como um comando externo ou rótulo.
