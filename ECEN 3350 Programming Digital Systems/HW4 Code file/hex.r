	.include "nios_macros.s"
	.global _start
	
.equ H, 0b01110110
.equ E, 0b01111001
.equ L, 0b00111000
.equ O, 0b00111111
.equ B, 0b01111100
.equ U, 0b00111110
.equ F, 0b01110001
.equ S, 0b01101101
.global _start
_start:
	movia	r1, 0x10000040
	movia 	r20, 0x10000020
	movia 	r19, Hex_bits
	ldw 	r6, 0(r19)

Display:
	br		Hex
	mov 	r6, r4

Hex:
	stwio 	r6, 0(r20)
	roli 	r6, r6, 8
	
	movia 	r7, 500000
Delay:
	subi	r7, r7, 1
	bne		r7, r0, Delay
	br		Display

.data
Hex_bits:
      .word H