%include "../include/io.mac"

extern printf
global check_row
global check_column
global check_box
; you can declare any helper variables in .data or .bss

section .data
    freq: times 10 db 0
section .text


; int check_row(char* sudoku, int row);
check_row:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int row 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor eax, eax
    mov ecx, 10
.loop_zero:                  ; Initializeaza array-ul de frecventa cu 0
    mov byte [freq + ecx], 0
    loop .loop_zero
	
	mov ebx, 9
    mov eax, edx            ; Calculeaza offset-ul catre inceputul randului
    mul ebx                 ; row * 9 
    add esi, eax           ; Indica inceputul randului dorit

    mov ecx, 9
.check:
	xor eax, eax
    mov al, byte [esi + ecx - 1]
    
    cmp al, 9
    jg .exit
    cmp al, 1
    jl .exit
    
    inc byte [freq + eax]  ; Incrementeaza frecventa pentru acest numar
    cmp byte [freq + eax], 1  ; Verifica daca numarul apare de mai multe ori
    jg .exit

    loop .check
    mov eax, 1             ; Randul este valid
    jmp end_check_row
    
.exit:
    mov eax, 2             ; Randul este invalid

    ;; Freestyle ends here
end_check_row:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY

; int check_column(char* sudoku, int column);
check_column:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int column 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor eax, eax
    mov ecx, 10
.loop_zero:                  ; Initializeaza array-ul de frecventa cu 0
    mov byte [freq + ecx], 0
    loop .loop_zero

    mov ecx, 9

.check:

    mov edi, ecx
    dec edi

    push esi          
    imul edi, 9
    add esi, edi               ; Muta la randul corect
    mov al, byte [esi + edx]
    pop esi
    
    cmp al, 9
    jg .exit
    cmp al, 1
    jl .exit
    
    inc byte [freq + eax]   ; Incrementeaza frecventa pentru acest numar
    cmp byte [freq + eax], 1 ; Verifica daca numarul apare de mai multe ori
    jg .exit

    loop .check
    mov eax, 1              ; Coloana este valida
    jmp end_check_row

.exit:
    mov eax, 2              ; Coloana este invalida

    ;; Freestyle ends here
end_check_column:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY


; int check_box(char* sudoku, int box);
check_box:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov     esi, [ebp + 8]  ; char* sudoku, pointer to 81-long char array
    mov     edx, [ebp + 12]  ; int box 
    ;; DO NOT MODIFY
   
    ;; Freestyle starts here
    xor eax, eax
    mov ecx, 10
.loop_zero:                  ; Initializeaza array-ul de frecventa cu 0
    mov byte [freq + ecx], 0
    loop .loop_zero

    mov eax, edx
    xor edx, edx
    mov ebx, 3
    div ebx                 ; eax = box / 3 (rand_caseta)
                            ; edx = box % 3 (coloana_caseta)

    imul edi, eax, 3        ; edi = rand_caseta * 3
    imul ebx, edx, 3        ; ebx = coloana_caseta * 3

    mov ecx, 3
    add edi, ecx            ; Incepe de la ultimul rand al casetei
.check:
    dec edi                 ; Muta un rand in sus

    push ecx
    push ebx

    mov ecx, 3
    add ebx, ecx            ; Incepe de la ultima coloana a casetei

.iterate_col
    dec ebx                 ; Muta o coloana la stanga

    imul eax, edi, 9        ; Calculeaza pozitia in array
    add eax, ebx            ; rand * 9 + coloana
    movzx edx, byte [esi + eax]
    
    cmp edx, 9
    jg .exit
    cmp edx, 1
    jl .exit
    
    inc byte [freq + edx]   ; Incrementeaza frecventa pentru acest numar
    cmp byte [freq + edx], 1 ; Verifica daca numarul apare de mai multe ori
    jg .exit
    
    loop .iterate_col

    pop ebx
    pop ecx
    loop .check

    mov eax, 1              ; Caseta este valida
    jmp end_check_row

.exit:
    mov eax, 2              ; Caseta este invalida
    add esp, 8

    ;; Freestyle ends here
end_check_box:
    ;; DO NOT MODIFY

    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    leave
    ret
    
    ;; DO NOT MODIFY
