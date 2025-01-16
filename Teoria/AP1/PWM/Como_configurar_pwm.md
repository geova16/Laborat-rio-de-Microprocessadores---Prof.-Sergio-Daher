# Configuração do periférico PWM no PIC16F877A ou PIC16F628A

# 1. Calcular o valor que deve ser colocado em PR2, e carregar o PR2 com este valor.

```
PR2 = [(Fosc) / (Fpwm x 4 x PRESCALE_TIMER2)] - 1 
```
OBS: Escolher um PRESCALE_TIMER2 (1, 4 e 16) de forma que PR2 seja menor que 256 (8 bits) 

# 2. Calcular e configurar o valor do Duty Cycle (Valores para CCPR1L e os bits 5 e 4 de CCP1CON). 

## Encontrar um valor binário de 10 bits dado pela fórmula:
```
DutyCycle(%) x (PR2 + 1) x 4 = CCPR1L:CCP1CON<4:5> (resultado em decimal --> transformar em binário)
```
## Inserir os 8 bits mais significativos (esquerda) no registador CCPR1L e os 2 bits menos significativos (direita) nos bits 5 e 4 do CCP1CON

# 4. Selecionar o prescale do Timer 2 no registrador T2CON. Habilite o Timer 2

# 5. Configure o módulo CCP1CON para PWM
- Basta inserir b'1111' nos 4 bits menos significativos (direita) e nos bits 5 e 4 inserir os 2 bits menos significativos calculados acima

# Exemplo prático
- Considere uma Fosc = XTAL = 10MHz
- Faremos um PWM de 10kHz com 2% de Duty Cycle

## Cálculo do PR2

```
PR2 = [(Fosc) / (Fpwm x 4 x PRESCALE_TIMER2)] - 1

PR2 = [(10MHz) / (10kHz x 4 x 1)] - 1

PR2 = 249
```

## Duty Cycle

```
DutyCycle(%) x (PR2 + 1) x 4 = CCPR1L:CCP1CON<4:5>

0,02 x (249 + 1) x 4 = CCPR1L:CCP1CON<4:5>

20(d) = CCPR1L:CCP1CON<4:5> = 0000 0001 0100 (b)
```

- Para CCPR1L --> 00 0001 01
- Para CCP1CON<5:4> --> 00

  ## T2CON
 - Como usamos prescale = 1, temos que configurar  T2CON para tal
 - Para habilitar T2CON --> BIT3(TMR2ON) = 1
 - Para prescale 1 --> BIT1:0 (T2CKPS<1:0>)	= 00

## Código

```assembly
#INCLUDE <P16F628A.INC>

ORG  0x00
  GOTO INICIO
ORG  0x04
  RETFIE

INICIO:
  BANKSEL PR2
  MOVLW  d'249'
  MOVWF  PR2

  BANKSEL  CCP1CON
  MOVLW  b'00001111'
  MOVWF  CCP1CON

  BANKSEL  CCPR1L
  MOVLW  b'00000101'
  MOVWF  CCPR1L

  BANKSEL  T2CON
  MOVLW  b'00000100'
  MOVWF  T2CON

  BANKSEL  TRISB
  CLRF  TRISB

MAIN:
  GOTO MAIN

END

```

# Exemplo 2

```assembly
#INCLUDE <P16F628A.INC>

ORG  0x00
  GOTO INICIO
ORG  0x04
  RETFIE

INICIO:
BANKSEL TRISB ; Seleciona banco 1.
BCF TRISB, 3 ; Coloca o Pino do CCP1 para saída.

MOVLW D’49’ ; Carrega o PR2.
MOVWF PR2

BANKSEL CCP1CON ; Seleciona banco 0.
MOVLW B’00101111’ ; Configura o modo de operação do
MOVWF CCP1CON ; CCP e os dois bits do duty cycle.
MOVLW B’00000100’ ; Configura o Prescale do Timer 2.
MOVWF T2CON
MOVLW B’00001100’ ; Configura o duty cycle
MOVWF CCPR1L

MAIN:
  GOTO MAIN

END

```
