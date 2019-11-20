.equ HEX, 0x10000020 
.equ TIMER, 0x10002000 
.equ PERIOD, 5000000
.equ H, 0b01110110
.equ E, 0b01111001
.equ L, 0b00111000
.equ O, 0b00111111
.equ B, 0b01111100
.equ U, 0b00111110
.equ F, 0b01110001
.equ S, 0b01101101
.data
hexH: .word H
hexE: .word E
hexL: .word L
hexL2: .word L
hexO: .word O


	.global _start
_start:
	movia r8, TIMER 
	movi r9, %lo(PERIOD) 
	stwio r9, 8(r8)
	movi r9, %hi(PERIOD) 
	stwio r9, 12(r8)
	movi r9, 0b110 
	stwio r9, 4(r8)
	stwio r0, 0(r8)
	movia r10, HEX
	movia r11, hexH
	movia r12, hexO
LOOP:
	ldwio r9, 0(r8) 
	andi r9, r9, 0x1
	beq r9, r0, LOOP 
	ldb r13, 0(r11) 
	stwio r13, 0(r10) 
	addi r11, r11, 1 
	ble r11, r12, next
	movia r11, hexH
next:
	stwio r0, 0(r8)
	br LOOP 