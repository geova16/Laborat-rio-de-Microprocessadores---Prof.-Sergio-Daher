org 100h
; Esta diretiva define a origem do codigo. No formato .COM, o codigo comeca na posicao 100h.

;mov DL, 'O'
; Move o caractere '1' (representado por seu valor ASCII, 49) para o registrador DL.
; DL eh usado para armazenar o caractere que sera enviado a funcao de saida de caractere.

;mov AH, 2
; Configura o registrador AH com o valor 2.
; Na interrupção 21h do DOS, AH = 2 indica a função "Exibir caractere na saída padrão".

;int 21h
; Chama a interrupção 21h do DOS, que executa a função de exibição de caractere.
; O caractere em DL ('1') será mostrado no console.  
       
mov AH, 2
       
mov DL, 'O' 
int 21h     

mov DL, 'I' 
int 21h       

mov DL, ',' 
int 21h       

mov DL, ' ' 
int 21h
mov DL, 'M' 
int 21h
mov DL, 'U' 
int 21h
mov DL, 'N' 
int 21h
mov DL, 'D' 
int 21h
mov DL, 'O' 
int 21h

mov AH, 0
; Configura o registrador AH com o valor 0.
; Na interrupção 16h, AH = 0 indica a função "Esperar por entrada de tecla" (leitura de tecla).

int 16h
; Chama a interrupção 16h, que aguarda até que o usuário pressione uma tecla.
; O código ASCII da tecla pressionada será armazenado em AL, mas não é usado neste programa.

ret
; Retorna ao sistema operacional, finalizando o programa.
