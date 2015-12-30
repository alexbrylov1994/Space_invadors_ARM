.section .text

.globl InitializeScreen

//frameBuffer = r0
InitializeScreen:
    push    {r4-r10, lr}

//Queens

//Queen #1
    mov		r1, #100            // x-coordinate
	mov		r2, #50             // y-coordinate
	ldr 	r3, =0x780F         // colour
	mov		r4, #30             // dimension
	push	{r4}                // 5th argument = dimension

	bl 		DrawSquare          //draws square

//Queen #2
    mov		r1, #820
	mov		r2, #50
	ldr 	r3, =0x780F
	mov		r4, #30
	push	{r4}

    bl 		DrawSquare


//Knights
    counter     .req    r5
    incXcoor    .req    r6

    mov     counter, #0         // keeping count of number of knights made
    mov     incXcoor, #220      // the x-coordinate of first knight. Later this will be incremented by a set amount

knightCreate:
    mov		r1, incXcoor
	mov		r2, #100
	ldr 	r3, =0xFFFF         // white knights
	mov		r4, #35
	push	{r4}                // send r4 as 5th argument

	bl 		DrawSquare
    
    add     incXcoor, #120      // spacing of 120 pixels between each knight
    add     counter, #1         // counter++

    cmp     counter, #5         // making 5 knights
    blt     knightCreate


//Pawns
    mov     counter, #0         // keeping count of number of pawns made
    mov     incXcoor, #0        // the x-coordinate of first pawn. 

pawnCreate:
    mov		r1, incXcoor
	mov		r2, #200
	ldr 	r3, =0xF800         // red pawns
	mov		r4, #45
	push	{r4}                // send r4 as 5th argument

	bl 		DrawSquare
    
    add     incXcoor, #100      // spacing of 100 pixels between each pawn
    add     counter, #1         // counter++

    cmp     counter, #10        // making 10 pawns
    blt     pawnCreate

	.unreq	incXcoor
	.unreq	counter


//Player

	ldr		r1, =450			// centre of enemies

moveright:
	ldr r8, =0
	cmp r1, #700
	
	bge endmove
	bl wait

	add r1, #5
	
	b moveright
endmove:
	

	mov		r2, #700            // near the very bottom
	ldr 	r3, =0x001F         // blue player
	mov		r4, #35
	push	{r4}                // send r4 as 5th argument

	bl 		DrawSquare


//Obstacles

//Obstacle1
    ldr     r1, =125            // Near the centre of screen
    ldr     r2, =600            // near the bottom of the screen
    ldr     r3, =0xF81F         // pink colour
    ldr     r4, =100            // 100 pixels wide
    ldr     r5, =15             // 15 pixels in height
    push    {r4, r5}

    bl      DrawRectangle

//Obstacle 2
    ldr     r1, =425            // Near the centre of screen
    ldr     r2, =600            // near the bottom of the screen
    ldr     r3, =0xF81F         // pink colour
    ldr     r4, =100            // 100 pixels wide
    ldr     r5, =15             // 15 pixels in height
    push    {r4, r5}

    bl      DrawRectangle

//Obstacle3
    ldr     r1, =725            // Near the centre of screen
    ldr     r2, =600            // near the bottom of the screen
    ldr     r3, =0xF81F         // pink colour
    ldr     r4, =100            // 100 pixels wide
    ldr     r5, =15             // 15 pixels in height
    push    {r4, r5}

    bl      DrawRectangle

//Drawing Game Border

    mov     r1, #0              //start drawing from this X cord
    mov     r2, #0              //start drawing from this Y cord
    ldr     r3, =0xAFE5         //yellow-green colored pixels

drawTopEdge:
    bl      DrawPixel16bpp
    add     r1, #1
    cmp     r1, #1000           // 1000 pixels
    bne     drawTopEdge
    
    mov     r1, #0              //start drawing from this X cord
    mov     r2, #0              //start drawing from this Y cord
    ldr     r4, =750            //draw edge until this Y cord

drawLeftEdge:
    bl      DrawPixel16bpp
    add     r2, #1
    cmp     r2, r4              // 750 pixels
    bne     drawLeftEdge

drawBottomEdge:
    bl      DrawPixel16bpp
    add     r1, #1
    cmp     r1, #1000           // 1000 pixels
    bne     drawBottomEdge

drawRightEdge:
    bl      DrawPixel16bpp
    sub     r2, #1
    cmp     r2, #0              // 750 pixels   
    bne     drawRightEdge

    mov     r1, #0              //start drawing from this X cord
    mov     r2, #25             //start drawing from this Y cord

drawHeaderInfoBox:
    bl      DrawPixel16bpp
    add     r1, #1
    cmp     r1, #1000
    bne     drawHeaderInfoBox

drawScoreText:
    ldr     r3, =0xFD20         //Orange
    mov     r1, #0              //X cord to write at
    mov     r2, #5              //Y cord to write at
    mov     r5, #0              //char position counter
    ldr     r6, =scoreText      //address of string to write
    b       nextCharLoop

drawScoreNum:
    ldr     r3, =0xFFFFFF       //White
    mov     r1, #60             //X cord to write at
    mov     r5, #0              //char position counter
    ldr     r6, =Score          //address of string to write
    b       nextCharLoop

drawGameName:
    ldr     r3, =0xF81F         //Pink
    ldr     r1, =430            //X cord to write at
    mov     r5, #0              //char position counter
    ldr     r6, =gameName       //address of string to write
    b       nextCharLoop

drawCreatorNames:
    ldr     r3, =0x07E0         //Green
    ldr     r1, =780            //X cord to write at
    mov     r5, #0              //char position counter
    ldr     r6, =creatorNames   //address of string to write
    b       nextCharLoop

nextCharLoop:
    ldrb     r4, [r6, r5]
    
    cmp r4, #'$'                //keep looping until we have drawn out creator names (and thus finished writing)
	beq end    

    cmp     r4, #'@'
    beq     drawScoreNum     

    cmp     r4, #'!'
    beq     drawGameName    

    cmp     r4, #'%'
    beq     drawCreatorNames
	
    add r5, #1                  //increment position counter
	bl DrawChar
	add r1, #10                 //add 10 (spacing between chars)
    b   nextCharLoop   

end:
    pop     {r4-r10, lr}
    bx      lr

.section    .data
.align  4
scoreText:      .asciz  "SCORE:@"
gameName:       .asciz  "iAgree: The Game%"
creatorNames:   .asciz  "Arta Seify, Nizar Maan$"

