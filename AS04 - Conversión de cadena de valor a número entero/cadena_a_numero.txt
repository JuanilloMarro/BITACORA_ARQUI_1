; Autor: Juan Diego Marroquín Escobar - 1689821
; Ejercicio: Conversor de cadena de valor a número entero
; Fecha de creación: 23/03/23 

section .data

    str db '1234'   ; Cadena de valor a convertir
    len equ $-str   
    result dd 0     

section .text
    global _start

    ; Función para convertir la cadena a un número entero
    
    cadena_entero:
        push esi        
        push ecx
        push edx

        mov esi, eax    
        xor eax, eax    
        mov ecx, [esi]  
        cmp ecx, '-'    ; Comprobamos si la cadena proporcionada inicia con un posible signo negativo
        jne .check_digit 

        inc esi       
        mov ecx, [esi]  

    .check_digit:
        cmp ecx, '0'    ; Comprueba si el dígito es un número
        jl .done      
        cmp ecx, '9'
        jg .done
        sub ecx, '0'    ; Convierte el dígito a su valor numérico
        imul eax, 10    
        add eax, ecx    
        inc esi         ; Avanza al siguiente dígito de la cadena
        mov ecx, [esi]  
        jmp .check_digit

    .done:
        pop edx         
        pop ecx
        pop esi
        ret             

    _start:
        ; Llama a la función str_to_int para convertir la cadena en valor a un número entero
        lea eax, [str] 
        call cadena_entero

        
        mov [result], eax

        
        mov eax, 1     
        xor ebx, ebx    
        int 80h         