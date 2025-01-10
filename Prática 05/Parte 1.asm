#INCLUDE <P16F877A.INC>

errorlevel  -302              ; Suprime a mensagem 302 do arquivo de lista

; Definição de registradores
ad_L       EQU   0x71         ; Registrador para armazenar o byte menos significativo do ADC
ad_H       EQU   0x72         ; Registrador para armazenar o byte mais significativo do ADC
tempd1     EQU   0x73         ; Registrador temporário 1
tempd2     EQU   0x74         ; Registrador temporário 2

; Vetor de reset e interrupção
ORG 0
    GOTO INI                  ; Redireciona para o início do programa

ORG 4
    RETFIE                    ; Retorno para interrupções (não utilizado no momento)

; ------------------------------
; Rotina de inicialização
INI:
    ; Configuração dos pinos de entrada e saída
    BANKSEL TRISA             ; Seleciona o banco de memória que contém TRISA
    MOVLW b'00000001'         ; Configura RA0 (AN0) como entrada analógica
    MOVWF TRISA               ; Grava a configuração em TRISA

    BANKSEL TRISC             ; Seleciona o banco de memória que contém TRISC
    CLRF TRISC                ; Configura todos os pinos de PORTC como saída

    ; Configuração do ADC
    BANKSEL ADCON1            ; Seleciona o banco de memória que contém ADCON1
    BCF ADCON1, ADFM          ; Justificação à esquerda
    BCF ADCON1, PCFG3         ; Configura os pinos AN0-AN7 como analógicos
    BCF ADCON1, PCFG2
    BSF ADCON1, PCFG1
    BCF ADCON1, PCFG0
    
    BANKSEL PORTC
    CLRF    PORTC

MAIN:
    ; Loop principal
    CALL le_ad                ; Chama a sub-rotina para realizar a leitura do ADC
    
    
    BANKSEL ad_H              ; Seleciona o banco onde ad_H está localizado
    MOVFW ad_H                ; Move o byte mais significativo do resultado para o W
    BANKSEL PORTC             ; Seleciona o banco de PORTC
    MOVWF PORTC               ; Exibe o valor do byte alto no PORTC
    GOTO MAIN                 ; Retorna ao início do loop principal

; ------------------------------
; Sub-rotina para leitura do ADC
le_ad:
    BANKSEL ADCON0            ; Seleciona o banco que contém ADCON0
    BSF ADCON0, ADCS1         ; Configura o clock do ADC para FOSC/32
    BCF ADCON0,	CHS2         
    BCF ADCON0,	CHS1         
    BCF ADCON0,	CHS0
    BSF ADCON0, ADON          ; Liga o módulo ADC

    ; Atraso para estabilização do ADC
    ;BANKSEL tempd1            ; Seleciona o banco para variáveis temporárias
    ;CALL d10_1ms              ; Chama a rotina de atraso de 1 ms

    ; Inicia a conversão ADC
    BANKSEL ADCON0            ; Seleciona o banco de ADCON0
    BSF ADCON0, 6             ; Seta o bit GO/DONE para iniciar a conversão

    ; Aguarda a conclusão da conversão (tempo adicional)
    BANKSEL tempd1            ; Seleciona o banco para variáveis temporárias
    CALL d10_1ms              ; Chama a rotina de atraso de 1 ms

    ; Captura o resultado do ADC
    BANKSEL ADRESL            ; Seleciona o banco onde ADRESL está localizado
    MOVFW ADRESL              ; Move o byte menos significativo para W
    MOVWF ad_L                ; Armazena o byte em ad_L

    BANKSEL ADRESH            ; Seleciona o banco onde ADRESH está localizado
    MOVFW ADRESH              ; Move o byte mais significativo para W
    MOVWF ad_H                ; Armazena o byte em ad_H

    RETURN                    ; Retorna para o programa principal

; ------------------------------
; Rotina de atraso de 1 ms
; (baseada em 10 MHz de clock)
d10_1ms:
    MOVLW .4                  ; Configura o contador externo para 4 ciclos
    MOVWF tempd1              ; Armazena no registrador temporário tempd1
dly_1my:
    MOVLW .204                ; Configura o contador interno para 204 ciclos
    MOVWF tempd2              ; Armazena no registrador temporário tempd2
dly_1mx:
    DECFSZ tempd2, 1          ; Decrementa o contador interno
    GOTO dly_1mx              ; Continua decrementando até zerar
    CLRWT                     ; Limpa o watchdog timer
    DECFSZ tempd1, 1          ; Decrementa o contador externo
    GOTO dly_1my              ; Continua decrementando até zerar
    RETURN                    ; Retorna ao programa principal

; ------------------------------
; Rotina de atraso de 4,4 µs
; (baseada em 10 MHz de clock)
dly_4uS:
    MOVLW .2                  ; Configura o contador interno para 2 ciclos
    MOVWF tempd1              ; Armazena no registrador temporário tempd1
dlyloop4uS:
    NOP                       ; Instrução de espera (1 ciclo)
    DECFSZ tempd1, 1          ; Decrementa o contador interno
    GOTO dlyloop4uS           ; Continua decrementando até zerar
    RETURN                    ; Retorna ao programa principal
END
