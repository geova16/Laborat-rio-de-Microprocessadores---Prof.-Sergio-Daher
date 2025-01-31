org 100h

jmp inicio

k   db  234

inicio:

mov AL, [k]

call imprime

.exit

imprime:

mov AH, 0

mov DL, 100

div DL        ; Divide AX por 100 - separar a centena

mov DL, AL    ; Centena para AL

mov CL, AH    ; Dezena e unidade para CL

mov AH, 2     ; Funcionalidade da interrupcao

add DL, 48    ; Converte a centena para ASCII

int 21h       ; Imprime a centena  


mov DL, 10     

mov AL, CL    ; Move a dezena e unidade para AL

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
                                   
                                   
                                
                               
