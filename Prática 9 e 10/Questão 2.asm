#start=thermometer.exe#      

org 100h   

start:
 in AL,125      ; Le o valor do endereco I/O 125 (temperatura)
 
 cmp AL,22      ; Compara a temperatura com 22
 
 jl low         ; temperatura < 22 --> jmp para low
 
 cmp AL,55      ; 55 > temperatura > 22 --> jmp para high
 
 jle ok    
 
 jg high       
 
low:      
                       
 mov AL,1     
 
 out 127,AL      ; mov 1 para a porta enderacada em 127 (queimador) - aumenta a temperatura
 
 jmp ok          ; retorna ao inicio

high:
 mov AL,0
 out 127,AL

ok:
 jmp start
