# Como usar USART no PIC

## Habilitar as interrupções
```
BANKSEL  PIE1
BSF  PIE1, TXIE    ; Habilita a interrupção de transmissão
BSF  PIE1, RCIE    ; Habilita a interrupção de transmissão

BANKSEL  INTCON
BSF  INTCON, PIE    ; Habilita interrupções de periféricos
BSF  INTCON, GIE    ; Habilita interrupções gerais
```
- Obs: Quando a interrupção de transmissão acontecer, o bit **TXIF** do registrador **PIR1** será setado, é necessário que seja limpo manualmente.
- Obs: Quando a interrupção de recepção acontecer, o bit **RCIF** do registrador **PIR1** será setado, é necessário que seja limpo manualmente.

## Iniciar o registrador SPBRG com baud rate desejado

```
SPBRG = [Fosc / (M x Baud Rate)] - 1

Baud Rate baixo --> BRGH = 0 --> M = 64
Baud Rate ALTO --> BRGH = 1 --> M = 16

```

## Implementando a transmissão
- Habilitar as interrupções (se necessário)
- Configurar o SPBRG como mostrado acima
- Resetar o BIT SYNC do registrador TXSTA
- Setar o BIT SPEN do registrador RCSTA
- Habilitar o transmissor setando o bit TXEN do registrador TXSTA
- Carregar o dado a ser transmitido no registrador TXREG

## Implementando a recepção
- Habilitar as interrupções (se necessário)
- Configurar o SPBRG como mostrado acima
- Resetar o BIT SYNC do registrador TXSTA
- Setar o BIT SPEN do registrador RCSTA
- Habilitar o transmissor setando o bit CREN do registrador RCSTA
- Ler o dado recebido no registrador RCREG

```
BANKSEL TXSTA
BCF  TXSTA, SYNC    ; Habilita transmissão no modo assíncrono
BSF  TXSTA, TXEN    ; Habilita transmissão
BSF  TXSTA, BRGH    ; Habilita alta taxa de transmissão (baud rate alto).


BANKSEL  RCSTA
BSF  RCSTA, SPEN    ; Habilita o módulo UART.

```


