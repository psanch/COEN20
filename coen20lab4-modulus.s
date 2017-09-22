        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     Modulus
Modulus:SDIV R2,R0,R1 //quotient in R2
        MLS R0,R1,R2,R0 //(number % divisor) in R0
        ADD R0,R0,R1 //(number % divisor) + divisor in R0
        SDIV R2,R0,R1 //quotient of R0 in R2
        MLS R0,R1,R2,R0 // ((number % divisor) + divisor) % divisor == mod operator
        BX LR
        .end

