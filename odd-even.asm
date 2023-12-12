.model small
.stack 100h

.data
    msg_odd db 'Odd$'
    msg_even db 'Even$'
    msg_positive db 'Positive$'
    msg_negative db 'Negative$'
    msg_enter db 13, 10, 'Enter a number: $'
    num_input db 6, ?

.code
start:
    mov ax, @data
    mov ds, ax

    mov ah, 06h
    mov al, 0
    mov bh, 07h
    mov cx, 0
    mov dx, 184FH
    int 10h

    mov ah, 09h
    lea dx, msg_enter
    int 21h

    mov ah, 0Ah
    lea dx, num_input
    int 21h

    mov si, offset num_input + 2
    xor ax, ax
    mov cx, 10

convert_loop:
    mov dl, byte ptr [si]
    cmp dl, 0Dh
    je check_odd_even
    sub dl, '0'
    mul cx
    add ax, dx
    inc si
    jmp convert_loop

check_odd_even:
    test ax, 1
    jz even_number
    mov ah, 09h
    lea dx, msg_odd
    int 21h
    jmp check_positive_negative

even_number:
    mov ah, 09h
    lea dx, msg_even
    int 21h
    jmp check_positive_negative

check_positive_negative:
    test ax, ax
    jz zero_number
    jns positive_number
    mov ah, 09h
    lea dx, msg_negative
    int 21h
    jmp end_program

positive_number:
    mov ah, 09h
    lea dx, msg_positive
    int 21h
    jmp end_program

zero_number:
    jmp end_program

end_program:
    mov ah, 4Ch
    int 21h

end start
