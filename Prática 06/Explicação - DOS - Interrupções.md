# Guia de DOS e Interrupções

## O que é DOS?

**DOS** (Disk Operating System) é um sistema operacional simples e baseado em texto que foi amplamente utilizado em computadores pessoais entre os anos 1980 e início de 1990. Ele fornece uma interface de linha de comando (CLI) que permite aos usuários executar programas, gerenciar arquivos e interagir com hardware básico.

### Características principais do DOS:
- Interface de linha de comando (CLI).
- Suporte para sistemas de arquivos FAT12 e FAT16.
- Uso extensivo de **interrupções de software** para realizar tarefas.

---

## O que são interrupções no DOS?

As **interrupções de software** são comandos especiais que permitem que os programas solicitem serviços do sistema operacional (ou do BIOS). Cada interrupção é identificada por um número hexadecimal, e algumas são específicas do DOS, enquanto outras interagem diretamente com o hardware.

A interrupção mais usada no DOS é a **int 21h**, que contém uma série de subfunções acessadas definindo valores específicos no registrador `AH`.

---

## Principais Interrupções do DOS

### **Interrupção 21h** - Serviços do DOS

Esta é a interrupção mais versátil, com subfunções que permitem manipular arquivos, exibir texto, ler teclado, e muito mais.

```asm
; Exibir um caractere (AH = 02h)
mov AH, 02h       ; Função 02h: Exibir caractere
mov DL, 'A'       ; Caractere a ser exibido (A)
int 21h           ; Chama a interrupção

; Exibir uma string (AH = 09h)
mov AH, 09h       ; Função 09h: Exibir string
lea DX, msg       ; Endereço da string (terminada com $)
int 21h           ; Chama a interrupção
; Dados
msg db 'Olá, mundo!$', 0

; Ler uma tecla (AH = 01h)
mov AH, 01h       ; Função 01h: Ler tecla
int 21h           ; Chama a interrupção
; Resultado: Caractere lido será armazenado em AL

; Criar um arquivo (AH = 3Ch)
mov AH, 3Ch       ; Função 3Ch: Criar arquivo
lea DX, filename  ; Endereço do nome do arquivo
mov CX, 0         ; Atributos do arquivo
int 21h           ; Chama a interrupção
; Dados
filename db 'novo_arquivo.txt', 0

; Abrir um arquivo (AH = 3Dh)
mov AH, 3Dh       ; Função 3Dh: Abrir arquivo
lea DX, filename  ; Endereço do nome do arquivo
mov AL, 00h       ; Modo de acesso (somente leitura)
int 21h           ; Chama a interrupção

; Gravar em arquivo (AH = 40h)
mov AH, 40h       ; Função 40h: Gravar em arquivo
mov BX, handle    ; Handle do arquivo
lea DX, buffer    ; Endereço dos dados a serem escritos
mov CX, tamanho   ; Tamanho dos dados
int 21h           ; Chama a interrupção
; Dados
buffer db 'Texto de exemplo', 0
tamanho equ $ - buffer

; Fechar arquivo (AH = 3Eh)
mov AH, 3Eh       ; Função 3Eh: Fechar arquivo
mov BX, handle    ; Handle do arquivo
int 21h           ; Chama a interrupção

; Encerrar o programa (AH = 4Ch)
mov AH, 4Ch       ; Função 4Ch: Encerrar programa
mov AL, 00h       ; Código de saída (0)
int 21h           ; Termina o programa
