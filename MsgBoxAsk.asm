INCLUDE Irvine32.inc

.data
    caption  BYTE "Corncernment", 0
    question BYTE "Are you qabz?", 0
    msgRes   BYTE "Returned EAX = ", 0

.code
main PROC
    ; Display message box with Yes/No buttons
    mov ebx, OFFSET caption
    mov edx, OFFSET question
    call MsgBoxAsk                ; Returns result in EAX (6 = Yes, 7 = No, 2 = Cancel)

    ; Print response value
    mov edx, OFFSET msgRes
    call WriteString
    call WriteDec                 ; Displays the value stored in EAX
    call Crlf

    exit
main ENDP

END main
