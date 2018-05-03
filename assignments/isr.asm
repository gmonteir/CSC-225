    .ORIG x3500

    AND R1, R1, #0
    LDI R0, KBDR   ; get char from KBDR
    STI R1, KBSRL  ; clear KBSR
    LD R1, UP1     ; write UP1 PC over UP2 PC on stack
    LDR R1, R1, #0
    STR R1, R6, #0
    RTI            ; return from interrupt

UP1   .FILL x32FF
KBDR  .FILL xFE02
KBSRL .FILL xFE00
    
    .END