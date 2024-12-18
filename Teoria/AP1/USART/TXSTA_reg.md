# Registrador TXSTA - Controle da Transmissão UART

O **registrador TXSTA** (Transmit Status and Control Register) é utilizado para configurar e monitorar o funcionamento do módulo de transmissão da UART em microcontroladores PIC. Ele permite habilitar o transmissor, configurar o modo de operação e monitorar o status do envio de dados.

## Estrutura do Registrador TXSTA

O registrador TXSTA possui 8 bits, cada um com uma função específica relacionada à transmissão UART:

| **Bit** | **Nome**   | **Descrição**                                                                 |
|---------|------------|-----------------------------------------------------------------------------|
| 7       | CSRC       | **Clock Source Select**: Define a fonte do clock em modo síncrono.            |
| 6       | TX9        | **9-Bit Transmit Enable**: Habilita a transmissão de dados com 9 bits.        |
| 5       | TXEN       | **Transmit Enable**: Habilita o transmissor UART.                             |
| 4       | SYNC       | **Synchronous Mode Select**: Seleciona entre modo síncrono e assíncrono.      |
| 3       | SENDB      | **Send Break Character**: Controla o envio de caracteres de break.            |
| 2       | BRGH       | **High Baud Rate Select**: Seleciona entre baixa e alta taxa de transmissão.  |
| 1       | TRMT       | **Transmit Shift Register Status**: Indica se o registrador de transmissão está vazio. |
| 0       | TX9D       | **9th Bit of Transmit Data**: Nono bit de dados a ser transmitido em modo 9 bits. |

## Função de Cada Bit

### Bit 7: CSRC - Clock Source Select (somente no modo síncrono)
- **0**: O clock é fornecido externamente no pino SCK.
- **1**: O clock é gerado internamente pelo microcontrolador.

### Bit 6: TX9 - 9-Bit Transmit Enable
- **0**: Transmissão com 8 bits.
- **1**: Habilita a transmissão com 9 bits (nono bit é armazenado em TX9D).

### Bit 5: TXEN - Transmit Enable
- **0**: Transmissor desabilitado.
- **1**: Transmissor habilitado.

### Bit 4: SYNC - Synchronous Mode Select
- **0**: Modo assíncrono.
- **1**: Modo síncrono.

### Bit 3: SENDB - Send Break Character
- **0**: Não envia caracteres de break.
- **1**: Envia um caractere de break no próximo ciclo de transmissão.

### Bit 2: BRGH - High Baud Rate Select
- **0**: Baixa taxa de transmissão (baud rate baixo).
- **1**: Alta taxa de transmissão (baud rate alto).

### Bit 1: TRMT - Transmit Shift Register Status (somente leitura)
- **0**: Registrador de transmissão ainda está ocupado (transmissão em andamento).
- **1**: Registrador de transmissão está vazio (pronto para enviar novos dados).

### Bit 0: TX9D - 9th Bit of Transmit Data
- Armazena o nono bit de dados para ser transmitido no modo 9 bits.
- Este bit é enviado antes dos outros 8 bits do dado.

## Exemplo de Configuração do Registrador TXSTA

### Objetivo
Configurar a UART para transmissão em modo assíncrono, 8 bits de dados, alta taxa de transmissão e habilitar o transmissor.

### Código Assembly
```assembly
; Configura o registrador TXSTA
MOVLW b'00100100'  ; SYNC = 0 (modo assíncrono), BRGH = 1 (alta taxa), TXEN = 1 (habilitar transmissão)
MOVWF TXSTA        ; Carrega o valor no registrador TXSTA
```

### Explicação do Código
1. **`MOVLW b'00100100'`**:
   - **Bit 5 (TXEN)**: Habilita o transmissor UART.
   - **Bit 2 (BRGH)**: Configura alta taxa de transmissão.
   - **Bit 4 (SYNC)**: Define o modo assíncrono.
2. **`MOVWF TXSTA`**: Carrega o valor configurado no registrador TXSTA.

## Observações
- O registrador TXSTA funciona em conjunto com outros registradores, como **SPBRG** (para configurar a taxa de transmissão) e **RCSTA** (para habilitar o módulo UART).
- No modo assíncrono, o bit **SYNC** deve ser **0**.
- Certifique-se de configurar corretamente o baud rate no registrador SPBRG, considerando os valores de **BRGH** e o clock do sistema.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o registrador TXSTA e as configurações de transmissão UART.
