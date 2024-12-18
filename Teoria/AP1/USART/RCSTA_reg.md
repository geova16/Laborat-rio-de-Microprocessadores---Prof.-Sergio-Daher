# Registrador RCSTA - Controle do Recebimento UART

O **registrador RCSTA** (Receive Status and Control Register) é utilizado para configurar e monitorar o funcionamento do módulo de recepção da UART em microcontroladores PIC. Ele permite habilitar o receptor, configurar o modo de operação e monitorar erros de comunicação.

## Estrutura do Registrador RCSTA

O registrador RCSTA possui 8 bits, cada um com uma função específica relacionada à recepção UART:

| **Bit** | **Nome**   | **Descrição**                                                                 |
|---------|------------|-----------------------------------------------------------------------------|
| 7       | SPEN       | **Serial Port Enable**: Habilita o módulo UART.                              |
| 6       | RX9        | **9-Bit Receive Enable**: Habilita a recepção de dados com 9 bits.           |
| 5       | SREN       | **Single Receive Enable**: Habilita o modo de recepção única no modo síncrono. |
| 4       | CREN       | **Continuous Receive Enable**: Habilita o modo de recepção contínua no modo assíncrono. |
| 3       | ADDEN      | **Address Detect Enable**: Habilita a detecção de endereço em modo 9 bits.   |
| 2       | FERR       | **Framing Error**: Indica erro de enquadramento (somente leitura).           |
| 1       | OERR       | **Overrun Error**: Indica erro de sobrecarga no buffer de recepção (somente leitura). |
| 0       | RX9D       | **9th Bit of Receive Data**: Nono bit de dados recebidos em modo 9 bits.     |

## Função de Cada Bit

### Bit 7: SPEN - Serial Port Enable
- **0**: Desabilita o módulo UART.
- **1**: Habilita o módulo UART.

### Bit 6: RX9 - 9-Bit Receive Enable
- **0**: Recepção com 8 bits.
- **1**: Habilita a recepção com 9 bits (nono bit é armazenado em RX9D).

### Bit 5: SREN - Single Receive Enable (somente no modo síncrono)
- **0**: Recepção única desabilitada.
- **1**: Habilita a recepção de um único byte no modo síncrono.

### Bit 4: CREN - Continuous Receive Enable
- **0**: Recepção contínua desabilitada.
- **1**: Habilita a recepção contínua no modo assíncrono.

### Bit 3: ADDEN - Address Detect Enable
- **0**: Detecção de endereço desabilitada.
- **1**: Habilita a detecção de endereço em modo 9 bits.

### Bit 2: FERR - Framing Error (somente leitura)
- **0**: Nenhum erro de enquadramento detectado.
- **1**: Erro de enquadramento detectado (bit de parada ausente ou inválido).

### Bit 1: OERR - Overrun Error (somente leitura)
- **0**: Nenhum erro de sobrecarga detectado.
- **1**: Erro de sobrecarga detectado (dados no buffer não foram lidos antes da chegada de novos dados). Deve ser limpo manualmente desabilitando e reabilitando o bit CREN.

### Bit 0: RX9D - 9th Bit of Receive Data
- Armazena o nono bit de dados recebidos no modo 9 bits.
- Este bit é recebido antes dos outros 8 bits do dado.

## Exemplo de Configuração do Registrador RCSTA

### Objetivo
Configurar a UART para recepção em modo assíncrono, 8 bits de dados e habilitar o receptor.

### Código Assembly
```assembly
; Configura o registrador RCSTA
MOVLW b'10010000'  ; SPEN = 1 (habilitar UART), CREN = 1 (recepção contínua), RX9 = 0 (8 bits)
MOVWF RCSTA        ; Carrega o valor no registrador RCSTA
```

### Explicação do Código
1. **`MOVLW b'10010000'`**:
   - **Bit 7 (SPEN)**: Habilita o módulo UART.
   - **Bit 4 (CREN)**: Habilita a recepção contínua.
   - **Bit 6 (RX9)**: Define recepção em 8 bits.
2. **`MOVWF RCSTA`**: Carrega o valor configurado no registrador RCSTA.

## Observações
- O registrador RCSTA deve ser configurado em conjunto com o registrador TXSTA e SPBRG para a correta configuração da UART.
- Em caso de erro de sobrecarga (OERR = 1), o bit CREN deve ser desabilitado e reabilitado para limpar o erro.
- Certifique-se de que o baud rate configurado no registrador SPBRG seja compatível com o clock do sistema e os valores de BRGH e SYNC.

## Referência
Consulte o datasheet do microcontrolador PIC correspondente para mais detalhes sobre o registrador RCSTA e as configurações de recepção UART.
