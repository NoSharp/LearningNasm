section .data
    ; Variables.

    msg db "Howdy.", 0xa ; Define our variable and assign it to a location.
    msg_len  equ $-msg ; set the length of the output.

section .text

    extern printf
    global _start: ; needed for NASM.
    
_start:
               
        call print
        mov ebx, 0
        mov eax, 1
        int 80h

print:
    mov ecx, msg
    mov edx, msg_len
    mov ebx, 1
    mov eax, 4
    int 80h
    ret
