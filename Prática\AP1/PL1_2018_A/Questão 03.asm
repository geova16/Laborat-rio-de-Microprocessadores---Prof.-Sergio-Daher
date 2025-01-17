#INCLUDE <P16F628A.INC>

CONTA	EQU   0x20
DUTY_CYCLE  EQU	0x21
DUTY_CYCLE_CCPR1L   EQU	0x22
DUTY_CYCLE_CCP1CON  EQU	0x23
    
ORG  0x00
     
  GOTO INICIO
  
ORG  0x04

  RETFIE

INICIO:
  BANKSEL PR2
  MOVLW  d'155'
  MOVWF  PR2

  BANKSEL  CCP1CON
  MOVLW  b'00001111'
  MOVWF  CCP1CON

  BANKSEL  CCPR1L
  MOVLW  b'00000111'
  MOVWF  CCPR1L
  
  BANKSEL   DUTY_CYCLE
  MOVLW	d'0'
  MOVWF	DUTY_CYCLE

  BANKSEL  T2CON
  MOVLW  b'00000100'
  MOVWF  T2CON	
  
  BANKSEL   OPTION_REG
  BSF	OPTION_REG, 7
  
  ; Configuração de TRISA e TRISB
  BANKSEL TRISB
  CLRF	TRISB

  ; Configuração do módulo UART
  BANKSEL SPBRG      ; Seleciona o banco para acessar SPBRG
  movlw d'325'          ; Configura baud rate para 19200 (exemplo)
  movwf SPBRG        ; Escreve no registrador SPBRG
    
  BANKSEL TXSTA      ; Seleciona o banco para acessar TXSTA
  bsf  TXSTA,TXEN    ; Habilita o transmissor UART
  bsf  TXSTA,BRGH    ; Configura alta velocidade UART
    
  BANKSEL RCSTA      ; Seleciona o banco para acessar RCSTA
  bsf  RCSTA,SPEN    ; Habilita o módulo UART
  bsf  RCSTA,CREN    ; Habilita recepção contínua

  ; Configuração do registrador INTCON
  BANKSEL INTCON     ; Seleciona o banco para acessar INTCON
  CLRF	INTCON
  
MAIN:
    
  ; Verifica se há dado recebido pela UART
   BANKSEL PIR1       ; Seleciona o banco para acessar PIR1
   BTFSC PIR1,RCIF    ; Testa se o bit RCIF (flag de recepção UART) está setado
   CALL  rec_e_trata  ; Se RCIF = 1, chama a sub-rotina para tratar o dado recebido
 
  GOTO MAIN

  
  rec_e_trata
    BANKSEL RCREG
    MOVF    RCREG, W
    SUBLW   0x41	;A em hexa
    
    BTFSC   STATUS, Z
    GOTO    RECEBEU_A
    
    BANKSEL RCREG
    MOVF    RCREG, W
    SUBLW   0x42	;b em hexa
    
    BTFSC   STATUS, Z
    GOTO    RECEBEU_B
    
    BANKSEL RCREG
    MOVF    RCREG, W
    SUBLW   0x43	;c em hexa
    
    BTFSC   STATUS, Z
    GOTO    RECEBEU_C
    
    return
    
    RECEBEU_A:
	MOVLW	d'156'
	call grava_pwm
	return
    
    RECEBEU_B:
	MOVLW	d'312'
	call grava_pwm
	return
	
    RECEBEU_C:
	MOVLW	d'562'
	call grava_pwm
	return
    

	
    return				
  
grava_pwm
	    BANKSEL   DUTY_CYCLE
	    
	    MOVWF	DUTY_CYCLE

	    MOVF	DUTY_CYCLE, W		; Armazena o valor do duty cycle atual em W
	    MOVWF	DUTY_CYCLE_CCPR1L	; Move de W pra DUTY_CYCLE_CCPR1L
	    RRF DUTY_CYCLE_CCPR1L, 1	; Rotaciona pra direita
	    RRF DUTY_CYCLE_CCPR1L, 1  

	    MOVF	DUTY_CYCLE_CCPR1L, W	; Move o conteúdo do registrador (já rotacionado 2 casas pra direita)

	    BANKSEL CCPR1L
	    MOVWF	CCPR1L			; Move o conteúdo pra ajuste do duty cycle

	    ; Coloca o conteudo dos dois bits menos significativos nos bits 4 e 5 do registrador ccp1con

	    BANKSEL   DUTY_CYCLE
	    BTFSS	DUTY_CYCLE, 1
	    BCF	CCP1CON, 5
	    BTFSC	DUTY_CYCLE, 1
	    BSF	CCP1CON, 5

	    BTFSS	DUTY_CYCLE, 0
	    BCF	CCP1CON, 4
	    BTFSC	DUTY_CYCLE, 0
	    BSF	CCP1CON, 4
	return
    
END
