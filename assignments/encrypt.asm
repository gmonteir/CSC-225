; start at x3000 and clear registers
.ORIG x3000
AND R1, R1, #0
AND R2, R2, #0

; used to convert ASCII key to decimal
ADD R2, R2, #-10

; display first message and get encryption key
LEA R0, KEY
TRAP x22
TRAP x20
TRAP x21
LD R4, VAR
ADD R0, R0, R4
ADD R1, R0, R1
TRAP x20
TRAP x21

; display second message
LEA R0, IM
LEA R3, MSG
TRAP x22

; get one character of input message until Enter is pressed
INPUT TRAP x20
      TRAP x21
      ADD R4, R0, R2
      BRz ENTER

; XOR R0 with #1 to flip last bit, then add key
AND R5, R5, #0
ADD R5, R5, #1
AND R4, R0, R5
NOT R4, R4
AND R0, R0, R4
NOT R0, R0
AND R5, R4, R5
NOT R5, R5
AND R4, R0, R5
NOT R4, R4
ADD R4, R1, R4

; store encrypted character in blocked memory and repeat
STR R4, R3, #0
ADD R3, R3, #1
BR INPUT

; display encrypted message
ENTER LEA R0, EM
      TRAP x22
      LEA R0, MSG
      TRAP x22

; clear blocked memory for next run
      LD R0, COUNT
      AND R1, R1, #0
      LEA R2, MSG
CLEAR STR R1, R2, #0
      ADD R2, R2, #1
      ADD R0, R0, #-1
      BRp CLEAR
      ADD R0, R0, #10
      TRAP x21
      TRAP x25

; variables
VAR   .FILL #-48
COUNT .FILL #21
KEY   .STRINGZ "Encryption Key (1-9): "
IM    .STRINGZ "Input Message: "
EM    .STRINGZ "Encrypted Message: "
MSG   .BLKW #21
      .END