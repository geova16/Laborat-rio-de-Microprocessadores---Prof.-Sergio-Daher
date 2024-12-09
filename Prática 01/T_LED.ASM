#include <p16F628A.inc>   ; Inclui o arquivo com definições específicas do processador PIC16F628A

#define LED1   PORTB,5     ; Define um alias para o pino RB5 como LED1
                          
X        EQU   0x70        ; Define X como um registrador na memória (endereço 0x70)
Y        EQU   0x71        ; Define Y como um registrador na memória (endereço 0x71)

;-----------------------------------------
; Vetores de Reset e Interrupção
;-----------------------------------------
ORG     0x000             ; Vetor de reset do processador
 goto    INI              ; Salta para o início do programa (rótulo INI)
	

ORG     0x004             ; Vetor de interrupção
 retfie                   ; Retorna da interrupção (não tratada neste programa)

;-----------------------------------------
; Inicialização do Microcontrolador
;-----------------------------------------
INI:
 ; Configuração do TRISB para definir PORTB como saída
 BANKSEL TRISB            ; Seleciona o banco de memória onde o TRISB está localizado
 movlw B'00000000'        ; Carrega 0b00000000 no registrador W (configura todos os pinos de PORTB como saída)
 movwf TRISB              ; Escreve no registrador TRISB para aplicar a configuração

 ; Retorna ao banco de memória do PORTB
 BANKSEL PORTB            ; Seleciona o banco de memória onde o PORTB está localizado

;-----------------------------------------
; Programa Principal
;-----------------------------------------
MAIN:
 movlw 0xff               ; Carrega o valor 0xFF no registrador W
 call  atraso             ; Chama a sub-rotina de atraso (X = 0xFF)
 bcf   LED1               ; Limpa o bit 5 de PORTB (desliga LED1)

 movlw 0x80               ; Carrega o valor 0x80 no registrador W
 call  atraso             ; Chama a sub-rotina de atraso (X = 0x80)
 bsf   LED1               ; Define o bit 5 de PORTB (liga LED1)
 goto  MAIN               ; Loop infinito, volta ao início do programa principal

;-----------------------------------------
; Sub-rotina de Atraso
;-----------------------------------------
atraso:
            movwf   X     ; Armazena o valor recebido em X (contagem principal)

at1:        movlw   100   ; Carrega o valor 100 no registrador W
            movwf   Y     ; Armazena o valor em Y (contador interno)
at2:        decfsz  Y     ; Decrementa Y, verifica se é zero
            goto    at2   ; Se Y não for zero, repete o loop interno

            decfsz  X     ; Decrementa X, verifica se é zero
            goto    at1   ; Se X não for zero, repete o loop externo
            return        ; Retorna ao chamador (atraso concluído)

;-----------------------------------------
; Final do Programa
;-----------------------------------------
END                       ; Indica ao assembler que o programa terminou
