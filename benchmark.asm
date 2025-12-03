LENGTH  .EQU $0610 ; ADDRESS OF LENGTH
        .ORG $0600
SUM     .DW $0
        .DW $0
ARRAY   .DW $0000
        .DW $0001


        .DW $0000
        .DW $0001

        .DW $0000
        .DW $0001
        
        .ORG $0000
        BRA $0010 ; since FPGA starts at $0000

        .ORG $0010  
big     MV r1, r0 ; clear r1
        MV r2, r0; clear r2
        MV r3, r0 ; index init i=0
        LW r6, r0, LENGTH ; load length from $0610
loop    SLT r0, r3, r6
        BRZ done ; if r3==r6 done
        MV r5, r3
        SLLI r5, r5, $2 ; r5 = i*4
        ADDI r4, r5, $2 ; r4 = i*4 + 2
        LW r5, r5, ARRAY ; r5 <- M[ARRAY + i*4] first 16b
        LW r4, r4, ARRAY ; r4 <- M[ARRAY + i*4 +2] next 16b
        .DW $644C ; ADD32 r1 r1 r4 $0110 010 001 001 100
        ADDI r3, r3, $1 ; i+=1
        BRA loop ; go to loop
done    SW r0, r2, SUM ; store first 16b
        LI r5, SUM ;
        ADDI r5, r5, $2 ; r5 <- SUM + 2
        SW r5, r1, $0 ; store next 16b
        BRA big ; big loop
        STOP ; stop