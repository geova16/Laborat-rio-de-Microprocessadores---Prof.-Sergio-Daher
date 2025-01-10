#INCLUDE <P16F877A.INC>

errorlevel  -302              ; Suprime a mensagem 302 do arquivo de lista

; Definição de registradores
ad_L       EQU   0x71         
ad_H       EQU   0x72        
tempd1     EQU   0x73         
tempd2     EQU   0x74        

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

    BANKSEL TRISB
    CLRF TRISB
    
    ; Configuração do ADC
    BANKSEL ADCON1            ; Seleciona o banco de memória que contém ADCON1
    CLRF    ADCON1
    
    BANKSEL PORTC
    CLRF    PORTC

MAIN:
    ; Loop principal
    CALL le_ad                ; Chama a sub-rotina para realizar a leitura do ADC
    
    BANKSEL ad_H              ; Seleciona o banco onde ad_H está localizado
    MOVFW ad_H                ; Move o byte mais significativo do resultado para o W
    
    BANKSEL PORTC             ; Seleciona o banco de PORTC
    MOVWF PORTC               ; Exibe o valor do byte alto no PORTC
    
    BANKSEL ad_L
    MOVFW ad_L
    
    BANKSEL PORTB
    MOVWF   PORTB
    GOTO MAIN                 ; Retorna ao início do loop principal
    

; ------------------------------
; Sub-rotina para leitura do ADC
le_ad:
    BANKSEL ADCON0            ; Seleciona o banco que contém ADCON0
    MOVLW   b'01000001'
    MOVWF   ADCON0
    
    BSF ADCON0, GO
    
    BTFSC ADCON0, GO
    GOTO $-1
    
    ; Captura o resultado do ADC
    BANKSEL ADRESL            ; Seleciona o banco onde ADRESL está localizado
    MOVFW ADRESL              ; Move o byte menos significativo para W
    MOVWF ad_L                ; Armazena o byte em ad_L

    BANKSEL ADRESH            ; Seleciona o banco onde ADRESH está localizado
    MOVFW ADRESH              ; Move o byte mais significativo para W
    MOVWF ad_H                ; Armazena o byte em ad_H

    RETURN                    ; Retorna para o programa principal

END
