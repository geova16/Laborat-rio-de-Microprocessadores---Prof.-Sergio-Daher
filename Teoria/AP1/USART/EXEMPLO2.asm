#INCLUDE <P16F628A.INC>

CONTA EQU 0x20

;------------------------------------------
; Vetores de Reset e Interrupção
;------------------------------------------
ORG 0x0000			; Vetor de reset
    GOTO INI               ; Salta para o início do programa

ORG 0x0004			; Vetor de interrupção
    
    BANKSEL CONTA
    DECFSZ CONTA, F
    RETFIE
    
    MOVLW D'105'
    MOVWF CONTA
    
    BANKSEL INTCON
    BCF	INTCON, T0IF
    
    BANKSEL PIR1
    BTFSS PIR1, TXIF  ; Verifica se o buffer de transmissão está vazio
    GOTO $-1          ; Aguarda até estar pronto
    BANKSEL TXREG
    MOVLW 0x41
    MOVWF TXREG
    
    BANKSEL TMR0
    MOVLW D'70'
    MOVWF TMR0
    
    RETFIE

;------------------------------------------
; Inicialização do Programa
;------------------------------------------
INI:
    
    ; Configuração do USART
    ;BANKSEL PIE1
    ;BSF PIE1, RCIE
    
    BANKSEL RCSTA
    MOVLW B'10010000'
    MOVWF RCSTA
    
    BANKSEL TXSTA
    MOVLW B'00100100'
    MOVWF TXSTA
    
    BANKSEL TRISB
    MOVLW 0x00
    MOVWF TRISB
    
    BANKSEL SPBRG
    MOVLW D'15'
    MOVWF SPBRG
    
    BANKSEL INTCON
    BSF	INTCON, GIE
    BSF INTCON,	T0IE
    
    BANKSEL OPTION_REG
    MOVLW   B'00100111'
    MOVWF   OPTION_REG
    
    BANKSEL TMR0
    MOVLW D'70'
    MOVWF TMR0
    
    BANKSEL CONTA
    MOVLW D'105'
    MOVWF CONTA
    
MAIN
    
    GOTO MAIN
    
;------------------------------------------
; Final do Programa
;------------------------------------------
END                     ; Indica o fim do programa
