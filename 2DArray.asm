INCLUDE Irvine32.inc

.data
    ROWS = 2
    COLS = 3
    
    ; 2x3 WORD matrix
    matrix WORD 10, 20, 30    ; Row 0
           WORD 40, 50, 60    ; Row 1
           
    rowSize = COLS * TYPE matrix    ; Bytes per row: 3 * 2 = 6 bytes
    
    lblDirect BYTE "Direct Access matrix[1][2]: ", 0
    lblSum    BYTE "Total Matrix Sum: ", 0
    
    sumVal    DWORD 0
    saveECX   DWORD ?

.code
main PROC
    call Clrscr

    ; ===================================================
    ; 1. Direct Access to matrix[1][2] (Value: 60)
    ; Offset = (1 * 6) + (2 * 2) = 10 bytes
    ; ===================================================
    mov edx, OFFSET lblDirect
    call WriteString
    movzx eax, matrix[1 * rowSize + 2 * TYPE matrix]
    call WriteDec
    call Crlf
    call Crlf

    ; ===================================================
    ; 2. Nested Loop Traversal (Sum All Elements)
    ; ===================================================
    mov ebx, 0              ; EBX = Row byte offset (0, 6, 12...)
    mov ecx, ROWS           ; Outer loop counter

OuterLoop:
    mov saveECX, ecx        ; Preserve outer ECX counter
    mov esi, 0              ; ESI = Column element index (0, 1, 2)
    mov ecx, COLS           ; Inner loop counter

InnerLoop:
    ; Access element using [Base Row Offset + Column Scaled Index]
    movzx eax, matrix[ebx + esi * TYPE matrix]
    add sumVal, eax         ; Add value to running sum
    inc esi                 ; Advance column index
    loop InnerLoop

    add ebx, rowSize        ; Move EBX to start of next row (add 6 bytes)
    mov ecx, saveECX        ; Restore outer ECX counter
    loop OuterLoop

    ; Print Total Sum
    mov edx, OFFSET lblSum
    call WriteString
    mov eax, sumVal
    call WriteDec
    call Crlf

    exit
main ENDP
END main
