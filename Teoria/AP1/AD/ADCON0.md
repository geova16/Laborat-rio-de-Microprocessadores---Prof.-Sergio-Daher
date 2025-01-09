# Registrador ADCON0 no Microcontrolador PIC

O registrador **ADCON0** controla o funcionamento do módulo de Conversão Analógico-Digital (ADC) em microcontroladores PIC. Ele permite configurar o ADC, selecionar o canal de entrada, iniciar a conversão e verificar o status do processo.

## Estrutura do Registrador ADCON0

| **Bit** | **Nome**        | **Descrição**                                                                                                                             |
|---------|-----------------|-------------------------------------------------------------------------------------------------------------------------------------------|
| 7       | **ADCS1**       | Seleciona a frequência de clock do ADC (junto com o bit ADCS0 no ADCON0 e bits ADCS2 no ADCON1).                                           |
| 6       | **GO/DONE**     | Controla e monitora o processo de conversão: <br> **1** = Inicia a conversão AD <br> **0** = Conversão concluída.                        |
| 5       | **CHS2**        | Seleciona o canal analógico de entrada (junto com CHS1 e CHS0).                                                                           |
| 4       | **CHS1**        | Seleciona o canal analógico de entrada (junto com CHS2 e CHS0).                                                                           |
| 3       | **CHS0**        | Seleciona o canal analógico de entrada.                                                                                                   |
| 2       | **Unimplemented** | Reservado para uso futuro. Deve ser mantido em **0**.                                                                                   |
| 1       | **ADON**        | Habilita ou desabilita o módulo ADC: <br> **1** = ADC habilitado <br> **0** = ADC desabilitado.                                            |
| 0       | **Unimplemented** | Reservado para uso futuro. Deve ser mantido em **0**.                                                                                   |

## Funções dos Principais Bits

### ADCS1 e ADCS0
- Configuram a frequência de clock para o ADC.
- Consulte o datasheet do microcontrolador para os valores específicos.

### GO/DONE
- Controla o processo de conversão:
  - **1**: Inicia a conversão AD.
  - **0**: Conversão concluída (zerado automaticamente pelo hardware).

### CHS2:CHS0
- Selecionam o canal de entrada analógica:
  - **000**: Canal AN0
  - **001**: Canal AN1
  - **010**: Canal AN2
  - E assim por diante.

### ADON
- Habilita ou desabilita o módulo ADC.
- Deve ser configurado como **1** antes de iniciar qualquer conversão.

## Exemplo de Código

```assembly
; Configura o ADC para usar o canal AN0 e habilitar o módulo
BANKSEL ADCON0     ; Seleciona o banco que contém ADCON0
MOVLW 0x01         ; Carrega o valor 0x01 (ADON = 1, Canal AN0 = 000)
MOVWF ADCON0       ; Escreve no registrador ADCON0

; Inicia a conversão
BSF ADCON0, 2      ; Seta o bit GO/DONE para iniciar a conversão

; Aguarda o término da conversão
WAIT_CONVERSION:
    BTFSC ADCON0, 2 ; Verifica se o bit GO/DONE foi zerado
    GOTO WAIT_CONVERSION ; Se ainda não, continua aguardando

; Leitura do resultado
MOVFW ADRESL       ; Lê o byte menos significativo do resultado
MOVWF ad_L         ; Armazena o valor em um registrador
MOVFW ADRESH       ; Lê o byte mais significativo do resultado
MOVWF ad_H         ; Armazena o valor em outro registrador
