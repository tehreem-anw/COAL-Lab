INCLUDE Irvine32.inc

.data
    msg1 BYTE "This text is Red on Blue background!", 0
    msg2 BYTE "This text is Light Green on Black background!", 0
    msg3 BYTE "Back to default console colors.", 0

.code
main PROC
    call Clrscr

    ; 1. Set text to Yellow on Blue background
    mov eax, red + (blue * 16)       ; yellow = 14, blue = 1 -> EAX = 14 + 16 = 30 (1Eh)
    call SetTextColor
    mov edx, OFFSET msg1
    call WriteString
    call Crlf

    ; 2. Change color to Light Green on Black background
    mov eax, lightGreen + (black * 16)  ; lightGreen = 10, black = 0 -> EAX = 10
    call SetTextColor
    mov edx, OFFSET msg2
    call WriteString
    call Crlf

    ; 3. Restore default colors (Light Gray on Black)
    mov eax, lightGray + (black * 16)   ; lightGray = 7, black = 0 -> EAX = 7
    call SetTextColor
    mov edx, OFFSET msg3
    call WriteString
    call Crlf

    exit
main ENDP
END main
