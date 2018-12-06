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