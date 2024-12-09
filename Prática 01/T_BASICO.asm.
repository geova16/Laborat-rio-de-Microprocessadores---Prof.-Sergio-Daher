#include <p16F628A.inc>   ; Inclui o arquivo com as definições específicas do processador PIC16F628A

ORG     0x000             ; Vetor de reset do processador (início do programa)
 goto    INI              ; Vai para o rótulo INI (início do programa)
	

ORG     0x004             ; Vetor de interrupção (endereço para tratar interrupções)
 retfie                   ; Retorna da interrupção (caso ocorra, nada será tratado aqui)

; Rótulo para o início do programa
INI:
 bsf   STATUS,RP0         ; Seleciona o banco de memória 1 (bit RP0 = 1)
 bcf   STATUS,RP1         ; Garante que o banco de memória é 1 (bit RP1 = 0)
 movlw B'00000000'        ; Carrega o literal 00000000 no registrador W (define como saída)
 movwf TRISB              ; Configura todos os pinos do PORTB como saída
 bcf   STATUS,RP0         ; Volta ao banco de memória 0 (bit RP0 = 0)

; Início do programa principal
MAIN:
 movlw 0x00               ; Carrega o literal 0x00 no registrador W (todos os pinos baixos)
 movwf PORTB              ; Escreve 0x00 no PORTB (apaga os LEDs, por exemplo)
 movlw 0xFF               ; Carrega o literal 0xFF no registrador W (todos os pinos altos)
 movwf PORTB              ; Escreve 0xFF no PORTB (acende todos os LEDs, por exemplo)
 goto  MAIN               ; Loop infinito: volta para o início do programa principal

END                       ; Final do programa (indica ao assembler que o código terminou)
