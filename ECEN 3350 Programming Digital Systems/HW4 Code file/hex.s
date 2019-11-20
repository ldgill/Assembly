	.include "nios_macros.s"
	.global _start
	
.equ H, 0x76
.equ E, 0x79
.equ L, 0x38
.equ O, 0x3F
.equ SPACE, 0x00
.equ B, 0x7C
.equ U, 0x3E
.equ F, 0x71
.equ S, 0x6D
.global _start
_start:
	movia 	r20, 0x10000020
	movi	r21, Mask
	movi	r4,0
	movi	r2,11
	movia 	r19, Hex_bits

Help:
	
	ldwio r6, 0(r19) 
	and r3, r3, r0
	and r3, r3, r6
	stwio r3, 0(r20)
	
	

	

Hex:
	ldwio r6, 0(r19)
	movi r21, Mask
	ldwio r21, 0(r21)
	slli r3, r3, 8
	and r3, r3, r21
	or r3, r3, r6
	stwio r3, 0(r20)
	
	addi r19, r19, 4
	addi r4,r4,1
	
	movia 	r7, 1000000
	
	ble r4,r2, Delay
	br END

Delay:
	subi	r7, r7, 1
	bne		r7, r0, Delay
	br		Hex


END:
	and r4, r4, r0
	br _start

.data
Hex_bits:
    .word H,E,L,L,O, SPACE, B,U,F,F,S
Mask:
	.word 0xFFFFFF00
	