#INCLUDE <P16F628A.INC>   ; Inclui o arquivo com definições específicas do PIC16F628A

; Definição de registradores para a sub-rotina de atraso
at_x       EQU   0x70     ; Registrador para o contador externo do atraso
at_tmp1    EQU   0x71     ; Registrador para o contador interno do atraso
at_tmp2    EQU   0x72     ; Registrador para o contador mais interno do atraso
sentido    EQU   0x73     ; Registrador para armazenar o sentido do motor

;-----------------------------------------
; Vetores de Reset e Interrupção
;-----------------------------------------
ORG 0x00                 ; Vetor de reset
GOTO INICIO              ; Salta para o início do programa

ORG 0x04                 ; Vetor de interrupção
RETFIE                   ; Retorna da interrupção (não tratada neste programa)

;-----------------------------------------
; Inicialização do Microcontrolador
;-----------------------------------------
INICIO:  
      ; Configura o PORTA como saída
      BANKSEL TRISA      ; Seleciona o banco de memória para acessar TRISA
      MOVLW 0x00         ; Configura todos os pinos de PORTA como saída (TRISA = 0x00)
      MOVWF TRISA        ; Escreve o valor no registrador TRISA

      ; Configura o PORTB como entrada
      BANKSEL TRISB      ; Seleciona o banco de memória para acessar TRISB
      MOVLW 0xFF         ; Configura todos os pinos de PORTB como entrada (TRISB = 0xFF)
      MOVWF TRISB        ; Escreve o valor no registrador TRISB

      ; Inicializa o registrador de sentido
      BANKSEL sentido    ; Seleciona o banco de memória para acessar o registrador sentido
      CLRF sentido       ; Inicializa o sentido como 0 (giro em um sentido padrão)

;-----------------------------------------
; Programa Principal
;-----------------------------------------
MAIN:
  ; Verifica o estado do botão em RB0
  BANKSEL PORTB          ; Seleciona o banco de memória para acessar PORTB

  BTFSS PORTB, 0         ; Testa o bit 0 de PORTB 
  CALL sentido_1         ; Chama a rotina para o sentido 1

  BTFSC PORTB, 0
  CALL sentido_2         ; Chama a rotina para o sentido 2

  GOTO MAIN              ; Volta ao início do programa principal (loop infinito)


;-----------------------------------------
; Sub-rotina para o sentido 1
;-----------------------------------------
sentido_1:
  MOVLW B'00000000'
  
  MOVLW B'00001001'      ; Define o padrão 0x09 (passo 1)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000011'      ; Define o padrão 0x03 (passo 2)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000110'      ; Define o padrão 0x06 (passo 3)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00001100'      ; Define o padrão 0x0C (passo 4)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  RETURN                 ; Retorna ao programa principal

;-----------------------------------------
; Sub-rotina para o sentido 2
;-----------------------------------------
sentido_2:
    
  MOVLW B'00000000'
  
  MOVLW B'00001100'      ; Define o padrão 0x0C (passo 4)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000110'      ; Define o padrão 0x06 (passo 3)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000011'      ; Define o padrão 0x03 (passo 2)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00001001'      ; Define o padrão 0x09 (passo 1)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  RETURN                 ; Retorna ao programa principal

;-----------------------------------------
; Sub-rotina 'passo': Envia o padrão para PORTA e realiza atraso
;-----------------------------------------
passo:
  BANKSEL PORTA          ; Seleciona o banco de memória para acessar PORTA
  MOVWF PORTA            ; Escreve o padrão recebido em PORTA
  MOVLW .80              ; Define o atraso com valor inicial de 80 (em X)
  CALL atraso            ; Chama a sub-rotina de atraso
  RETURN                 ; Retorna ao programa principal

;-----------------------------------------
; Sub-rotina 'atraso': Gera um atraso configurável
;-----------------------------------------
atraso:
  BANKSEL at_x           ; Seleciona o banco de memória para acessar at_x
  MOVWF at_x             ; Armazena o valor inicial em at_x (contador externo)
  MOVLW .50              ; Configura o contador interno com 50
at1:  MOVWF at_tmp1       ; Armazena 50 no registrador at_tmp1 (contador interno)
at2:  MOVWF at_tmp2       ; Armazena 50 no registrador at_tmp2 (contador mais interno)
at3:  DECFSZ at_tmp2      ; Decrementa at_tmp2 e verifica se chegou a zero
  GOTO at3               ; Repete o loop se at_tmp2 não for zero
  DECFSZ at_tmp1         ; Decrementa at_tmp1 e verifica se chegou a zero
  GOTO at2               ; Repete o loop se at_tmp1 não for zero
  DECFSZ at_x            ; Decrementa at_x e verifica se chegou a zero
  GOTO at1               ; Repete o loop se at_x não for zero
  RETURN                 ; Retorna ao chamador quando o atraso termina

;-----------------------------------------
; Final do Programa
;-----------------------------------------
END                     ; Indica o fim do programa
