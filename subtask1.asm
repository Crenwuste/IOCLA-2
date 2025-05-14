%include "../include/io.mac"

; declare your structs here

section .data
    event_size: dd 36
    days_per_month: dd 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
section .text
    global check_events
    extern printf

check_events:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov ebx, [ebp + 8]      ; events
    mov ecx, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    xor edi, edi

.loop_start:
    cmp edi, ecx            ; Verificam daca am parcurs toate evenimentele
    jge .done

    mov eax, edi ; 
    imul eax, dword [event_size]
    add eax, ebx
    mov esi, eax ; event[i] 

    movzx edx, word [esi + 34]  ; Citim anul si verificam daca este valid
    cmp edx, 1990
    jl .set_invalid
    cmp edx, 2030
    jg .set_invalid

    movzx edx, byte [esi + 33]  ; Citim luna si verificam daca este valida
    cmp edx, 1
    jl .set_invalid
    cmp edx, 12
    jg .set_invalid

    movzx eax, byte [esi + 32]  ; Citim ziua si verificam daca este valida
    cmp eax, 1
    jl .set_invalid
    dec edx
    cmp eax, dword[days_per_month + edx * 4]  ; Verificam daca ziua este valida pentru luna respectiva
    jg .set_invalid

    mov byte [esi + 31], 1  ; Setam valid la 1 daca toate verificarile au trecut
    jmp .next

.set_invalid:
    mov byte [esi + 31], 0  ; Setam valid la 0 daca vreo verificare a esuat

.next:
    inc edi                 ; Trecem la urmatorul eveniment
    jmp .loop_start

.done:
    ;; Your code ends here

    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY