# Cálculo do Tempo de Interrupção do Timer0

Este guia explica como calcular o tempo de interrupção do **Timer0** em microcontroladores da família PIC, considerando a frequência do clock, prescaler e o valor inicial do Timer0.

## Fatores que Influenciam o Tempo de Interrupção
1. **Frequência do clock do sistema** (`f_osc`).
2. **Prescaler configurado no OPTION_REG**.
3. **Resolução do Timer0** (8 bits: 0 a 255).
4. **Valor inicial carregado no Timer0**.

---

## Passo a Passo para o Cálculo

### **Passo 1: Determinar a Frequência do Timer0**
A frequência do Timer0 (`f_timer`) depende do clock do sistema e do prescaler:

```
    f_timer = f_osc / (4 * Prescaler)
```

- **`f_osc`**: Frequência do cristal oscilador (ex.: 4 MHz).
- O divisor **4** ocorre porque o PIC usa ciclos de máquina (4 ciclos de clock para cada instrução).

---

### **Passo 2: Determinar o Período do Timer0**
O período do Timer0 (`T_timer`) é o inverso da frequência do Timer0:

```
    T_timer = 1 / f_timer
```

---

### **Passo 3: Calcular o Tempo de Interrupção**
O tempo de interrupção ocorre quando o Timer0 faz um overflow (atinge 255 e retorna a 0). Para calcular o tempo de interrupção (`T_int`):

```
    T_int = T_timer * (256 - Valor_Inicial)
```

- **`256`**: Número total de valores do Timer0 (8 bits).
- **`Valor_Inicial`**: Valor inicial carregado no Timer0 (em decimal).

---

## Exemplo Prático

### **Dados:**
- Clock do sistema: **4 MHz** (`f_osc`).
- Prescaler: **1:8**.
- Valor inicial do Timer0: **0**.

### **Cálculo:**

1. **Frequência do Timer0:**
```
    f_timer = f_osc / (4 * Prescaler)
    f_timer = 4,000,000 / (4 * 8) = 125,000 Hz
```

2. **Período do Timer0:**
```
    T_timer = 1 / f_timer
    T_timer = 1 / 125,000 = 8 µs
```

3. **Tempo de Interrupção:**
```
    T_int = T_timer * (256 - Valor_Inicial)
    T_int = 8 µs * 256 = 2,048 ms
```

O tempo de interrupção será **2,048 ms** se o Timer0 iniciar em 0.

---

### **Ajustando com Valor Inicial**
Se o Timer0 iniciar com um valor diferente de 0 (ex.: 100):

```
    T_int = T_timer * (256 - Valor_Inicial)
    T_int = 8 µs * (256 - 100)
    T_int = 8 µs * 156 = 1,248 ms
```

O tempo de interrupção será **1,248 ms**.

---

## Fórmula Geral
Para qualquer configuração do Timer0, a fórmula do tempo de interrupção é:

```
    T_int = (1 / (f_osc / (4 * Prescaler))) * (256 - Valor_Inicial)
```

---

## Observações
- **Prescaler**: Deve ser configurado no registrador **OPTION_REG**.
- O **Valor_Inicial** é o valor carregado no Timer0 antes de iniciar a contagem.
- O Timer0 é um contador de **8 bits**, permitindo valores de 0 a 255.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o Timer0 e seu funcionamento.
