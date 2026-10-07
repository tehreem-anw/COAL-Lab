INCLUDE Irvine32.inc

.data
    wordStr    BYTE "ASSEMBLY", 0
    asciiCodes DWORD LENGTHOF wordStr - 1 DUP(?)
    
    lblSum     BYTE "ASCII Codes Sum: ", 0
    lblLen     BYTE "asciiCodes LENGTHOF=", 0
    lblSize    BYTE " SIZEOF=", 0
    lblStair   BYTE "--- Staircase Output ---", 0
    lblLower   BYTE "Lowercase Result: ", 0
    lblMsgRes  BYTE "MsgBoxAsk returned EAX = ", 0
    
    boxCap     BYTE "Confirmation", 0
    boxQ       BYTE "Do you want to exit?", 0
    
    sumVal     DWORD 0
    saveCount  DWORD ?

.code
main PROC
    call Clrscr

    ; ===================================================
    ; TASK 1: ASCII Extraction, Sum & Metadata
    ; ===================================================
    mov ecx, LENGTHOF wordStr - 1
    mov esi, 0

L_Ascii:
    movzx eax, wordStr[esi]
    mov asciiCodes[esi * TYPE asciiCodes], eax
    add sumVal, eax
    inc esi
    loop L_Ascii

    ; Display ASCII Sum
    mov edx, OFFSET lblSum
    call WriteString
    mov eax, sumVal
    call WriteDec
    call Crlf

    ; Display LENGTHOF and SIZEOF
    mov edx, OFFSET lblLen
    call WriteString
    mov eax, LENGTHOF asciiCodes
    call WriteDec
    mov edx, OFFSET lblSize
    call WriteString
    mov eax, SIZEOF asciiCodes
    call WriteDec
    call Crlf
    call Crlf

    ; ===================================================
    ; TASK 2: Staircase Pattern Output
    ; ===================================================
    mov edx, OFFSET lblStair
    call WriteString
    call Crlf

    mov ecx, LENGTHOF wordStr - 1

L_Stair:
    mov saveCount, ecx          ; Save outer loop counter
    
    ; Temporarily truncate string by inserting null byte at index ECX
    mov esi, ecx
    mov al, wordStr[esi]        ; Backup original char
    mov wordStr[esi], 0         ; Insert null terminator

    ; Print truncated string
    mov edx, OFFSET wordStr
    call WriteString
    call Crlf

    ; Restore original char
    mov wordStr[esi], al

    mov ecx, saveCount          ; Restore outer loop counter
    loop L_Stair

    call Crlf

    ; ===================================================
    ; TASK 3: Lowercase Conversion & UI Procedures
    ; ===================================================
    mov ecx, LENGTHOF wordStr - 1
    mov esi, 0

L_Lower:
    add wordStr[esi], 32        ; Convert UPPER to lower ('A' -> 'a')
    inc esi
    loop L_Lower

    ; Visual delay
    mov eax, 500
    call Delay

    ; Set text color to lightGreen on black background
    mov eax, lightGreen + (black * 16)
    call SetTextColor

    ; Print Lowercase String
    mov edx, OFFSET lblLower
    call WriteString
    mov edx, OFFSET wordStr
    call WriteString
    call Crlf
    call Crlf

    ; Reset text color to default
    mov eax, lightGray + (black * 16)
    call SetTextColor

    ; Show confirmation dialog
    mov ebx, OFFSET boxCap
    mov edx, OFFSET boxQ
    call MsgBoxAsk

    ; Display EAX return code (6 = Yes, 7 = No)
    mov edx, OFFSET lblMsgRes
    call WriteString
    call WriteDec
    call Crlf

    exit
main ENDP
END main
