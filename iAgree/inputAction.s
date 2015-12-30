.section .text

.globl InputAction

//r0 = an integer representing the action taken, r1 = FrameBuffer
InputAction:
    push    {r4-r10, lr}

    FrameBufferPointer      .req        r10
    mov     FrameBufferPointer, r1

    // Pause button Pressed
    cmp     r0, #0
    beq     pause

    // Up button pressed
    cmp     r0, #1
    beq     moveUp

    // Down button pressed
    cmp     r0, #2
    beq     moveDown

    // Left button pressed
    cmp     r0, #3
    beq     moveLeft

    // Right button pressed
    cmp     r0, #4
    beq     moveRight

    // A button Pressed
    cmp     r0, #5
    beq     shoot    


    
pause:
    ldr     r2, =GameState
    ldrb     r3, [r2]
    cmp     r3, #0
    beq     end

    mov     r3, #0
    str     r3, [r2]

    mov     r0, FrameBufferPointer
    bl      DrawPauseMenu
   
    b       end

moveUp:
    ldr     r2, =GameState
    ldrb    r3, [r2]

    cmp     r3, #0               //if the game is currently paused
    b       gamePaused

moveDown:
    ldr     r2, =GameState
    ldrb    r3, [r2]

    cmp     r3, #0               //if the game is currently paused
    b       gamePaused
    
    

moveLeft:
    b       end

moveRight:
    b       end

shoot:
    mov     r0, r1
    bl      ClearScreen


gamePaused:
    ldr     r2, =PauseMenuPointer
    ldrb    r3, [r2]

    cmp     r0, #1          // Checking to see if up or down was pressed
    subeq   r3, #1          // If up was pressed
    addne   r3, #1          // If down was pressed

    cmp     r3, #3          // Circular motion back to the top
    moveq   r3, #0

    cmp     r3, #-1         // Circular motion back to the bottom
    moveq   r3, #2

    strb    r3, [r2]

    mov     r0, FrameBufferPointer
    bl      DrawPauseMenu

end:
    pop     {r4-r10, lr}
    bx      lr
    
