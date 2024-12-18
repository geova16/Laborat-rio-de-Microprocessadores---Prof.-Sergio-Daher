# Registrador INTCON - Controle de Interrupções

O registrador **INTCON** no microcontrolador **PIC16F877** é usado para configurar e monitorar as interrupções do sistema. Ele controla o habilitamento global e específico das interrupções, além de indicar quais interrupções ocorreram.

## Estrutura do Registrador INTCON

| **Bit** | **Nome**     | **Descrição**                                                                 |
|---------|--------------|-----------------------------------------------------------------------------|
| 7       | GIE          | **Global Interrupt Enable**: 0 = Desabilita todas as interrupções; 1 = Habilita todas as interrupções. |
| 6       | PEIE         | **Peripheral Interrupt Enable**: 0 = Desabilita interrupções periféricas; 1 = Habilita interrupções periféricas. |
| 5       | T0IE         | **Timer0 Interrupt Enable**: 0 = Desabilita interrupção do Timer0; 1 = Habilita interrupção do Timer0. |
| 4       | INTE         | **External Interrupt Enable**: 0 = Desabilita interrupção externa; 1 = Habilita interrupção externa (pino RB0/INT). |
| 3       | RBIE         | **PortB Change Interrupt Enable**: 0 = Desabilita interrupção de mudança em PORTB; 1 = Habilita interrupção de mudança em PORTB. |
| 2       | T0IF         | **Timer0 Interrupt Flag**: 0 = Não houve interrupção do Timer0; 1 = Interrupção do Timer0 ocorreu. |
| 1       | INTF         | **External Interrupt Flag**: 0 = Não houve interrupção externa; 1 = Interrupção externa ocorreu. |
| 0       | RBIF         | **PortB Change Interrupt Flag**: 0 = Não houve mudança em PORTB; 1 = Mudança em PORTB ocorreu. |

## Função de Cada Bit

### Bit 7: GIE - Global Interrupt Enable
- Controla o habilitamento geral das interrupções do sistema.
- **0**: Todas as interrupções são desabilitadas.
- **1**: Interrupções habilitadas, sujeitas às configurações individuais.

### Bit 6: PEIE - Peripheral Interrupt Enable
- Controla o habilitamento das interrupções periféricas, como UART, ADC, etc.
- **0**: Interrupções periféricas desabilitadas.
- **1**: Interrupções periféricas habilitadas.

### Bit 5: T0IE - Timer0 Interrupt Enable
- Habilita ou desabilita a interrupção do Timer0.
- **0**: Interrupção do Timer0 desabilitada.
- **1**: Interrupção do Timer0 habilitada.

### Bit 4: INTE - External Interrupt Enable
- Habilita ou desabilita a interrupção externa (pino RB0/INT).
- **0**: Interrupção externa desabilitada.
- **1**: Interrupção externa habilitada.

### Bit 3: RBIE - PortB Change Interrupt Enable
- Habilita ou desabilita a interrupção por mudança no estado dos pinos RB4 a RB7.
- **0**: Interrupção de mudança em PORTB desabilitada.
- **1**: Interrupção de mudança em PORTB habilitada.

### Bit 2: T0IF - Timer0 Interrupt Flag
- Indica se ocorreu uma interrupção do Timer0.
- **0**: Nenhuma interrupção do Timer0 ocorreu.
- **1**: Interrupção do Timer0 ocorreu.
- **Nota**: Deve ser limpo manualmente no código.

### Bit 1: INTF - External Interrupt Flag
- Indica se ocorreu uma interrupção externa no pino RB0/INT.
- **0**: Nenhuma interrupção externa ocorreu.
- **1**: Interrupção externa ocorreu.
- **Nota**: Deve ser limpo manualmente no código.

### Bit 0: RBIF - PortB Change Interrupt Flag
- Indica se houve mudança no estado dos pinos RB4 a RB7.
- **0**: Nenhuma mudança em PORTB ocorreu.
- **1**: Mudança em PORTB ocorreu.
- **Nota**: Deve ser limpo manualmente no código.

## Exemplo de Configuração do Registrador INTCON

### Objetivo
Habilitar:
- Interrupção global (GIE).
- Interrupção do Timer0 (T0IE).
- Interrupção externa (INTE).

### Código Assembly
```assembly
; Configura o registrador INTCON
BSF INTCON, GIE     ; Habilita interrupção global
BSF INTCON, T0IE    ; Habilita interrupção do Timer0
BSF INTCON, INTE    ; Habilita interrupção externa

; Loop principal
MAIN:
    BTFSS INTCON, T0IF  ; Verifica se houve interrupção do Timer0
    GOTO MAIN           ; Retorna ao loop principal se T0IF = 0
    BCF INTCON, T0IF    ; Limpa a flag de interrupção do Timer0
    ; Adicione aqui o código de tratamento para a interrupção
    GOTO MAIN
```

### Explicação do Código
1. **`BSF INTCON, GIE`**: Habilita interrupções globais.
2. **`BSF INTCON, T0IE`**: Habilita a interrupção do Timer0.
3. **`BSF INTCON, INTE`**: Habilita a interrupção externa.
4. **`BTFSS INTCON, T0IF`**: Verifica se a flag de interrupção do Timer0 está setada.
5. **`BCF INTCON, T0IF`**: Limpa a flag de interrupção do Timer0 após tratá-la.

## Observações
- O bit **GIE** deve estar habilitado para que qualquer interrupção funcione.
- Flags de interrupção (**T0IF**, **INTF**, **RBIF**) precisam ser **limpas manualmente** no código após o tratamento.
- As configurações de interrupção dependem de outros registradores associados, como **OPTION_REG** e **PIE1**.

## Referência
Consulte o **datasheet do PIC16F877** para mais detalhes sobre o registrador INTCON e o funcionamento das interrupções.
