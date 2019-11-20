
.global _start
_start:
/* the following two instr. (orhi and ori) are what movia converts to */

movia r2, X
movia r3, Y
movia r4, W
ldw r2, 0(r2)
ldw r3, 0(r3)
ldw r4, 0(r4)

blt r2, r3, LABEL

STOP:
br STOP
LABEL:
subi r4, r4, 0x2
br STOP

.data
Z:
.word 0
X:
.word 13
Y:
.word 2
W:
.word 1