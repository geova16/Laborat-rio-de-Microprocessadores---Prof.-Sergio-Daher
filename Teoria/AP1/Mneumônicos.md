# Mnemônicos da Família PIC16

## 1. Instruções de Movimentação de Dados
| **Mnemônico** | **Descrição**                                 |
|---------------|-----------------------------------------------|
| `MOVLW k`     | Move uma constante **k** para o registrador W. |
| `MOVWF f`     | Move o conteúdo de W para o registrador **f**. |
| `MOVF f, d`   | Move o conteúdo de **f** para **d** (W ou f).   |
| `CLRF f`      | Limpa (zera) o conteúdo do registrador **f**.  |
| `CLRW`        | Limpa (zera) o registrador de trabalho **W**.  |

## 2. Instruções Aritméticas
| **Mnemônico**  | **Descrição**                                 |
|----------------|-----------------------------------------------|
| `ADDLW k`      | Soma o valor **k** (literal) com **W**.        |
| `ADDWF f, d`   | Soma o conteúdo de **W** com **f** e armazena em **d**. |
| `SUBLW k`      | Subtrai o valor **k** de **W**.                |
| `SUBWF f, d`   | Subtrai o conteúdo de **f** de **W** e armazena em **d**. |
| `INCF f, d`    | Incrementa o conteúdo do registrador **f** e armazena em **d**. |
| `DECF f, d`    | Decrementa o conteúdo do registrador **f** e armazena em **d**. |
| `INCFSZ f, d`  | Incrementa **f** e salta se o resultado for zero. |
| `DECFSZ f, d`  | Decrementa **f** e salta se o resultado for zero. |

## 3. Instruções Lógicas e Bit a Bit
| **Mnemônico**  | **Descrição**                                      |
|----------------|----------------------------------------------------|
| `ANDLW k`      | Faz operação lógica **AND** entre **k** e **W**.     |
| `ANDWF f, d`   | Faz operação lógica **AND** entre **W** e **f** e armazena em **d**. |
| `IORLW k`      | Faz operação lógica **OR** entre **k** e **W**.      |
| `IORWF f, d`   | Faz operação lógica **OR** entre **W** e **f** e armazena em **d**. |
| `XORLW k`      | Faz operação lógica **XOR** entre **k** e **W**.     |
| `XORWF f, d`   | Faz operação lógica **XOR** entre **W** e **f** e armazena em **d**. |
| `COMF f, d`    | Complementa (inverte) o conteúdo do registrador **f** e armazena em **d**. |
| `RLF f, d`     | Rotaciona o conteúdo de **f** para a esquerda.     |
| `RRF f, d`     | Rotaciona o conteúdo de **f** para a direita.      |
| `SWAPF f, d`   | Troca os nibbles (4 bits) altos e baixos de **f**. |

## 4. Instruções de Manipulação de Bits
| **Mnemônico**  | **Descrição**                                      |
|----------------|----------------------------------------------------|
| `BSF f, b`     | Seta o bit **b** do registrador **f**.              |
| `BCF f, b`     | Limpa o bit **b** do registrador **f**.             |
| `BTFSS f, b`   | Testa o bit **b** de **f** e salta se estiver setado. |
| `BTFSC f, b`   | Testa o bit **b** de **f** e salta se estiver limpo. |
| `BTG f, b`     | Inverte (toggle) o bit **b** do registrador **f**.  |

## 5. Instruções de Controle de Fluxo
| **Mnemônico**  | **Descrição**                                      |
|----------------|----------------------------------------------------|
| `GOTO label`   | Salta para uma etiqueta especificada (**label**).   |
| `CALL label`   | Chama uma sub-rotina localizada na etiqueta **label**. |
| `RETURN`       | Retorna de uma sub-rotina.                         |
| `RETLW k`      | Retorna com **k** carregado no registrador **W**.   |
| `NOP`          | Não realiza nenhuma operação (No Operation).       |

## 6. Instruções de Gerenciamento de Processador
| **Mnemônico**  | **Descrição**                                      |
|----------------|----------------------------------------------------|
| `SLEEP`        | Coloca o microcontrolador em modo de baixo consumo. |
| `CLRWDT`       | Limpa o Watchdog Timer (WDT).                     |
| `OPTION`       | Escreve no registrador de configuração OPTION.    |
| `TRIS f`       | Configura um registrador como entrada ou saída.   |

## Resumo dos Operandos
- **`f`**: Um registrador de memória (destino ou fonte).
- **`d`**: Destino da operação:
   - `0` → Resultado vai para W.
   - `1` → Resultado vai para o registrador **f**.
- **`k`**: Literal (constante numérica).
- **`b`**: Número do bit dentro do registrador.
