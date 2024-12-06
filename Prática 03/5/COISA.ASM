#include <P16F628A.INC>  ; Inclui a biblioteca específica para o microcontrolador PIC16F628A

; Declaração de registradores de uso geral (variáveis do programa)
received_char EQU 0x70   ; Registrador para armazenar o caractere recebido via USART

; Vetor de reset e interrupção
    ORG 0                 ; Define o endereço inicial de reset
    GOTO INI              ; Vai para o código de inicialização (INI)

    ORG 4                 ; Define o endereço inicial para interrupções
    RETFIE                ; Retorna da interrupção e reabilita as interrupções

; Rotina de inicialização
INI:
    ; Configuração dos pinos
    BANKSEL TRISA         ; Seleciona o banco que contém o registrador TRISA
    movlw 0x00            ; Configura os pinos de PORTA como saída
    movwf TRISA           ; Escreve o valor em TRISA
    movlw 0b00111111      ; Configura RB6 e RB7 como saída, os outros como entrada
    movwf TRISB           ; Escreve o valor em TRISB

    ; Configuração do módulo USART para recepção serial
    BANKSEL SPBRG         ; Seleciona o registrador SPBRG
    movlw .64             ; Define a taxa de baud (64 para 9600 bps com Fosc = 10 MHz)
    movwf SPBRG           ; Escreve o valor em SPBRG
    BANKSEL TXSTA         ; Seleciona o registrador TXSTA
    bsf  TXSTA, BRGH      ; Configura alta velocidade
    bcf  TXSTA, SYNC      ; Modo assíncrono
    bsf  TXSTA, TXEN      ; Habilita transmissão
    BANKSEL RCSTA         ; Seleciona o registrador RCSTA
    bsf  RCSTA, SPEN      ; Habilita a porta serial
    bsf  RCSTA, CREN      ; Habilita recepção contínua

    ; Configuração inicial de interrupções (opcional para USART)
    BANKSEL INTCON        ; Seleciona o registrador INTCON
    movlw 0x00            ; Desabilita todas as interrupções
    movwf INTCON          ; Escreve o valor em INTCON

MAIN:
    ; Verifica se há um caractere disponível para leitura
    BANKSEL PIR1          ; Seleciona o registrador PIR1
    btfss PIR1, RCIF      ; Verifica o flag RCIF (se há dados disponíveis no RCREG)
    goto MAIN             ; Se não há dados, volta para MAIN

    ; Lê o caractere recebido
    BANKSEL RCREG         ; Seleciona o registrador RCREG
    movf RCREG, W         ; Move o valor recebido para W
    BANKSEL received_char ; Seleciona o registrador de uso geral
    movwf received_char   ; Armazena o caractere recebido em received_char

    ; Decodifica o caractere recebido
    BANKSEL received_char ; Seleciona o banco de received_char
    movf received_char, W ; Carrega o caractere em W
    
    ; Verifica se é 'A'
    xorlw 'A'             ; Compara W com 'A'
    btfsc STATUS, Z       ; Se for igual, o flag Z é 1
    goto turn_on_RB6      ; Vai para ligar RB6
    
    ; Verifica se é 'Z'
    movf received_char, W ; Recarrega W
    xorlw 'Z'             ; Compara W com 'Z'
    btfsc STATUS, Z       ; Se for igual, o flag Z é 1
    goto turn_off_RB6     ; Vai para desligar RB6
    
    ; Verifica se é 'S'
    movf received_char, W ; Recarrega W
    xorlw 'S'             ; Compara W com 'S'
    btfsc STATUS, Z       ; Se for igual, o flag Z é 1
    goto turn_on_RB7      ; Vai para ligar RB7
    
    ; Verifica se é 'X'
    movf received_char, W ; Recarrega W
    xorlw 'X'             ; Compara W com 'X'
    btfsc STATUS, Z       ; Se for igual, o flag Z é 1
    goto turn_off_RB7     ; Vai para desligar RB7

    goto MAIN             ; Retorna ao loop principal

; Liga RB6
turn_on_RB6:
    BANKSEL PORTB         ; Seleciona o banco de PORTB
    bsf PORTB, 6          ; Liga o bit RB6
    goto MAIN             ; Retorna ao loop principal

; Desliga RB6
turn_off_RB6:
    BANKSEL PORTB         ; Seleciona o banco de PORTB
    bcf PORTB, 6          ; Desliga o bit RB6
    goto MAIN             ; Retorna ao loop principal

; Liga RB7
turn_on_RB7:
    BANKSEL PORTB         ; Seleciona o banco de PORTB
    bsf PORTB, 7          ; Liga o bit RB7
    goto MAIN             ; Retorna ao loop principal

; Desliga RB7
turn_off_RB7:
    BANKSEL PORTB         ; Seleciona o banco de PORTB
    bcf PORTB, 7          ; Desliga o bit RB7
    goto MAIN             ; Retorna ao loop principal

END                       ; Indica o fim do código
