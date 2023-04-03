; Autor: Juan Diego Marroquín Escobar - 1689821
; Ejercicio: Mayúsculas a Minúsculas
; Fecha de creación: 15/03/23 

section .data
    mensaje db 'MAYÚSCULAS A MINÚSCULAS', 0
    mensaje_len equ $ - mensaje

section .text
    global _start

_start:
    
    ; Imprime el mensaje original
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Convierte el mensaje a minúsculas
    call convertir_a_minusculas

    ; Imprime el mensaje convertido
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Finaliza el programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

convertir_a_minusculas:
    ; Convierte la cadena a minúsculas
    pusha
    xor esi, esi  
    loop_start:
        ; Si la cadena terminó, salta a la etiqueta loop_end
        cmp byte [mensaje + esi], 0
        je loop_end

        ; Si la letra es mayúscula, conviértela a minúscula
        cmp byte [mensaje + esi], 'A'
        jb loop_continue
        cmp byte [mensaje + esi], 'Z'
        ja loop_continue
        or byte [mensaje + esi], 0x20

        ; Incrementa el contador y vuelve al inicio del loop
        loop_continue:
        inc esi
        jmp loop_start

    loop_end:
    popa
    ret
