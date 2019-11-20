.equ  HEX, 0x10000020 
.equ TIME, 50000000 
.equ H, 0b01110110
.equ E, 0b01111001
.equ L, 0b00111000
.equ O, 0b00111111
.equ B, 0b01111100
.equ U, 0b00111110
.equ F, 0b01110001
.equ S, 0b01101101

.data
hexH:  .byte 0b01110110
hexE:  .byte 0b01111001
hexL:  .byte 0b00111000
hexL2: .byte 0b00111000
hexO:  .byte 0b00111111

.global _start
_start:
	movia 	r1,  0x10002000 
	movi 	r2, %lo(TIME) 
	stwio 	r2, 8(r1)
	movi 	r2, %hi(TIME)
	stwio 	r2, 12(r1)
	movi 	r2, 0b110 
	stwio 	r2, 4(r1)
	stwio 	r0, 0(r1)
	movia 	r10,  HEX # Hex
	movia 	r11, hexH
	movia 	r12, hexO

LOOP:
	ldwio 	r2, 0(r1) # Check for timeout bit
	andi 	r2, r2, 0x1
	beq 	r2, r0, LOOP # Keep polling if timeout bit not set
	ldb 	r13, 0(r11) # load next digit to display to hex
	stwio 	r13, 0(r10) # store digit to hex
	slli	r13, r13, 8
	addi 	r11, r11, 1

	ble 	r11, r12, next # adjust address to roll-over to zero after 3
	movia 	r11, hexH

next:
stwio 	r0, 0(r1) # clear timeout bit

br LOOP # resume polling