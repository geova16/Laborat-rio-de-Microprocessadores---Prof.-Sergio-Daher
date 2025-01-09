# Configuração dos Registradores ADCON0 e ADCON1

Este documento descreve como configurar os registradores **ADCON0** e **ADCON1** em um microcontrolador PIC para atender aos seguintes requisitos:

## Requisitos

1. **Período do Clock do ADC (TAD):**
   - \( TAD = 3,2 \, \mu s \)
   - **XTAL** = 10 MHz

2. **Referências de Tensão:**
   - **VREF+ = VDD**
   - **VREF- = VSS**

3. **Entradas Analógicas:**
   - **AN0-AN7** configurados como entradas analógicas.

4. **Canal Selecionado:**
   - **AN0** como canal de entrada analógica.

5. **Módulo ADC em funcionamento:**
   - ADC habilitado.

6. **Formato de Saída:**
   - Justificado à esquerda.

---

## Passo a Passo

### 1. **Cálculo do Clock do ADC**

Para atender \( TAD = 3,2 \, \mu s \), calculamos o divisor necessário para o clock do ADC. Com \( \text{XTAL} = 10 \, \text{MHz} \):

\[
T_{FOSC} = \frac{1}{10 \, \text{MHz}} = 0,1 \, \mu s
\]

Divisão necessária para \( TAD = 3,2 \, \mu s \):

\[
\text{Divisor} = \frac{TAD}{T_{FOSC}} = \frac{3,2}{0,1} = 32
\]

Selecionamos **FOSC/32**, que corresponde a **ADCS1 = 1** e **ADCS0 = 0** no registrador **ADCON0**.

---

### 2. **Configuração dos Registradores**

#### **ADCON1**
- Configura os pinos **AN0-AN7** como entradas analógicas.
- Define as referências de tensão internas:
  - **VREF+ = VDD**
  - **VREF- = VSS**

| **Bit**   | **Valor** | **Descrição**                              |
|-----------|-----------|--------------------------------------------|
| **VCFG1** | 0         | VREF- conectado a VSS                     |
| **VCFG0** | 0         | VREF+ conectado a VDD                     |
| **PCFG3:0** | 0000    | AN0-AN7 configurados como entradas analógicas |

**Valor Final do ADCON1:**
\[
\text{ADCON1} = 0b00000000 = 0x00
\]

---

#### **ADCON0**
- Seleciona o canal **AN0** como entrada analógica.
- Configura o clock do ADC para **FOSC/32**:
  - **ADCS1 = 1**
  - **ADCS0 = 0**
- Habilita o ADC:
  - **ADON = 1**
- Formato de saída:
  - Justificado à esquerda (**ADFM = 0**).

| **Bit**   | **Valor** | **Descrição**                              |
|-----------|-----------|--------------------------------------------|
| **CHS3:0** | 0000     | Seleciona o canal AN0                     |
| **ADCS1** | 1         | Seleciona FOSC/32 (junto com ADCS0)       |
| **ADCS0** | 0         | Seleciona FOSC/32 (junto com ADCS1)       |
| **GO/DONE** | 0       | Inicialmente nenhuma conversão em andamento |
| **ADON**  | 1         | Habilita o ADC                            |

**Valor Final do ADCON0:**
\[
\text{ADCON0} = 0b00000001 = 0x01
\]

---

### 3. **Configuração em Assembly**

A seguir, o código assembly para configurar os registradores:

```assembly
; Configura o ADCON1
BANKSEL ADCON1     ; Seleciona o banco do registrador ADCON1
MOVLW 0x00         ; Configura todos os pinos como analógicos, VREF+ = VDD, VREF- = VSS
MOVWF ADCON1       ; Escreve no registrador ADCON1

; Configura o ADCON0
BANKSEL ADCON0     ; Seleciona o banco do registrador ADCON0
MOVLW 0x01         ; Habilita o ADC, seleciona AN0, FOSC/32, justificado à esquerda
MOVWF ADCON0       ; Escreve no registrador ADCON0
