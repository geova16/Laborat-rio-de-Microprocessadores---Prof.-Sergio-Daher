org 100h 

w equ 60                   ; largura
                           ; altura
h equ 30  

pos_ini_x equ 300          ; vertice (ponto) inicial do desenho

pos_ini_y equ 100
 

    mov ah, 0 
    
    mov al, 13h 
    
    int 10h             ;seta o modo de video AL = 13h - graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page.
    

    
    mov cx, pos_ini_x    
    
    mov bx, pos_ini_x-w    
    
    mov dx, pos_ini_y          
    
    mov al, 2           ; cor da linha
 
     
     
    call draw_linha_h

     
    
    mov cx, pos_ini_x       
    
    mov dx, pos_ini_y
    
    mov bx, pos_ini_y-h         
    
    mov al, 15          ; cor da linha
             
  
             
    call draw_linha_v  
    
    
    
    mov cx, pos_ini_x    
    
    mov bx, pos_ini_x-w    
    
    mov dx, pos_ini_y-h          
    
    mov al, 2           ; cor da linha
                      
                      
    call draw_linha_h                     
                         
    
    mov cx, pos_ini_x-w       
    
    mov dx, pos_ini_y
    
    mov bx, pos_ini_y-h         
    
    mov al, 15          ; cor da linha
             
  
             
    call draw_linha_v 
    
    
             
    mov ah,00  
    
    int 16h   
    
    mov ah,00 
    
    mov al,03  
    
    int 10h    
    
    ret   
    
; funcoes uteis 





                 
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
