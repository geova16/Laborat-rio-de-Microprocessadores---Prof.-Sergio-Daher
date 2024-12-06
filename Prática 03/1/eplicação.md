## Como verificar se o trecho de inicialização está configurando a USART para 9600 bps @ Fosc = 10 MHz, 8 databits, no-parity, 1 startbit, 1 stopbit?

### 1. Cálculo da Taxa de Baud
O valor de **SPBRG** (Baud Rate Generator) é calculado com a fórmula:

#### Modo de Alta Velocidade (BRGH = 1):
\[
SPBRG = \frac{Fosc}{16 \cdot BaudRate} - 1
\]

- **Fosc**: 10 MHz
- **BaudRate**: 9600 bps

Substituindo os valores:
\[
SPBRG = \frac{10,000,000}{16 \cdot 9600} - 1 = 64
\]

No código fornecido:
```assembly
movlw .64
movwf SPBRG
