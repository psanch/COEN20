        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

//extern uint32_t BFI(uint32_t word, uint32_t value, uint32_t lsb, uint32_t width)

        .global     BFI
BFI:   PUSH {R4,R5}

        LDR R4,=1

        LSL R4,R4,R3 //shift a one into len bit position
        SUB R4,R4,1 //fill all 0's size len at bits 0 to len-1

        MOV R5,R4 //preserve R4, we will use for y
        LSL R5,R5,R2 //move string of 1s up to lsb size len - 1
        MVN R5,R5 //all 1s are 0s, all 0s are 1s
        AND R0,R0,R5 //all bits of x at lsb to len-1 are now 0s, else preserved as x

        AND R4,R1,R4 //size - 1 bits of y are preserved starting at bit 0
        LSL R4,R4,R2 //move these bits of y up to lsb

        ORR R0,R0,R4 //allow the bits of y to flow through into x, perserve x's other bits

        POP {R4,R5}
        BX  LR

        .global     UBFX

UBFX: // r1 = lsb, r2 = width
        LDR R3,=1
        LSL R3,R3,R2
        SUB R3,R3,1 // mask = ( 1 << width ) - 1

        LSR R0,R0,R1 //word == word >> lsb

        AND R0,R0,R3 //word = word & mask

        BX LR

        .end


