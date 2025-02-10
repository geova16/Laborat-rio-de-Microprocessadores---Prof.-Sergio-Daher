#start=thermometer.exe#      

org 100h

jmp start   

quebra_lin db 0x0d,0x0a,'$'

fa db ' F$'

ce db ' C$'

start: 

 in AL,125      ; Le o valor do endereco I/O 125 (temperatura) 
 
 push AX 
 
 push AX       
 
 
 call PRINT_DECIMAL
 
 
 lea     dx, ce 
    
 mov     ah, 9
    
 int     21h              ; Imprime label1 
 
 
 lea     dx, quebra_lin 
    
 mov     ah, 9
    
 int     21h              ; Imprime label1
  
 
 pop  AX 
             
 call CONVERTE   
 
 call PRINT_DECIMAL 
 
 
 lea     dx, fa 
    
 mov     ah, 9
    
 int     21h              
 
 
 lea     dx, quebra_lin 
    
 mov     ah, 9
    
 int     21h              
 




 pop AX
 
 cmp AL,22      ; Compara a temperatura com 22
 
 jl low         ; temperatura < 22 --> jmp para low
 
 cmp AL,55      ; 55 > temperatura > 22 --> jmp para high
 
 jle ok    
 
 jg high       
 
low:      
                       
 mov AL,1     
 
 out 127,AL      ; mov 1 para a porta enderacada em 127 (queimador) - aumenta a temperatura
 
 jmp ok          ; retorna ao inicio

high:    

 mov AL,0 
 
 out 127,AL

ok: 

 jmp start 
 
 
 
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


;--------------------------------------------------------------
; Função converte celcius para decimal
; Entrada: AX contém o a temperatura em celcius
; Saida: AX contem a temperatura em farenheint              4
; °F = °(C * 9/5) + 32

;--------------------------------------------------------------
CONVERTE PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    mov ah, 0
    
    mov bx, 9
    
    mul bx
    
    mov bx, 5
    
    div bx
    
    add al, 32
 
    
    POP DX
    POP CX
    POP BX
    RET    
    
CONVERTE ENDP
