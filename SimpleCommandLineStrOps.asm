section	.data
    msg_whole db "show (W)hole number." ,0x21 ,0xa
    msg_quit db "(Q)uit", 0xa
    msg_getinpt db "Enter choice", 0xa
    msg_1_len equ $ - msg_whole
    msg_5_len equ $ - msg_quit
    msg_6_len equ $ - msg_getinpt



section .bss
    num resb 5
    cmd resb 1
    
    len resb 100

    tensPos resb 5
    onesPos resb 5
section	.text
   global _start     ;must be declared for linker (ld)


_start:	            ;tells linker entry point
    mov ecx, msg_getinpt
    mov edx, msg_6_len
    call print
    
    call input_num
    call print_input_num 
    
    call ask_loop

    call ext


ask_main:

    mov	ecx,msg_whole     ;message length
    mov	edx,msg_1_len
    call print       ;Call method, add to stack.
    ret

ask_loop:
    ;Print the main "help" menu.
    call ask_main
    
    ; READ and print cmd
    call input_cmd
    ; DEBUG call print_input_cmd

    ; Complicated If statement bit.
    ; ARE WE EQUAL TO W?
    mov ah, "W" ; temporary Holder

    cmp [cmd], ah ; Ah holds the letter "W", [cmd] , [ var ]
    je print_w ; Does it equal? print it!

    xor ah, ah
    ; ARE WE EQUAL TO O
    mov ah, "Q" ; temporary Holder

    cmp [cmd], ah ; Ah holds the letter "W", [cmd] , [ var ]
    je ext

    call ask_loop    
    
    ret

print_w:
       
    mov eax, num
    
    mov edx, 5
    call print

ext:
    mov eax, 1 ; out
    mov ebx, 0
    int 0x80 ; call kernel
    ret


print:  
    mov ebx, 1 ; File descriptor
    mov eax, 4 ; make sys_write calls
    int	0x80 ; call kernel
    ret ; return

print_input_num:
    mov ecx, num
    mov edx, 5
    mov eax, 4
    mov ebx, 1
    
    int 80h  
    ret

print_input_cmd:
    mov ecx, cmd
    mov edx, 5
    mov eax, 4
    mov ebx, 1
    
    int 80h  
    ret

input_num:
    mov eax, 3
    mov ebx, 2
    mov ecx, num  
    mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information

    
    int 80h
    ret

input_cmd:
    mov eax, 3
    mov ebx, 2
    mov ecx, cmd
    mov edx, 5          ;5 bytes (numeric, 1 for sign) of that information
    int 80h
    ret
