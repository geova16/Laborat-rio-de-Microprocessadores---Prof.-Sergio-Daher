# Registrador CCP1CON - PIC16

O registrador **CCP1CON** é utilizado para configurar e controlar o módulo CCP1 (Capture/Compare/PWM) nos microcontroladores PIC. Este módulo pode operar em três modos principais:
- **Capture**: Captura o valor do Timer quando ocorre um evento externo.
- **Compare**: Gera uma saída quando o Timer atinge um valor especificado.
- **PWM (Pulse Width Modulation)**: Gera um sinal PWM com duty cycle configurável.

## Estrutura do Registrador CCP1CON

| **Bits** | **Nome**        | **Descrição**                                                               |
|----------|-----------------|-----------------------------------------------------------------------------|
| 7-6      | Não utilizado  | Reservado (lê-se como 0).                                                  |
| 5-4      | CCP1X:CCP1Y    | Bits menos significativos (LSB) do duty cycle no modo PWM.                 |
| 3-0      | CCP1M3:CCP1M0  | Seleção do modo de operação do módulo CCP1.                                |

### Configuração do Modo (CCP1M3:CCP1M0)

| **CCP1M3:CCP1M0** | **Modo**             | **Descrição**                                                       |
|--------------------|---------------------|---------------------------------------------------------------------|
| `0000`            | Desligado           | O módulo CCP1 está desligado.                                       |
| `0100`            | Capture (borda baixa) | Captura o valor do Timer na borda de descida do sinal.             |
| `0101`            | Capture (borda alta)  | Captura o valor do Timer na borda de subida do sinal.              |
| `1000`            | Compare (setar saída)| Seta o pino CCP1 quando ocorre a correspondência com o Timer.      |
| `1001`            | Compare (limpar saída)| Limpa o pino CCP1 quando ocorre a correspondência com o Timer.     |
| `1100`            | PWM                 | Configura o módulo no modo PWM.                                     |

---

## Função de Cada Bit

### Bits 7-6: Reservados
- Não utilizados.
- Devem ser mantidos como **0** para evitar comportamento inesperado.

### Bits 5-4: CCP1X e CCP1Y
- Utilizados no modo **PWM** para definir os dois bits menos significativos (LSB) do **duty cycle**.
- Estes bits complementam os 8 bits superiores armazenados no registrador **CCPR1L**.

### Bits 3-0: CCP1M3:CCP1M0
- Configuram o modo de operação do módulo CCP1.
- Consulte a tabela acima para os valores possíveis e seus significados.

---

## Exemplo de Configuração

### Exemplo 1: Configurar o CCP1 no modo Capture com borda de subida
```assembly
    BANKSEL CCP1CON       ; Seleciona o banco do CCP1CON
    MOVLW B'00000101'     ; Configura o módulo CCP1 no modo Capture (borda de subida)
    MOVWF CCP1CON         ; Grava o valor no registrador CCP1CON
```

### Exemplo 2: Configurar o CCP1 no modo PWM
```assembly
    BANKSEL CCP1CON       ; Seleciona o banco do CCP1CON
    MOVLW B'00111100'     ; Configura o módulo CCP1 no modo PWM
    MOVWF CCP1CON         ; Grava o valor no registrador CCP1CON

    ; Configuração adicional necessária para PWM
    BANKSEL PR2           ; Seleciona o registrador PR2 (período PWM)
    MOVLW D'255'          ; Define o período PWM como 255
    MOVWF PR2

    BANKSEL CCPR1L        ; Seleciona o registrador CCPR1L (duty cycle - bits superiores)
    MOVLW D'128'          ; Define o duty cycle como 50% (valor médio)
    MOVWF CCPR1L

    BANKSEL T2CON         ; Configura o Timer2, necessário para PWM
    MOVLW B'00000100'     ; Liga o Timer2 com prescaler de 1
    MOVWF T2CON
```

---

## Observações

1. **Modos Múltiplos**: O registrador CCP1CON deve ser configurado conforme o modo desejado. Cada modo requer configurações adicionais (ex.: Timer usado no modo PWM).
2. **Periféricos Associados**: Certifique-se de que o pino CCP1 está configurado corretamente no registrador TRISC (como saída no modo PWM ou Compare).
3. **Consulte o Datasheet**: A funcionalidade exata pode variar dependendo do modelo do microcontrolador. Verifique o datasheet para detalhes específicos.

## Referência
Consulte o **datasheet** do microcontrolador PIC16 para obter mais informações sobre o funcionamento do registrador CCP1CON.
