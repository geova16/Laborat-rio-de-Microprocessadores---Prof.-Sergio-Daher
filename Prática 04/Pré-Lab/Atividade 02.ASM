#include <P16F628A.INC>   ; Definições do PIC16F628A

;-----------------------------------------
; Configuração Inicial
;-----------------------------------------
ORG 0x00                 ; Vetor de reset
GOTO INICIO              ; Salta para o início do programa

ORG 0x04                 ; Vetor de interrupção
RETFIE                   ; Retorna da interrupção

;-----------------------------------------
; Inicialização do PWM
;-----------------------------------------
INICIO:
    ; Configura o pino RB3 como saída
    BANKSEL TRISB        ; Seleciona o banco para acessar TRISB
    BCF TRISB, 3         ; Configura o pino RB3 como saída

    ; Configura o módulo CCP1 para PWM
    BANKSEL CCP1CON      ; Seleciona o banco para acessar CCP1CON
    MOVLW 0x0C           ; Configura o CCP1 no modo PWM
    MOVWF CCP1CON        ; Escreve no registrador CCP1CON

    ; Configura o período PWM (PR2)
    BANKSEL PR2          ; Seleciona o banco para acessar PR2
    MOVLW 0x80            ; Define o valor de PR2 para frequência de 20 kHz
    MOVWF PR2            ; Escreve no registrador PR2

    ; Configura o duty cycle
    BANKSEL CCPR1L       ; Seleciona o banco para acessar CCPR1L
    MOVLW 0x10            ; Define o valor de CCPR1L para duty cycle de 30%
    MOVWF CCPR1L         ; Escreve no registrador CCPR1L

    ; Configura o Timer2
    BANKSEL T2CON        ; Seleciona o banco para acessar T2CON
    MOVLW 0x04           ; Configura o Timer2 com prescaler = 1
    MOVWF T2CON          ; Escreve no registrador T2CON

    ; Loop principal
MAIN:
    GOTO MAIN            ; Loop infinito

;-----------------------------------------
; Final do Programa
;-----------------------------------------
END                     ; Indica o fim do programa
