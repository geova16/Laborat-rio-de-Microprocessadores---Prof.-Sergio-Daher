#INCLUDE <P16F628A.INC>

#DEFINE LED1   PORTB,6                             
#DEFINE LED2   PORTB,7                             

at_x        EQU   0x70
at_tmp1     EQU   0x71
at_tmp2     EQU   0x72

temp        EQU   0x74

	ORG 0
    GOTO INI

	ORG 4
	RETFIE


INI:
    BANKSEL OPTION_REG
	movlw   0x80
	movwf	OPTION_REG

    BANKSEL TRISA
    movlw 0x00
    movwf TRISA
    movlw 0x3F
    movwf TRISB


    BANKSEL SPBRG
    movlw .64
    movwf SPBRG
    BANKSEL TXSTA
    bsf  TXSTA,TXEN     
    bsf  TXSTA,BRGH     
    BANKSEL RCSTA
    bsf  RCSTA,SPEN     
    bsf  RCSTA,CREN     

    BANKSEL INTCON
    movlw 0x00
    movwf INTCON

MAIN:

 	MOVFW 0x01									  ; W = tempo de atraso
 	CALL  atraso								  ; chama a funcao atraso 

    BANKSEL TXREG
 	MOVLW 0x41
 	MOVWF TXREG

    BANKSEL PIR1
 	BTFSC PIR1,RCIF
 	CALL  rec_e_trata

	GOTO MAIN
;==========================================
;==========================================
rec_e_trata
    	BANKSEL RCREG
        movfw RCREG

    	BANKSEL PORTB
    	movwf temp
    	sublw 'A'
    	btfsc STATUS,Z
        BCF   LED1
    	movfw temp
    	sublw 'Z'
    	btfsc STATUS,Z
    	BSF   LED1

    	movfw temp
    	sublw 'S'
    	btfsc STATUS,Z
        BCF   LED2
    	movfw temp
    	sublw 'X'
    	btfsc STATUS,Z
    	BSF   LED2

		return
;==========================================
;==========================================
atraso
        movwf   at_x 
 	    movlw   0x10

at1:    movwf   at_tmp1
at2:    movwf   at_tmp2
at3:    decfsz  at_tmp2
        goto    at3
        decfsz  at_tmp1
        goto    at2
        decfsz  at_x
        goto    at1
        return
;==========================================
;==========================================

END
