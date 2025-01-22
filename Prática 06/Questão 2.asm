org 100h
mov AH,1
int 21h
mov DL,AL
inc DL
mov AH, 2
int 21h
mov AH, 0
int 16h
ret
