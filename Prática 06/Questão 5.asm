ORG 100h        
          
jmp INICIO          
          

BUF DB 10       ; Primeiro byte: tamanho máximo do buffer (10 caracteres)
    DB 0         ; Segundo byte: número de caracteres lidos (inicialmente 0)
    DB 10 DUP (?) ; Espaço para armazenar o texto digitado (até 10 caracteres)

MSG DB 0Dh, 0Ah, 'No de caracteres = ', '$' ; Mensagem base para exibição


INICIO:

LOOP_ENTRADA:
    ; Entrada da frase - Aguarda até o usuário digitar algo
    MOV DX, OFFSET BUF   ; Aponta o endereço do buffer para DX
    MOV AH, 0Ah          ; Função de entrada de buffer (DOS: INT 21h, AH=0Ah)
    INT 21h              

    ; Verificar se algo foi digitado
    MOV AL, [BUF + 1]    ; Carrega o número de caracteres lidos no registrador AL
    CMP AL, 0            ; Compara o número de caracteres lidos com 0
    JE LOOP_ENTRADA      ; Se for zero (string vazia), volta para o loop

    ; Exibir a mensagem de "No de caracteres = "
    MOV DX, OFFSET MSG     ; Aponta para a mensagem de base
    MOV AH, 09h            ; Função para exibição de string (DOS: INT 21h, AH=09h)
    INT 21h                
    
    ; Exibir o número de caracteres lidos
    MOV AL, [BUF + 1]      ; Carrega o número de caracteres lidos no registro AL
    ADD AL, 48             ; Converte o valor para o equivalente ASCII
    MOV DL, AL             ; Move o valor ASCII para DL
    MOV AH, 02h            ; Função para exibição de caractere (DOS: INT 21h, AH=02h)
    INT 21h                     
    
    ; Codigo para quebra de linha
    MOV AH, 2
    MOV DL, 10
    INT 21h
    
    MOV DL, 13
    INT 21h
    
    
    JMP INICIO             

END                        
