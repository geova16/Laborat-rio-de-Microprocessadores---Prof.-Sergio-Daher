#INCLUDE <P16F628A.INC>
CONTA EQU 0x20 ; Variável pra armazenar a quantidade de estouros
CONTADOR EQU 0x21
CONTADOR_AUX	EQU 0x22

ORG 0
    GOTO INICIO
ORG 4
    BTFSS INTCON, TMR0IF    ; 1 = Interrupção aconteceu --> Pula o RETFIE
			    ; 0 = Interrupção não aconteceu --> Não pula o RETFIE
    RETFIE
    
    BANKSEL INTCON
    BCF INTCON, TMR0IF ; Limpa a flag para a próxima detecção
    
    BANKSEL CONTA
    DECFSZ CONTA, F ; Decresce a varíavel que conta estouros, quando ela chegar a 0 ---> Salta o RETFIE
    RETFIE
    MOVLW d'19'
    MOVWF CONTA ; Reseta a contagem
    
    BANKSEL CONTADOR
    INCF    CONTADOR, F	    ; Incrementa o contador binário
    
    MOVLW   b'00000011'
    
    SUBWF   CONTADOR, W	    ; Subtrai CONTADOR de 3 para verificar se é 3
    
    BTFSC   STATUS, Z	    ; Verifica se a subtração é igual a 0
    CLRF    CONTADOR	    ; Se for o --> contador é 3 --> Limpa contador
    
    MOVF    CONTADOR, W
    
    BANKSEL CONTADOR_AUX
    CLRF    CONTADOR_AUX
    MOVWF   CONTADOR_AUX
    
    ;ROTACIONA O CONTADOR_AUX 4 CASAS PRA ESQUERDA PARA SE ADEQUAR A RB4 E RB5
    
    RLF CONTADOR_AUX, F
    RLF	CONTADOR_AUX, F
    RLF CONTADOR_AUX, F
    RLF	CONTADOR_AUX, F
    
    MOVF    CONTADOR_AUX, W
    
    BANKSEL PORTB
    MOVWF   PORTB
    
    RETFIE

INICIO:
    BANKSEL INTCON
    MOVLW b'10100000' ; (BSF INTCON, GIE - Habilita interrupção global e BSF INTCON, T0IE ;- Habilita interrupção do Timer0)
    MOVWF INTCON
    
    BANKSEL OPTION_REG
    MOVLW b'00000111' ; PRESCALE = 256
    MOVWF OPTION_REG
    
    BANKSEL TRISB
    CLRF TRISB ; Define PORTB todo como saída.
    
    BANKSEL CONTA
    MOVLW   d'19'	;--> 38 ESTOUROS POR SEGUNDO --> 2Hz --> 2 INTERRUPÇÕES POR SEGUNDO --> 19 ESTOUROS POR MEIO SEGUNDO --> 1 INTERRUPÇÃO POR 0,5 SEGUNDOS
    MOVWF   CONTA
    
    BANKSEL CONTADOR
    CLRF    CONTADOR

MAIN:
    GOTO MAIN
    
END
