.text
.global sumthree
sumthree:

addi sp, sp, -16;

stw ra, 12(sp);
stw r19, 8(sp);
stw r18, 4(sp);
stw r17, 0(sp);

mov r4, r4;
mov r5, r5;

call sumtwo

mov r4, r2;
mov r5, r6;

call sumtwo

stw r2, r2;

ldw ra, 12(sp);
ldw r19, 8(sp);
ldw r18, 4(sp);
ldw r17, 0(sp);

addi sp, sp, 16;
ret

/*Sumtwo:
add r2, r4,r5;
ret;
*/
 
//do not colloborate data