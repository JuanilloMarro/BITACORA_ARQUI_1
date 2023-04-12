; Autor: Juan Diego Marroquín Escobar - 1689821
; Proyecto 2
; Fecha de creación: 11/04/23 

%include 'stdio32.asm'

SECTION .data
	msgError db 'ERROR. Valores fuera del rango aceptado', 0h
	msgErrorSintaxis db 'ERROR. verifique la expresion', 0h

SECTION .bss
	cadena resb 100

SECTION .text
	global _start

_start:
	mov ebp, esp
	mov ecx, 0
	mov ebx, 2

ciclo:
	mov eax, [ebp + ebx * 4]
	cmp byte [eax + 1], 0
	jnz convertirnumero


	cmp byte[eax], 43
	je sumar

	cmp byte[eax], 45
	je restar

	cmp byte[eax], 47
	je dividir

	cmp byte[eax], 120
	je multiplicar

convertirnumero:
	mov edi, 0
	call asciidecimal
	cmp edi, 1
	je error2
	mov [cadena + ecx * 4], eax
	inc ecx
	jmp finCiclo

finCiclo:
	inc ebx
	cmp ebx, [ebp]
	jle ciclo
	jmp mostrarResultado

mostrarResultado:
	cmp ecx, 1
	jne errorsintaxis

	dec ecx
	mov eax, [cadena + ecx * 4]
	call printIntln
	call exit

bajarNumDePila:
	cmp ecx, 2
	jl errorsintaxis
	dec ecx
	mov esi, [cadena + ecx * 4]
	dec ecx
	mov eax, [cadena + ecx * 4]
	ret

apilarRespuesta:
	mov [cadena + ecx * 4], eax
	inc ecx
	jmp finCiclo

sumar:
	call bajarNumDePila
	add eax, esi
	call apilarRespuesta

restar:
	call bajarNumDePila
	sub eax, esi
	call apilarRespuesta

multiplicar:
	call bajarNumDePila
	imul esi
	call apilarRespuesta

dividir:
	call bajarNumDePila
	idiv esi
	call apilarRespuesta

error2:
	mov eax, msgError
	call printStrln
	call exit

errorsintaxis:
	mov eax, msgErrorSintaxis
	call printStrln
	call exit

