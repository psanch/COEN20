        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

        .global     Remainder2
Remainder2:
        LDR R2,=1
        LSL R2,R2,R1 //R2 = 1 << k
        SUB R3,R2,1 //R3 = (1 << k) - 1

        AND R3,R3,R0 //R3 = (power - 1) & s32
        AND R2,R2,R0,ASR 31 //R2 = power & ( s32 ASR 31)

        SUB R0,R3,R2 // R0 = ((power - 1) & s32) - (power & (s32 >> 31)) for return

        BX LR

        .end

/*
int Remainder_c(int s32, int k){
    int power = 1 << k;
    return ((power - 1) & s32) - (power & (s32 >> 31));
}
*/
