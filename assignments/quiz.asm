        .ORIG x3000         ; start program at x3000

        AND R2, R2, #0      ; clear R2 and set up R3 to convert ASCII values
        LD R3, CONVERT

        LD R0, Q1           ; load first question address into R0
        TRAP x22            ; print first question
        LD R1, Q1Answ       ; load first question point values into R1
        JSR GET             ; call GET to get user answer
        JSR CALC            ; call CALC to get point value from answer

        LD R0, Q2           ; load second question address into R0
        TRAP x22            ; print second question
        LD R1, Q2Answ       ; load second question point values into R1
        JSR GET             ; call GET to get user answer
        JSR CALC            ; call CALC to get point value from answer

        LD R0, Q3           ; load third question address into R0
        TRAP x22            ; print third question
        LD R1, Q3Answ       ; load third question point values into R1
        JSR GET             ; call GET to get user answer
        JSR CALC            ; call CALC to get point value from answer

        LD R0, Q4           ; load fourth question address into R0
        TRAP x22            ; print fourth question
        LD R1, Q4Answ       ; load fourth question point values into R1
        JSR GET             ; call GET to get user answer
        JSR CALC            ; call CALC to get point value from answer

        JSR PRINT           ; call PRINT to print result based on score
        HALT                ; halt

GET     ST R7, SAVE_R7      ; save value of R7 for RET
        LEA R0, ANSW        ; load answer prompt address into R0
        TRAP x22            ; print answer prompt
        TRAP x20            ; get user answer
        TRAP x21
        ADD R0, R0, R3      ; convert answer ASCII to decimal
        LD R7, SAVE_R7      ; load value of R7 for RET
        RET                 ; return

CALC    ADD R0, R0, #-1     ; subtract one from user answer
        ADD R1, R1, R0      ; add decremented answer to base address to get the correspond point value address
        LDR R0, R1, #0      ; load point value into R0
        ADD R2, R2, R0      ; add points to R2 (total score)
        RET                 ; return

PRINT   ST R7, SAVE_R7      ; save value of R7 for RET
        LD R1, R4LB         ; load result 4 lower bound into R1 for score checking
        ADD R1, R2, R1      ; add lower bound to total score
        BRn THIRD           ; if result is negative, jump to result 3 check
        LD R0, Result4      ; otherwise, load result 4 address into R0
        BR DONE             ; jump to result printing

THIRD   LD R1, R3LB         ; load result 3 lower bound into R1 for score checking
        ADD R1, R2, R1      ; add lower bound to total score
        BRn SECOND          ; if result is negative, jump to result 2 check
        LD R0, Result3      ; otherwise, load result 3 address into R0
        BR DONE             ; jump to result printing

SECOND  LD R1, R2LB         ; load result 2 lower bound into R1 for score checking
        ADD R1, R2, R1      ; add lower bound to total score
        BRn FIRST           ; if result is negative, jump to result 1
        LD R0, Result2      ; otherwise, load result 2 address into R0
        BR DONE             ; jump to result printing

FIRST   LD R0, Result1      ; load result 1 address into R0
DONE    TRAP x22            ; print result
        LD R7, SAVE_R7      ; load value of R7 for RET
        RET                 ; return

SAVE_R7 .BLKW #1            ; data storage
CONVERT .FILL #-48
R2LB    .FILL #-11
R3LB    .FILL #-21
R4LB    .FILL #-31
Q1      .FILL x3300
Q1Answ  .FILL x3373
Q2      .FILL x3377
Q2Answ  .FILL x343F
Q3      .FILL x3443
Q3Answ  .FILL x34DE
Q4      .FILL x34E2
Q4Answ  .FILL x35B6
Result1 .FILL x35BA
Result2 .FILL x35F9
Result3 .FILL x3639
Result4 .FILL x3662
ANSW    .STRINGZ "Answer: "
        
        .END                ; end program