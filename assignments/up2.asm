     .ORIG x3400

     AND R5, R5, #0 ; add one to R5 until negative
ASTK ADD R5, R5, #1
     BRzp ASTK
     LD R0, CHAR
     TRAP x21       ; print asterisk
     AND R5, R5, #0 ; clear R5
     BR ASTK        ; repeat

CHAR .FILL x2A

     .END