# Registrador PIR1 - Flags de Interrupções Periféricas

O **registrador PIR1** (Peripheral Interrupt Request Register 1) é utilizado para monitorar as interrupções periféricas no microcontrolador PIC. Cada bit deste registrador indica se uma interrupção periférica específica ocorreu.

## Estrutura do Registrador PIR1

O registrador PIR1 possui 8 bits, onde cada bit é associado a uma interrupção periférica específica:

| **Bit** | **Nome**   | **Descrição**                                                                |
|---------|------------|-------------------------------------------------------------------------------|
| 7       | PSPIF      | **Parallel Slave Port Interrupt Flag**: Indica uma interrupção no Parallel Slave Port. (somente em dispositivos com PSP) |
| 6       | ADIF       | **ADC Interrupt Flag**: Indica que a conversão ADC foi concluída.             |
| 5       | RCIF       | **EUSART Receive Interrupt Flag**: Indica que um dado foi recebido na UART.   |
| 4       | TXIF       | **EUSART Transmit Interrupt Flag**: Indica que o buffer de transmissão está vazio. |
| 3       | SSPIF      | **Synchronous Serial Port Interrupt Flag**: Indica que uma transmissão ou recepção SPI/I2C foi concluída. |
| 2       | CCP1IF     | **CCP1 Interrupt Flag**: Indica que um evento de captura, comparação ou PWM ocorreu no módulo CCP1. |
| 1       | TMR2IF     | **Timer2 Interrupt Flag**: Indica que o Timer2 atingiu overflow.              |
| 0       | TMR1IF     | **Timer1 Interrupt Flag**: Indica que o Timer1 atingiu overflow.              |

## Função de Cada Bit

### Bit 7: PSPIF - Parallel Slave Port Interrupt Flag
- **0**: Nenhuma interrupção ocorreu no Parallel Slave Port.
- **1**: Uma interrupção ocorreu no Parallel Slave Port.

### Bit 6: ADIF - ADC Interrupt Flag
- **0**: Nenhuma conversão ADC foi concluída.
- **1**: Uma conversão ADC foi concluída. Esta flag deve ser limpa manualmente no software.

### Bit 5: RCIF - EUSART Receive Interrupt Flag
- **0**: Nenhum dado foi recebido na UART.
- **1**: Um dado foi recebido e está no buffer de recepção.

### Bit 4: TXIF - EUSART Transmit Interrupt Flag
- **0**: O buffer de transmissão ainda está ocupado.
- **1**: O buffer de transmissão está vazio e pronto para receber novos dados.

### Bit 3: SSPIF - Synchronous Serial Port Interrupt Flag
- **0**: Nenhuma transmissão ou recepção SPI/I2C foi concluída.
- **1**: Uma transmissão ou recepção SPI/I2C foi concluída. Esta flag deve ser limpa manualmente.

### Bit 2: CCP1IF - CCP1 Interrupt Flag
- **0**: Nenhum evento ocorreu no módulo CCP1.
- **1**: Um evento de captura, comparação ou PWM ocorreu no módulo CCP1.

### Bit 1: TMR2IF - Timer2 Interrupt Flag
- **0**: Nenhum overflow ocorreu no Timer2.
- **1**: O Timer2 atingiu overflow. Esta flag deve ser limpa manualmente no software.

### Bit 0: TMR1IF - Timer1 Interrupt Flag
- **0**: Nenhum overflow ocorreu no Timer1.
- **1**: O Timer1 atingiu overflow. Esta flag deve ser limpa manualmente no software.

## Exemplo de Configuração do Registrador PIR1

### Objetivo
Monitorar interrupções do ADC, Timer1 e UART (recepção).

### Código Assembly
```assembly
; Verifica e limpa a flag de interrupção do ADC
BTFSS PIR1, ADIF    ; Verifica se a conversão ADC foi concluída
GOTO SKIP_ADC        ; Salta se nenhuma interrupção ocorreu
BCF PIR1, ADIF      ; Limpa a flag ADIF

; Verifica e limpa a flag de interrupção do Timer1
BTFSS PIR1, TMR1IF  ; Verifica se o Timer1 atingiu overflow
GOTO SKIP_TMR1       ; Salta se nenhuma interrupção ocorreu
BCF PIR1, TMR1IF    ; Limpa a flag TMR1IF

; Verifica e limpa a flag de recepção UART
BTFSS PIR1, RCIF    ; Verifica se um dado foi recebido na UART
GOTO SKIP_UART       ; Salta se nenhuma interrupção ocorreu
MOVF RCREG, W       ; Lê o dado recebido

SKIP_ADC:
SKIP_TMR1:
SKIP_UART:
; Continuação do código
```

### Explicação do Código
1. **`BTFSS PIR1, ADIF`**: Verifica se a conversão ADC foi concluída.
2. **`BCF PIR1, ADIF`**: Limpa a flag ADIF manualmente.
3. **`BTFSS PIR1, TMR1IF`**: Verifica se o Timer1 atingiu overflow.
4. **`BCF PIR1, TMR1IF`**: Limpa a flag TMR1IF manualmente.
5. **`BTFSS PIR1, RCIF`**: Verifica se um dado foi recebido na UART.
6. **`MOVF RCREG, W`**: Lê o dado recebido da UART.

## Observações
- As flags no registrador PIR1 são **somente leitura** e devem ser **limpas manualmente** no software após o tratamento da interrupção.
- O PIR1 deve ser utilizado em conjunto com o registrador PIE1 para habilitar as interrupções desejadas.
- Consulte o datasheet do microcontrolador para verificar quais bits estão disponíveis no dispositivo específico.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o registrador PIR1 e as interrupções periféricas.
