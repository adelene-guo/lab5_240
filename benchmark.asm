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
LENGTH  .EQU $0610 ; len(array) = 0
.ORG $0600
SUM     .DW $0
        .DW $0

        .ORG $0000
        BRA $0010 ; since FPGA starts at $0000

        .ORG $0010
        MV r1, r0 ; (5 cycles)
        MV r2, r0; (5 cycles)
        MV r3, r0 ; (5 cycles)
        LW r6, r0, LENGTH ; load length from $0610
loop    SLTI r0, r3, r6; (8 cycles)
        BRZ done ; (7 if taken, 6 if not taken)
        MV r5, r3 ; (5 cycles)
        SLLI r5, r5, $2 ; (7 cycles)
        ADDI r4, r5, $2 ; (7 cycles)
        LW r5, r5, ARRAY ; (9 cycles)
        LW r4, r4, ARRAY ; (9 cycles)
        .DW $644C ; $0110 010 001 001 100
        ADDI r3, r3, $1 ; (7 cycles)
        BRA loop ; (7 cycles)
done    SW r0, r2, SUM ; (9 cycles)
        LI r5, SUM ; (7 cycles)
        ADDI r5, r5, $2 ; (7 cycles)
        SW r5, r1, $0 ; (9 cycles)
        STOP ; (5 cycles)