
                 
draw_linha_v:

    
    ; desenha uma linha de (cx, dx) ate (cx, bx) 
    ; desenha de baixo pra cima
    ; parametros
    ; dx = posicao vertical inicial da linha
    ; bx = posicao vertical final da linha
    ; cx = posicao horizontal da linha 
    ; al = cor da linha   
    
    ; obs dx deve ser maior que bx sempre!
    
    mov ah, 0ch             
    int 10h
    
    ; cx = posicao x             
    
    dec dx              
                            
    cmp dx, bx        
                          
    jae draw_linha_v            
    
    ret

                 
                 
                 
draw_linha_h:              

    
    ; desenha uma linha de (cx, dx) ate (bx, dx) 
    ; desenha da direita pra esquerda
    ; parametros
    ; cx = posicao horizontal inicial da linha
    ; bx = posicao horizontal final da linha
    ; dx = posicao vertical da linha 
    ; al = cor da linha   
    
    ; obs cx deve ser maior que bx sempre!
    
    mov ah, 0ch             
    int 10h
    
    ; cx = posicao x             
    
    dec cx              
                            
    cmp cx, bx        
                          
    jae draw_linha_h            
    
    ret
