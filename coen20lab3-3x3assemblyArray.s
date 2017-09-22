        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// int *pWord2(void *arrayBaseAdr, int numberOfColumns, int currentRow, int currentCol)

        .global     pWord
pWord:
        MUL R1,R1,R2 //multiply sizeof row * # row
        ADD R1,R1,R3 //add number column
        ADD R0,R0,R1,LSL 2 //translate to addressing locations for 32 bits, leave return in R0
        BX LR //return


        .end

