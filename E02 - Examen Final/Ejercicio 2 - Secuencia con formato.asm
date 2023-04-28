; Autor: Juan Diego Marroquín Escobar - 1689821
; Final: Código que lee desde línea de comandos una secuencia con formato base exponente...
; Fecha de creación: 28/04/23 

; --- Pasos para resolverlo---
; 1. Inicializamos los registros
; 2. Realizamos la multiplicación cíclica
; 3. Leemos los argumentos desde la línea de comandos
; 4. Verificamos que se hayan leído dos argumentos válidos
; 5. Calculamos el resultado utilizando multiplicación cíclica
; 6. Imprimimos el resultado
; 7. Salimos del programa
; 8. Imprimimos un mensaje de error y salimos del programa

section .data
msg1 db "Error: Debe especificar dos argumentos numéricos", 10, 0
msg2 db "%d", 10, 0
msg3 db "%d elevado a la %d es %d", 10, 0

section .bss
base resd 1
exponente resd 1
resultado resd 1

section .text
global main

extern printf
extern scanf
extern atoi

mul_ciclico:
    push ebp
    mov ebp, esp
    push ebx
    push ecx

    mov eax, 1
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]

    .loop:
        cmp ecx, 0
        je .end

        test ecx, 1
        jz .skip_mul

        imul eax, ebx
    .skip_mul:
        shl ebx, 1
        shr ecx, 1
        jmp .loop

    .end:
        pop ecx
        pop ebx
        mov esp, ebp
        pop ebp
        ret

main:
    mov esi, [esp+4]
    add esi, 8
    mov edi, base
    mov dword [edi], 0
    mov edi, exponente
    mov dword [edi], 0
    cmp byte [esi], 0
    je .error
    mov edi, base
    call atoi
    mov dword [edi], eax
    mov edi, exponente
    mov esi, [esp+8]
    cmp byte [esi], 0
    je .error
    call atoi
    mov dword [edi], eax

    mov eax, dword [base]
    cmp eax, 0
    je .error
    mov eax, dword [exponente]
    cmp eax, 0
    je .error

    mov ebx, dword [base]
    mov ecx, dword [exponente]
    push ecx
    push ebx
    call mul_ciclico
    add esp, 8
    mov edi, resultado
    mov dword [edi], eax

    push dword [exponente]
    push dword [base]
    push dword [resultado]
    push dword msg3
    call printf
    add esp, 16

    xor eax, eax
    ret

.error:
    push dword msg1
    call printf
    add esp, 4
    xor eax, eax