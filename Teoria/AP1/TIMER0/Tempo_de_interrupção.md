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
- Prescaler: **1:256**.
- Valor inicial do Timer0: **0**.

### **Cálculo:**

1. **Frequência do Timer0:**
```
    f_timer = f_osc / (4 * Prescaler)
    f_timer = 4,000,000 / (4 * 256) = 3,906.25 Hz
```

2. **Período do Timer0:**
```
    T_timer = 1 / f_timer
    T_timer = 1 / 3,906.25 = 0.000256 s = 256 µs
```

3. **Tempo de Interrupção:**
```
    T_int = T_timer * (256 - Valor_Inicial)
    T_int = 256 µs * 256 = 65.536 ms
```

O tempo de interrupção será **65,536 ms** se o Timer0 iniciar em 0.

---

### **Cálculo de Interrupções em 1 Segundo**
Para determinar quantas interrupções ocorrem em 1 segundo, basta dividir 1 segundo pelo tempo de uma interrupção:

```
    Número de Interrupções = 1 / T_int
    Número de Interrupções = 1 / 0.065536 ≈ 15.26
```

O Timer0 gera aproximadamente **15 interrupções por segundo** com estas configurações.

---

### **Ajustando com Valor Inicial**
Se o Timer0 iniciar com um valor diferente de 0 (ex.: 100):

```
    T_int = T_timer * (256 - Valor_Inicial)
    T_int = 256 µs * (256 - 100)
    T_int = 256 µs * 156 = 39.936 ms
```

O tempo de interrupção será **39,936 ms**, e o número de interrupções por segundo será:

```
    Número de Interrupções = 1 / T_int
    Número de Interrupções = 1 / 0.039936 ≈ 25.04
```

O Timer0 gera aproximadamente **25 interrupções por segundo** com um valor inicial de 100.

---

## Fórmula Geral
Para qualquer configuração do Timer0, a fórmula do tempo de interrupção é:

```
    T_int = (1 / (f_osc / (4 * Prescaler))) * (256 - Valor_Inicial)
```

E o número de interrupções por segundo é dado por:

```
    Número de Interrupções = 1 / T_int
```

---

## Observações
- **Prescaler**: Deve ser configurado no registrador **OPTION_REG**.
- O **Valor_Inicial** é o valor carregado no Timer0 antes de iniciar a contagem.
- O Timer0 é um contador de **8 bits**, permitindo valores de 0 a 255.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o Timer0 e seu funcionamento.
