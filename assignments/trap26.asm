    .ORIG x3300

    LD R4, SAVE_PC ; save UP1 PC into x32FF
    STR R7, R4, #0
    LD R4, ENABLE  ; set enable interrupt bit
    STI R4, KBSR
    LD R4, UP2
    JMP R4         ; jump to UP2

UP2     .FILL x3400
SAVE_PC .FILL x32FF
ENABLE  .FILL x4000
KBSR    .FILL xFE00

    .END