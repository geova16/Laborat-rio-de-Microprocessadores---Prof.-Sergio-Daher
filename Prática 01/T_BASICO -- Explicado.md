# Detalhamento da Execução (Clock de 1 MHz)

Abaixo estão os cálculos detalhados para o tempo em nível baixo (T_baixo) e nível alto (T_alto) do sinal gerado pelo código, considerando um clock de 1 MHz.

---

## 1. Parâmetros do Clock
- Frequência do clock: 1 MHz
- Ciclo de instrução: 
  T_ciclo = 4 / F_clock = 4 / 1 MHz = 4 μs

---

## 2. Tempo em Nível Baixo (PORTB = 0x00)
O tempo em nível baixo ocorre durante as instruções que configuram o PORTB como 0x00 (nível lógico baixo).

### Instruções:
- `movlw 0x00`: Carrega o valor 0x00 no registrador W (1 ciclo de instrução = 4 μs).
- `movwf PORTB`: Escreve o valor 0x00 em PORTB (1 ciclo de instrução = 4 μs).

### Total:
T_baixo = 2 ciclos de instrução = 8 μs.

---

## 3. Tempo em Nível Alto (PORTB = 0xFF)
O tempo em nível alto ocorre durante as instruções que configuram o PORTB como 0xFF (nível lógico alto) e inclui o desvio para reinício do loop.

### Instruções:
- `movlw 0xFF`: Carrega o valor 0xFF no registrador W (1 ciclo de instrução = 4 μs).
- `movwf PORTB`: Escreve o valor 0xFF em PORTB (1 ciclo de instrução = 4 μs).
- `goto MAIN`: Desvia para o início do loop (2 ciclos de instrução = 8 μs).

### Total:
T_alto = 4 ciclos de instrução = 16 μs.

---

## 4. Período do Sinal (T_sinal)
O período total do sinal é a soma dos tempos em nível baixo (T_baixo) e em nível alto (T_alto).

T_sinal = T_baixo + T_alto = 8 μs + 16 μs = 24 μs.

---

## 5. Frequência do Sinal (F_sinal)
A frequência do sinal gerado é o inverso do período total:

F_sinal = 1 / T_sinal = 1 / 24 μs ≈ 41.67 kHz.

---

## Resumo dos Cálculos
| Parâmetro      | Valor            |
|----------------|------------------|
| Tempo Baixo (T_baixo) | 8 μs        |
| Tempo Alto (T_alto)  | 16 μs       |
| Período (T_sinal)    | 24 μs       |
| Frequência (F_sinal) | 41.67 kHz   |

---

## Observações
O tempo em alta (T_alto) é maior que o tempo em baixa (T_baixo) devido à instrução de desvio (`goto MAIN`), que consome 2 ciclos de instrução e ocorre após o PORTB ser configurado em 0xFF. Isso adiciona um tempo extra ao nível alto do sinal.

Com o clock de 1 MHz, o ciclo de instrução é mais lento (4 μs), o que reduz a frequência do sinal gerado para 41.67 kHz.
