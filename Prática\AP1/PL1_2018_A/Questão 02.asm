; Programa para PIC16F628A - Geração de PWM de 8kHz e 10% de Duty Cycle
; Alteração do Duty Cycle via entrada
; Clock: 10 MHz

    #include <P16F628A.inc>       ; Arquivo de definição do microcontrolador

    __config _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF

;------------------------------------------
; Definição de constantes
;------------------------------------------

#define BUTAO_PIN PORTB,0         ; Botão de entrada no pino RB0

;------------------------------------------
; Variáveis
;------------------------------------------
    cblock  0x20                   ; Início da RAM para variáveis
        duty_cycle                ; Duty cycle atual (em passos de 10%)
        TEMP1                     ; Temporário para atraso
    endc

;------------------------------------------
; Inicialização
;------------------------------------------
    org 0x0000                    ; Início do programa
    goto Start                    ; Pula para o início do programa

    org 0x0004                    ; Vetor de interrupção
    retfie                        ; Retorna da interrupção

Start:
    ; Configuração dos registradores
    banksel TRISB
    movlw   0x01                  ; Configura RB0 como entrada e restante como saída
    movwf   TRISB

    banksel T2CON
    movlw   b'00000100'           ; Configura Timer2: Prescaler 1:4
    movwf   T2CON                 ; Timer2 ligado

    movlw   0x7C                  ; Configura PR2 para definir o período
                                   ; Período PWM = [(PR2) + 1] * 4 * Tosc * (TMR2 Prescaler)
                                   ; Para 8 kHz: PR2 = ((1/8k)/(4*0.4e-6*4))-1 = 124 (0x7C)
    BANKSEL PR2    
    movwf   PR2                   ; Define período do PWM

    banksel CCP1CON
    movlw   d'26'                 ; Duty Cycle inicial = 10% (26/1024 de ciclo total)
    movwf   CCPR1L                ; Bits mais significativos do duty cycle
    movlw   b'00001100'           ; Bits menos significativos para duty cycle
    movwf   CCP1CON

    bsf     CCP1CON, CCP1M3       ; Configura CCP1 no modo PWM
    bsf     CCP1CON, CCP1M2       

    bsf     T2CON, TMR2ON         ; Liga Timer2 para iniciar PWM

;------------------------------------------
; Loop principal
;------------------------------------------
MainLoop:
    btfss   BUTAO_PIN             ; Verifica se o botão foi pressionado
    goto    MainLoop              ; Se não pressionado, continua no loop

    call    IncrementaDutyCycle   ; Incrementa o duty cycle
    call    atraso                ; Chama delay para evitar leituras múltiplas
    goto    MainLoop              ; Retorna ao loop principal

;------------------------------------------
; Sub-rotinas
;------------------------------------------
IncrementaDutyCycle:
    movlw   d'26'
    addwf   duty_cycle, F

    movf    duty_cycle, W
    movwf   CCPR1L                ; Atualiza o duty cycle no registrador CCPR1L

    return

atraso:
    movlw   d'255'                ; Loop externo
DelayOuter:
    movwf   TEMP1
DelayInner:
    decfsz  TEMP1, F              ; Decrementa TEMP1
    goto    DelayInner            ; Continua até TEMP1 zerar
    decfsz  W, F                  ; Decrementa loop externo
    goto    DelayOuter            ; Continua até W zerar
    return

    end
