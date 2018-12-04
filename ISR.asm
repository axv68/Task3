; ISR.asm
; Name: Rishabh Parekh and Amit Verma
; UTEid: rbp668 and axv68
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x4600
               .ORIG x2600
	;getc 
poll	LDI R0,KBSR
	BRzp poll
	LDR R1,KBDR
	;verify
	LD R2,aye	;Make R2 a -A
	ADD R3,R1,R2	;check if character is A 
	BRz putc
	ADD R2,#-2	;make R2 a -C
	ADD R3,R1,R2	;check if character is C
	BRz putc
	LD R2,gee	;make R2 hold a -G
	ADD R3,R2,R1	;check if character is G
	BRz putc	
	LD R2,you	;make R2 hold a -U
	ADD R3,R2,R1	;check if character is U
	BRz putc
	BRnzp poll
	;putc		
putc	ST R,boi
loop	LDI R5, DSR 
	BRzp loop
	



	RET
aye	.FILL #-65
you	.FILL #-85
cee	.FILL #-67
gee	.FILL #-71
KBSR	.FILL xFE00
KBDR	.FILL xFEO2
Place	.FILL x4600
boi	.Blkw 1

		.END
