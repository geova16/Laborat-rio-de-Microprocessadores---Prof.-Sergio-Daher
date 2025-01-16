; Inclui o arquivo de configuração para o PIC16F628A
#include <P16F628A.INC>

; Define o ponto inicial do programa
ORG 0x00
GOTO INICIO          ; Redireciona para o início do programa principal

; Vetor de interrupção
ORG 0x04
RETFIE               ; Retorna de uma interrupção

; Rotina principal do programa
INICIO:
    ; Configuração do PR2 (Período do PWM)
    BANKSEL PR2       ; Seleciona o banco de memória para PR2
    MOVLW d'249'      ; Carrega o valor 249 no registrador W (PR2)
    MOVWF PR2         ; Move o valor de W para o registrador PR2

    ; Configuração do CCP1CON (Modo PWM no CCP1)
    BANKSEL CCP1CON   ; Seleciona o banco de memória para CCP1CON
    MOVLW b'00001111' ; Configura o CCP1 em modo PWM
    MOVWF CCP1CON     ; Move o valor para o registrador CCP1CON

    ; Configuração do Duty Cycle no CCPR1L
    BANKSEL CCPR1L    ; Seleciona o banco de memória para CCPR1L
    MOVLW b'00000101' ; Define o valor inicial do Duty Cycle
    MOVWF CCPR1L      ; Move o valor para o registrador CCPR1L

    ; Configuração do T2CON (Timer 2 para o PWM)
    BANKSEL T2CON     ; Seleciona o banco de memória para T2CON
    MOVLW b'00000100' ; Configura o Timer 2 e ativa o pré-escalonador
    MOVWF T2CON       ; Move o valor para o registrador T2CON

    ; Configuração do TRISB (Portas de saída)
    BANKSEL TRISB     ; Seleciona o banco de memória para TRISB
    CLRF TRISB        ; Define todas as portas do PORTB como saída

; Loop principal
MAIN:
    GOTO MAIN         ; Mantém o programa em loop infinito

END                  ; Finaliza o programa
