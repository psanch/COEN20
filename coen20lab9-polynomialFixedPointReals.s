        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// Q32 Q32Poly(Q32 x, Q32 coefficients[], int32_t terms) ;
// R0.R1 == q32coef
// R2.R3 == q32mult
// R4.R5 = resulting poly

//R6-> ADR coef
//R7-> terms
//R8.R9 = x

// R10.R11 = x2n

// Q32  Q32Product(Q32 a, Q32 b)

        .global     Q32Poly
Q32Poly:
        PUSH {R4-R12,LR}

        MOV R8,R0 //R8.R9 == x
        MOV R9,R1
        MOV R6,R2 //R6 = ADR Coef
        MOV R7,R3 //R7 = terms

        LDR R4,=0 //poly = 0
        LDR R5,=1
        MOV R10,R4
        MOV R11,R5 //x2n = q32(1)// R10.R11 = x2n

        MOV R5,R4 //poly = 0

loop:
        CBZ R7,done //if terms == 0 done

        LDR R0,[R6],4 //load from adr coef and increment
        LDR R1,[R6],4

        MOV R2,R10 //move x2n in as second param.
        MOV R3,R11

        PUSH {R4-R12,LR}
        BL Q32Product //pasing in R0.R1, R2.R3 as parameters Q32coef, Q32x2n
        POP {R4-R12,LR} //resulting product in R0.R1

        ADDS R4,R4,R0 //poly = poly + q32 mult
        ADC R5,R5,R1 //add with carry

        MOV R2,R10 //X2n in R2.R3
        MOV R3,R11

        MOV R0,R8 //x in R0,R1
        MOV R1,R9

        PUSH {R4-R12,LR}
        BL Q32Product
        POP {R4-R12,LR} //R0.R1 now hold new x2n

        MOV R10,R0 //update preserved x2n
        MOV R11,R1

        SUB R7,R7,1 //terms--
        B loop
done:
        MOV R0,R4 //prepare q32 poly for return
        MOV R1,R5
        POP {R4-R12,LR}
        BX          LR

        .end

