org 100h
jmp start
vec1 db 1, 2, 5, 6       ; declaracao de vetores
vec2 db 3, 5, 3, 1
vec3 db ?, ?, ?, ?       ; declaracao de vetor 'limpo'

start:
    lea si, vec1         ; carrega o EA(effective adress) endereco do vec1 em SI(registrador de indexacao)
    
    lea bx, vec2         ;
    
    lea di, vec3         ;
    
    mov cx, 4            ;

sum:
    mov al, [si]         ; copia o byte (8bits) menos significativos de vec1 (1, no caso) para AL  
    
    add al, [bx]         ; soma o byte acima com o menos significativo de vec2 (3, no caso)        
    
    mov [di], al         ; armazena o resultado no byte menos sig de vec3 armazenado no endereco armazenado em di  
                         ;   
    inc si               ; incrementa o endereco de vec1 para acessar o segundo byte
    
    inc bx               ; mesmo que acima so que com vec2
    
    inc di               ; mesmo que acima so que com vec3 pra armazenar a soma  
    
loop sum                 ; loop 4 vezes (decrementa CX), como CX = 4 --> retorna pro rotulo soma 4 vezes

.EXIT                      


; Observando a janela de memorias observamos que 
;
; vec1 esta armazenado em 102h
; vec2 esta armazenado em 106h
; vec3 esta armazenado em 10Ah    
; 
; Note que a diferenca de enderecos entre os vetores eh justamente 4
; Isso se da por conta que cada vetor possui 4 bytes    

; Os valores armazenados nas posicoes de memoria de vec3 sao justamente a soma vec1+vec2
