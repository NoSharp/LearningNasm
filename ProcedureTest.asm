
section .data
    ; Variables.

    msg db "Howdy.", 0xa ; "0xa" == New line. Define our variable
    msg_len  equ $-msg ; set the length of the output.

section .text

    extern printf
    global _start: ; needed for NASM.
    
_start:
               
        call print
        ; EXIT OUR CODE ;)
        call exit

exit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret

print:
    mov ecx, msg ; message to write.
    mov edx, msg_len ; message length.
    mov ebx, 1 ; print 
    mov eax, 4 ; Sys_write call.
    int 80h
    ret ; return
