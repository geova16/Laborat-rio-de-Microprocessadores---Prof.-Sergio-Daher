org 100h 

 
start:

; si = tamanho do quadrado

; di = pos_ini_x

; bp = pos_ini_y

    mov si, 18
    
    mov di, 15
    
    mov bp, 15   
    
    mov cx, 8



    mov ah, 0 
    
    mov al, 13h 
    
    int 10h             ;seta o modo de video AL = 13h - graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page. 


void_loop:

    call Desenha_quadrado   
    
    dec si
    
    dec si
    
    inc di
    
    inc bp
    
    ; si = tamanho do quadrado

    ; di = pos_ini_x

    ; bp = pos_ini_y     
    
    
loop void_loop    
    
              
    mov ah,00  
    
    int 16h   
    
    mov ah,00 
    
    mov al,03  
    
    int 10h    
    

Desenha_quadrado:   

; si = tamanho do quadrado

; di = pos_ini_x

; bp = pos_ini_y   


push ax

push bx

push cx

push dx


    add di, si
    
    mov cx, di ; pos_ini_x + lado    
              
    sub di, si
              
    mov bx, di ; pos_ini_x  
    
    mov dx, bp ; pos_y_constante         
    
    mov al, 2           ; cor da linha
 
     
     
    call draw_linha_h
    ; si = tamanho do quadrado

    ; di = pos_ini_x

    ; bp = pos_ini_y
     
    add di, si
    
    mov cx, di    ; pos_ini_x+w       
              
    sub di, si 
    
    add bp, si
              
    mov dx, bp    ; pos_ini_y+w
              
    sub bp, si          
              
    mov bx, bp    ; pos_ini_y         
    
    mov al, 2          ; cor da linha
             
  
             
    call draw_linha_v  
    ; si = tamanho do quadrado

    ; di = pos_ini_x

    ; bp = pos_ini_y
    
    add di, si
    
    mov cx, di    ; pos_ini_x+w    
              
    sub di, si          
              
    mov bx, di    ; pos_ini_x    
              
    add bp, si
              
    mov dx, bp    ; pos_ini_y+w          
              
    sub bp, si          
              
    mov al, 2           ; cor da linha
                      
                      
    call draw_linha_h                     
    ; si = tamanho do quadrado

    ; di = pos_ini_x

    ; bp = pos_ini_y
                         
    
    mov cx, di    ; pos_ini_x       
            
    add bp, si        
            
    mov dx, bp    ; pos_ini_y+w
              
    sub bp, si          
              
    mov bx, bp    ; pos_ini_y         
    
    mov al, 2          ; cor da linha
             
  
             
    call draw_linha_v 
    
    pop dx
    
    pop cx
    
    pop bx
    
    pop ax
   
    ret   
    



                 
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
