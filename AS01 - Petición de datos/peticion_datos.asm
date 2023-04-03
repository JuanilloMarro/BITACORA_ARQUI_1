; Autor: Juan Diego Marroquín Escobar - 1689821
; Ejercicio: Petición de datos
; Fecha de creación: 7/03/23 

SECTION .data
    mensaje DB 'Ingrese cualquier numero número entero: '
    formato DB '%d', 0
    numero DD 0

SECTION .text
    global _start

    extern scanf, printf

_start:

    push mensaje
    call printf
    add esp, 4

    push numero
    push formato
    call scanf
    add esp, 8

    mov eax, 1
    xor ebx, ebx
    int 0x80