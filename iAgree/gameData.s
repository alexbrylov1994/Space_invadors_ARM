.section .text

.globl GameData

GameData:
    bx      lr








.section .data
.align  4

.globl QueenDim, QueenArray, KnightDim, KnightArray, PawnDim, PawnArray, PlayerDim, PlayerPos, ObstacleDim, ObstacleArray, GameState, PauseMenuPointer, Score

QueenDim:   .int    30
QueenArray: .int    q1, q2          // the queens
q1:         .int    100, 50         // x-cor, y-cor
q2:         .int    820, 50

KnightDim:  .int    35
KnightArray:.int    k1, k2, k3, k4, k5
k1:         .int    220, 100
k2:         .int    340, 100
k3:         .int    460, 100
k4:         .int    580, 100
k5:         .int    700, 100

PawnDim:    .int    45
PawnArray:  .int    p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 
p1:         .int    0, 200
p2:         .int    100, 200
p3:         .int    200, 200
p4:         .int    300, 200
p5:         .int    400, 200
p6:         .int    500, 200
p7:         .int    600, 200
p8:         .int    700, 200
p9:         .int    800, 200
p10:        .int    900, 200

PlayerDim:  .int    35
PlayerPos:  .int    450, 700

ObstacleDim:      .int    15, 15, 15
ObstacleArray:    .int    o1, o2, o3  
o1:        .int    125, 600
o2:        .int    425, 600
o3:        .int    725, 600

GameState: .byte    1           // 0 = Pause, 1 = Game running

PauseMenuPointer:   .byte    0

Score:  .byte    '0','1', '0', '!'   
