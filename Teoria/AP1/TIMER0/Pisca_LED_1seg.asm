#INCLUDE <P16F628A.INC>

CONTA	EQU 0x20    ; Variável para armazenar a quantidade de estouros
		    ; 15 estouros = 1s
		    ; CLOCK = 4MHz

;------------------------------------------
; Vetores de Reset e Interrupção
;------------------------------------------
ORG 0			; Vetor de reset
    GOTO INI               ; Salta para o início do programa

ORG 4			; Vetor de interrupção
    BTFSS INTCON, T0IF	; Verifica se foi o timer0 que interrompeu, se sim, salta o próxima instrução (RETFIE)
			; FLAG T0IF = 0 ---> Não foi
			; FLAG T0IF = 1 ---> TIMER0 interrompido

    RETFIE		; Saí da rotina de interrupção
    
    BCF INTCON, T0IF	; Limpa a FLAG de interrupção do timer0
    
    BANKSEL CONTA
    DECFSZ CONTA, F	; Decresce a varíavel que conta estouros, quando ela chegar a 0 ---> Salta o RETFIE
    RETFIE
    
    MOVLW   d'15'	;Reseta a varivel que conta estouros
    MOVWF CONTA
    
    BANKSEL PORTB	; OxFF = b'11111111'
    MOVLW 0xFF		; Operação XOR com as portas RB0:RB7 (Qualquer bit XOR com 1 é invertido)
    XORWF PORTB, F	; Inverte os bits de PORTB, fazendo o estado do LED mudar
    
    RETFIE
    
   

;------------------------------------------
; Inicialização do Programa
;------------------------------------------
INI:
    ;Definindo as portas RBA como sáida
    BANKSEL TRISB
    CLRF    TRISB
    
    BANKSEL PORTB
    CLRF PORTB
    
    ;Configurando timer0
    BANKSEL OPTION_REG
    MOVLW   B'10000111' ; Habilita um prescale de 256 (3 bits menos significativos) e Desabilita
    MOVWF   OPTION_REG
    
    ;Habilitando interrupções
    BSF INTCON, T0IE
    BSF INTCON, GIE
    
    ;Iniciando contador
    BANKSEL CONTA
    MOVLW d'15'
    MOVWF CONTA
    
    
MAIN
    GOTO MAIN
    
;------------------------------------------
; Final do Programa
;------------------------------------------
END                     ; Indica o fim do programa
