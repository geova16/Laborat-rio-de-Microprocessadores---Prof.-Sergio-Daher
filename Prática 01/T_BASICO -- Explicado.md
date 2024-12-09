# Detalhamento da Execução

Abaixo estão os cálculos detalhados para o tempo em nível baixo (\(T_{baixo}\)) e nível alto (\(T_{alto}\)) do sinal gerado pelo código.

---

## 1. Tempo em Nível Baixo (PORTB = 0x00)
O tempo em nível baixo ocorre durante as instruções que configuram o **PORTB** como 0x00 (nível lógico baixo).

### Instruções:
- **`movlw 0x00`**: Carrega o valor 0x00 no registrador W (**1 ciclo de instrução**).
- **`movwf PORTB`**: Escreve o valor 0x00 em PORTB (**1 ciclo de instrução**).

### Total:
\[
T_{baixo} = 2 \cdot T_{ciclo} = 2 \cdot 1 \, \mu s = 2 \, \mu s
\]

---

## 2. Tempo em Nível Alto (PORTB = 0xFF)
O tempo em nível alto ocorre durante as instruções que configuram o **PORTB** como 0xFF (nível lógico alto) e inclui o desvio para reinício do loop.

### Instruções:
- **`movlw 0xFF`**: Carrega o valor 0xFF no registrador W (**1 ciclo de instrução**).
- **`movwf PORTB`**: Escreve o valor 0xFF em PORTB (**1 ciclo de instrução**).
- **`goto MAIN`**: Desvia para o início do loop (**2 ciclos de instrução**).

### Total:
\[
T_{alto} = (1 + 1 + 2) \cdot T_{ciclo} = 4 \cdot 1 \, \mu s = 4 \, \mu s
\]

---

## 3. Período do Sinal (\(T_{sinal}\))
O período total do sinal é a soma do tempo em nível baixo (\(T_{baixo}\)) e do tempo em nível alto (\(T_{alto}\)).

\[
T_{sinal} = T_{alto} + T_{baixo} = 4 \, \mu s + 2 \, \mu s = 6 \, \mu s
\]

---

## 4. Frequência do Sinal (\(F_{sinal}\))
A frequência do sinal gerado é o inverso do período total:

\[
F_{sinal} = \frac{1}{T_{sinal}} = \frac{1}{6 \, \mu s} \approx 166.67 \, \text{kHz}
\]

---

## Resumo dos Cálculos
| Parâmetro      | Valor            |
|----------------|------------------|
| Tempo Baixo (\(T_{baixo}\)) | \(2 \, \mu s\)     |
| Tempo Alto (\(T_{alto}\))  | \(4 \, \mu s\)     |
| Período (\(T_{sinal}\))    | \(6 \, \mu s\)     |
| Frequência (\(F_{sinal}\)) | \(166.67 \, \text{kHz}\) |

---

## Observações
O tempo em alta (\(T_{alto}\)) é maior que o tempo em baixa (\(T_{baixo}\)) devido à instrução de desvio (`goto MAIN`), que consome **2 ciclos de instrução** e ocorre após o PORTB ser configurado em 0xFF. Isso adiciona um tempo extra ao nível alto do sinal.
