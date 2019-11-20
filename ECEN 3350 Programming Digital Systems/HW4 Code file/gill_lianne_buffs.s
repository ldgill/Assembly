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
.equ A, 0x49494949
.equ B2, 0x36363636
.equ C, 0x7F7F7F7F
.equ BLANK, 0x00000000
.global _start
_start:
	movia 	r20, 0x10000020
	movi	r21, Mask
	movi	r22, Mask2
	movi	r4,0
	movi	r5,0
	movi	r2,12
	movi	r1, 15
	movia 	r19, Hex_bits
	movia	r18, Pattern_bits

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
	
	ble r4,r1, Delay
	br Help2

Delay:
	subi	r7, r7, 1
	bne		r7, r0, Delay
	br		Hex

Help2:
	
	ldwio r6, 0(r18) 
	and r3, r3, r0
	and r3, r3, r6
	stwio r3, 0(r20)
	
Pattern:
	ldwio r6, 0(r18)
	movi r22, Mask2
	ldwio r22, 0(r22)
	slli r3, r3, 31
	and r3, r3, r22
	or r3, r3, r6
	stwio r3, 0(r20)
	
	addi r18, r18, 4
	addi r5,r5,1
	
	movia 	r8, 1000000
	
	ble r5,r2, Delay2
	br END
Delay2:
	subi	r8, r8, 1
	bne		r8, r0, Delay
	br		Pattern


END:
	and r4, r4, r0
	and r5, r5, r0
	br _start

.data
Hex_bits:
    .word H,E,L,L,O, SPACE, B,U,F,F,S, SPACE,SPACE,SPACE,SPACE
Pattern_bits:
	.word A,B2,A,B2,A,B2,C,BLANK,C,BLANK,C,BLANK
Mask:
	.word 0xFFFFFF00
Mask2:
	.word 0x00000000
	