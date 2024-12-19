# Registrador T2CON - PIC16

O registrador **T2CON** controla as principais funcionalidades do Timer2 nos microcontroladores PIC. Ele permite configurar o prescaler, o pós-escaler e ativar ou desativar o Timer2.

## Estrutura do Registrador T2CON

| **Bit** | **Nome**     | **Descrição**                                         |
|---------|--------------|-----------------------------------------------------|
| 7       | Não usado    | Reservado (lê-se como 0).                           |
| 6       | Não usado    | Reservado (lê-se como 0).                           |
| 5       | TOUTPS3      | Seleção do pós-escaler (bit mais significativo).     |
| 4       | TOUTPS2      | Seleção do pós-escaler.                              |
| 3       | TOUTPS1      | Seleção do pós-escaler.                              |
| 2       | TOUTPS0      | Seleção do pós-escaler (bit menos significativo).    |
| 1       | TMR2ON       | Liga/Desliga o Timer2 (1 = Ativo, 0 = Desligado).    |
| 0       | T2CKPS<1:0>  | Seleção do prescaler (2 bits).                      |

---

## Configuração do Prescaler (T2CKPS<1:0>)
O prescaler é usado para dividir a frequência de entrada do Timer2, aumentando o tempo entre incrementos.

| **T2CKPS1:T2CKPS0** | **Prescaler** |
|---------------------|---------------|
| `00`                | 1             |
| `01`                | 4             |
| `10`                | 16            |
| `11`                | Reservado     |

---

## Configuração do Pós-escaler (TOUTPS<3:0>)
O pós-escaler é usado para dividir o número de ciclos do Timer2 antes de gerar um evento de interrupção.

| **TOUTPS3:TOUTPS0** | **Pós-escaler** |
|---------------------|-----------------|
| `0000`              | 1               |
| `0001`              | 2               |
| `0010`              | 3               |
| ...                 | ...             |
| `1111`              | 16              |

---

## Exemplo de Configuração

### Exemplo 1: Configurar o Timer2 com Prescaler 16 e Pós-escaler 4

#### Código Assembly:
```assembly
    BANKSEL T2CON        ; Seleciona o banco do T2CON
    MOVLW B'00100110'    ; Pós-escaler de 4, prescaler de 16, liga o Timer2
    MOVWF T2CON
```

### Exemplo 2: Configurar o Timer2 com Prescaler 4 e Pós-escaler 1

#### Código Assembly:
```assembly
    BANKSEL T2CON        ; Seleciona o banco do T2CON
    MOVLW B'00000101'    ; Pós-escaler de 1, prescaler de 4, liga o Timer2
    MOVWF T2CON
```

---

## Observações

1. **Ativação do Timer2**:
   - O bit **TMR2ON** deve ser setado para iniciar o Timer2.
   - Quando desativado, o Timer2 para de contar.

2. **Combinação com PR2**:
   - O valor no registrador PR2 define o limite superior do Timer2.
   - O Timer2 é reiniciado quando atinge o valor de PR2.

3. **Interrupções**:
   - A interrupção do Timer2 ocorre quando o Timer2 completa seu ciclo e o pós-escaler termina.
   - A flag de interrupção **TMR2IF** no registrador **PIR1** é usada para monitorar este evento.

4. **Uso em PWM**:
   - O Timer2 é amplamente utilizado como base para o módulo PWM, controlando a frequência do sinal.

---

## Referência
Consulte o **datasheet** do microcontrolador PIC16 para obter mais informações sobre o registrador T2CON e suas funcionalidades.
