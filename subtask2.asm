%include "../include/io.mac"

; declare your structs here

section .bss
    temp_event: resb 36

section .text
    global sort_events
    extern printf

sort_events:
    ;; DO NOT MODIFY
    enter 0, 0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    
    dec ecx 
.first_loop:

    mov eax, ecx
    imul eax, 36
    add eax, ebx
    mov esi, eax ; ebx + (ecx) * 36

    push ecx ; save for next i step ;
.second_loop:

    mov eax, ecx
    dec eax
    imul eax, 36
    add eax, ebx
    mov edi, eax
	
    movzx eax, byte [edi + 31] ; cmp valid flags
    cmp byte [esi + 31], al
    jl .continue
    jg .swap
	
    mov ax, word [edi + 34] ; cmp year
    cmp word [esi + 34], ax
    jl .swap
    jg .continue
	
    mov al, byte [edi + 33] ; cmp month
    cmp byte [esi + 33], al
    jl .swap
    jg .continue

    mov al, byte [edi + 32] ; cmp day
    cmp byte [esi + 32], al
    jl .swap
    jg .continue

    ;jmp .cmp_name
    ; TO DO compare names

.continue:
    loop .second_loop

    pop ecx
    loop .first_loop
    ;; Your code ends here

     ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

.swap:
    ; ------------------------
    ; pas 1: copiem A în buffer
    ; ------------------------
    push ebx
    push ecx
    xor eax, eax
    mov ecx, 36
    mov ebx, temp_event

    .copy_a_to_temp:
        mov al, [esi]
        mov [ebx], al
        inc esi
        inc ebx
        loop .copy_a_to_temp

    ; readucem ESI și EBX
    sub esi, 36
    sub ebx, 36

    ; ------------------------
    ; pas 2: copiem B în A
    ; ------------------------
    mov ecx, 36

    .copy_b_to_a:
        mov al, [edi]
        mov [esi], al
        inc edi
        inc esi
        loop .copy_b_to_a

    sub esi, 36
    sub edi, 36

    ; ------------------------
    ; pas 3: copiem temp în B
    ; ------------------------
    mov ecx, 36
.copy_temp_to_b:
    mov al, [ebx]
    mov [edi], al
    inc ebx
    inc edi
    loop .copy_temp_to_b

    sub esi, 36
    pop ecx
    pop ebx ; refa contextul inainte de swap
    jmp .continue
    

   
