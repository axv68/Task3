; ISR.asm
; Name: Rishabh Parekh and Amit Verma
; UTEid: rbp668 and axv68
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
poll	LDI R0,KBSR
	BRzp poll
	LDI R0,KBDR
	;verify
	LD R2,aye	;Make R2 a -A
	ADD R3,R0,R2	;check if character is A 
	BRz store
	LD R2,cee	;make R2 a -C
	ADD R3,R0,R2	;check if character is C
	BRz store
	LD R2,gee	;make R2 hold a -G
	ADD R3,R2,R0	;check if character is G
	BRz store	
	LD R2,you	;make R2 hold a -U
	ADD R3,R2,R0	;check if character is U
	BRz store
	BRnzp poll	
store	STI R0, Place	
	RTI
aye	.FILL #-65
you	.FILL #-85
cee	.FILL #-67
gee	.FILL #-71
KBSR	.FILL xFE00
KBDR	.FILL xFE02
DSR	.FILL xFE04
DDR	.FILL xFE06
Place	.FILL x4600

		.END