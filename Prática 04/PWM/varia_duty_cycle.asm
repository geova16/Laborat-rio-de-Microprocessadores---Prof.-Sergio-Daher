#include <P16F628A.INC>   ; Definições do PIC16F628A
TEMP EQU 0x20 ; Declara TEMP no endereço 0x20

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
    ; Configura os pinos RA0 e RA1 como entrada
    BANKSEL TRISA        ; Seleciona o banco para acessar TRISA
    BSF TRISA, 0         ; Configura RA0 como entrada
    BSF TRISA, 1         ; Configura RA1 como entrada

    ; Configura o pino RB3 como saída
    BANKSEL TRISB        ; Seleciona o banco para acessar TRISB
    BCF TRISB, 3         ; Configura o pino RB3 como saída

    ; Configura o módulo CCP1 para PWM
    BANKSEL CCP1CON      ; Seleciona o banco para acessar CCP1CON
    MOVLW 0x0C           ; Configura o CCP1 no modo PWM
    MOVWF CCP1CON        ; Escreve no registrador CCP1CON

    ; Configura o período PWM (PR2)
    BANKSEL PR2          ; Seleciona o banco para acessar PR2
    MOVLW 0x80           ; Define o valor de PR2 para frequência de 20 kHz
    MOVWF PR2            ; Escreve no registrador PR2

    ; Configura o Timer2
    BANKSEL T2CON        ; Seleciona o banco para acessar T2CON
    MOVLW 0x04           ; Configura o Timer2 com prescaler = 1
    MOVWF T2CON          ; Escreve no registrador T2CON

    ; Inicializa Duty Cycle
    BANKSEL CCPR1L
    MOVLW d'13'          ; Duty cycle inicial (20%)
    MOVWF CCPR1L

;-----------------------------------------
; Loop Principal
;-----------------------------------------
MAIN:
    BANKSEL PORTA        ; Seleciona o banco para acessar PORTA
    MOVF PORTA, W        ; Lê o valor de PORTA

    ; Verifica os estados de RA0 e RA1
    ANDLW b'00000011'    ; Isola os dois bits menos significativos (RA1 e RA0)
    MOVWF TEMP           ; Armazena o valor em TEMP

    MOVLW b'00'          ; Verifica se é 00 (20%)
    XORWF TEMP, W        ; Compara com TEMP
    BTFSC STATUS, Z
    GOTO duty_20

    MOVLW b'01'          ; Verifica se é 01 (40%)
    XORWF TEMP, W        ; Compara com TEMP
    BTFSC STATUS, Z
    GOTO duty_40

    MOVLW b'10'          ; Verifica se é 10 (60%)
    XORWF TEMP, W        ; Compara com TEMP
    BTFSC STATUS, Z
    GOTO duty_60

    MOVLW b'11'          ; Verifica se é 11 (80%)
    XORWF TEMP, W        ; Compara com TEMP
    BTFSC STATUS, Z
    GOTO duty_80

    GOTO MAIN            ; Retorna ao loop principal

;-----------------------------------------
; Configuração do Duty Cycle
;-----------------------------------------
duty_20:
    MOVLW d'25'          ; Duty cycle de 20%
    GOTO pwm

duty_40:
    MOVLW d'51'         ; Duty cycle de 40%
    GOTO pwm

duty_60:
    MOVLW d'76'         ; Duty cycle de 60%
    GOTO pwm

duty_80:
    MOVLW d'102'         ; Duty cycle de 80%
    GOTO pwm

pwm:
    BANKSEL CCPR1L       ; Seleciona o banco para acessar CCPR1L
    MOVWF CCPR1L         ; Escreve o valor no registrador CCPR1L
    GOTO MAIN            ; Volta para o loop principal

;-----------------------------------------
; Final do Programa
;-----------------------------------------
END                     ; Indica o fim do programa
