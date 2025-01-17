#INCLUDE <P16F877A.INC>

ad_L       EQU   0x71
ad_H       EQU   0x72

tempd1     EQU   0x73 
tempd2     EQU   0x74  


	ORG 0
    GOTO INI

	ORG 4
	RETFIE 

INI:


MAIN:
	GOTO 	MAIN

;******************
;1 ms delay routine (10 MHz)
;******************
d10_1ms
	movlw	.4			;
	movwf	tempd1		;
dly_1my	movlw	.204	;
	movwf	tempd2		; 
dly_1mx	decfsz	tempd2,1;		
	goto	dly_1mx		;
	clrwdt				;   
	decfsz	tempd1,1	;		
	goto	dly_1my		;
	return				;



;******************
;4.4uS delay routine (10 MHz)
;******************
dly_4uS
	movlw	.2			;
	movwf	tempd1		;
dlyloop4uS
	nop					;
	decfsz	tempd1,1	;		
	goto	dlyloop4uS	;
	return				;



