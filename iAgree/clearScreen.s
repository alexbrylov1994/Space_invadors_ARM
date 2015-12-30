.section .text

.globl  ClearScreen
//frameBuffer = r0, x-cord = r1, y-cord = r2, colour = r3 Xdimension = r4 Ydimension = r5
// Clears the screen
// r0 = frameBuffer
ClearScreen:
    mov     r1, #0
    mov     r2, #0
    mov     r3, #0
    ldr     r4, =1024
    ldr     r5, =768
    push    {r4, r5}

    bl      DrawRectangle
