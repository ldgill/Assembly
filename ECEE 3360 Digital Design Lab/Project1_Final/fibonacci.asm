	.global fibonacci

fibonacci:
	;save the return address back to where we were in main onto the stack
	push {lr}

check0:
	;check to see if n is 0, if less than checkneg, if greater than check1
	cmp r0, #0
	blt checkneg
	bgt check1
	;return the value of 1 if n=0
	mov r0, #1
	pop {pc}

checkneg:
	;if n is a negative number return 0
	mov r0, #0
	pop {pc}


check1:
	;check to see if n is 1 if i is greater than go to recurse
	cmp r0, #1
	bgt recurse
	;return the value of 1
	mov r0, #1
	pop {pc}

recurse:

	push {r0}
	;get the value of fib(n-1)
	sub r0,r0,#1
	BL fibonacci

	;store n-1 into register 1
	mov r1,r0
	pop {r0}
	;put r1/n-1 on stack
	push{r1}
	;get the value of fib(n-2)
	sub r0, r0,#2
	BL fibonacci

	pop {r1}
	;add them together to get fib(n)
	add r0,r0,r1
exit:
	;return
	pop {pc}
