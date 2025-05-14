%include "../include/io.mac"

extern printf
global remove_numbers

section .data
	fmt db "%d", 10, 0

section .text

; function signature: 
; void remove_numbers(int *a, int n, int *target, int *ptr_len);

remove_numbers:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     esi, [ebp + 8] ; source array
	mov     ebx, [ebp + 12] ; n
	mov     edi, [ebp + 16] ; dest array
	mov     edx, [ebp + 20] ; pointer to dest length

	;; DO NOT MODIFY
   

	;; Your code starts here
	xor ecx, ecx
	xor ebx, ebx

start_loop:
	mov eax, [esi + ebx*4] ; eax devine elementul curent din vectorul sursa

	test eax, 1 ; Verificam daca numarul este impar, daca da sarim peste
	jnz skip

	push ebx
	mov ebx, eax
	dec ebx
	test eax, ebx ; Verificam daca numarul este putere a lui 2 cu formula n&(n-1)
	pop ebx
	jz skip       ; Daca este putere a lui 2, sarim peste

	mov [edi + ecx*4], eax  ; Copiem numarul in vectorul tinta
	inc ecx                 ; Incrementam contorul vectorului tinta

skip:
	inc ebx                ; Trecem la urmatorul element din vectorul sursa
	cmp ebx, [ebp + 12]
	jl start_loop
	mov [edx], ecx         ; Salvam lungimea noului vector

	;; Your code ends here
	

	;; DO NOT MODIFY

	popa
	leave
	ret
	
	;; DO NOT MODIFY
