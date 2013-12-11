DECLARE SUB DrawMaze (ty%)
DECLARE SUB MakeMaze ()
DECLARE SUB Life ()
DEFINT A-Z
RANDOMIZE (TIMER)
CONST ySize = 20
CONST xSize = 20
DIM SHARED Maze(xSize + 1, ySize + 1)
SCREEN 1
MakeMaze
ty = 100
DO
ty = ty - 10
DrawMaze (ty)
Life: Life: Life: Life:
LOOP

SUB DrawMaze (ty)

FOR y = 1 TO ySize
    FOR x = xSize TO 1 STEP -1
        h = Maze(x, y) * 4
        IF h > 0 THEN
            h = h + 5
            sx = x * 10 - 10 + y * 5
            sy = y * 10 + 4 + ty
            LINE (sx, sy)-(sx - 5, sy - 10), 3
            LINE (sx, sy - h)-(sx - 5, sy - 10 - h), 3
            LINE (sx - 5, sy - 10)-(sx - 5, sy - 10 - h), 3
            LINE (sx + 5, sy - 10 - h)-(sx - 5, sy - 10 - h), 3
            LINE (sx + 5, sy - 10 - h)-(sx + 10, sy - h), 3
            LINE (sx, sy)-(sx + 10, sy - h), 3, B
            PAINT (sx - 2, sy - h), 2, 3
            PAINT (sx, sy - h - 5), 1, 3
            LINE (sx, sy)-(sx + 10, sy - h), 2, BF
            LINE (sx, sy)-(sx - 5, sy - 10), 0
            LINE (sx, sy - h)-(sx - 5, sy - 10 - h), 0
            LINE (sx - 5, sy - 10)-(sx - 5, sy - 10 - h), 0
            LINE (sx + 5, sy - 10 - h)-(sx - 5, sy - 10 - h), 0
            LINE (sx + 5, sy - 10 - h)-(sx + 10, sy - h), 0
            LINE (sx, sy)-(sx + 10, sy - h), 0, B
        END IF
    NEXT x
NEXT y
END SUB

SUB Life
FOR y = 1 TO ySize
FOR x = 1 TO xSize
p = Maze(x, y) + Maze(x + 1, y) + Maze(x - 1, y) + Maze(x, y + 1) + Maze(x, y - 1) + Maze(x - 1, y - 1) + Maze(x + 1, y - 1) + Maze(x - 1, y + 1) + Maze(x + 1, y + 1)
IF Maze(x, y) > 0 AND p > 5 THEN Maze(x, y) = 0 ELSE IF Maze(x, y) = 0 AND p < 5 THEN Maze(x, y) = 2
NEXT x
NEXT y
END SUB

SUB MakeMaze
FOR y = 1 TO ySize
FOR x = 1 TO xSize
Maze(x, y) = CINT(RND)
NEXT x
NEXT y
END SUB

