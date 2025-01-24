ORG 100h         ; Início do programa COM

JMP INICIO

; Declaração de variáveis
BUF DB 16  DUP (?)       ; Primeiro byte: tamanho máximo do buffer (255 caracteres)
MSG DB 0Dh, 0Ah, 'No de caracteres = ', '$' ; Mensagem base para exibição

; Início do código
INICIO:
    ; Entrada da frase
    MOV DX, OFFSET BUF   ; Aponta o endereço do buffer para DX
    MOV AH, 0Ah          ; Função de entrada de buffer (DOS: INT 21h, AH=0Ah)
    INT 21h              ; Chamada de interrupção para entrada de dados

    ; Exibir a mensagem de "No de caracteres = "
    MOV DX, OFFSET MSG     ; Aponta para a mensagem de base
    MOV AH, 09h            ; Função para exibição de string (DOS: INT 21h, AH=09h)
    INT 21h                ; Chamada de interrupção para exibir a mensagem
    
    ; Exibir o número de caracteres lidos
    MOV AL, [BUF + 1]      ; Carrega o número de caracteres lidos no registro AL
    ADD AL, 48             ; Converte o valor para o equivalente ASCII
    MOV DL, AL             ; Move o valor ASCII para DL
    MOV AH, 02h            ; Função para exibição de caractere (DOS: INT 21h, AH=02h)
    INT 21h                ; Chamada de interrupção para exibir o caractere

    ; Finaliza o programa
    MOV AH, 4Ch         ; Função para terminar o programa (DOS: INT 21h, AH=4Ch)
    INT 21h             ; Chamada de interrupção para finalizar

END                        ; Fim do programa    
