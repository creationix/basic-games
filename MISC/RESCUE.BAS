DECLARE SUB explosion (x%, y%)
DEFINT A-Z
TYPE coord
    r AS INTEGER
    d AS INTEGER
    x AS INTEGER
    y AS INTEGER
    real AS INTEGER
END TYPE
DIM bul(20) AS coord
DIM copt1(800), copt2(800), copt3(800)
SCREEN 7
LINE (20, 1)-(20, 20), 9, BF
LINE (19, 1)-(19, 20), 1, BF
LINE (21, 1)-(21, 20), 1, BF
LINE (0, 1)-(40, 1), 15
LINE (0, 2)-(40, 2), 7
LINE (0, 3)-(40, 3), 8
LINE (20, 10)-(35, 17), 14, B
LINE (3, 12)-(25, 20), 14, B
LINE (21, 11)-(34, 16), 6, BF
LINE (4, 13)-(24, 19), 6, BF
PSET (20, 10)
DRAW "d15l5u5d5r5c15l10h2f2r20e2"
GET (1, 1)-(40, 20), copt1
CLS
LINE (20, 1)-(20, 20), 9, BF
LINE (19, 1)-(19, 20), 1, BF
LINE (21, 1)-(21, 20), 1, BF
LINE (10, 1)-(30, 1), 15
LINE (10, 2)-(30, 2), 7
LINE (10, 3)-(30, 3), 8
LINE (20, 10)-(35, 17), 14, B
LINE (3, 12)-(25, 20), 14, B
LINE (21, 11)-(34, 16), 6, BF
LINE (4, 13)-(24, 19), 6, BF
PSET (20, 10)
DRAW "r15l5u5d5r5c15l10h2f2r20e2"
GET (1, 1)-(40, 20), copt2
CLS
LINE (20, 1)-(20, 20), 9, BF
LINE (19, 1)-(19, 20), 1, BF
LINE (21, 1)-(21, 20), 1, BF
LINE (19, 1)-(21, 1), 15
LINE (19, 2)-(21, 2), 7
LINE (19, 3)-(21, 3), 8
LINE (20, 10)-(35, 17), 14, B
LINE (3, 12)-(25, 20), 14, B
LINE (21, 11)-(34, 16), 6, BF
LINE (4, 13)-(24, 19), 6, BF
PSET (20, 10)
DRAW "d15l5u5d5r5c15l10h2f2r20e2"
GET (1, 1)-(40, 20), copt3

sc = 1
stx = 140: sty = 4
DO
IF osc <> sc THEN
    IF sc < 1 THEN sc = 3
    IF sc > 3 THEN sc = 1
    CLS
    SELECT CASE sc
    CASE 1: RESTORE scren1
    CASE 2: RESTORE scren2
    CASE 3: RESTORE scren3
    END SELECT
    stx = x: sty = y
    FOR y = 0 TO 9
        FOR x = 0 TO 15
            READ l
            IF l > 0 AND l < 9 THEN
                LINE (x * 20, y * 20)-(x * 20 + 19, y * 20 + 19), l + 8, BF
                LINE (x * 20 + 5, y * 20 + 5)-(x * 20 + 15, y * 20 + 15), 7, BF
                LINE (x * 20 + 5, y * 20 + 5)-(x * 20 + 5, y * 20 + 15), 8, BF
                LINE (x * 20 + 5, y * 20 + 5)-(x * 20 + 15, y * 20 + 5), 8, BF
                LINE (x * 20 + 15, y * 20 + 5)-(x * 20 + 15, y * 20 + 15), 15, BF
                LINE (x * 20 + 5, y * 20 + 15)-(x * 20 + 15, y * 20 + 15), 15, BF
            END IF
            IF l = 10 THEN
                LINE (x * 20, y * 20 + 10)-(x * 20 + 19, y * 20 + 19), l + 8, BF
            END IF
        NEXT x
    NEXT y
    x = stx: y = sty
    ox = x: oy = y
END IF
osc = sc
a$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
IF a$ = CHR$(0) + CHR$(72) THEN d = d - 1
IF a$ = CHR$(0) + CHR$(80) THEN d = d + 1
IF a$ = CHR$(0) + CHR$(75) THEN r = r - 1: dr = -1
IF a$ = CHR$(0) + CHR$(77) THEN r = r + 1: dr = 1
IF a$ = " " THEN
    GOSUB freebomb
    bul(a).real = 1
    bul(a).x = x + dr * 30 + 20
    bul(a).y = y + 15
    bul(a).r = dr * 10 + r
    bul(a).d = d
END IF
ox = x: oy = y
x = x + r: y = y + d
IF y < 0 THEN y = 0: d = 0
IF x < 0 THEN x = 279: sc = sc - 1
IF x > 279 THEN x = 0: sc = sc + 1
IF y > 179 THEN y = 179: d = 0
IF t = 0 THEN PUT (ox, oy), copt1%
IF t = 1 THEN PUT (ox, oy), copt2%
IF t = 2 THEN PUT (ox, oy), copt3%
IF t = 3 THEN PUT (ox, oy), copt2%
IF shield = 0 THEN
IF POINT(x + 5, y + 1) > 0 THEN explosion x, y
IF POINT(x + 35, y + 1) > 0 THEN explosion x, y
IF POINT(x + 3, y + 19) > 0 THEN explosion x, y
IF POINT(x + 34, y + 16) > 0 THEN explosion x, y
END IF
t = (t + 1) MOD 4
IF t = 0 THEN PUT (x, y), copt1%, OR
IF t = 1 THEN PUT (x, y), copt2%, OR
IF t = 2 THEN PUT (x, y), copt3%, OR
IF t = 3 THEN PUT (x, y), copt2%, OR
FOR a = 1 TO 1000: NEXT a

FOR a = 1 TO 5
    SOUND 100 + a * 20 + ABS(r) * 10 + ABS(d) * 10, .1
NEXT a
FOR a = 1 TO 20
    IF bul(a).real THEN
        IF bul(a).real = 2 THEN PSET (bul(a).x, bul(a).y), POINT(bul(a).x, bul(a).y) XOR 15
        IF bul(a).real = 1 THEN bul(a).real = 2
        bul(a).x = bul(a).x + bul(a).r / 2
        bul(a).y = bul(a).y + bul(a).d / 2
        bul(a).d = bul(a).d + 1
        IF POINT(bul(a).x, bul(a).y) <> 0 THEN bul(a).real = -1
        IF bul(a).real > 0 THEN PSET (bul(a).x, bul(a).y), POINT(bul(a).x, bul(a).y) XOR 15
        IF bul(a).real = -1 THEN
            bul(a).real = 0
            FOR rd = 0 TO 5
            CIRCLE (bul(a).x, bul(a).y), rd, 14
            CIRCLE (bul(a).x + 1, bul(a).y), rd, 12
            CIRCLE (bul(a).x, bul(a).y), rd, 0
            CIRCLE (bul(a).x + 1, bul(a).y), rd, 0
            SOUND 37 + rd * 10, .2
            NEXT rd
            FOR sy = bul(a).y - 5 TO bul(a).y + 5
            FOR sx = bul(a).x - 5 TO bul(a).x + 5
                IF POINT(sx, sy - 1) > 0 AND POINT(sx, sy) = 0 THEN PSET (sx, sy - 1), 8
                IF POINT(sx - 1, sy) > 0 AND POINT(sx, sy) = 0 THEN PSET (sx - 1, sy), 7
            NEXT sx
            NEXT sy
        END IF
    END IF
NEXT a
LOOP

freebomb:
f = 0
FOR a = 1 TO 20
IF bul(a).real = 0 THEN f = a
NEXT a
a = f
RETURN

scren1:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 3,3,3,3,0,0,0,1,1,0,0,5,5,5,5,5
DATA 3,3,3,3,0,0,0,1,1,0,0,5,5,5,5,5
DATA 3,3,3,3,2,2,2,1,1,0,0,0,0,0,5,5
DATA 3,3,3,3,2,2,2,1,1,0,0,0,0,0,5,5
DATA 3,3,3,3,2,2,2,1,1,0,0,0,0,5,5,5
DATA 3,3,3,3,2,2,2,1,1,0,0,0,0,5,5,5
DATA 3,3,3,3,2,2,2,1,1,0,0,0,0,5,5,5
scren2:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 4,4,4,4,4,4,4,0,0,0,4,4,4,4,4,4
DATA 4,4,4,4,4,4,4,0,0,0,4,4,4,4,4,4
DATA 4,4,0,0,0,0,0,0,0,0,0,0,4,4,4,4
DATA 4,4,0,0,0,0,0,0,0,0,0,0,4,4,4,4
DATA 4,4,4,4,4,0,0,10,10,10,0,0,4,4,4,4
DATA 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
DATA 4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4
scren3:
DATA 0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,8,8,0,0,0,0,0,0,0
DATA 0,0,0,0,8,8,8,8,8,8,8,8,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5
DATA 5,0,0,8,8,0,0,0,0,0,0,0,0,0,5,5
DATA 5,5,0,8,8,0,0,8,8,0,0,0,0,5,5,5
DATA 5,5,5,8,8,0,0,8,8,0,0,0,5,5,5,5
scren4:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SUB explosion (x, y)
EXIT SUB
FOR a = 1 TO 25
CIRCLE (x + 20, y + 10), a, 12, , , 1 / 2
NEXT a
FOR a = 1 TO 25
CIRCLE (x + 20, y + 10), a, 14, , , 2 / 1
NEXT a
FOR a = 50 TO 1 STEP -1
CIRCLE (x + 20, y + 10), a, 0, , , 1 / 2
NEXT a
FOR a = 20 TO 1 STEP -1
CIRCLE (x + 20, y + 10), a, 0, , , 2 / 1
NEXT a
END SUB

