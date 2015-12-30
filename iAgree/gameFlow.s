.section .text

.globl GameFlow

// Where the game happens
//r0 = FrameBuffer
GameFlow:
    FrameBufferPointer      .req    r10
    mov     FrameBufferPointer, r0

    SNESInput       .req    r9

    bl 		InitializeScreen

SNESLoop:
    bl      ReadingSNES
    bl      InputDecode
    mov     SNESInput, r0
    cmp     SNESInput, #6
    beq     SNESLoop

    mov     r1, FrameBufferPointer
    
    bl      InputAction

    bl      wait

    b       SNESLoop
    
    bx      lr


wait:
	ldr r0, =0x20003004         // address of CLO 
	ldr r1, [r0]                // read CLO 
    ldr r2, =400000   
	add r1, r2                  // add 250000 micros
waitLoop: 
	ldr r2, [r0] 
	cmp r1, r2                  // stop when CLO = r1 
	bhi waitLoop 
	bx lr
