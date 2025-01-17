#INCLUDE <P16F628A.INC>

; Enviar o CARACTERE A para ocomputador por comunicação serial ao ser gerada uma borda de subida no pinoRB0 (ao pressionarmos um botão ligado aesse pino).
; BAUD RATE 9600 bps, 8 bits, sem paridade e 1 stop-bit.
; Fosc = 10MHz

ENVIADO  EQU  0x20

ORG  0x00
  GOTO  INICIO

ORG  0x04
  
  BANKSEL INTCON
  BCF	INTCON, INTF
  

  
  BANKSEL   TXREG
  MOVLW	0x41          ;TABELA ASCII
  MOVWF	TXREG

  
  RETFIE

INICIO:
  BANKSEL   OPTION_REG
  BSF	OPTION_REG, 7
  
  BANKSEL   INTCON
  BSF	INTCON, GIE
  BSF	INTCON, INTE
  
  BANKSEL   SPBRG
  MOVLW	d'65'
  MOVWF	SPBRG

  BANKSEL TXSTA
  MOVLW	b'00100100'
  MOVWF	TXSTA
  
  BANKSEL RCSTA
  BSF RCSTA, SPEN ; Habilita o módulo UART.

  BANKSEL TRISB
  MOVLW b'00000001'
  MOVWF  TRISB

  BANKSEL  TRISA 
  MOVLW	0xFF
  MOVWF	TRISA
  
  MAIN:
    GOTO MAIN
  
  END
