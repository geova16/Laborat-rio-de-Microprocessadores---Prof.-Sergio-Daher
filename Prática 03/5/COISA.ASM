#include <P16F628A.INC>  ; Inclui a biblioteca específica para o microcontrolador PIC16F628A

; Declaração de registradores de uso geral (variáveis do programa)
at_x        EQU   0x70  ; Registrador para contagem externa no atraso
at_tmp1     EQU   0x71  ; Registrador temporário 1 para o loop de atraso
at_tmp2     EQU   0x72  ; Registrador temporário 2 para o loop de atraso
char_to_send EQU   0x73  ; Registrador para armazenar o caractere a ser enviado

; Vetor de reset e interrupção
    ORG 0                 ; Define o endereço inicial de reset
    GOTO INI              ; Vai para o código de inicialização (INI)

    ORG 4                 ; Define o endereço inicial para interrupções
    RETFIE                ; Retorna da interrupção e reabilita as interrupções

; Rotina de inicialização
INI:
    BANKSEL OPTION_REG    ; Seleciona o banco de memória que contém o registrador OPTION_REG
    movlw   0x80          ; Configura o OPTION_REG para desabilitar o pull-up interno e ativar o timer0 com prescaler
    movwf   OPTION_REG    ; Escreve o valor em OPTION_REG

    BANKSEL TRISA         ; Seleciona o banco que contém o registrador TRISA
    movlw 0x00            ; Configura os pinos de PORTA como saída
    movwf TRISA           ; Escreve o valor em TRISA
    movlw 0xFF            ; Configura os pinos de PORTB como entrada
    movwf TRISB           ; Escreve o valor em TRISB

    ; Configuração do módulo USART para transmissão serial
    BANKSEL SPBRG         ; Seleciona o registrador SPBRG
    movlw .63             ; Define a taxa de baud (63 para 9600 bps com Fosc = 10 MHz)
    movwf SPBRG           ; Escreve o valor em SPBRG
    BANKSEL TXSTA         ; Seleciona o registrador TXSTA
    bsf  TXSTA,TXEN       ; Habilita o módulo de transmissão (TX)
    bsf  TXSTA,BRGH       ; Configura a alta velocidade de transmissão
    BANKSEL RCSTA         ; Seleciona o registrador RCSTA
    bsf  RCSTA,SPEN       ; Habilita o módulo serial (USART)
    bsf  RCSTA,CREN       ; Habilita o recebimento contínuo

    ; Configuração inicial de interrupções
    BANKSEL INTCON        ; Seleciona o registrador INTCON
    movlw 0x00            ; Desabilita todas as interrupções
    movwf INTCON          ; Escreve o valor em INTCON

    ; Inicializa o caractere a ser enviado como 'A'
    BANKSEL char_to_send
    movlw 0x41            ; Carrega o valor ASCII de 'A' no W
    movwf char_to_send    ; Salva o caractere inicial em char_to_send

MAIN:
    ; Verifica o estado do botão (RB0)
    BANKSEL PORTB         ; Seleciona o banco para acessar PORTB
    btfss PORTB, 0         ; Testa o bit RB0 (se RB0 = 1, salta para send_X)
    goto send_A           ; Se RB0 = 0, envia 'A'

send_X:
    BANKSEL char_to_send
    movlw 0x58            ; Carrega o valor ASCII de 'X' no W
    movwf char_to_send    ; Atualiza o caractere a ser enviado
    goto send_char        ; Vai para a rotina de envio

send_A:
    BANKSEL char_to_send
    movlw 0x41            ; Carrega o valor ASCII de 'A' no W
    movwf char_to_send    ; Atualiza o caractere a ser enviado

send_char:
    ; Atraso antes de enviar o caractere
    MOVLW .110            ; Define o tempo de atraso (110 loops)
    CALL atraso           ; Chama a sub-rotina de atraso

    ; Envia o caractere armazenado em char_to_send
    BANKSEL TXREG         ; Seleciona o registrador TXREG
    movf char_to_send, W  ; Move o valor de char_to_send para W
    MOVWF TXREG           ; Escreve o valor no registrador TXREG para transmissão

    GOTO MAIN             ; Retorna para o início do laço principal

; Sub-rotina de atraso
atraso
        movwf   at_x       ; Armazena o valor inicial de W no registrador at_x
        movlw   .8         ; Define o valor inicial para o loop de atraso externo

at1:    movwf   at_tmp1    ; Inicializa o temporário 1
at2:    movwf   at_tmp2    ; Inicializa o temporário 2
at3:    decfsz  at_tmp2    ; Decrementa at_tmp2, verifica se é zero
        goto    at3        ; Continua o loop interno se não for zero
        decfsz  at_tmp1    ; Decrementa at_tmp1, verifica se é zero
        goto    at2        ; Continua o loop intermediário se não for zero
        decfsz  at_x       ; Decrementa at_x, verifica se é zero
        goto    at1        ; Continua o loop externo se não for zero
        return             ; Retorna para o chamador quando o atraso terminar

END                        ; Indica o fim do código
