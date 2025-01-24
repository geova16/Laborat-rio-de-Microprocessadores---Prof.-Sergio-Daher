# Registradores do 8086 e Seus Usos no DOS

O processador 8086 possui vários tipos de registradores, classificados como **registradores de propósito geral**, **registradores de segmento**, **registradores de ponteiro e índice**, e **registradores de estado e controle**. A seguir, detalhamos cada um deles e seus principais usos no ambiente DOS.

---

## 1. Registradores de Propósito Geral

Os registradores de propósito geral são usados para armazenar dados temporários e realizar operações aritméticas e lógicas.

| **Registrador** | **Descrição**                                                                                                     | **Uso no DOS**                                                                                                                                                     |
|------------------|-----------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **AX**          | Registrador acumulador. Dividido em **AH** (parte alta) e **AL** (parte baixa).                                | Usado para operações aritméticas, chamadas de sistema e transferência de dados. Exemplo: Interrupção `INT 21h` utiliza AX para especificar a função.              |
| **BX**          | Registrador base. Dividido em **BH** e **BL**.                                                                | Frequentemente usado como base para acessar dados na memória em conjunto com deslocamento.                                                                        |
| **CX**          | Registrador contador. Dividido em **CH** e **CL**.                                                            | Usado como contador em loops e operações de repetição, como `REP MOVSB` e `LOOP`.                                                                                |
| **DX**          | Registrador de dados. Dividido em **DH** e **DL**.                                                            | Usado para operações envolvendo entrada/saída e multiplicação/divisão de 32 bits (parte alta do resultado ou do operando). Exemplo: porta de E/S em `OUT DX, AL`. |

---

## 2. Registradores de Segmento

Os registradores de segmento são usados para acessar diferentes áreas de memória em conjunto com registradores de deslocamento.

| **Registrador** | **Descrição**                                                             | **Uso no DOS**                                                                                                                   |
|------------------|---------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| **CS**          | Segmento de código. Aponta para o segmento que contém as instruções.    | Define a área onde o código executável está localizado.                                                                          |
| **DS**          | Segmento de dados. Aponta para o segmento que contém dados.             | Usado para acessar variáveis globais e estruturas de dados na memória.                                                          |
| **SS**          | Segmento de pilha. Aponta para o segmento que contém a pilha.           | Define a área onde a pilha é alocada, usada para armazenamento temporário e controle de sub-rotinas.                             |
| **ES**          | Segmento extra. Usado como um segmento auxiliar para operações diversas. | Frequentemente usado com operações de transferência de memória, como em `MOVS` e `STOS`.                                        |

---

## 3. Registradores de Ponteiro e Índice

Os registradores de ponteiro e índice são usados para acessar posições específicas na memória ou na pilha.

| **Registrador** | **Descrição**                                                        | **Uso no DOS**                                                                                                                                  |
|------------------|----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| **SP**          | Ponteiro de pilha. Aponta para o topo da pilha no segmento definido por **SS**. | Usado para empilhar e desempilhar valores durante chamadas de sub-rotinas ou interrupções.                                                     |
| **BP**          | Ponteiro base. Referência para acessar a pilha com deslocamentos.    | Usado para acessar parâmetros de funções e dados armazenados na pilha.                                                                         |
| **SI**          | Índice de origem.                                                   | Usado em operações de transferência de dados, como `MOVS`, para apontar para o endereço-fonte.                                                 |
| **DI**          | Índice de destino.                                                  | Usado em operações de transferência de dados, como `STOS`, para apontar para o endereço-destino.                                               |

---

## 4. Registradores de Estado e Controle

Estes registradores controlam o fluxo de execução e monitoram o estado do processador.

| **Registrador** | **Descrição**                                                               | **Uso no DOS**                                                                                                   |
|------------------|-----------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| **IP**          | Ponteiro de instrução. Contém o deslocamento da próxima instrução.          | Define a próxima instrução a ser executada no segmento de código (CS).                                         |
| **FLAGS**       | Registrador de estado. Indica o estado do processador e controla operações. | Usado para determinar condições como sinal, zero, carry, overflow, entre outras. Exemplo: ajustes em instruções condicionais como `JE` ou `JNE`. |

---

## Tabela Resumida de Registradores do 8086

| **Tipo**               | **Registradores**        | **Descrição Geral**                                                  |
|-------------------------|--------------------------|-----------------------------------------------------------------------|
| **Propósito Geral**     | AX, BX, CX, DX          | Operações aritméticas, lógicas e de transferência de dados.          |
| **Segmento**            | CS, DS, SS, ES          | Acesso a diferentes áreas de memória.                                |
| **Ponteiro e Índice**   | SP, BP, SI, DI          | Acesso à pilha e operações com dados na memória.                     |
| **Estado e Controle**   | IP, FLAGS               | Controle de fluxo e monitoramento do estado do processador.          |

---

## Exemplo de Código em Assembly (DOS)

Abaixo está um exemplo simples que utiliza vários registradores para realizar uma chamada de sistema no DOS:

```asm
; Programa em Assembly para exibir uma mensagem no DOS
.model small
.stack 100h
.data
    mensagem db 'Hello, World!$', 0
.code
main proc
    mov ax, @data       ; Carregar o segmento de dados em AX
    mov ds, ax          ; Configurar DS com o segmento de dados
    lea dx, mensagem    ; Carregar o endereço da mensagem em DX
    mov ah, 09h         ; Função de exibição de string (INT 21h)
    int 21h             ; Chamada de interrupção do DOS
    mov ah, 4Ch         ; Função para terminar o programa (INT 21h)
    int 21h             ; Chamada de interrupção do DOS
main endp
end main
