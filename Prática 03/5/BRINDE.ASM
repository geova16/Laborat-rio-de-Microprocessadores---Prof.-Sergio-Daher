#INCLUDE <P16F628A.INC>

#DEFINE LED1   PORTB,6        ; Define LED1 no pino RB6
#DEFINE LED2   PORTB,7        ; Define LED2 no pino RB7

at_x        EQU   0x70        ; Registrador para contador de atraso externo
at_tmp1     EQU   0x71        ; Registrador para contador de atraso interno
at_tmp2     EQU   0x72        ; Registrador para contador mais interno

temp        EQU   0x74        ; Registrador temporário usado para armazenar dados recebidos

;------------------------------------------
; Vetores de Reset e Interrupção
;------------------------------------------
ORG 0                  ; Vetor de reset
GOTO INI               ; Salta para o início do programa

ORG 4                  ; Vetor de interrupção
RETFIE                 ; Retorna da interrupção

;------------------------------------------
; Inicialização do Programa
;------------------------------------------
INI:
    ; Configuração do registrador OPTION_REG
    BANKSEL OPTION_REG ; Seleciona o banco para acessar OPTION_REG
    movlw   0x80       ; Configura Timer0 com prescaler atribuído a WDT
    movwf   OPTION_REG ; Escreve a configuração em OPTION_REG

    ; Configuração de TRISA e TRISB
    BANKSEL TRISA      ; Seleciona o banco para acessar TRISA
    movlw 0x00         ; Configura todos os pinos de PORTA como saída
    movwf TRISA        ; Escreve no registrador TRISA
    movlw 0x3F         ; Configura os pinos RB0-RB5 como entrada e RB6-RB7 como saída
    movwf TRISB        ; Escreve no registrador TRISB

    ; Configuração do módulo UART
    BANKSEL SPBRG      ; Seleciona o banco para acessar SPBRG
    movlw .64          ; Configura baud rate para 9600 (exemplo)
    movwf SPBRG        ; Escreve no registrador SPBRG
    BANKSEL TXSTA      ; Seleciona o banco para acessar TXSTA
    bsf  TXSTA,TXEN    ; Habilita o transmissor UART
    bsf  TXSTA,BRGH    ; Configura alta velocidade UART
    BANKSEL RCSTA      ; Seleciona o banco para acessar RCSTA
    bsf  RCSTA,SPEN    ; Habilita o módulo UART
    bsf  RCSTA,CREN    ; Habilita recepção contínua

    ; Configuração do registrador INTCON
    BANKSEL INTCON     ; Seleciona o banco para acessar INTCON
    movlw 0x00         ; Desabilita todas as interrupções
    movwf INTCON       ; Escreve no registrador INTCON

;------------------------------------------
; Loop Principal
;------------------------------------------
MAIN:
    ; Gera um atraso utilizando a sub-rotina "atraso"
    MOVFW 0x01         ; Carrega o valor do atraso no WREG
    CALL  atraso       ; Chama a sub-rotina de atraso

    ; Transmite o caractere 'A' pela UART
    BANKSEL TXREG      ; Seleciona o banco para acessar TXREG
    MOVLW 0x41         ; Carrega o caractere 'A' (ASCII 0x41)
    MOVWF TXREG        ; Transmite o caractere

    ; Verifica se há dado recebido pela UART
    BANKSEL PIR1       ; Seleciona o banco para acessar PIR1
    BTFSC PIR1,RCIF    ; Testa se o bit RCIF (flag de recepção UART) está setado
    CALL  rec_e_trata  ; Se RCIF = 1, chama a sub-rotina para tratar o dado recebido

    GOTO MAIN          ; Retorna ao início do loop principal

;------------------------------------------
; Sub-rotina para Recepção e Tratamento do Dado
;------------------------------------------
rec_e_trata:
    BANKSEL RCREG      ; Seleciona o banco para acessar RCREG
    movfw RCREG        ; Move o dado recebido de RCREG para WREG

    BANKSEL PORTB      ; Seleciona o banco para acessar PORTB
    movwf temp         ; Armazena o dado recebido no registrador temporário "temp"

    ; Verifica se o dado recebido é 'A'
    sublw 'A'          ; Subtrai 'A' do valor em WREG
    btfsc STATUS,Z     ; Verifica se o resultado é zero (igualdade)
    BCF   LED1         ; Apaga o LED1 (RB6) se o dado for 'A'

    ; Verifica se o dado recebido é 'Z'
    movfw temp         ; Restaura o valor original de "temp" no WREG
    sublw 'Z'          ; Subtrai 'Z' do valor em WREG
    btfsc STATUS,Z     ; Verifica se o resultado é zero (igualdade)
    BSF   LED1         ; Acende o LED1 (RB6) se o dado for 'Z'

    ; Verifica se o dado recebido é 'S'
    movfw temp         ; Restaura o valor original de "temp" no WREG
    sublw 'S'          ; Subtrai 'S' do valor em WREG
    btfsc STATUS,Z     ; Verifica se o resultado é zero (igualdade)
    BCF   LED2         ; Apaga o LED2 (RB7) se o dado for 'S'

    ; Verifica se o dado recebido é 'X'
    movfw temp         ; Restaura o valor original de "temp" no WREG
    sublw 'X'          ; Subtrai 'X' do valor em WREG
    btfsc STATUS,Z     ; Verifica se o resultado é zero (igualdade)
    BSF   LED2         ; Acende o LED2 (RB7) se o dado for 'X'

    return             ; Retorna para o chamador

;------------------------------------------
; Sub-rotina de Atraso
;------------------------------------------
atraso:
    movwf   at_x       ; Armazena o valor inicial no contador externo (at_x)
    movlw   0x10       ; Carrega o valor do contador interno

at1:    movwf   at_tmp1 ; Configura o contador interno
at2:    movwf   at_tmp2 ; Configura o contador mais interno
at3:    decfsz  at_tmp2 ; Decrementa at_tmp2, verifica se chegou a zero
        goto    at3     ; Se não chegou a zero, repete o loop
        decfsz  at_tmp1 ; Decrementa at_tmp1, verifica se chegou a zero
        goto    at2     ; Se não chegou a zero, repete o loop
        decfsz  at_x    ; Decrementa at_x, verifica se chegou a zero
        goto    at1     ; Se não chegou a zero, repete o loop

        return          ; Retorna ao chamador quando o atraso termina

;------------------------------------------
; Final do Programa
;------------------------------------------
END                     ; Indica o fim do programa
