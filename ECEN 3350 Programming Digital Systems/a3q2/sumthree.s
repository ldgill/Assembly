.text
.global sumthree
sumthree:

addi sp, sp, -24;

stw ra, 20(sp);
stw fp, 16(sp);
addi fp, fp, -24;
stw r4, 12(sp);
stw r5, 8(sp);
stw r6, 4(sp);


call sumtwo

stw r2, 0(sp);
stw r4, 0(sp);
stw r5, 4(sp);

call sumtwo

stw r2, 0(sp);

ldw ra, 20(sp);

ret

 
