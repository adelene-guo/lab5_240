        .ORG $2000
SUM     .DW $0
ARRAY   .DW $FFFF
        .DW $FFFF
        .DW $FFFF
        .DW $0117
LENGTH  .EQU $0004 ; len(array) = 4

        .ORG $0010
        MV r1, r0 ; initialize sum
        MV r2, r0 ; index (r2 <- 0)
loop    SLTI r0, r2, LENGTH
        BRZ done ; if index==LENGTH, done
        LI r3, ARRAY ; base of array
        MV r4, r2
        SLLI r4, r4, $1 ; i*2
        LW r4, r4, ARRAY ; load r4 <- mem[base of array + i*2]
        ADD r1, r1, r4 ; sum <- sum + r4
        ADDI r2, r2, $1 ; i++
        BRA loop 
done    SW r0, r1, SUM ; mem[0 + SUM] = r1
        STOP