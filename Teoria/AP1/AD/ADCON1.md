# Registrador ADCON1 - PIC16

O registrador **ADCON1** controla a configuração do conversor Analógico-Digital (ADC) nos microcontroladores PIC. Ele determina o formato dos resultados da conversão, configura os pinos analógicos/digitais e seleciona a referência de tensão do ADC.

## Estrutura do Registrador ADCON1

| **Bit** | **Nome**     | **Descrição**                                                                 |
|---------|--------------|-----------------------------------------------------------------------------|
| 7       | ADFM         | Seleção do formato do resultado (Justificado à direita/esquerda).           |
| 6-4     | Não usado    | Reservado (lê-se como 0).                                                    |
| 3-0     | PCFG3:PCFG0  | Configuração dos pinos analógicos/digitais e referências de tensão do ADC.   |

---

## Configuração do Formato do Resultado (ADFM)

| **ADFM** | **Formato do Resultado**                  |
|----------|-------------------------------------------|
| `0`      | Justificado à esquerda (bits mais significativos em ADRESH). |
| `1`      | Justificado à direita (bits menos significativos em ADRESL). |

---

## Configuração dos Pinos Analógicos/Digitais (PCFG3:PCFG0)

Os bits **PCFG3:PCFG0** definem quais pinos são configurados como entradas analógicas ou digitais e selecionam as referências de tensão para o ADC.

| **PCFG3:PCFG0** | **Configuração dos Pinos**                     | **Referências de Tensão**      |
|-----------------|-----------------------------------------------|---------------------------------|
| `0000`          | Todos os pinos analógicos                     | VREF+ e VSS                    |
| `0001`          | AN0 como analógico, restante digital          | VREF+ e VSS                    |
| `0010`          | AN0 e AN1 analógicos, restante digital        | VDD e VSS                      |
| `0111`          | Todos os pinos digitais                       | VDD e VSS                      |
| `1111`          | Todos os pinos digitais                       | VDD e VSS                      |

---

## Exemplo de Configuração

### Exemplo 1: Configurar AN0 como analógico com VREF+ externo e VSS como referência negativa

#### Código Assembly:
```assembly
    BANKSEL ADCON1       ; Seleciona o banco do ADCON1
    MOVLW B'00000001'    ; AN0 analógico, VREF+ externo
    MOVWF ADCON1         ; Configura o ADCON1
```

### Exemplo 2: Configurar todos os pinos como digitais

#### Código Assembly:
```assembly
    BANKSEL ADCON1       ; Seleciona o banco do ADCON1
    MOVLW B'00001111'    ; Todos os pinos digitais
    MOVWF ADCON1         ; Configura o ADCON1
```

---

## Observações

1. **Seleção do Formato do Resultado**:
   - Justificado à direita é mais comumente usado, pois facilita cálculos quando se utiliza o resultado do ADC.

2. **Referências de Tensão**:
   - As referências podem ser ajustadas para diferentes fontes (ex.: VREF+ externo).

3. **Impacto no Consumo de Energia**:
   - Pinos configurados como analógicos consomem menos energia em relação aos pinos digitais devido à ausência de oscilações lógicas.

4. **Interação com Outros Registradores**:
   - O ADCON1 funciona em conjunto com ADCON0, que controla a ativação do módulo ADC e a seleção do canal.

---

## Referência
Consulte o **datasheet** do microcontrolador PIC16 para obter mais informações sobre o registrador ADCON1 e suas interações com o módulo ADC.
