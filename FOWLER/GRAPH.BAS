'1 block
'2 slide \
'3 slide /
'4 coin
'5 fish icon
'6 angel icon
'7 dude icon
'8 water
'9 lava
'10 slime
'11 - squid
'12 - blob
'13 - fireball
'14 - fire1
'15 - fire2
'16 - key
'17 - door
'18 fish
'19 angel
'20 dude
DEFINT A-Z
DIM p%(384 * 2, 20)
RANDOMIZE TIMER
SCREEN 13
CONST back = 0
CLS

LINE (1, 1)-(32, 24), back, BF
GET (1, 1)-(32, 24), p%(0, 0)
FOR n = 1 TO 20
LINE (0, 0)-(33, 25), back, BF
IF n = 8 OR n = 10 OR n = 11 THEN
    FOR a = 1 TO 100
    PSET (32 * RND, 24 * RND), 0: DRAW "l3r3d1r3"
    PSET (32 * RND, 24 * RND), 1: DRAW "l3r3d1r3"
    PSET (32 * RND, 24 * RND), 9: DRAW "l3r3d1r3"
    PSET (32 * RND, 24 * RND), 3: DRAW "l3r3d1r3"
    NEXT a
END IF

IF n <= 3 THEN
FOR y = 1 TO 24
FOR x = 1 TO 32
c = 2 + CINT(RND) * 8
IF n = 2 AND x - 6 - y > 0 THEN c = back
IF n = 3 AND (24 - x) - y > 0 THEN c = back
PSET (x, y), c
NEXT x
NEXT y
END IF
IF n = 4 THEN
FOR a = 1 TO 12
CIRCLE (15, 12), a, 15
CIRCLE (16, 12), a, 14
NEXT a
END IF
IF n = 18 THEN RESTORE start:
IF n = 5 OR n = 6 OR n = 7 OR n = 18 OR n = 19 OR n = 20 OR n = 11 OR n = 12 THEN
sy = 11
IF n > 12 THEN LINE (1, 1)-(32, 24), 0, BF
IF n < 8 THEN LINE (1, 1)-(32, 24), 7, BF: LINE (1, 1)-(33, 25), 15, B: LINE (0, 0)-(32, 24), 0, B: LINE (2, 2)-(33, 25), 15, B: LINE (0, 0)-(31, 23), 0, B: sy = 6
FOR y = 1 TO 12
FOR x = 1 TO 16
READ c
IF c > 0 THEN
PSET (x + 8, y + sy), c + 8
END IF
NEXT x
NEXT y
FOR y = 1 TO 12
FOR x = 1 TO 16
IF POINT(x + 8, y + sy) > 8 THEN
    IF POINT(x + 7, y + sy) < 8 THEN PSET (x + 7, y + sy), 8
    IF POINT(x + 9, y + sy) < 8 THEN PSET (x + 9, y + sy), 4
    IF POINT(x + 8, y + sy - 1) < 8 THEN PSET (x + 8, y + sy - 1), 15
    IF POINT(x + 8, y + sy + 1) < 8 THEN PSET (x + 8, y + sy + 1), 0
END IF
NEXT x
NEXT y
END IF
IF n = 9 THEN
    FOR a = 1 TO 300
    PSET (32 * RND, 24 * RND), 0: DRAW "l3r3d1u3"
    PSET (32 * RND, 24 * RND), 4: DRAW "l3r3d1d3"
    PSET (32 * RND, 24 * RND), 12: DRAW "ldr3d1r3"
    PSET (32 * RND, 24 * RND), 14: DRAW "l3r3d1r3"
    NEXT a
END IF
IF n = 10 THEN
FOR a = 1 TO 10
    PSET (32 * RND, 24 * RND), 0: DRAW "l2r2d1r2"
    PSET (32 * RND, 24 * RND), 2: DRAW "l2r2d1r2"
    PSET (32 * RND, 24 * RND), 10: DRAW "l2r2d1r2"
NEXT a
END IF
IF n = 13 THEN
FOR a = 1 TO 10
CIRCLE (16 + RND, 12 + RND), a, 14
CIRCLE (16 + RND, 12 + RND), a, 4
CIRCLE (16 + RND, 12 + RND), a, 12
NEXT a
END IF
IF n = 14 OR n = 15 THEN
FOR x = 1 TO 32
FOR y = 16 * RND TO 24
PSET (x, y), 4 + CINT(RND) * 8
PSET (x + 1, y), 14
NEXT y
NEXT x
END IF
IF n = 16 THEN
FOR a = 1 TO 6
CIRCLE (16, 16), a, 13
CIRCLE (17, 16), a, 11
LINE (16, 16)-(14 + a, 1), 13
LINE (16, 16)-(13 + a, 2), 11
NEXT a
END IF
IF n = 17 THEN
FOR a = 1 TO 1000
PSET (32 * RND, 24 * RND), 6
PSET (32 * RND, 24 * RND), 7
NEXT a
FOR a = 1 TO 4
CIRCLE (18, 16), a, 12
CIRCLE (17, 16), a, 15
NEXT a
END IF
a$ = INKEY$
'SLEEP
GET (1, 1)-(32, 24), p%(0, n)
NEXT n
DEF SEG = VARSEG(p%(0, 0))
BSAVE "fowler.pic", 0, VARPTR(p%(384 * 2, 20))


start:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0
DATA 1,0,0,0,1,5,5,5,5,5,1,1,0,0,0,0
DATA 5,1,0,1,5,5,5,5,5,5,4,5,1,1,0,0
DATA 5,1,1,5,5,5,5,5,5,5,4,4,5,5,1,0
DATA 5,5,1,5,5,5,5,5,5,5,5,5,5,5,5,1
DATA 5,1,1,5,5,5,5,5,5,5,5,5,5,5,1,0
DATA 5,1,0,1,5,5,5,5,5,5,5,5,1,1,0,0
DATA 1,0,0,0,1,5,5,5,5,5,1,1,0,0,0,0
DATA 1,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

DATA 0,0,0,0,0,0,7,7,7,0,0,0,0,0,0,0
DATA 0,6,6,0,0,7,0,0,0,7,0,0,6,6,0,0
DATA 6,6,6,6,0,0,7,7,7,0,0,6,6,6,6,0
DATA 6,6,6,6,6,0,0,0,0,0,6,6,6,6,6,0
DATA 6,3,3,6,6,0,1,3,1,0,6,6,3,3,6,0
DATA 6,6,6,3,6,6,3,3,3,6,6,3,6,6,6,0
DATA 0,6,6,6,3,6,0,3,0,6,3,6,6,6,0,0
DATA 0,0,6,6,6,3,3,3,3,3,6,6,6,0,0,0
DATA 0,0,0,0,0,6,3,3,3,6,0,0,0,0,0,0
DATA 0,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,3,0,3,0,0,0,0,0,0,0
DATA 0,0,0,0,0,3,3,0,3,3,0,0,0,0,0,0

DATA 0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,2,2,2,2,0,0,0,0,0,0
DATA 0,0,0,0,0,0,2,2,2,2,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,5,5,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,5,5,5,5,0,0,0,0,5,0
DATA 0,0,5,5,5,5,5,5,5,5,5,5,5,5,0,0
DATA 0,5,0,0,0,0,5,5,5,5,0,0,0,0,0,0
DATA 0,0,0,0,0,0,5,5,5,5,0,0,0,0,0,0
DATA 0,0,0,0,0,5,5,5,5,5,5,0,0,0,0,0
DATA 0,0,0,0,5,5,0,0,0,5,5,0,0,0,0,0
DATA 0,0,0,0,5,5,5,0,0,5,5,5,0,0,0,0
DATA 0,0,0,0,5,5,5,5,0,5,5,5,5,0,0,0

DATA 0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0
DATA 0,0,0,0,0,2,5,2,5,2,0,0,0,0,0,0
DATA 0,0,0,0,0,2,5,2,5,2,0,0,0,0,0,0
DATA 0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0
DATA 0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0
DATA 0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0
DATA 0,0,2,0,0,2,2,2,2,2,0,2,2,0,0,0
DATA 0,2,0,0,2,2,2,2,2,2,2,0,2,2,0,0
DATA 0,2,0,2,0,2,2,2,2,2,2,2,0,2,0,0
DATA 0,2,0,2,0,2,0,2,2,0,2,2,0,2,0,0
DATA 0,2,0,2,0,2,0,2,0,0,0,2,0,2,0,0


DATA 0,0,0,0,0,0,0,5,5,2,5,0,0,0,0,0
DATA 0,0,0,0,0,0,2,5,5,5,2,5,0,0,0,0
DATA 0,0,0,0,0,0,5,2,5,5,5,2,5,0,0,0
DATA 0,0,0,0,0,0,5,5,2,5,5,5,2,2,0,0
DATA 0,0,0,0,0,0,5,5,0,2,0,5,2,2,5,0
DATA 5,2,5,5,2,5,5,0,0,4,2,2,5,5,2,5
DATA 0,5,2,5,5,2,5,0,4,4,2,2,5,2,0,0
DATA 0,0,5,2,5,5,2,0,4,2,5,5,2,0,0,0
DATA 0,0,0,5,2,5,5,2,2,5,5,2,0,0,0,0
DATA 0,0,0,0,5,2,5,2,2,5,2,0,0,0,0,0
DATA 0,0,0,0,0,5,2,5,5,2,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

DATA 0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,2,2,2,0,0,0,0,0,0,0
DATA 0,0,0,0,0,2,5,2,5,2,0,0,0,0,0,0
DATA 0,0,0,0,0,2,5,2,5,2,0,0,0,0,0,0
DATA 0,0,0,0,0,2,2,2,2,2,0,0,0,0,0,0
DATA 0,0,0,0,2,2,2,2,2,2,2,0,0,0,0,0
DATA 0,0,0,2,2,2,2,2,2,2,2,2,0,0,0,0
DATA 0,0,2,0,0,2,2,2,2,2,0,2,2,0,0,0
DATA 0,2,0,0,2,2,2,2,2,2,2,0,2,2,0,0
DATA 0,2,0,2,0,2,2,2,2,2,2,2,0,2,0,0
DATA 0,2,0,2,0,2,0,2,2,0,2,2,0,2,0,0
DATA 0,2,0,2,0,2,0,2,0,0,0,2,0,2,0,0

