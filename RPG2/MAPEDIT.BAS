SCREEN 12
DEFINT A-Z
FILES "*.map"
INPUT "Edit which"; file$
IF INSTR(file$, ".") = 0 THEN file$ = file$ + ".map"
DIM map(180, 110)
PRINT "opening..."
DEF SEG = VARSEG(map(0, 0))
BLOAD file$, 0
mapx = map(0, 0)
mapy = map(0, 1)
WINDOW SCREEN (0, 0)-(mapx + 1, mapy * 1.2 + 1)
DEF SEG
OUT &H3C8, 1
OUT &H3C9, 20: OUT &H3C9, 25: OUT &H3C9, 20: 'path
OUT &H3C9, 0: OUT &H3C9, 10: OUT &H3C9, 60: 'Water
OUT &H3C9, 60: OUT &H3C9, 30: OUT &H3C9, 0: 'Bridge
OUT &H3C9, 50: OUT &H3C9, 50: OUT &H3C9, 50: 'Wall
OUT &H3C9, 0: OUT &H3C9, 30: OUT &H3C9, 0: 'Grass
OUT &H3C9, 0: OUT &H3C9, 60: OUT &H3C9, 0: 'Tree
OUT &H3C9, 50: OUT &H3C9, 40: OUT &H3C9, 40: 'mountain
OUT &H3C9, 20: OUT &H3C9, 30: OUT &H3C9, 63: ' rock
OUT &H3C9, 20: OUT &H3C9, 20: OUT &H3C9, 20: ' Floor
OUT &H3C9, 60: OUT &H3C9, 40: OUT &H3C9, 40: ' Door
OUT &H3C9, 60: OUT &H3C9, 60: OUT &H3C9, 60: ' person
OUT &H3C9, 60: OUT &H3C9, 30: OUT &H3C9, 0: ' lava
OUT &H3C9, 50: OUT &H3C9, 35: OUT &H3C9, 10: ' table
OUT &H3C9, 20: OUT &H3C9, 50: OUT &H3C9, 50: ' Chair

CLS
FOR y = 1 TO mapy
FOR x = 1 TO mapx
LINE (x, y)-(x + 1, y + 1), map(x, y) + 1, BF
NEXT x
NEXT y
x = mapx \ 2
y = mapy \ 2
DO
ox = x: oy = y
a$ = INKEY$
'map(x, y) = 6
IF a$ = "8" THEN y = y - 1
IF a$ = "2" THEN y = y + 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "q" THEN map(x, y) = 1 'water
IF a$ = "w" THEN map(x, y) = 2 'wood
IF a$ = "e" THEN map(x, y) = 3 'wall
IF a$ = "r" THEN map(x, y) = 4 'Grass
IF a$ = "t" THEN map(x, y) = 5 'Tree
IF a$ = "y" THEN map(x, y) = 6 'mountain
IF a$ = "u" THEN map(x, y) = 7 'rock
IF a$ = "i" THEN map(x, y) = 8 'floor
IF a$ = "o" THEN map(x, y) = 9 'door
IF a$ = "p" THEN map(x, y) = 10 'Person
IF a$ = "a" THEN map(x, y) = 11 'Lava
IF a$ = "s" THEN map(x, y) = 12 'table
IF a$ = "d" THEN map(x, y) = 13 'chair
IF a$ = "f" THEN map(x, y) = 14 'clock
IF a$ = "g" THEN map(x, y) = 15 'chest
IF a$ = "h" THEN map(x, y) = 16 'head of bed
IF a$ = "j" THEN map(x, y) = 17 'foot of bed
IF a$ = "k" THEN map(x, y) = 18 'dressor
IF a$ = "l" THEN map(x, y) = 19 'fireplace
IF a$ = ";" THEN map(x, y) = 20 'window

IF a$ = " " THEN map(x, y) = 0 'Path
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
IF x > mapx THEN x = mapx
IF y > mapy THEN y = mapy
IF ox <> x OR oy <> y THEN LINE (ox, oy)-(ox + 1, oy + 1), map(ox, oy) + 1, BF: LOCATE 27, 1: PRINT x, y;
LINE (x, y)-(x + 1, y + 1), 15, BF
LOOP WHILE a$ <> "Q"
PRINT "closing..."
map(0, 0) = mapx
map(0, 1) = mapy
DEF SEG = VARSEG(map(0, 0))
BSAVE file$, 0, VARPTR(map(mapx, mapy))
DEF SEG

