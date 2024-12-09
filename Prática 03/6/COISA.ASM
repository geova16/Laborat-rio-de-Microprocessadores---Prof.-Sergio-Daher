#include <P16F628A.INC>  ; Inclui a biblioteca específica para o microcontrolador PIC16F628A

; Variáveis de uso geral
at_x        EQU   0x70     ; Registrador para contagem externa no atraso
at_tmp1     EQU   0x71     ; Registrador temporário 1
at_tmp2     EQU   0x72     ; Registrador temporário 2
temp        EQU   0x74     ; Registrador para armazenar o caractere recebido

; Vetores de inicialização e interrupção
    ORG 0                 ; Define o endereço de reset
    GOTO INI              ; Vai para a rotina de inicialização

    ORG 4                 ; Define o endereço para interrupções
    RETFIE                ; Retorna de uma interrupção e habilita interrupções

; Rotina de inicialização
INI:
    BANKSEL OPTION_REG
    movlw   0x80
    movwf   OPTION_REG    ; Desabilita pull-ups e configura prescaler no Timer0

    ; Configuração dos registradores de direção dos pinos
    BANKSEL TRISA
    movlw   0x00          ; Configura PORTA como saída
    movwf   TRISA
    movlw   0x3F          ; Configura RB0 a RB5 como entrada e RB6/RB7 como saída
    movwf   TRISB

    ; Configuração do módulo USART para comunicação serial
    BANKSEL SPBRG
    movlw .64             ; Configura taxa de baud (64 para 9600 bps com Fosc = 10 MHz)
    movwf SPBRG
    BANKSEL TXSTA
    bsf TXSTA, TXEN       ; Habilita transmissão
    bsf TXSTA, BRGH       ; Configura alta velocidade
    BANKSEL RCSTA
    bsf RCSTA, SPEN       ; Habilita a porta serial (USART)
    bsf RCSTA, CREN       ; Habilita recepção contínua

    ; Desabilita interrupções
    BANKSEL INTCON
    movlw 0x00
    movwf INTCON

MAIN:
    ; Atraso antes de transmitir
    MOVLW 0x01            ; Define o tempo de atraso
    CALL atraso           ; Chama a rotina de atraso

    ; Transmite o caractere 'A'
    BANKSEL TXREG
    MOVLW 0x41            ; Carrega o valor ASCII de 'A' (caractere 'A')
    MOVWF TXREG           ; Envia o caractere via USART
    
    ; Verifica se há dados recebidos
    BANKSEL PIR1          ; Seleciona PIR1 para verificar RCIF
    BTFSC PIR1, RCIF      ; Verifica se há dados no registrador RCREG
    CALL rec_e_trata      ; Chama a rotina para tratar o caractere recebido
    
    GOTO MAIN             ; Retorna ao loop principal
    
; Rotina de recepção e tratamento de caracteres recebidos
rec_e_trata:
    BANKSEL RCREG
    MOVFW RCREG           ; Lê o caractere recebido no registrador RCREG
    
    ; Verifica se o caractere recebido é 'K'
    movwf temp            ; Salva o caractere em temp
    sublw 'K'             ; Compara com 'K'
    btfsc STATUS, Z       ; Se igual, flag Z é setado
    CALL envia_legal      ; Chama a rotina para enviar "LEGAL !"
    
    RETURN                ; Retorna ao loop principal

; Rotina para enviar a mensagem "LEGAL !"
envia_legal:
    ; Envia cada caractere de "LEGAL !"
    BANKSEL TXREG
    MOVLW 'L'
    MOVWF TXREG
    CALL atraso
    MOVLW 'E'
    MOVWF TXREG
    CALL atraso
    MOVLW 'G'
    MOVWF TXREG
    CALL atraso
    MOVLW 'A'
    MOVWF TXREG
    CALL atraso
    MOVLW 'L'
    MOVWF TXREG
    CALL atraso
    MOVLW '!'
    MOVWF TXREG
    CALL atraso
    RETURN

; Rotina de atraso
atraso:
    movwf   at_x          ; Armazena o valor inicial no registrador at_x
    movlw   .100        ; Define o valor para o loop externo

at1:
    movwf   at_tmp1       ; Inicializa o temporário 1
at2:
    movwf   at_tmp2       ; Inicializa o temporário 2
at3:
    decfsz  at_tmp2       ; Decrementa at_tmp2 e verifica se é zero
    goto    at3           ; Continua o loop interno se não for zero
    decfsz  at_tmp1       ; Decrementa at_tmp1 e verifica se é zero
    goto    at2           ; Continua o loop intermediário se não for zero
    decfsz  at_x          ; Decrementa at_x e verifica se é zero
    goto    at1           ; Continua o loop externo se não for zero
    RETURN                ; Retorna ao chamador quando o atraso terminar

END                       ; Fim do programa
