; kernel.asm
BITS 32

section .text
global _start

_start:
    ; Приветствие через прямой доступ к видеопамяти (0xB8000)
    mov edi, 0xB8000
    mov esi, message
    mov ah, 0x0F           ; белый на чёрном
.print:
    lodsb
    test al, al
    jz .done
    stosw                  ; символ + атрибут
    jmp .print

.done:
    ; Бесконечный цикл (позже тут будет main)
    cli
.hang:
    hlt
    jmp .hang

section .data
message db "Hello from my kernel!", 0
