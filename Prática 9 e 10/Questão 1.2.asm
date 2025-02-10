org 100h 

pos_ini_x equ 300          ; vertice (ponto) inicial do desenho

pos_ini_y equ 100           

wh equ 40                   ; largura = altura quadrado   

cor equ 15
   
   

mov ah, 0 
    
mov al, 13h 
    
int 10h             ;seta o modo de video AL = 13h - graphical mode. 40x25. 256 colors. 320x200 pixels. 1 page.
    

 
mov dx, pos_ini_y+wh   


desenha:   
    


       
    mov cx, pos_ini_x    
    
    mov bx, pos_ini_x-wh    
    
    dec dx         
    
    mov al, cor           ; cor da linha
 
     
     
    call draw_linha_h 
    
    
    cmp dx, pos_ini_y        
                          
    jae desenha     
    
             
    mov ah,00  
    
    int 16h   
    
    mov ah,00 
    
    mov al,03  
    
    int 10h    
    
    ret   
           
           
; funcoes uteis 
                 
                                  
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
