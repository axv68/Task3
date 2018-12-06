; Main.asm
; Name: Rishabh Parekh and Amit Verma
; UTEid: rbp668 and axv68
; Continuously reads from x4600 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
    .ORIG x4000
; initialize the stack pointer
	LD R6, stack
; enable keyboard interrupts
	LD R0, mask 
	STI R0, KBSR
; set up the keyboard interrupt vector table entry
	LD R0, isr_loc
	STI R0, KBIVentry 
; start of actual program
	AND R4, R4, #0		;store 0 at x4600
	STI R4, holding
search	LDI R0, holding	        ;read the new char at x4600
	BRz search
	TRAP x21
	AND R4, R4, #0		;store 0 at x4600
	STI R4, holding
	LD R1, char		;R1 has previous character
	BRz searchA		;search for an a
	LD R2, aye	        ;check if prev char was an A
	ADD R3, R1, R2
	BRz searchU		;search for an U
	LD R2, you	        ;check if prev char was a U
	ADD R3, R1, R2
	BRz searchG		;search for a G
	ST R4, char
	BR search		;if it's invalid go back to search
searchA LD R1, aye		;check if the char in R0 is an A
	ADD R2, R0, R1
	BRnp search		;if not then it goes back to search
	ST R0, char		;store A to prev char spot
	BR search		;go to search
searchU	LD R1, you		;check if the char is a U
	ADD R2, R0, R1		
	ST R0, char		;Store current char to previous char
	BR search		;go back to search
searchG	LD R1, gee		;check for G
	ADD R2, R0, R1	
	ST R4, char		;store 0 to x4600
	BRnp search             ;if not a G, go back to search		
	ST R4, char		;store 0 to x4600 
	LD R0, bar		;display pipe bar
	OUT
find	LDI R0, holding		
	BRz find
	TRAP x21
	AND R4, R4, #0
	STI R4, holding
	LD R1, char	        ;check if previous char holder is blank (if so, can start sequence)
	BRz findU
	LD R2, you		;if prev char is U, got to findAG
	ADD R3, R1, R2
	BRz findAG
	LD R2, aye              ;if previous char is A or G, go to findGA
	ADD R3, R1, R2
	BRz findGA
	LD R2, gee
	ADD R3, R1, R2
	BRz findGA
	ST R4, char 		;if char is a C, go back to find
	BR find
findU   LD R1, you		;find U, store to prev char spot
	ADD R2, R0, R1
	BRnp find
	ST R0, char
	BR find
	HALT
stack      .FILL x4000
isr_loc    .FILL x2600
KBIVentry  .FILL x0180
mask 	   .FILL x4000
KBSR	   .FILL xFE00
holding	   .FILL x4600
aye	   .FILL #-65 
cee	   .FILL #-67
gee	   .FILL #-71
you	   .FILL #-85
bar	   .FILL #124
char	   .BLKW 1
		.END