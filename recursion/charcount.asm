.ORIG x3300

; initialize first space for return value
COUNT ADD R6, R6, #-1
; push return address
ADD R6, R6, #-1
STR R7, R6, #0
; push address of previous stack frame
ADD R6, R6, #-1
STR R5, R6, #0

; set new frame pointer
ADD R5, R6, #0

AND R3, R3, #0
; copy first letter address to R0
LDR R0, R5, #3
; copy first letter into R1
LDR R1, R0, #0
; test if character is null
BRz DONE

; add local variable to stack
ADD R6, R6, #-1
STR R3, R6, #0

; copy search letter into R2
LDR R2, R5, #4
; test if characters are equal
NOT R1, R1
ADD R1, R1, #1
ADD R4, R1, R2
BRnp DIFF

ADD R3, R3, #1
STR R3, R6, #0

; generate new stack frame
DIFF ADD R6, R6, #-1
STR R2, R6, #0
ADD R0, R0, #1
ADD R6, R6, #-1
STR R0, R6, #0
JSR COUNT

STR R3, R6, #0
LDR R2, R5, #-1
ADD R3, R3, R2
ADD R6, R6, #4

DONE STR R3, R5, #2
LDR R7, R5, #1
LDR R5, R5, #0
ADD R6, R6, #2
RET

.END