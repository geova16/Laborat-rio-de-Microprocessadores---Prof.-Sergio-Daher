# Análise dos Ciclos de Clock no Código

## Configuração do Clock
- Frequência do clock principal: 1 MHz.
- Ciclo de instrução:
  - T_ciclo = 4 / F_clock = 4 / 1 MHz = 4 μs.

---

## Cálculo dos Tempos de Atraso

### Sub-rotina `atraso`
1. **Loop Interno (at2):**
   - Executa 100 iterações, cada uma consumindo 3 ciclos.
   - 
   - Tempo total: T_at2 = 100 * 3 * T_ciclo = 1.2 ms.

2. **Loop Externo (at1):**
   - Cada iteração inclui:
     - Tempo do loop interno: T_at2 = 1.2 ms.
     - Instruções adicionais: 4 ciclos = 16 μs.
   - Tempo total por iteração: T_at1 = 1.216 ms.

3. **Tempo Total do Atraso:**
   - Para \( X = 0xFF \) (255): T_atraso,FF = 255 * T_at1 ≈ 310.08 ms.
   - Para \( X = 0x80 \) (128): T_atraso,80 = 128 * T_at1 ≈ 155.008 ms.

---

## Tempos em Alta e Baixa do LED

1. **Tempo em Baixa (T_baixo):**
   - Tempo do atraso com \( X = 0xFF \): 310.08 ms.
   - Instruções adicionais: movlw e bcf = 8 μs.
   - Total: T_baixo ≈ 310.088 ms.

2. **Tempo em Alta (T_alto):**
   - Tempo do atraso com \( X = 0x80 \): 155.008 ms.
   - Instruções adicionais: movlw e bsf = 8 μs.
   - Total: T_alto ≈ 155.016 ms.

---

## Período e Frequência

1. **Período Total (T_sinal):**
   - T_sinal = T_baixo + T_alto = 310.088 ms + 155.016 ms = 465.104 ms.

2. **Frequência Gerada (F_sinal):**
   - F_sinal = 1 / T_sinal = 1 / 465.104 ms ≈ 2.15 Hz.

---

## Resumo
| Parâmetro                | Valor               |
|--------------------------|---------------------|
| Tempo em Baixa (T_baixo) | 310.088 ms         |
| Tempo em Alta (T_alto)   | 155.016 ms         |
| Período Total (T_sinal)  | 465.104 ms         |
| Frequência Gerada        | 2.15 Hz            |
