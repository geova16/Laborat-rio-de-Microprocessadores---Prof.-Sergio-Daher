;Co´digo para linha que comeca em um determinado lugar e termina em outro
ORG 100h  

MOV AH, 0          ; Modo gra´fico
MOV AL, 13h        ; Modo 320x200 256 cores
INT 10h            ; Chama a interrupc¸a~o de vi´deo

MOV CX, 70         ; Coordenada X inicial (fixa em 70)
MOV DX, 100        ; Coordenada Y inicial
MOV BL, 0Fh        ; Cor inicial (branco)
MOV SI, 0          ; Flag para detectar mudanc¸a de cor

DESENHA:
    MOV AH, 01h    ; Verifica se uma tecla foi pressionada
    INT 16h        ; Interrupc¸a~o do teclado
    JZ CONTINUA    ; Se nenhuma tecla foi pressionada, continua desenhando
    
    MOV AH, 00h    ; Le^ a tecla pressionada
    INT 16h        ; Captura a tecla
    INC BL         ; Muda a cor (para variar em mu´ltiplas teclas)
    AND BL, 0Fh    ; Garante que a cor esteja dentro do intervalo permitido
    CMP BL, 00h    ; Verifica se a cor ficou preta
    JNZ CONTINUA   ; Se na~o for preta, continua normalmente
    MOV BL, 01h    ; Se for preta, altera para 1 (azul claro ou pro´xima cor visi´vel)
    
CONTINUA:
    MOV AH, 0Ch    ; Func¸a~o de plotar pixel
    MOV AL, BL     ; Cor do pixel
    MOV BH, 0      ; Pa´gina de vi´deo
    INT 10h        ; Desenha o pixel
    
    DEC DX         ; Move para o pro´ximo ponto na linha vertical
    CMP DX, 30     ; Se chegou ao limite inferior (30), para
    JGE DESENHA    ; Continua desenhando se ainda estiver na a´rea permitida

FIM:
RET
