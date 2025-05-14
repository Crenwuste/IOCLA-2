%include "../include/io.mac"

extern printf
global base64

section .data
	alphabet db 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
	fmt db "%d", 10, 0

section .text

base64:
	;; DO NOT MODIFY

	push ebp
	mov ebp, esp
	pusha

	mov esi, [ebp + 8] ; source array
	mov ebx, [ebp + 12] ; n
	mov edi, [ebp + 16] ; dest array
	mov edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY


	; -- Your code starts here --
	; calcul lungime output si numar iteratii
	mov  eax, ebx
	mov  ecx, 3
	xor  edx, edx
	div  ecx
	mov  ecx, 4
	mul  ecx
	push eax

	mov  eax, ebx
	mov  ecx, 3
	xor  edx, edx
	div  ecx
	mov  ecx, eax

.encode_loop:
	; procesarea primului caracter
	movzx eax, byte [esi]
	shr   eax, 2
	mov   al, [alphabet + eax]
	mov   [edi], al
	inc   edi

	; procesare al doilea caracter
	movzx eax, byte [esi]
	and   eax, 0x03               ; obtine ultimii 2 biti din primul octet
	shl   eax, 4
	movzx edx, byte [esi + 1]     
	shr   edx, 4                  ; retine doar primitii 4 biti din al doilea octet 
	or    eax, edx                ; concateneaza cele 2 segmente anterioare
	mov   al, [alphabet + eax]
	mov   [edi], al
	inc   edi

	; procesare al treilea caracter
	movzx eax, byte [esi + 1]
	and   eax, 0x0F               ; obtine ultimii 4 biti din al doilea octet
	shl   eax, 2
	movzx edx, byte [esi + 2]
	shr   edx, 6                  ; retine doar primii 2 biti din al 3-lea octet
	or    eax, edx                ; concateneaza cele 2 segmente anterioare
	mov   al, [alphabet + eax]
	mov   [edi], al
	inc   edi

	; procesare al patrulea caracter
	movzx eax, byte [esi + 2]
	and   eax, 0x3F
	mov   al, [alphabet + eax]
	mov   [edi], al
	inc   edi

  ; sari la urmatoarul grupul de 3 octeti
	add   esi, 3
	dec   ecx
	jnz   .encode_loop

	; salvare lungime finala
	pop   eax
	mov   edx, [ebp + 20]
	mov   [edx], eax
	; -- Your code ends here --


	;; DO NOT MODIFY

	popa
	leave
	ret

	;; DO NOT MODIFY