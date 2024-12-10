#INCLUDE <P16F628A.INC>   ; Inclui o arquivo com definições específicas do PIC16F628A

; Definição de registradores para a sub-rotina de atraso
at_x       EQU   0x70     ; Registrador para o contador externo do atraso
at_tmp1    EQU   0x71     ; Registrador para o contador interno do atraso
at_tmp2    EQU   0x72     ; Registrador para o contador mais interno do atraso

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

      ; Configura o módulo CCP1 para PWM
      BANKSEL CCP1CON    ; Seleciona o banco de memória para acessar CCP1CON
      MOVLW 0x0C         ; Configura o CCP1 no modo PWM (0x0C)
      MOVWF CCP1CON      ; Escreve o valor no registrador CCP1CON

      ; Configura o registrador PR2 para o período do PWM
      BANKSEL PR2        ; Seleciona o banco de memória para acessar PR2
      MOVLW 0x80         ; Define o período do PWM (PR2 = 0x80)
      MOVWF PR2          ; Escreve o valor no registrador PR2

      ; Configura o registrador CCPR1L para o duty cycle do PWM
      BANKSEL CCPR1L     ; Seleciona o banco de memória para acessar CCPR1L
      MOVLW 0x60         ; Define o duty cycle do PWM (CCPR1L = 0x60)
      MOVWF CCPR1L       ; Escreve o valor no registrador CCPR1L

      ; Configura o Timer2 para ativar o PWM
      BANKSEL T2CON      ; Seleciona o banco de memória para acessar T2CON
      MOVLW 0x04         ; Configura o Timer2 com prescaler = 1 (T2CON = 0x04)
      MOVWF T2CON        ; Escreve o valor no registrador T2CON

;-----------------------------------------
; Programa Principal
;-----------------------------------------
MAIN:
  ; Envia padrões de controle para PORTA (motor de passo, por exemplo)
  MOVLW B'00001001'      ; Define o padrão 0x09 (passo 1)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000011'      ; Define o padrão 0x03 (passo 2)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00000110'      ; Define o padrão 0x06 (passo 3)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  MOVLW B'00001100'      ; Define o padrão 0x0C (passo 4)
  CALL passo             ; Chama a sub-rotina para aplicar o padrão e realizar o atraso

  GOTO MAIN              ; Volta ao início do programa principal (loop infinito)

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
