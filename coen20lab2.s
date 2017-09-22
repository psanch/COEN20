        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// void PrintTwo(char *format, int32_t numb) ;

        .global     PrintTwo
PrintTwo:

        PUSH {R4,R5,LR} //PRESERVE VARIABLE REGISTERS AND LINK REGISTER

        MOV R4,R0 //STORE FORMAT
        MOV R5,R1 //STORE VALUE

        BL printf //CALL PRINTF #1 WITH DEFAULT VALUE

        MOV R0,R4 //PREPARE STORED FORMAT/VALUE FOR CALL #2
        MOV R1,R5

        ADD R1,R1,1 //ADD 1 TO DEFAULT VALUE, STORE IN R1

        BL printf //CALL PRINTF #2

        POP {R4,R5,LR} //POP PRESERVATION OF VARIABLE REGISTERS AND LINK REGISTER
        BX LR //RETURN TO LR (MAIN)

        .end

