INCLUDE Irvine32.inc

.data
offsets SWORD -5, 3, -2, 7
readings SWORD 4 DUP (?)
adj SDWORD 4 DUP (?)
R SDWORD ?
m1 BYTE "Enter reading: ",0
m2 BYTE "R signed decimal: ",0
m3 BYTE "R hex value: ",0
m4 BYTE "R hex value low word: ",0
m5 BYTE "R signed decimal low byte: ",0

.code
main PROC
mov ecx, 4
mov esi, 0

L1:
mov edx, OFFSET m1
call WriteString
call ReadInt
mov readings[esi * TYPE readings], ax
movsx eax, ax
movsx ebx, offsets[esi * TYPE offsets]
add eax, ebx
mov adj[esi * TYPE adj], eax
call Crlf
inc esi
loop L1

mov esi, adj[0]
neg esi
mov ebx, adj[4]
sub ebx, adj[8]
mov edx, adj[12]
mov R, edx
add R, esi
add R, ebx

mov edx, OFFSET m2
call WriteString
mov eax, R
call WriteInt
call Crlf

mov edx, OFFSET m3
call WriteString
mov eax, R
call WriteHex
call Crlf

mov edx, OFFSET m4
call WriteString
movzx eax, WORD PTR [R]
call WriteHex
call Crlf

mov edx, OFFSET m5
call WriteString
movsx eax, BYTE PTR [R]
call WriteInt
call Crlf

exit
main ENDP
END main
