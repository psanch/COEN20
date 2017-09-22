        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// float Poly(float, float [], int32_t) ;

/*

S0 = x
R0 = float[]
R1 = terms

S1 = coef[i]
S2 = poly
S3 = x2n

*/

zero:   .float 0.0
one:    .float 1.0

        .global     Poly
Poly:
        VLDR S2, zero
        VLDR S3, one
next:
        CBZ R1,done //if terms == 0 then done
        VLDMIA R0!,{S1} //Get coeficient and increment

        VMLA.F32 S2,S3,S1 //s2 = x2n * coef
        VMUL.F32 S3,S3,S0 //x2n *= x

        SUB R1,R1,1 //terms--

        B next

done:
        VMOV S0,S2 //prepare result for return
        BX LR

        .end

