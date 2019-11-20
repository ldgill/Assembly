/********************************************************************************
 * This program demonstrates use of parallel ports in the DE0 Media Computer
 *
 * It performs the following: 
 * 	1. displays the SW switch values on the green LEDG
 * 	2. displays the KEY[3..1] pushbutton values on the green LEDG
 * 	3. displays a rotating pattern on the HEX displays
 * 	4. if KEY[3..1] is pressed, uses the SW switches as the pattern
********************************************************************************/
	.text									/* executable code follows */
	.global	_start
_start:

	/* initialize base addresses of parallel ports */
	movia		r15, 0x10000040		/* SW slider switch base address */
	movia		r16, 0x10000010		/* green LED base address */
	movia		r17, 0x10000050		/* pushbutton KEY base address */
	movia		r20, 0x10000020		/* HEX3_HEX0 base address */
	movia		r19, HEX_bits
	ldw		r6, 0(r19)				/* load pattern for HEX displays */

DO_DISPLAY:
	ldwio		r4, 0(r15)				/* load slider switches */
	stwio		r4, 0(r16)				/* write to green LEDs */

	ldwio		r5, 0(r17)				/* load pushbuttons */
	beq		r5, r0, NO_BUTTON	
	mov		r6, r4					/* copy SW switch values onto HEX displays */
WAIT:
	ldwio		r5, 0(r17)				/* load pushbuttons */
	bne		r5, r0, WAIT			/* wait for button release */

NO_BUTTON:
	stwio		r6, 0(r20)				/* store to HEX3 ... HEX0 */
	roli		r6, r6, 1				/* rotate the displayed pattern */

	movia		r7, 100000				/* delay counter */
DELAY:	
	subi		r7, r7, 1
	bne		r7, r0, DELAY	

	br 		DO_DISPLAY

/********************************************************************************/
	.data									/* data follows */

HEX_bits:
	.word 0x0000000F

