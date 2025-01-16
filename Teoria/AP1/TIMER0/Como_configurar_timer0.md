# Configuração do Timer0 no PIC16F877

- O **Timer0** é um temporizador/contador de 8 bits presente no microcontrolador **PIC16F877**. 
- Naturalmente, ele conta de 0 a 256 (decimal), 0x00 a 0xFF (hexa).
- A contagem é armazenada no registrador TMR0.
- A cada ciclo de clock é acresentado +1 no TMR0 até chegar no limite (256) e acontecer um estouro.
- O prescale serve pra definir se o TIMER0 vai ser incrementado a cada ciclo de clock ou não, é possível definir em quantos ciclos de clock o TIMER0 vai somar +1.
- Assim que acontece o estouro, acontece a interrupção do TIMER0 (se tiver habilitada no registrador INTCON) e o registrador TMR0 reseta.
- Quando isso acontece, o BIT2 (TMR0IF - Timer0 Interruption Flag) do registrador INTCON é setado. (Necessário ser limpo manualmente - BCF TMR0IF, INTCON)

- Ele pode operar utilizando o **clock interno** ou uma fonte externa de clock, além de contar pulsos com configuração de prescaler.

## 1. Quanto tempo para o TIMER0 estourar (Interrupção)?


O cálculo do **TempoTotal** é realizado com base na fórmula a seguir:

```
TempoTotal = (256 - tempoInicial) * Prescaler * CicloMaquina
```

O tempoInicial geralmente é 0 mas é possível carregar o registrador TMR0 com um valor para que ele conte a partir desse valor.

Exemplo:

```assembly
BANKSEL    TMR0
MOVLW    d'100'
MOVWF    TMR0
```

Nesse caso, o TIMER0 vai contar de 100 até 256 e estourar, depois disso, o TMR0 é zerado novamente. Então, para essa contagem sempre acontecer de 100 até 256 o TMR0 tem que ser carregado com 100 em todo início de Loop.

Onde:
- **Prescaler**: De acordo com o valor selecionado no registrador `OPTION_REG` nos BITS (PS2:PS0).
- **CicloMaquina**: Calculado pela fórmula:

```
CicloMaquina = 4 / Frequência do Clock Cristal
```

## 2. Configuração do Timer0
A configuração do **Timer0** é feita através do **registrador OPTION_REG**.

### Formato do Registrador OPTION_REG
| **Bit** | **Nome**  | **Descrição**                                                  |
|---------|-----------|------------------------------------------------------------|
| 7       | RBPU      | **Pull-up no PORTB**: 0 = Habilita pull-up; 1 = Desabilita pull-up. |
| 6       | INTEDG    | **Borda da Interrupção**: 0 = Borda descendente; 1 = Borda ascendente. |
| 5       | T0CS      | **Fonte do Timer0**: 0 = Clock interno; 1 = Pino T0CKI.    |
| 4       | T0SE      | **Borda de Contagem**: 0 = Borda ascendente; 1 = Borda descendente. |
| 3       | PSA       | **Prescaler Assignment**: 0 = Prescaler para Timer0; 1 = Prescaler para WDT. |
| 2-0     | PS2:PS0   | **Prescaler Rate Select**: Define o valor de divisão do prescaler. |

### Configuração Passo a Passo

#### Passo 1: Escolher a Fonte do Timer0
- **Clock Interno**: T0CS = 0.
- **Clock Externo** (pino T0CKI): T0CS = 1.
- Na prática, usamos sempre clock interno, então --> BIT5 = 0

#### Passo 2: Definir a Borda de Contagem
- **Borda Ascendente**: T0SE = 0.
- **Borda Descendente**: T0SE = 1.

#### Passo 3: Configurar o Prescaler
- **Prescaler para Timer0**: PSA = 0.
- Na prática, sempre usamos PSA = 0 --> BIT3 = 0
- **Prescaler para WDT**: PSA = 1.
- Selecionar o valor do prescaler com os bits PS2, PS1 e PS0.

#### Tabela de Valores do Prescaler
| **PS2:PS0** | **Prescaler** |
|-------------|---------------|
| 000         | 1:2           |
| 001         | 1:4           |
| 010         | 1:8           |
| 011         | 1:16          |
| 100         | 1:32          |
| 101         | 1:64          |
| 110         | 1:128         |
| 111         | 1:256         |

#### Passo 4: Carregar o Registrador OPTION_REG
O registrador **OPTION_REG** é configurado para definir todas as opções acima.

## 3. Exemplo de Configuração do Timer0
### Objetivo
- Utilizar o Timer0 com **clock interno** e **prescaler de 1:8**.
- Incrementar o Timer0 em borda **ascendente**.

### Código Assembly
```assembly
; Configura OPTION_REG
MOVLW b'00000110'  ; RBPU = 0, INTEDG = 0, T0CS = 0, T0SE = 0, PSA = 0, PS2:PS0 = 110 (1:8)
OPTION            ; Carrega o valor no registrador OPTION_REG

; Iniciar Timer0
CLRF TMR0         ; Zera o registrador TMR0

LOOP:
    BTFSS INTCON, T0IF  ; Verifica a flag T0IF (Timer0 Overflow)
    GOTO LOOP           ; Retorna para LOOP se não houve overflow
    BSF INTCON, T0IF    ; Limpa a flag T0IF
    ; Aqui você pode adicionar o código para o que fazer quando o Timer0 estourar
    GOTO LOOP
```

### Explicação do Código
1. **`MOVLW b'00000110'`**: Configura o OPTION_REG.
   - **T0CS = 0**: Clock interno.
   - **T0SE = 0**: Incremento na borda ascendente.
   - **PSA = 0**: Prescaler atribuido ao Timer0.
   - **PS2:PS0 = 110**: Prescaler de 1:8.
2. **`CLRF TMR0`**: Inicializa o Timer0 com 0.
3. **`BTFSS INTCON, T0IF`**: Testa o bit **T0IF** para verificar se houve overflow.
4. **`BSF INTCON, T0IF`**: Limpa a flag T0IF.
5. **`GOTO LOOP`**: Retorna para o loop principal.

## 4. Monitorando o Timer0
- A flag **T0IF** no registrador **INTCON** é setada quando ocorre um **overflow** no Timer0.
- Essa flag precisa ser **limpa manualmente** no software.

## 5. Observações
- O Timer0 incrementa a cada ciclo de clock quando o prescaler está configurado.
- Utilize o **datasheet** do PIC16F877 para ajustar o tempo de overflow conforme sua aplicação.

## Referência
Consulte o **datasheet do PIC16F877** para mais detalhes sobre o Timer0 e suas configurações.
