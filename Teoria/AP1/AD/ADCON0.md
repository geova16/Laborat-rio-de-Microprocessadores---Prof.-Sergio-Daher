# Registrador ADCON0 no Microcontrolador PIC

O registrador **ADCON0** controla o funcionamento do módulo de Conversão Analógico-Digital (ADC) em microcontroladores PIC. Ele permite configurar o ADC, selecionar o canal de entrada, iniciar a conversão e verificar o status do processo.

## Estrutura do Registrador ADCON0

| **Bit** | **Nome**        | **Descrição**                                                                                                                             |
|---------|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| 7       | **ADCS1**       | Seleciona a frequência de clock do ADC (junto com o bit ADCS0 no ADCON0 e bits ADCS2 no ADCON1).                                           |
| 6       | **GO/DONE**     | Controla e monitora o processo de conversão: <br> **1** = Inicia a conversão AD <br> **0** = Conversão concluída.                        |
| 5       | **CHS2**        | Seleciona o canal analógico de entrada (junto com CHS1 e CHS0).                                                                           |
| 4       | **CHS1**        | Seleciona o canal analógico de entrada (junto com CHS2 e CHS0).                                                                           |
| 3       | **CHS0**        | Seleciona o canal analógico de entrada.                                                                                                   |
| 2       | **Unimplemented** | Reservado para uso futuro. Deve ser mantido em **0**.                                                                                   |
| 1       | **ADON**        | Habilita ou desabilita o módulo ADC: <br> **1** = ADC habilitado <br> **0** = ADC desabilitado.                                            |
| 0       | **Unimplemented** | Reservado para uso futuro. Deve ser mantido em **0**.                                                                                   |

## Funções dos Principais Bits

### ADCS1 e ADCS0
- Configuram a frequência de clock para o ADC.
- Consulte o datasheet do microcontrolador para os valores específicos.

### GO/DONE
- Controla o processo de conversão:
  - **1**: Inicia a conversão AD.
  - **0**: Conversão concluída (zerado automaticamente pelo hardware).

### CHS2:CHS0
- Selecionam o canal de entrada analógica:
  - **000**: Canal AN0
  - **001**: Canal AN1
  - **010**: Canal AN2
  - E assim por diante.

### ADON
- Habilita ou desabilita o módulo ADC.
- Deve ser configurado como **1** antes de iniciar qualquer conversão.

## Exemplo de Código

```assembly
; Configura o ADC para usar o canal AN0 e habilitar o módulo
BANKSEL ADCON0     ; Seleciona o banco que contém ADCON0
MOVLW 0x01         ; Carrega o valor 0x01 (ADON = 1, Canal AN0 = 000)
MOVWF ADCON0       ; Escreve no registrador ADCON0

; Inicia a conversão
BSF ADCON0, 2      ; Seta o bit GO/DONE para iniciar a conversão

; Aguarda o término da conversão
WAIT_CONVERSION:
    BTFSC ADCON0, 2 ; Verifica se o bit GO/DONE foi zerado
    GOTO WAIT_CONVERSION ; Se ainda não, continua aguardando

; Leitura do resultado
MOVFW ADRESL       ; Lê o byte menos significativo do resultado
MOVWF ad_L         ; Armazena o valor em um registrador
MOVFW ADRESH       ; Lê o byte mais significativo do resultado
MOVWF ad_H         ; Armazena o valor em outro registrador


# Bit ADCS1 no Registrador ADCON0 (Microcontroladores PIC)

O bit **ADCS1** (junto com **ADCS0**) no registrador **ADCON0** é usado para configurar a **frequência do clock do módulo ADC** em microcontroladores PIC. A frequência do clock do ADC deve ser cuidadosamente escolhida para atender aos requisitos de tempo do conversor analógico-digital, garantindo precisão e estabilidade na conversão.

---

## Função do Bit ADCS1

- O **ADCS1** é um dos dois bits de controle (**ADCS1** e **ADCS0**) que definem a fonte do clock usado pelo ADC.
- A fonte de clock afeta a velocidade de conversão, que deve ser lenta o suficiente para permitir que o ADC funcione corretamente, mas não tão lenta a ponto de prejudicar o desempenho geral do microcontrolador.

---

## Configuração da Frequência do Clock

Os bits **ADCS1** e **ADCS0** permitem selecionar diferentes fontes e divisores de clock para o ADC. A configuração exata depende do modelo do microcontrolador, mas geralmente as opções incluem:

| **ADCS1** | **ADCS0** | **Fonte do Clock do ADC**          | **Descrição**                                  |
|-----------|-----------|------------------------------------|------------------------------------------------|
| 0         | 0         | **FOSC/2**                        | Frequência do oscilador do sistema dividida por 2. |
| 0         | 1         | **FOSC/8**                        | Frequência do oscilador do sistema dividida por 8. |
| 1         | 0         | **FOSC/32**                       | Frequência do oscilador do sistema dividida por 32. |
| 1         | 1         | **FRC (Internal RC Oscillator)**   | Oscilador interno de baixa frequência (aproximadamente 500 kHz). |

---

## Quando Escolher Cada Configuração

A seleção da frequência do clock depende da velocidade do oscilador do sistema (**FOSC**) e do tempo de aquisição/conversão especificado no datasheet do microcontrolador.

### Regra Geral:
- O clock do ADC deve estar na faixa de **1 a 2 µs por ciclo**, conforme especificado na maioria dos datasheets PIC.
- Se **FOSC** for muito alto (ex.: 20 MHz), deve-se usar um divisor maior (como **FOSC/32**) para reduzir a velocidade do clock do ADC.
- O **FRC** pode ser usado quando o microcontrolador estiver operando em baixa velocidade ou quando a precisão do clock não for crítica.

---

## Exemplo Prático

Se o oscilador do sistema (**FOSC**) for 8 MHz, e o ADC requer um período de clock entre 1 e 2 µs:

1. **Período do FOSC**:
   \[
   \text{Período do FOSC} = \frac{1}{8\,\text{MHz}} = 125\,\text{ns}
   \]

2. **Divisão desejada**:
   \[
   \text{Divisão} = \frac{\text{Período do ADC Clock}}{\text{Período do FOSC}}
   \]
   Para obter um clock ADC de **1 µs**, a divisão será:
   \[
   \frac{1\,\text{µs}}{125\,\text{ns}} = 8
   \]

3. **Configuração ideal**:
   - Selecionar **FOSC/8**, que corresponde a:
     - **ADCS1 = 0**
     - **ADCS0 = 1**

---

## Importância

A correta configuração de **ADCS1** (e **ADCS0**) garante que o ADC funcione dentro de suas especificações, evitando:

- **Conversões incorretas ou imprecisas**:
  - O clock do ADC muito rápido pode fazer com que a conversão termine antes de estabilizar.
  
- **Desempenho lento**:
  - Um clock ADC muito lento pode prejudicar a eficiência do sistema.

---

## Resumo

- **ADCS1** faz parte da configuração do clock do ADC.
- Ele trabalha com **ADCS0** para selecionar uma fonte de clock apropriada.
- A frequência deve ser ajustada com base no **FOSC** do sistema e nos requisitos do ADC (1-2 µs por ciclo).

Sempre consulte o datasheet do microcontrolador específico para determinar a configuração ideal para o seu projeto.

---
