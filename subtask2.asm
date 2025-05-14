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
    
.first_loop:               ; Bucla exterioara (bubble sort)

    mov edx, 0             ; Initializam contorul pentru bucla interioara
.second_loop:              ; Bucla interioara

    cmp edx, ecx
    jz .exit_loop

    mov eax, edx
    imul eax, 36
    add eax, ebx
    mov esi, eax           ; esi = &events[j]

    mov eax, edx
    inc eax
    imul eax, 36
    add eax, ebx
    mov edi, eax           ; edi = &events[j+1]
	
    movzx eax, byte [edi + 31]  ; Comparam flag-urile de validitate
    cmp byte [esi + 31], al
    jg .continue
    jl .swap
	
    mov ax, word [edi + 34]     ; Comparam anii
    cmp word [esi + 34], ax
    jg .swap
    jl .continue
	
    mov al, byte [edi + 33]     ; Comparam lunile
    cmp byte [esi + 33], al
    jg .swap
    jl .continue

    mov al, byte [edi + 32]     ; Comparam zilele
    cmp byte [esi + 32], al
    jg .swap
    jl .continue

    jmp .compare_name           ; Comparam numele

.continue:
    inc edx                     ; Trecem la urmatorul element
    jmp .second_loop

.exit_loop:
    loop .first_loop            ; Repetam bucla exterioara
    jmp .done

.compare_name:                  ; Salvam pe stiva registrii
    push ebx                    ; pentru a putea reface contextul
    push ecx
    push esi
    push edi
    mov ecx, 31
.compare_loop:
    mov al, byte [esi]    
    mov bl, byte [edi]
    
    ; Verifica daca a ajuns la terminatorul null (sfarsitul sirului)
    cmp al, 0             
    je .check_end
    cmp bl, 0
    je .check_end

    cmp al, bl
    jg .call_swap            ; swap daca al > bl
    jl .call_continue        ; continua daca al < bl

    inc esi
    inc edi
    loop .compare_loop
    jmp .call_continue

.check_end:                 ; Gestioneaza cazurile in care                       
    cmp al, 0               ; un sir se termina primul 
    jne .call_swap
    cmp bl, 0
    jne .call_continue

.call_continue              ; Refa contextul
    pop edi
    pop esi
    pop ecx
    pop ebx
    jmp .continue

.call_swap:                 ; Refa contextul
    pop edi
    pop esi
    pop ecx
    pop ebx
    
.swap:
    push ebx
    push ecx
    xor eax, eax
    mov ecx, 36
    mov ebx, temp_event

.copy_a_to_temp:          ; Copiem primul eveniment in buffer
    mov al, [esi]
    mov [ebx], al
    inc esi
    inc ebx
    loop .copy_a_to_temp

    sub esi, 36               ; Restauram pointerii
    sub ebx, 36


    mov ecx, 36

.copy_b_to_a:             ; Copiem al doilea eveniment in locul primului
    mov al, [edi]
    mov [esi], al
    inc edi
    inc esi
    loop .copy_b_to_a

    sub esi, 36
    sub edi, 36


    mov ecx, 36
.copy_temp_to_b:              ; Copiem din buffer in locul celui de-al doilea eveniment
    mov al, [ebx]
    mov [edi], al
    inc ebx
    inc edi
    loop .copy_temp_to_b

    sub esi, 36
    pop ecx
    pop ebx
    jmp .continue

.done:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY