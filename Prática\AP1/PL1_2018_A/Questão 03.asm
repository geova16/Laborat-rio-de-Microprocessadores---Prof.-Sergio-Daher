; Programa para PIC16F628A - USART: Receber caracteres de '0' a '8' e retornar '1' a '9'
; Clock: 10 MHz

    #include <P16F628A.inc>       ; Arquivo de definição do microcontrolador

    __config _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF

;------------------------------------------
; Definição de constantes
;------------------------------------------


;------------------------------------------
; Variáveis
;------------------------------------------
    cblock  0x20                   ; Início da RAM para variáveis
        received_char             ; Caractere recebido via USART
    endc

;------------------------------------------
; Inicialização
;------------------------------------------
    org 0x0000                    ; Início do programa
    goto    Start                    ; Pula para o início do programa
    
    org 0x0004
    goto    Receba
    retfie

Start:
    ; Configuração USART
    banksel TXSTA
    movlw   b'00100100'           ; Configurações: BRGH = 1, modo assíncrono
    movwf   TXSTA                 ; Habilita transmissão

    banksel RCSTA
    movlw   b'10010000'           ; Habilita recepção e módulo serial
    movwf   RCSTA

    banksel SPBRG
    movlw   d'25'                 ; Configura baud rate: 9600 bps com Fosc = 10 MHz
    movwf   SPBRG

    banksel PIR1
    bcf     PIR1, RCIF            ; Limpa flag de recepção
    
    banksel INTCON
    bsf	INTCON, GIE
    bsf INTCON,	T0IE
    
    BANKSEL TRISB
    MOVLW 0x00
    MOVWF TRISB

;------------------------------------------
; Loop principal
;------------------------------------------
MainLoop:

    goto    MainLoop              ; Volta para o loop principal

;------------------------------------------
; Sub-rotinas
;------------------------------------------
Receba:
    banksel PIR1
    bcf	PIR1, RCIF
    
    banksel RCREG
    movf    RCREG, W              ; Lê o dado recebido
    movwf   received_char         ; Armazena o caractere recebido
    
    banksel received_char
    movf    received_char, W      ; Move o caractere recebido para W
    addlw   d'1'                  ; Incrementa o valor ASCII em 1
    
    banksel PIR1
    bsf     PIR1, TXIF            ; Sinaliza que o buffer está pronto para transmissão
    btfss   PIR1, TXIF  ; Verifica se o buffer de transmissão está vazio
    goto    $-1          ; Aguarda até estar pronto

    banksel TXREG
    movwf   TXREG                 ; Envia o caractere incrementado

    return

    end
