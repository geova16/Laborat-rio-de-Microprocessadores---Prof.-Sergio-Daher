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
```

### 2. Configuração do Registro TXSTA
O registro TXSTA configura a transmissão. No código fornecido:

#### BRGH (bit 2):
```assembly
bsf TXSTA, BRGH
```
Esse bit está habilitado, ativando o modo de alta velocidade (correto).

#### TXEN (bit 5):
```assembly
bsf TXSTA, TXEN
```
Esse bit habilita a transmissão (correto).

#### SYNC (bit 4)
Não configurado no código (valor padrão = 0), o que define o modo como assíncrono (correto).

### 3. Configuração do Registro RCSTA
O registro RCSTA configura o módulo de recepção. No código fornecido:
#### SPEN (bit 7):
```assembly
bsf RCSTA, SPEN
```
Habilita a porta serial (correto).
#### CREN (bit 4):
```assembly
bsf RCSTA, CREN
```

### 4. Formato de Dados (8N1)

#### 8 data bits: O padrão do PIC é 8 bits no modo assíncrono (correto).
#### No parity: A paridade não é configurada no código, mantendo o padrão de sem paridade (correto).
#### 1 stop bit: O padrão no modo assíncrono do PIC é 1 stop bit (correto).
