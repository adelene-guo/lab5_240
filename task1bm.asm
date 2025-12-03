        .ORG $2000
SUM     .DW $0
        .DW $0
ARRAY   .DW $FFFF
        .DW $FFFE


        .DW $FFFF
        .DW $FFFE


        .DW $FFFF
        .DW $FFFF

        .DW $0000
        .DW $0001

        .DW $ABCD
        .DW $1234

        .DW $ABCD
        .DW $1234

        .DW $CAFE
        .DW $F00D

        .DW $BEEF
        .DW $BEEF
LENGTH  .EQU $0008 ; len(array) = 8




        .ORG $0010
        MV r1, r0 ; (5 cycles)
        MV r2, r0; (5 cycles)
        MV r3, r0 ; (5 cycles)
loop    SLTI r0, r3, LENGTH; (8 cycles)
        BRZ done ; (7 if taken, 6 if not taken)
        MV r4, r3 ; (5 cycles)
        SLLI r4, r4, $2 ; (7 cycles)
        ADDI r5, r4, $2 ; (7 cycles)
        LW r4, r4, ARRAY ; (9 cycles)
        LW r5, r5, ARRAY ; (9 cycles)
        ADD r2, r2, r5 ; (5 cycles)
        BRV OF ; (7 if taken, 6 if not taken)
        BRA noOF ; (7 if taken, 6 if not taken)
OF      ADDI r1, r1, $1 ; (7 cycles)
noOF    ADD r1, r1, r4 ; (5 cycles)
        ADDI r3, r3, $1 ; (7 cycles)
        BRA loop ; (7 cycles)
done    SW r0, r2, SUM ; (9 cycles)
        LI r5, SUM ; (7 cycles)
        ADDI r5, r5, $2 ; (7 cycles)
        SW r5, r1, $0 ; (9 cycles)
        STOP ; (5 cycles)