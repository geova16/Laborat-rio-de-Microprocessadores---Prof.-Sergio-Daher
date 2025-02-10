org 100h

jmp inicio

    k   dw  999   



inicio:

mov AX, [k]

call PRINT_DECIMAL

.exit
      
      
      
;--------------------------------------------------------------
; Função PRINT_DECIMAL
; Entrada: AX contém o número decimal de 3 dígitos a ser exibido
;--------------------------------------------------------------
PRINT_DECIMAL PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 10         ; Base 10
    MOV BX, 0          ; Contador de dígitos armazenados

CONVERT_LOOP:
    MOV DX, 0          ; Limpa DX antes da divisão
    DIV CX             ; AX / 10, resultado em AX, resto em DX
    ADD DL, '0'        ; Converte número para caractere ASCII
    PUSH DX            ; Armazena o caractere na pilha
    INC BX             ; Incrementa contador de dígitos
    TEST AX, AX        ; Verifica se AX é zero
    JNZ CONVERT_LOOP   ; Se não for zero, continua dividindo

PRINT_LOOP:
    POP DX             ; Recupera dígito convertido
    MOV AH, 02H
    INT 21H            ; Imprime caractere
    DEC BX             ; Decrementa contador de caracteres
    JNZ PRINT_LOOP     ; Continua imprimindo até esvaziar a pilha

    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_DECIMAL ENDP
                               
