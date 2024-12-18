#include <p16F628A.inc>   ; processor specific variable definitions


ORG 0x0000             ; processor reset vector
    GOTO    INI              ; go to beginning of program
	

ORG 0x0004             ; interrupt vector location
    BCF	INTCON, INTF

    MOVLW d'65'
    MOVWF TXREG
    RETFIE
 
INI:
    
    BANKSEL TRISB
    MOVLW B'01111011'
    MOVWF TRISB
    
    
    BANKSEL INTCON 
    BSF INTCON, GIE ; Habilita as interrupções globais
    ;BSF INTCON, PEIE ; Habilita as interrupções dos periféricos
    BSF INTCON, INTE
    
    BANKSEL SPBRG
    MOVLW d'25' ; Baud rate = 9600
    MOVWF SPBRG
    
    ;BANKSEL PIE1
    ;BSF PIE1, RCIE ; Enable a interrupção de recepção 
    ;BSF PIE1, TXIE ; Enable a interrupção de transmissão
    
    BANKSEL RCSTA
    BSF RCSTA, SPEN ; Ativa a transimissão via usart
    
    BANKSEL TXSTA
    BSF TXSTA, TXEN ; Enable USART
    BSF TXSTA, BRGH ; Ativa a transmissão em altas velocidades
    BSF TXSTA, TRMT
    
   
MAIN:
    GOTO MAIN
 
END

