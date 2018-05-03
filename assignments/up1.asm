     .ORIG x3000

     LD R6, TRAP_26  ; initialize trap vector
     LD R0, TRAPL
     STR R6, R0, #0
     LD R6, ISR      ; initialize interrupt vector
     LD R0, ISRL
     STR R6, R0, #0
     LD R6, STACKP   ; initialize stack pointer

LOOP TRAP x26        ; get char
     TRAP x21        ; print char to screen
     TRAP x26        ; get char
     TRAP x21        ; print char to screen
     TRAP x26        ; get char
     TRAP x21        ; print char to screen
     TRAP x26        ; get char
     TRAP x21        ; print char to screen
     TRAP x26        ; get char
     TRAP x21        ; print char to screen
     LEA R0, END_MSG
     PUTS
     BR LOOP

STACKP  .FILL x3000
TRAP_26 .FILL x3300
TRAPL   .FILL x0026
ISR     .FILL x3500
ISRL    .FILL x0180
END_MSG .STRINGZ "\nSuccess! Running again...\n"

    .END