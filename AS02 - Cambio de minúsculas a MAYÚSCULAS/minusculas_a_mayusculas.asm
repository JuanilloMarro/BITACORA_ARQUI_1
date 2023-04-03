; Autor: Juan Diego Marroquín Escobar - 1689821
; Ejercicio: Minúsculas a Mayúsculas
; Fecha de creación: 16/03/23 

SECTION .data
    MEN  DB 'MMINÚSCULAS A MAYÚSCULAS', 0   ; Imprimir el mensaje
SECTION .text
    global _start

_start:
    mov     eax, 4      
    mov     ebx, 1       
    mov     ecx, MEN     
    mov     edx, len   
    int     0x80        

    call    minusculas  ; Función de Convertir a minúsculas
    call    mayusculas  ; Función de Convertir a mayúsculas

    mov     eax, 1      ; Salimos del programa
    xor     ebx, ebx    
    int     0x80        

minusculas:
    mov     ebx, MEN     
    mov     ecx, len    
    xor     esi, esi     
mloop:
    cmp     byte [ebx+esi], 0  ; Si nos encontramos al final del mensaje, salimos
    je      mexit
    cmp     byte [ebx+esi], 'a' ; Si es menor que la letra a, no es una letra minúscula
    jl      mskip
    cmp     byte [ebx+esi], 'z' ; Si es mayor que la letra z, no es una letra minúscula
    jg      mskip
    sub     byte [ebx+esi], 0x20 ; Convertir letra minúscula a mayúscula
mskip:
    inc     esi          
    jmp     mloop        
mexit:
    ret

mayusculas:
    mov     ebx, MEN    
    mov     ecx, len     
    xor     esi, esi     
oloop:
    cmp     byte [ebx+esi], 0  ; Si nos encontramos al final del mensaje, salimos
    je      oexit
    cmp     byte [ebx+esi], 'A' ; Si es menor que la letra A, no es una letra mayúscula
    jl      oskip
    cmp     byte [ebx+esi], 'Z' ; Si es mayor que la letra Z, no es una letra mayúscula
    jg      oskip
    or      byte [ebx+esi], 0x20 ; Convertir letra mayúscula a minúscula
oskip:
    inc     esi        
    jmp     oloop        
oexit:
    ret

len equ $-MEN          ; Definimos la longitud como una constante





