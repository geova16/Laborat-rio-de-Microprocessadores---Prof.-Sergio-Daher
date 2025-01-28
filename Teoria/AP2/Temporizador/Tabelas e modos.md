# Temporizador 8086 com PIT 8253/8254

Este documento fornece informações detalhadas sobre o uso do temporizador programável **PIT 8253/8254** no **8086**, incluindo tabelas de endereços, modos de operação e exemplos.

---

## Endereços dos Canais e Porta de Controle

| Canal      | Porta de Dados | Propósito do Canal                    |
|------------|----------------|---------------------------------------|
| **Channel 0** | `40h`         | Temporizador principal (usado para IRQ0). |
| **Channel 1** | `41h`         | Geralmente reservado para aplicações específicas. |
| **Channel 2** | `42h`         | Usado para controle do alto-falante do PC. |
| **Control**  | `43h`         | Porta de controle (configuração de modos e canais). |

- **Observação:** No código, você pode endereçar essas portas diretamente ou carregar o endereço no registrador `DX`.

---

## Estrutura do Byte de Controle

Ao configurar o temporizador, o **byte de controle** deve ser enviado para a **porta de controle** (`43h`). O byte tem o seguinte formato:

| Bits      | Descrição                                      |
|-----------|-----------------------------------------------|
| **7-6**    | Seleção do canal:                             |
|           | `00` - Channel 0                              |
|           | `01` - Channel 1                              |
|           | `10` - Channel 2                              |
|           | `11` - Comando "Read-Back"                    |
| **5-4**    | Modo de acesso:                               |
|           | `00` - Latch Count Value Command              |
|           | `01` - Acessar o LSB (byte menos significativo). |
|           | `10` - Acessar o MSB (byte mais significativo). |
|           | `11` - Acessar LSB e MSB (modo padrão).        |
| **3-1**    | Modo de operação:                             |
|           | `000` - Modo 0: Interrupt on Terminal Count   |
|           | `001` - Modo 1: Hardware Retriggerable One-Shot |
|           | `010` - Modo 2: Rate Generator                |
|           | `011` - Modo 3: Square Wave Generator         |
|           | `100` - Modo 4: Software Triggered Strobe     |
|           | `101` - Modo 5: Hardware Triggered Strobe     |
| **0**      | Tipo de contador:                             |
|           | `0` - Contador binário (16 bits).             |
|           | `1` - Contador BCD (4 dígitos).               |

---

## Modos de Operação do PIT

| Modo   | Descrição                                      | Uso Comum                          |
|--------|-----------------------------------------------|------------------------------------|
| **0**  | Interrupt on Terminal Count                   | Gera um pulso único quando o contador atinge zero. Usado em eventos programados. |
| **1**  | Hardware Retriggerable One-Shot               | Pulso único ativado externamente. Usado em medições e controle. |
| **2**  | Rate Generator                                | Gera pulsos periódicos. Usado para temporização de eventos, como a IRQ0. |
| **3**  | Square Wave Generator                         | Gera um sinal de onda quadrada. Usado em geração de frequências ou sons. |
| **4**  | Software Triggered Strobe                     | Um único pulso controlado por software. |
| **5**  | Hardware Triggered Strobe                     | Pulso controlado por sinal externo. |

---

## Exemplo de Byte de Controle

Se quisermos configurar o **Channel 0** no **Modo 2** (Rate Generator), com acesso ao **LSB e MSB**, o byte de controle será:

| Campo                | Valor   | Bits  |
|----------------------|---------|-------|
| Seleção do Canal     | `00`    | 7-6   |
| Modo de Acesso       | `11`    | 5-4   |
| Modo de Operação     | `010`   | 3-1   |
| Tipo de Contador     | `0`     | 0     |

**Byte de Controle em Binário:** `00110110b` (ou `36h` em hexadecimal).

---

## Código de Exemplo em Assembly

Aqui está um exemplo de como configurar o temporizador no Modo 2, usando o registrador `DX` para endereçar as portas de I/O:

```asm
; Configurar o temporizador no 8086 para gerar uma interrupção periódica.

mov al, 00110110b         ; Configurar: Modo 2 (Rate Generator), Canal 0
mov dx, 43h               ; Porta de controle do temporizador
out dx, al                ; Enviar comando para a porta de controle

mov ax, 0x4E20            ; Divisor (20.000 em decimal para ~60 Hz com clock de 1.19318 MHz)
mov dx, 40h               ; Porta de dados do Canal 0
out dx, al                ; Enviar byte menos significativo para o Canal 0
mov al, ah                ; Enviar byte mais significativo
out dx, al                ; Enviar para a mesma porta
```

Este código configura o **Canal 0** do temporizador em **Modo 2** (Rate Generator) para gerar uma interrupção periódica a uma frequência de aproximadamente 60 Hz.

---

Se precisar de mais informações ou exemplos, sinta-se à vontade para contribuir! 🛠️
