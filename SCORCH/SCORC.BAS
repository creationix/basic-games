DECLARE SUB fall (x%)
DECLARE SUB explosion (x%, y%, s%)
DEFINT A-Z
SCREEN 13
DIM fade(319)
FOR a = 0 TO 319
fade(a) = a
NEXT a
FOR a = 0 TO 319
SWAP fade(a), fade(INT(320 * RND))
NEXT a
FOR a = 0 TO 319
x = fade(a)
y = x MOD 20 + SIN(x / 2) * 3 + 100 + SIN(x / 10) * 10 + SIN(x / 50) * 60
LINE (x, 0)-(x, 200 - y), 0
LINE (x, 199 - y)-(x, 199), 10
NEXT a
DO
explosion 320 * RND, 100 + 100 * RND, 3 + 20 * RND
LOOP

SUB explosion (x, y, s)
FOR a = 1 TO s
SOUND 40 + a * 3, .1
CIRCLE (x, y), a, 4
CIRCLE (x, y + 1), a, 12
NEXT a
FOR a = 1 TO s
SOUND 40 + a * 5, .1
CIRCLE (x, y), a, 12
CIRCLE (x, y + 1), a, 14
NEXT a
FOR a = 1 TO s
SOUND 50 + a * 3, .1
CIRCLE (x, y), a, 14
CIRCLE (x, y + 1), a, 8
NEXT a
FOR a = 1 TO s
SOUND 40 + a * 3, .1
CIRCLE (x, y), a, 8
CIRCLE (x, y + 1), a, 4
NEXT a
FOR a = s TO 1 STEP -1
SOUND 40 + a * 3, .1
CIRCLE (x, y + 1), a, 0
CIRCLE (x, y), a, 0
NEXT a
FOR a = x - s TO x + s
fall a
NEXT a
END SUB

SUB fall (x)
DIM f(200)
pt = 0
FOR y = 199 TO 0 STEP -1
IF POINT(x, y) > 0 THEN pt = pt + 1: f(pt) = POINT(x, y)
NEXT y
LINE (x, 0)-(x, 199 - pt), 0
FOR y = 200 - pt TO 199
PSET (x, y), f(200 - y)
NEXT y

END SUB

SUB slide (y)
DIM f(320)
pt = 0
FOR x = 319 TO 0 STEP -1
IF POINT(x, y) > 0 THEN pt = pt + 1: f(pt) = POINT(x, y)
NEXT x
LINE (0, y)-(319 - pt, y), 0
FOR x = 320 - pt TO 319
PSET (x, y), f(320 - x)
NEXT x

END SUB

