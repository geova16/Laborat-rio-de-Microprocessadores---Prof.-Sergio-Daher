; Programa para PIC16F628A - Geração de PWM de 10Hz e 2% de Duty Cycle
; Utilizando o módulo CCP (PWM)
; Clock: 10 MHz

    #include <P16F628A.inc>       ; Arquivo de definição do microcontrolador

    __config _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_ON & _MCLRE_OFF

;------------------------------------------
; Inicialização
;------------------------------------------
    org 0x0000                    ; Início do programa
    goto inicio                    ; Pula para o início do programa

    org 0x0004                    ; Vetor de interrupção
    retfie                        ; Retorna da interrupção

inicio:
    ; Configuração dos registradores
    banksel TRISB                 ; Banco 1
    movlw   0x00                  ; Configura PORTB como saída
    movwf   TRISB

    movlw   b'00001100'           ; Configura Timer2: Prescaler 1:16
    movwf   T2CON                 ; Timer2 ligado

    movlw   0xFF                  ; Configura PR2 para definir o período
                                   ; Período PWM = [(PR2) + 1] * 4 * Tosc * (TMR2 Prescaler)
                                   ; Para 10 Hz: PR2 = ((1/10)/(4*0.4e-6*16))-1 = 156 (aprox. 0x9C)
    movwf   PR2                   ; Define período do PWM

    banksel  CCPR1L               ; Banco 0
    movlw   d'3'                  ; Duty Cycle = 2% (3/1024 de ciclo total)
    movwf   CCPR1L                ; Bits mais significativos do duty cycle
    
    bsf     CCP1CON, CCP1M3       ; Configura CCP1 no modo PWM
    bsf     CCP1CON, CCP1M2       
    
    bsf     T2CON, TMR2ON         ; Liga Timer2 para iniciar PWM

;------------------------------------------
; Loop principal
;------------------------------------------
MainLoop:
    goto    MainLoop              ; Loop infinito

    end
