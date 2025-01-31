org 100h

jmp ini             

    label1 db "x = $"  
    
    label2 db "2*x = $"  
    
    quebra_lin db 0x0d,0x0a,'$'

ini:
    lea     dx, label1  
    
    mov     ah, 9
    
    int     21h              ; Imprime label1
         
         
    mov     ah, 1
    
    int     21h              ; Le um caractere (trava o codigo)
         
    sub     al, 48           ; De ASCII para decimal 
    
    mov     ah, 0 
    
    mov     bx, 10
    
    mul     bx
    
    mul     bx
    
    mul     bx               ; Multiplica o numero lido por 1000 p jogar ele 3 casas pra esquerda
          
    push    ax               ; Guarda na pilha
    
    
    mov     ah, 1 
    
    int     21h              ; Le um caractere (trava o codigo)  
             
    sub     al, 48           ; De ASCII para decimal   
    
    mov     ah, 0 
    
    mov     bx, 100
    
    mul     bx               ; Multiplica o numero lido por 100 p jogar ele 2 casas pra esquerda
    
    mov     cx, 0
    
    mov     cx, ax           ; Guarda em CX
                             
    pop     ax               ; Puxa o numero milhar da pilha
    
    add     ax, cx           ; Soma o milhar com a centena
    
    push    ax               ; Guarda novamente na pilha
         
        
         
    mov     ah, 1
    
    int     21h              ; Le um caractere (trava o codigo)
         
    sub     al, 48           ; De ASCII para decimal  
    
    mov     ah, 0
    
    mov     bx, 10           ; Multiplica o numero lido por 10 p jogar ele 1 casa pra esquerda
    
    mul     bx
    
    mov     cx, 0
    
    mov     cx, ax           ; Guarda em CX 
    
    pop     ax               ; Puxa o numero todo da pilha
    
    add     ax, cx           ; Soma o numero com a dezena
    
    push    ax               ; Guarda novamente na pilha   
          
    
    
    mov     ah, 1 
    
    int     21h              ; Le um caractere (trava o codigo)  
             
    sub     al, 48           ; De ASCII para decimal
    
    mov     ah, 0
    
    mov     cx, 0
    
    mov     cx, ax           ; Guarda em CX 
    
    pop     ax               ; Puxa o numero todo da pilha
    
    add     ax, cx           ; Soma o numero com a dezena
    
    push    ax               ; Guarda novamente na pilha 
    
     
       
    
    lea     dx,quebra_lin 
    
    mov     ah,9      
    
    int     21h              ; Imprime quebra_lin
    
    
    lea     dx,label2 
    
    mov     ah,9  
                        
    int     21h              ; Imprime label2
    
    
    pop     ax               ; Resgata a soma da pilha
    
    mov     dx,2
    
    mul     dx               ; Multiplica a soma por 2
            
    
    call    imprime_4d       ; Imprime a soma*2
    
    .EXIT       
    
    
imprime_4d:
    
    ; Imprime a variavel anteriormente armazenada em AX (4 digitos)    
    
    mov     bx, 100
    
    div     bx               ; Divide AX por 100 - separar o (milhar e centena) da (dezena e unidade)
            
    push    dx               ; Guarda os valores da (dezena e unidade) na pilha (resto da div)
    
    
    
    mov     ch, al           ; Milhar e centena para CH
    
    mov     ax, 0
    
    mov     al, ch           ; Milhar e centena para AL    
    
    call    imprime_2d       ; Imprime os dois digitos de AL
    
    
    pop     dx               ; Recupera os valores guardados na pilha
    
    mov     cl, dl           ; Dezena e unidade para CL
    
    mov     ax, 0
            
    mov     al, cl           ; Dezena e unidade para AL 
    
    call    imprime_2d       ; Imprime os dois digitos de AL
    
    ret
    

imprime_2d: 

    ; Imprime o que ta em AL

    mov     ah,0 
    
    mov     dl,10  
    
    div     dl   
    
    mov     dl,al 
            
    mov     cl,ah
    
    mov     ah,2 
    
    add     dl,48 
    
    int     21h  
    
    
    mov     dl,cl 
    
    add     dl,48 
    
    int     21h   
    
    ret   
