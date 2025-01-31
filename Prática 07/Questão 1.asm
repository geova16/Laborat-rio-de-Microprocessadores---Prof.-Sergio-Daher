org 100h

jmp inicio

k   dw  999

inicio:

mov AX, [k]

call imprime

.exit

imprime:



mov BX, 100

div BX        ; Divide AX por 100 - separar a centena

mov BX, 0

mov BX, AX    ; Centena para BX

mov CX, DX    ; Dezena e unidade para CL 

push CX       ; Guarda dezena e unidade na pilha



mov AH, 2     ; Funcionalidade da interrupcao 

mov DL, AL

add DL, 48    ; Converte a centena para ASCII

int 21h       ; Imprime a centena  


pop CX        ; Recupera dezena e unidade da pilha

mov AX, CX    ; Move dez e unid para AX


mov DL, 10     

mov AH, 0

div DL        ; Divide AX por 10 - separa a dezena

mov DL, AL    ; Dezena para AL

mov CL, AH    ; Unidade para CL

mov AH, 2     ; Funcionalidade da interrupcao

add DL, 48    ; Converte a dezena para ASCII

int 21h       ; Imprime a dezena


add CL, 48    ; Converte a unidade para ASCII

mov DL, CL    ; Imprime a unidade

int 21h

ret
                                   
                                   
                                
                               
