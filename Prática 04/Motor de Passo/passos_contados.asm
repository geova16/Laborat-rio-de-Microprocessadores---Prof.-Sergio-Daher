#INCLUDE <P16F628A.INC>

#DEFINE LED1   PORTB,6        ; Define LED1 no pino RB6
#DEFINE LED2   PORTB,7        ; Define LED2 no pino RB7

at_x        EQU   0x70        ; Registrador para contador de atraso externo
at_tmp1     EQU   0x71        ; Registrador para contador de atraso interno
at_tmp2     EQU   0x72        ; Registrador para contador mais interno

conta_passos EQU 0x73         ; Registrador para contar passos
temp        EQU   0x74        ; Registrador temporário usado para armazenar dados recebidos
resultado   EQU   0x75        ; Registrador para calcular (0x50 - X)
direcao     EQU   0x76        ; Define o sentido de rotação (1 para horário, 0 para anti-horário)

;------------------------------------------
; Vetores de Reset e Interrupção
;------------------------------------------
ORG 0                  ; Vetor de reset
GOTO INI               ; Salta para o início do programa

ORG 4                  ; Vetor de interrupção
RETFIE                 ; Retorna da interrupção

;------------------------------------------
; Inicialização do Programa
;------------------------------------------
INI:
    ; Configuração do registrador OPTION_REG
    BANKSEL OPTION_REG ; Seleciona o banco para acessar OPTION_REG
    movlw   0x80       ; Configura Timer0 com prescaler atribuído ao WDT
    movwf   OPTION_REG ; Escreve a configuração em OPTION_REG

    ; Configuração de TRISA e TRISB
    BANKSEL TRISA      ; Seleciona o banco para acessar TRISA
    movlw 0x00         ; Configura todos os pinos de PORTA como saída
    movwf TRISA        ; Escreve no registrador TRISA
    
    ; Configuração do módulo UART
    BANKSEL SPBRG      ; Seleciona o banco para acessar SPBRG
    movlw .64          ; Configura baud rate para 9600 (exemplo)
    movwf SPBRG        ; Escreve no registrador SPBRG
    BANKSEL TXSTA      ; Seleciona o banco para acessar TXSTA
    bsf  TXSTA,TXEN    ; Habilita o transmissor UART
    bsf  TXSTA,BRGH    ; Configura alta velocidade UART
    BANKSEL RCSTA      ; Seleciona o banco para acessar RCSTA
    bsf  RCSTA,SPEN    ; Habilita o módulo UART
    bsf  RCSTA,CREN    ; Habilita recepção contínua

    ; Configuração do registrador INTCON
    BANKSEL INTCON     ; Seleciona o banco para acessar INTCON
    movlw 0x00         ; Desabilita todas as interrupções
    movwf INTCON       ; Escreve no registrador INTCON

;------------------------------------------
; Loop Principal
;------------------------------------------
MAIN:
    ; Aguarda um byte via UART
    BANKSEL PIR1       ; Seleciona o banco para acessar PIR1
    BTFSS PIR1,RCIF    ; Testa se o bit RCIF (flag de recepção UART) está setado
    GOTO MAIN          ; Se não houver dado, continua aguardando

    ; Recebe o byte via UART e processa
    CALL rec_e_trata   ; Chama a sub-rotina para tratar o dado recebido
    GOTO MAIN          ; Retorna ao início do loop principal

;------------------------------------------
; Sub-rotina para Recepção e Tratamento do Dado
;------------------------------------------
rec_e_trata:
    BANKSEL RCREG      ; Seleciona o banco para acessar RCREG
    movfw RCREG        ; Move o dado recebido de RCREG para WREG
    movwf temp         ; Armazena o dado recebido em "temp"

    ; Calcula (0x50 - X)
    movlw 0x50         ; Carrega o valor 0x50 em WREG
    subwf temp,W       ; Subtrai o valor recebido de 0x50
    movwf resultado    ; Armazena o resultado

    ; Determina o sentido de rotação
    btfsc STATUS,C     ; Se o resultado é negativo (carry setado),
    clrf direcao       ; Direção = 0 (anti-horário)
    
    btfss STATUS,C     ; Caso contrário,
    movlw 0x01         ; Direção = 1 (horário)
    movwf direcao

    ; Converte o valor absoluto do resultado
    btfsc STATUS,C     ; Se carry está setado, o valor é negativo
    comf resultado,F   ; Complementa o resultado para obter o valor absoluto

    ; Armazena o número de passos e inicia o movimento
    movf resultado,W   ; Carrega o valor absoluto em WREG
    movwf conta_passos ; Armazena no contador de passos
    CALL conta         ; Inicia o movimento

    RETURN             ; Retorna para o chamador

;------------------------------------------
; Movimento do Motor Baseado na Direção
;------------------------------------------
conta:
    DECFSZ conta_passos ; Decrementa conta_passos e verifica se chegou a zero
    GOTO passos         ; Realiza um passo se ainda não chegou a zero
    RETURN              ; Retorna quando todos os passos foram concluídos

passos:
    btfsc direcao,0     ; Verifica a direção: 1 = horário, 0 = anti-horário
    GOTO horario        ; Vai para o movimento horário
    
    btfss direcao, 0
    GOTO antihorario    ; Vai para o movimento anti-horário

horario:
    ; Sequência para giro horário
    MOVLW B'00001001'  ; Define o padrão 0x09 (passo 1)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00000011'  ; Define o padrão 0x03 (passo 2)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00000110'  ; Define o padrão 0x06 (passo 3)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00001100'  ; Define o padrão 0x0C (passo 4)
    CALL atraso        ; Aplica o padrão e realiza o atraso
    RETURN

antihorario:
    ; Sequência para giro anti-horário
    MOVLW B'00001100'  ; Define o padrão 0x0C (passo 1)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00000110'  ; Define o padrão 0x06 (passo 2)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00000011'  ; Define o padrão 0x03 (passo 3)
    CALL atraso        ; Aplica o padrão e realiza o atraso

    MOVLW B'00001001'  ; Define o padrão 0x09 (passo 4)
    CALL atraso        ; Aplica o padrão e realiza o atraso
    RETURN

;------------------------------------------
; Sub-rotina de Atraso
;------------------------------------------
atraso:
    BANKSEL at_x        ; Seleciona o banco de memória para acessar at_x
    MOVWF at_x          ; Armazena o valor inicial em at_x (contador externo)
    MOVLW .50           ; Configura o contador interno com 50
at1:
    MOVWF at_tmp1       ; Armazena 50 no registrador at_tmp1 (contador interno)
at2:
    MOVWF at_tmp2       ; Armazena 50 no registrador at_tmp2 (contador mais interno)
at3:
    DECFSZ at_tmp2      ; Decrementa at_tmp2 e verifica se chegou a zero
    GOTO at3            ; Repete o loop se at_tmp2 não for zero
    DECFSZ at_tmp1      ; Decrementa at_tmp1 e verifica se chegou a zero
    GOTO at2            ; Repete o loop se at_tmp1 não for zero
    DECFSZ at_x         ; Decrementa at_x e verifica se chegou a zero
    GOTO at1            ; Repete o loop se at_x não for zero
    RETURN              ; Retorna ao chamador quando o atraso termina

;------------------------------------------
; Final do Programa
;------------------------------------------
END                     ; Indica o fim do programa
