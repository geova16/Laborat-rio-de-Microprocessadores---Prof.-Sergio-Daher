# Registrador OPTION_REG - Timer 0

O **OPTION_REG** é um registrador especial utilizado na configuração do **Timer 0** e outras funções de controle nos microcontroladores da família PIC16. Este registrador é composto por 8 bits, onde cada bit possui uma função específica.

## Formato do Registrador OPTION_REG
| **Bit** | **Nome**  | **Descrição**                                                  |
|---------|-----------|------------------------------------------------------------|
| 7       | RBPU      | **Pull-up no PORTB**: 0 = Habilita pull-up; 1 = Desabilita pull-up. |
| 6       | INTEDG    | **Borda da Interrupção**: 0 = Borda descendente; 1 = Borda ascendente. |
| 5       | T0CS      | **Fonte do Timer 0**: 0 = Clock interno; 1 = Pino T0CKI.    |
| 4       | T0SE      | **Borda de Contagem**: 0 = Borda ascendente; 1 = Borda descendente. |
| 3       | PSA       | **Prescaler Assignment**: 0 = Prescaler para Timer 0; 1 = Prescaler para WDT. |
| 2-0     | PS2:PS0   | **Prescaler Rate Select**: Define o valor de divisão do prescaler. |

## Detalhamento dos Bits

### Bit 7: RBPU - Pull-up no PORTB
- **0**: Habilita os resistores de pull-up no PORTB (PORTB configurado como entrada).
- **1**: Desabilita os resistores de pull-up no PORTB.

### Bit 6: INTEDG - Borda da Interrupção
- **0**: A interrupção externa ocorre na borda **descendente** do sinal no pino INT.
- **1**: A interrupção externa ocorre na borda **ascendente** do sinal no pino INT.
- Na prática, BIT6 = 0.

### Bit 5: T0CS - Fonte do Timer 0
- **0**: O Timer 0 utiliza o **clock interno**.
- **1**: O Timer 0 utiliza o sinal externo no pino **T0CKI**.
- Na prática, BIT5 = 0.

### Bit 4: T0SE - Borda de Contagem do Timer 0
- **0**: O Timer 0 incrementa na borda **ascendente** do sinal em T0CKI.
- **1**: O Timer 0 incrementa na borda **descendente** do sinal em T0CKI.
- Na prática, BIT4 = 0.

### Bit 3: PSA - Prescaler Assignment
- **0**: O prescaler é atribuido ao **Timer 0**.
- **1**: O prescaler é atribuido ao **Watchdog Timer (WDT)**.
- Na prática, BIT3 = 0.

### Bits 2-0: PS2:PS0 - Prescaler Rate Select
Os bits PS2, PS1 e PS0 determinam o fator de divisão do prescaler, conforme a tabela abaixo:

| **PS2:PS0** | **Prescaler (Timer 0)** | **Prescaler (WDT)** |
|-------------|-------------------------|---------------------|
| 000         | 1:2                     | 1:1                 |
| 001         | 1:4                     | 1:2                 |
| 010         | 1:8                     | 1:4                 |
| 011         | 1:16                    | 1:8                 |
| 100         | 1:32                    | 1:16                |
| 101         | 1:64                    | 1:32                |
| 110         | 1:128                   | 1:64                |
| 111         | 1:256                   | 1:128               |

## Exemplo de Configuração do OPTION_REG para o Timer 0

### Objetivo
- Utilizar o Timer 0 com clock interno, prescaler de 1:8.

### Código Assembly
```assembly
MOVLW b'00000110'   ; RBPU = 0, INTEDG = 0, T0CS = 0, T0SE = 0, PSA = 0, PS2:PS0 = 110 (1:8)
OPTION             ; Carrega o valor no registrador OPTION_REG
```

### Explicação do Código
- `RBPU = 0`: Habilita os resistores de pull-up do PORTB.
- `INTEDG = 0`: Interrupção ocorre na borda descendente.
- `T0CS = 0`: Fonte do Timer 0 é o clock interno.
- `T0SE = 0`: Incrementa na borda ascendente.
- `PSA = 0`: Prescaler atribuido ao Timer 0.
- `PS2:PS0 = 110`: Prescaler de 1:8.

## Referência
Consulte o **datasheet** do microcontrolador PIC16 correspondente para mais detalhes sobre o registrador OPTION_REG e suas funcionalidades.
