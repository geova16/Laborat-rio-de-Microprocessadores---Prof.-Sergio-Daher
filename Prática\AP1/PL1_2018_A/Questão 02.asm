#INCLUDE <P16F628A.INC>

CONTA	EQU   0x20
DUTY_CYCLE  EQU	0x21
DUTY_CYCLE_CCPR1L   EQU	0x22
DUTY_CYCLE_CCP1CON  EQU	0x23

	
tempd1     EQU   0x73 
tempd2     EQU   0x74  
    
ORG  0x00
  GOTO INICIO
ORG  0x04
  
  BANKSEL INTCON
  BCF	INTCON,	INTF
  
  BANKSEL   DUTY_CYCLE
  MOVLW	d'8'
  ADDWF	DUTY_CYCLE, F
  
  MOVF	DUTY_CYCLE, W		; Armazena o valor do duty cycle atual em W
  MOVWF	DUTY_CYCLE_CCPR1L	; Move de W pra DUTY_CYCLE_CCPR1L
  RRF DUTY_CYCLE_CCPR1L, 1	; Rotaciona pra direita
  RRF DUTY_CYCLE_CCPR1L, 1  
  
  MOVF	DUTY_CYCLE_CCPR1L, W	; Move o conteúdo do registrador (já rotacionado 2 casas pra direita)
  
  BANKSEL CCPR1L
  MOVWF	CCPR1L			; Move o conteúdo pra ajuste do duty cycle
  
  BANKSEL   DUTY_CYCLE
  BTFSS	DUTY_CYCLE, 1
  BCF	CCP1CON, 5
  BTFSC	DUTY_CYCLE, 1
  BSF	CCP1CON, 5
  
  BTFSS	DUTY_CYCLE, 0
  BCF	CCP1CON, 4
  BTFSC	DUTY_CYCLE, 0
  BSF	CCP1CON, 4
  
  call d10_1ms
  
  RETFIE

INICIO:
  BANKSEL PR2
  MOVLW  d'19'
  MOVWF  PR2

  BANKSEL  CCP1CON
  MOVLW  b'00001111'
  MOVWF  CCP1CON

  BANKSEL  CCPR1L
  MOVLW  b'00000010'
  MOVWF  CCPR1L
  
  BANKSEL   DUTY_CYCLE
  MOVLW	d'8'
  MOVWF	DUTY_CYCLE

  BANKSEL  T2CON
  MOVLW  b'00000110'
  MOVWF  T2CON

  BANKSEL  TRISB
  MOVLW	b'00000001'
  MOVWF	TRISB	
  
  BANKSEL   OPTION_REG
  BSF	OPTION_REG, 7
  
  BANKSEL   INTCON
  BSF	INTCON, GIE
  BSF	INTCON, INTE
  
MAIN:
 
  GOTO MAIN

  
;******************
;1 ms delay routine (10 MHz)
;******************
d10_1ms
	movlw	.4			
	movwf	tempd1		
dly_1my	movlw	.204	
	movwf	tempd2		 
dly_1mx	decfsz	tempd2,1	
	goto	dly_1mx		
	clrwdt				  
	decfsz	tempd1,1			
	goto	dly_1my		
	return				
  
END
