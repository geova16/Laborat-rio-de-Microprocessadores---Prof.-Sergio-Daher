# Registrador PIE1 - Controle de Interrupções Periféricas

O **registrador PIE1** é utilizado para habilitar as interrupções periféricas no microcontrolador PIC. Cada bit do registrador PIE1 está associado a uma interrupção específica de um periférico, como o ADC, UART, ou módulos CCP.

## Estrutura do Registrador PIE1
O registrador PIE1 possui 8 bits, onde cada bit habilita uma interrupção periférica correspondente.

| **Bit** | **Nome**   | **Descrição**                                              |
|---------|------------|----------------------------------------------------------|
| 7       | PSPIF      | **Parallel Slave Port Interrupt Enable**: Habilita a interrupção do Parallel Slave Port (somente em dispositivos com PSP). |
| 6       | ADIE       | **ADC Interrupt Enable**: Habilita a interrupção do conversor analógico-digital (ADC). |
| 5       | RCIE       | **EUSART Receive Interrupt Enable**: Habilita a interrupção de recepção da UART. |
| 4       | TXIE       | **EUSART Transmit Interrupt Enable**: Habilita a interrupção de transmissão da UART. |
| 3       | SSPIE      | **Synchronous Serial Port Interrupt Enable**: Habilita a interrupção do SPI/I2C. |
| 2       | CCP1IE     | **CCP1 Interrupt Enable**: Habilita a interrupção do módulo CCP1 (Capture/Compare/PWM). |
| 1       | TMR2IE     | **Timer2 Interrupt Enable**: Habilita a interrupção do Timer2. |
| 0       | TMR1IE     | **Timer1 Interrupt Enable**: Habilita a interrupção do Timer1. |

## Função de Cada Bit

### Bit 7: PSPIF - Parallel Slave Port Interrupt Enable
- **0**: Desabilita a interrupção do Parallel Slave Port.
- **1**: Habilita a interrupção do Parallel Slave Port.

### Bit 6: ADIE - ADC Interrupt Enable
- **0**: Desabilita a interrupção do ADC.
- **1**: Habilita a interrupção do ADC quando uma conversão estiver completa.

### Bit 5: RCIE - EUSART Receive Interrupt Enable
- **0**: Desabilita a interrupção de recepção da UART.
- **1**: Habilita a interrupção de recepção da UART quando um dado estiver disponível no buffer de recepção.

### Bit 4: TXIE - EUSART Transmit Interrupt Enable
- **0**: Desabilita a interrupção de transmissão da UART.
- **1**: Habilita a interrupção de transmissão da UART quando o buffer de transmissão estiver vazio.

### Bit 3: SSPIE - Synchronous Serial Port Interrupt Enable
- **0**: Desabilita a interrupção do módulo SPI/I2C.
- **1**: Habilita a interrupção do módulo SPI/I2C para eventos de transmissão ou recepção.

### Bit 2: CCP1IE - CCP1 Interrupt Enable
- **0**: Desabilita a interrupção do módulo CCP1.
- **1**: Habilita a interrupção do módulo CCP1 para eventos de captura, comparação ou PWM.

### Bit 1: TMR2IE - Timer2 Interrupt Enable
- **0**: Desabilita a interrupção do Timer2.
- **1**: Habilita a interrupção do Timer2 ao atingir overflow.

### Bit 0: TMR1IE - Timer1 Interrupt Enable
- **0**: Desabilita a interrupção do Timer1.
- **1**: Habilita a interrupção do Timer1 ao atingir overflow.

## Exemplo de Configuração do Registrador PIE1

### Objetivo
Habilitar as interrupções do Timer1, Timer2 e ADC.

### Código Assembly
```assembly
; Configura o registrador PIE1
MOVLW b'01000011'  ; Habilita TMR1IE (bit 0), TMR2IE (bit 1) e ADIE (bit 6)
MOVWF PIE1         ; Carrega o valor no registrador PIE1
```

### Explicação do Código
1. **`MOVLW b'01000011'`**:
   - **Bit 6 (ADIE)**: Habilita a interrupção do ADC.
   - **Bit 1 (TMR2IE)**: Habilita a interrupção do Timer2.
   - **Bit 0 (TMR1IE)**: Habilita a interrupção do Timer1.
2. **`MOVWF PIE1`**: Carrega o valor configurado no registrador PIE1.

---

## Observações
- O registrador **PIE1** deve ser usado em conjunto com o registrador **PIR1**, que contém as flags de interrupção associadas.
- Para que qualquer interrupção periférica funcione, o bit **PEIE** (Peripheral Interrupt Enable) do registrador **INTCON** também deve estar habilitado.
- Consulte o **datasheet** do microcontrolador para verificar quais bits estão disponíveis no dispositivo específico, já que alguns podem não ser implementados em todas as variantes.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o registrador PIE1 e as interrupções periféricas.
