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

    ; Configuração de TRISA e TRISB
    BANKSEL TRISA      ; Seleciona o banco para acessar TRISA
    movlw 0xff         ; Configura todos os pinos de PORTA como saída
    movwf TRISA        ; Escreve no registrador TRISA
    movlw b'00000010'         ; Configura os pinos RB0-RB5 como entrada e RB6-RB7 como saída
    movwf TRISB        ; Escreve no registrador TRISB

    ; Configuração do módulo UART
    BANKSEL SPBRG      ; Seleciona o banco para acessar SPBRG
    movlw d'31'          ; Configura baud rate para 19200 (exemplo)
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
    ; Verifica se há dado recebido pela UART
    BANKSEL PIR1       ; Seleciona o banco para acessar PIR1
    BTFSC PIR1,RCIF    ; Testa se o bit RCIF (flag de recepção UART) está setado
    ;BANKSEL   TXREG
    ;CLRF    TXREG
    CALL  rec_e_trata  ; Se RCIF = 1, chama a sub-rotina para tratar o dado recebido

    GOTO MAIN          ; Retorna ao início do loop principal

;------------------------------------------
; Sub-rotina para Recepção e Tratamento do Dado
;------------------------------------------
rec_e_trata:
    
 
    BANKSEL RCREG      ; Seleciona o banco para acessar RCREG
    INCF RCREG,	W        ; Move o dado recebido de RCREG para WREG
    
    BANKSEL   TXREG
    MOVWF	TXREG
    CLRW


    return             ; Retorna para o chamador


END                     ; Indica o fim do programa
