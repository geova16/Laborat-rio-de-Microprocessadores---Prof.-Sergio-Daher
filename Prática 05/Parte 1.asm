#INCLUDE <P16F877A.INC>
			
 errorlevel  -302              ; suppress message 302 from list file


ad_L       EQU   0x71
ad_H       EQU   0x72

tempd1     EQU   0x73  ;;
tempd2     EQU   0x74  ;;


	ORG 0
    GOTO INI

	ORG 4
	RETFIE  ;; 

INI:
   ;------------------------------	
    BANKSEL TRISA
    MOVLW b'00000001'		;;  Dica: Os pinos ANx de entrada analógica  estão em PORTA
    MOVWF TRISA ; Dica: Os pinos Anx devem ser configurados como entradas 

    BANKSEL TRISC ;; 
    clrf	TRISC 	      ;; Dica: Os pinos de acionamento dos LEDs do BARGRAPH estão conectados a PORTC 
	  ;  Dica: Pinos para acionamento externo devem ser confirados como saídas 
   ;------------------------------	
    BANKSEL ADCON1
    movlw 	   ;; Configurar conforme pedido no guia
    movwf 	ADCON1
   ;------------------------------	

MAIN:
    CALL 	le_ad
    BANKSEL ad_H
    movfw   ad_H
    BANKSEL PORTC
    movwf 	PORTC
    GOTO 	MAIN


;==========================================
le_ad
    	BANKSEL ADCON0
   	movlw 	        ;; Configurar conforme pedido no guia
    	movwf 	ADCON0
		
        BANKSEL tempd1
        call    d10_1ms

    	BANKSEL ADCON0
   	BSF 	ADCON0, 2

        BANKSEL tempd1
        call    d10_1ms
        
    	BANKSEL ADRESL
   	MOVFW 	ADRESL
        MOVWF   ad_L

	BANKSEL ADRESH
   	MOVFW 	ADRESH
        MOVWF   ad_H

	return

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



