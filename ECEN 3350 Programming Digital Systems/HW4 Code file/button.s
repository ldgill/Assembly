.include "nios_macros.s"

	
.equ A, 0x79
.equ B, 0x49
.equ C, 0x1C

.global _start
_start:
	movia 	r20, 0x10000020
	movia	r17, 0x10000050
	
	movi	r4,0
	movi	r2,8
	
	movi	r21, Mask_Left
	movi	r22, Mask_Right
	movia 	r19, Pattern_Left
	movia	r18, Pattern_Right

	

END_Left:
	movia r19, Pattern_Left
	and r4, r4, r0


Shift_Left:
	ldwio	r14, 0(r17)
	bne		r14, r0, END_Right
	
	movia	r7, 500000
Delay1:
	subi	r7, r7, 1
	bne		r7, r0, Delay1
	br		Hex_Left
	
Hex_Left:
	ldwio r6, 0(r19)
	movi r21, Mask_Left
	ldwio r21, 0(r21)
	slli r3, r3, 8
	and r3, r3, r21
	or r3, r3, r6
	stwio r3, 0(r20)
	
	addi r19, r19, 4
	addi r4,r4,1
	
	
	ble r4,r2, Shift_Left
	br END_Left


END_Right:
	movia r18, Pattern_Right
	and r4, r4, r0


Shift_Right:

	ldwio	r14, 0(r17)
	bne		r14, r0, END_Left
	movia	r7, 500000

Delay2:
	subi	r7, r7, 1
	bne		r7, r0, Delay2
	br		Hex_Right

	
Hex_Right:
	ldwio r6, 0(r18)
	movi r22, Mask_Right
	ldwio r22, 0(r22)
	slli r6, r6, 24
	srli r3, r3, 8                                                       
	and r3, r3, r22
	or r3, r3, r6
	stwio r3, 0(r20)
	
	addi r18, r18, 4
	addi r4,r4,1

	
	ble r4,r2, Shift_Right
	br END_Right






.data
Pattern_Left:
    .word A,B,B,B,C,C,C,C
Pattern_Right:
	.word C,C,C,C,B,B,B,A
Mask_Left:
	.word 0xFFFFFF00
Mask_Right:
	.word 0x00FFFFFF
	