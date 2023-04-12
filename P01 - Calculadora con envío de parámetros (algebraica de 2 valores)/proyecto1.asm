; Autor: Juan Diego Marroquín Escobar - 1689821
; Proyecto 1
; Fecha de creación: 11/04/23 
; Programa en ensamblador NASM que implementa una calculadora simple para sumar, restar, multiplicar y dividir dos valores.

section .data
    mensaje1 db 'Ingrese el primer valor: ', 0
    mensaje2 db 'Ingrese el segundo valor: ', 0
    resultado db 'El resultado es: %d', 10, 0
    error_division db 'Error: División por cero', 10, 0

section .bss
    valor1 resb 5
    valor2 resb 5

section .text
    global _start

_start:
    ; Imprimir mensaje 1
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje1
    mov edx, 23
    int 0x80

    ; Leer valor 1
    mov eax, 3
    mov ebx, 0
    mov ecx, valor1
    mov edx, 5
    int 0x80

    ; Imprimir mensaje 2
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje2
    mov edx, 24
    int 0x80

    ; Leer valor 2
    mov eax, 3
    mov ebx, 0
    mov ecx, valor2
    mov edx, 5
    int 0x80

    ; Convertir valor 1 a entero
    mov eax, 0
    mov ebx, valor1
    mov edx, 0
    mov ecx, 10
    cld
    mov esi, ebx
    mov edi, eax
    rep movsb

    ; Convertir valor 2 a entero
    mov eax, 0
    mov ebx, valor2
    mov edx, 0
    mov ecx, 10
    cld
    mov esi, ebx
    mov edi, eax
    rep movsb

    ; Sumar valores
    add eax, ebx
    cmp ebx, 0
    je division_error
    jmp imprimir_resultado

    ; Restar valores
    sub eax, ebx
    cmp ebx, 0
    je division_error
    jmp imprimir_resultado

    ; Multiplicar valores
    imul ebx
    cmp ebx, 0
    je division_error
    jmp imprimir_resultado

    ; Dividir valores
    mov edx, 0
    div ebx
    cmp ebx, 0
    je division_error
    jmp imprimir_resultado

imprimir_resultado:
    ; Imprimir resultado
    push eax
    push resultado
    call printf
    add esp, 8

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

division_error:
    ; Imprimir error de división
    mov eax, 4
    mov ebx, 1
    mov ecx, error_division
    mov edx, 26
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

