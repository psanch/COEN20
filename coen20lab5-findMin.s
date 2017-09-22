        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// uint32_t  Add1(uint32_t x) ;

        .global     minimum_asm
minimum_asm:
        PUSH {R4} //preserve R4 as minimum

        LDR R3,=0 //R3 represents i, initialized at 0

        LDR R4,[R0] //assume minimum is the first element of the array

    loop:
        CMP R3,R1 //if i > count, break
        BGE ended

        LDR R2,[R0,R3,LSL 2] //load R2 with data[i]
        CMP R2,R4 //if !min skip
        BGE skip

        MOV R4,R2 //min found! put in R4

    skip:
        ADD R3,R3,1 //increment i
        B loop

    ended:
        MOV R0,R4 //prepare the minimum value for return
        POP {R4} //return original R4 value
        BX LR

        .end

