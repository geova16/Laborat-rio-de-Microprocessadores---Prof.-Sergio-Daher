
    LIST P=16F877A          
    INCLUDE <P16F877A.INC>  
    
    CBLOCK 0x20             
        TEMP                
    ENDC
 
    ORG 0x0000              

; Configuração inicial
START:
    BANKSEL ADCON1          ; Seleciona o banco onde está o registrador ADCON1
    CLRF ADCON1             ; Configura todos os pinos ANx como analógicos, referência VDD/VSS
    
    BANKSEL TRISA           ; Seleciona o banco onde está o registrador TRISA
    MOVLW 0xFF              ; Configura todos os pinos de PORTA como entrada
    MOVWF TRISA
    
    BANKSEL TRISC           ; Seleciona o banco onde está o registrador TRISC
    CLRF TRISC              ; Configura todos os pinos de PORTC como saída
    
    BANKSEL ADCON0          ; Seleciona o banco onde está o registrador ADCON0
    MOVLW b'1000001'              ; Configura ADC: ativa o módulo e seleciona o canal AN0
    MOVWF ADCON0

MAIN_LOOP:
    BSF ADCON0, GO_DONE     ; Inicia a conversão ADC
WAIT_ADC:
    BTFSC ADCON0, GO_DONE   ; Aguarda até que a conversão seja concluída
    GOTO WAIT_ADC
    MOVF ADRESH, W          ; Move o resultado (8 bits menos significativos) para W
    MOVWF PORTC             ; Escreve o resultado no PORTC
    GOTO MAIN_LOOP          ; Repete o processo
  
   END
