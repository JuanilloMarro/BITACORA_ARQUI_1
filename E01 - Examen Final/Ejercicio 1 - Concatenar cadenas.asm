; Autor: Juan Diego Marroquín Escobar - 1689821
; Final: Código que concatene dos cadenas de caracteres.
; Fecha de creación: 28/04/23 

    ; --- Pasos para resolverlo, lo estudie ayer jiji :) ---
    ; 1. Guardamos los registros
    ; 2. Bucamos el final de la cadena
    ; 3. Copiamos la cadena principal al final de la cadena de destino
    ; 4. Termina la cadena de destino con el carácter nulo
    ; 5. Devolvemos y restauramos los registros
    ; 6. Imprimimos el mensaje para la cadena 1
    ; 7. Leemos la cadena 1 del usuario
    ; 8. Imprimimos el mensaje para la cadena 2
    ; 9. Leemos la cadena 2 del usuario
    ; 10. Concatenamos las cadenas y almacenamos el resultado en "result"
    ; 11. Imprimimos la cadena concatenada
    ; 12. Salimos del programa

section .data
    msg1 db "Escriba la cadena 1 a utilizar: ", 0
    msg2 db "Escriba la cadena 2 a utilizar: ", 0
    msg3 db "Cadena copiada: ", 0

section .bss
    str1 resb 100
    str2 resb 100
    result resb 200

section .text
global main

extern printf
extern scanf

strCat:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx

    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    mov edx, [ebx]
    add ebx, edx
    dec ebx

    .loop:
        mov al, [ecx]
        mov [ebx+1], al
        inc ebx
        inc ecx
        cmp byte [ecx], 0
        jne .loop

    mov byte [ebx+1], 0

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret

main:
    push dword msg1
    call printf
    add esp, 4

    push dword str1
    push dword "%s"
    call scanf
    add esp, 8

    push dword msg2
    call printf
    add esp, 4

    push dword str2
    push dword "%s"
    call scanf
    add esp, 8

    push dword str1
    push dword str2
    push dword result
    call strCat
    add esp, 12

    push dword msg3
    push dword result
    call printf
    add esp, 8

    xor eax, eax
    ret
