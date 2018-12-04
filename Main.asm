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
loop    BR loop
; start of actual program

	TRAP x25
stack      .FILL x4000
isr_loc    .FILL x2600
KBIVentry  .FILL x0180
mask 	   .FILL x4000
KBSR	   .FILL xFE00
		.END
