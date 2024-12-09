1. Tempo em Nível Baixo (T_baixo)
O tempo em nível baixo ocorre durante as instruções que configuram o PORTB como 0x00 (nível lógico baixo).

Instruções:

movlw 0x00: Carrega o valor 0x00 no registrador W (1 ciclo de instrução).
movwf PORTB: Escreve o valor 0x00 em PORTB (1 ciclo de instrução).
Total de ciclos para T_baixo:

T_baixo = 1 ciclo (movlw) + 1 ciclo (movwf) = 2 ciclos de instrução

Cálculo do tempo:

Como cada ciclo de instrução tem duração de 1 μs:

T_baixo = 2 ciclos × 1 μs/ciclo = 2 μs

2. Tempo em Nível Alto (T_alto)
O tempo em nível alto ocorre durante as instruções que configuram o PORTB como 0xFF (nível lógico alto) e inclui o desvio para reinício do loop.

Instruções:

movlw 0xFF: Carrega o valor 0xFF no registrador W (1 ciclo de instrução).
movwf PORTB: Escreve o valor 0xFF em PORTB (1 ciclo de instrução).
goto MAIN: Desvia para o início do loop (2 ciclos de instrução).
Total de ciclos para T_alto:

T_alto = 1 ciclo (movlw) + 1 ciclo (movwf) + 2 ciclos (goto) = 4 ciclos de instrução

Cálculo do tempo:

T_alto = 4 ciclos × 1 μs/ciclo = 4 μs

