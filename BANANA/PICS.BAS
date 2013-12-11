DECLARE SUB PAL (R%, G%, B%)
DEFINT A-Z
DIM c(14, 14)
FOR y = 0 TO 14
FOR x = 0 TO 14
c(x, y) = -7
NEXT x
NEXT y
SCREEN 12
DIM P%(16800)
OUT &H3C8, 0
FOR A = 0 TO 7
OUT &H3C9, SQR(A) * 23
OUT &H3C9, SQR(A) * 23
OUT &H3C9, SQR(A) * 23
NEXT A
PAL 63, 63, 0  'L YELLOW     8           1
PAL 30, 30, 0  'D YELLOW     9           2
PAL 0, 10, 63  'WATER        10          3
PAL 0, 20, 53  'WATER        11          4
PAL 53, 25, 10 'BROWN        12          5
PAL 0, 63, 0   'GREEN        13          6
PAL 0, 33, 0   'GREEN        14          7
PAL 53, 10, 0   'RED        15           8

FOR n = 0 TO 20
WINDOW SCREEN (0 - sx, 0 - sy)-(639 - sx, 479 - sy)
sx = (sx + 40): IF sx > 630 THEN sx = 0: sy = sy + 40
IF n = 0 OR n > 5 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
PSET (x, y), CINT(RND) * 14
NEXT x
NEXT y
END IF
IF n = 1 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
c = 0
IF y < 7 OR x < 7 THEN c = 1
IF x > 35 OR y > 35 THEN c = -1
PSET (x, y), 3 + 3 * RND + c
NEXT x
NEXT y
END IF
IF n = 2 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
c = 0
IF y < 7 OR x < 7 THEN c = 1
IF x > 35 OR y > 35 THEN c = -1
PSET (x, y), 2 + 4 * RND + c
NEXT x
NEXT y
FOR A = 0 TO 360 STEP 30
DRAW "TA=" + VARPTR$(A)
PSET (20, 21), 4: DRAW "BU5U5LE5"
PSET (21, 20), 2: DRAW "BU5U5LE5"
PSET (21, 21), 0: DRAW "BU5U5LE5"
PSET (20, 20), 7: DRAW "BU5U5LE5"
NEXT A
END IF
IF n = 3 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
PSET (x, y), 8 + CINT(RND) * 7 + RND
NEXT x
NEXT y
END IF
IF n = 4 OR n = 19 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
PSET (x, y), 10 + RND
NEXT x
NEXT y
END IF
IF n = 5 THEN
FOR y = 1 TO 40
FOR x = 1 TO 40
PSET (x, y), RND
IF RND > .6 THEN PSET (x, y), 12
NEXT x
NEXT y
END IF
IF n = 6 OR n = 7 THEN
FOR A = 0 TO 15
CIRCLE (20, 20), A, 7 - A \ 2
CIRCLE (21, 20), A, 7 - A \ 2
NEXT A
IF n = 6 THEN T$ = "E3U2H3U2E2"
IF n = 7 THEN T$ = "L1U3R2U2L2U3R1U3"
FOR A = -1 TO 1
FOR B = -1 TO 1
PSET (20 + A, 10 + B), 7: DRAW T$
PSET (20 + A, 11 + B), 4: DRAW T$
PSET (21 + A, 10 + B), 3: DRAW T$
PSET (21 + A, 11 + B), 0: DRAW T$
NEXT B
NEXT A
IF n = 6 THEN
    CIRCLE (20, 20), 1, 15
    CIRCLE (20, 20), 2, 10
    CIRCLE (21, 20), 1, 15
    CIRCLE (21, 20), 2, 10
END IF
END IF
IF n = 8 THEN
FOR A = 0 TO 7
LINE (10 + A, 1 + A)-(30 - A, 40 - A), A, BF
NEXT A
CIRCLE (25, 20), 1, 15
CIRCLE (25, 20), 2, 10
CIRCLE (26, 20), 1, 15
CIRCLE (26, 20), 2, 10
END IF
IF n = 9 THEN
T$ = "BU5F5G5H5E5U8L6R6U8L5"
FOR A = -1 TO 1
FOR B = -1 TO 1
PSET (20 + A, 35 + B), 0: DRAW T$
PSET (20 + A, 31 + B), 3: DRAW T$
PSET (21 + A, 31 + B), 7: DRAW T$
PSET (21 + A, 35 + B), 4: DRAW T$
NEXT B
NEXT A
END IF
IF n = 10 THEN
FOR A = 0 TO 7
LINE (5 + A, 30 - A)-(25 + A, 30 - A), A
LINE (15 + A, 10 - A)-(15 + A, 30 - A), A
LINE (25 - A, 10 - A)-(25 - A, 30 - A), A
LINE (15 + A, 30)-(15 + A, 40), A
LINE (25 - A, 30)-(25 - A, 40), A
NEXT A
END IF
IF n = 11 THEN
FOR A = -4 TO -2
FOR B = -1 TO 1
CIRCLE (20 + A, 20 + B), 15, 12, 4.71, 1.57, 1
LINE (20 + A, 5 + B)-(20 + A, 35 + B), 3 + A + B
LINE (15 + A, 20 + B)-(40 + A, 20 + B), 3 + A + B
NEXT B
NEXT A
END IF
IF n = 12 THEN
FOR AN = 0 TO 360 STEP 10
DRAW "TA=" + VARPTR$(AN)
x = 4 * RND - 2
y = 4 * RND - 2
PSET (20 + x, 20 + y), 7: DRAW "U5E5U5"
PSET (20 + x, 21 + y), 3: DRAW "U5E5U5"
PSET (21 + x, 21 + y), 0: DRAW "U5E5U5"
PSET (21 + x, 20 + y), 2: DRAW "U5E5U5"
NEXT AN
END IF
IF n = 13 THEN
FOR A = 0 TO 7
LINE (14 + A, 10 - A * 2)-(20 - A, 30 - A), A
LINE (26 - A, 10 - A * 2)-(20 + A, 30 - A), A
LINE (14 + A, 10)-(14 + A, 40), A
LINE (26 - A, 10)-(26 - A, 40), A
NEXT A
END IF
IF n > 13 THEN
FOR y = 1 TO 13
FOR x = 1 TO 13
READ c
IF c = 0 THEN c = -7
IF n = 20 AND c = 5 THEN c = -6
IF n = 20 AND c = 8 THEN c = 1 + RND
c(x, y) = c
NEXT x
NEXT y
FOR y = 1 TO 13
FOR x = 1 TO 13
bx = x * 3 - 1
by = y * 3 - 1
IF c(x, y) > -7 THEN
PSET (bx, by), c(x, y) + 7
PSET (bx + 1, by - 1), c(x, y) + 7
PSET (bx + 1, by + 1), c(x, y) + 7
PSET (bx - 1, by - 1), c(x, y) + 7
PSET (bx - 1, by + 1), c(x, y) + 7
PSET (bx + 1, by), c(x + 1, y) + 7
PSET (bx - 1, by), c(x - 1, y) + 7
PSET (bx, by + 1), c(x, y + 1) + 7
PSET (bx, by - 1), c(x, y - 1) + 7
END IF
NEXT x
NEXT y


END IF
GET (1, 1)-(40, 40), P%(n * 800)
NEXT n
DEF SEG = VARSEG(P%(0))
BSAVE "BANANA.PIC", 0, VARPTR(P%(16800))

DATA 0,0,0,1,1,1,2,0,0,0,0,0,0
DATA 0,0,0,1,3,4,1,2,0,0,0,0,0
DATA 0,0,0,0,4,3,1,1,2,0,0,0,0
DATA 0,0,0,0,0,1,1,1,2,2,6,6,6
DATA 0,0,0,0,6,6,1,1,1,2,2,7,6
DATA 0,0,6,6,7,7,0,1,1,2,2,0,7
DATA 0,0,7,7,0,0,0,1,1,2,2,0,0
DATA 0,0,0,0,0,0,1,1,1,2,2,0,0
DATA 0,0,0,0,0,1,1,1,2,2,0,0,0
DATA 0,6,6,6,6,1,1,2,2,0,0,0,0
DATA 6,7,7,7,1,1,2,2,6,6,0,0,0
DATA 7,0,1,1,1,2,2,7,7,7,6,0,0
DATA 7,0,1,1,2,0,0,0,0,7,6,0,0

DATA 0,0,0,4,3,8,7,8,3,4,0,0,0
DATA 0,0,0,0,4,8,6,8,4,0,0,0,0
DATA 0,0,0,0,8,8,8,8,8,0,0,0,0
DATA 0,0,0,0,8,3,5,3,7,0,0,0,0
DATA 0,0,0,0,8,5,5,5,7,0,0,0,0
DATA 0,0,0,0,0,7,7,7,0,0,0,0,0
DATA 0,0,0,0,0,7,6,7,0,0,0,0,0
DATA 7,7,7,7,7,6,8,6,7,7,7,7,7
DATA 6,6,6,6,6,8,5,5,6,6,6,6,6
DATA 0,0,0,0,8,8,3,8,5,0,0,0,0
DATA 0,0,0,0,8,3,8,3,5,0,0,0,0
DATA 0,0,7,7,7,8,0,8,7,7,7,0,0
DATA 0,0,6,6,6,0,0,0,6,6,6,0,0

DATA 0,0,1,0,0,1,0,1,0,0,1,0,0
DATA 0,0,0,1,0,1,0,1,0,1,0,0,0
DATA 0,0,0,0,1,8,2,8,1,0,0,0,0
DATA 0,3,3,0,0,2,2,2,0,0,3,3,0
DATA 4,4,4,3,3,0,2,0,3,3,4,4,4
DATA 0,0,0,4,4,4,4,4,4,4,0,0,0
DATA 0,0,0,0,0,3,4,4,0,0,0,0,0
DATA 0,0,0,0,0,3,4,4,0,0,0,0,0
DATA 0,0,0,0,0,3,4,4,0,0,0,0,0
DATA 0,0,0,0,0,3,4,4,0,0,0,0,0
DATA 0,0,0,0,3,4,0,3,4,0,0,0,0
DATA 0,0,0,3,4,0,0,0,3,4,0,0,0
DATA 0,0,0,3,4,0,0,0,3,4,0,0,0

DATA 0,0,0,0,5,5,5,5,5,0,0,0,0
DATA 0,0,0,5,5,5,5,5,5,5,0,0,0
DATA 0,0,0,5,2,3,3,3,2,5,0,0,0
DATA 0,6,6,0,2,2,2,2,2,0,6,6,0
DATA 4,4,4,6,6,2,2,2,6,6,4,4,4
DATA 0,0,0,4,4,4,4,4,4,4,0,0,0
DATA 0,0,0,0,0,6,4,4,0,0,0,0,0
DATA 0,0,0,0,0,6,4,4,0,0,0,0,0
DATA 0,0,0,0,0,6,4,4,0,0,0,0,0
DATA 0,0,0,0,0,6,4,4,0,0,0,0,0
DATA 0,0,0,0,6,4,0,6,4,0,0,0,0
DATA 0,0,0,6,4,0,0,0,6,4,0,0,0
DATA 0,0,0,6,4,0,0,0,6,4,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,1,0,1,1,1,0,1,0,0,0
DATA 0,0,0,1,1,8,2,8,1,1,0,0,0
DATA 0,0,0,0,8,2,2,2,8,0,0,0,0
DATA 3,8,3,0,0,8,8,8,0,0,3,8,3
DATA 8,4,8,3,3,8,4,4,3,3,8,4,8
DATA 0,0,0,8,4,3,8,8,4,4,0,0,0
DATA 0,0,0,0,0,8,4,8,0,0,0,0,0
DATA 0,0,0,0,0,3,8,4,0,0,0,0,0
DATA 0,0,0,0,0,8,8,4,0,0,0,0,0
DATA 0,0,0,0,8,4,0,8,4,0,0,0,0
DATA 0,0,0,3,8,0,0,0,3,8,0,0,0
DATA 0,0,0,8,4,0,0,0,8,4,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0
DATA 2,1,0,0,0,0,0,0,0,0,0,0,0
DATA 2,8,1,0,0,1,1,1,1,6,7,0,0
DATA 8,2,2,8,1,8,2,2,8,7,6,0,0
DATA 0,2,2,8,2,8,2,8,2,2,8,1,0
DATA 0,0,8,2,8,2,2,8,2,2,8,2,0
DATA 0,0,8,2,8,2,2,8,2,2,8,2,0
DATA 0,8,2,8,8,2,8,2,2,8,2,0,0
DATA 1,2,8,0,0,2,8,2,2,8,0,0,0
DATA 2,2,0,0,0,0,0,0,0,0,0,0,0
DATA 2,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,8,5,0
DATA 0,0,0,0,0,0,0,0,8,5,8,5,8
DATA 0,0,0,0,0,0,0,5,8,5,8,5,8
DATA 0,5,8,5,8,5,8,5,8,5,8,5,0
DATA 8,0,8,5,8,5,8,5,8,5,8,0,0
DATA 0,0,8,5,8,5,8,5,8,5,8,0,0
DATA 0,5,8,5,8,5,8,5,8,5,8,0,0
DATA 8,5,5,0,0,0,0,0,0,5,8,0,0
DATA 8,5,0,0,0,0,0,0,0,5,8,0,0
DATA 8,5,0,0,0,0,0,0,0,5,8,0,0
DATA 8,5,8,0,0,0,0,0,0,5,8,5,0
DATA 8,5,8,5,0,0,0,0,0,5,8,5,8

SUB PAL (R, G, B)
OUT &H3C9, R
OUT &H3C9, G
OUT &H3C9, B

END SUB

