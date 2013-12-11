DECLARE SUB BLOWUP (X%, y%)
DECLARE SUB BLOWUPA (X%, y%)
DECLARE SUB Fixit (gx%, gy%, C%, DI%)
DECLARE SUB RowFall (gy%)
DECLARE FUNCTION Canput% (X%, y%, C%, DI%)
DECLARE SUB pbloc (X%, y%)
DEFINT A-Y
DECLARE SUB DRAWIT ()
DECLARE SUB Piece (X, y%, C%, DI%)
SCREEN 7
CONST pn = 12
CONST MX = 20
CONST MY = 20
DIM SHARED p$(pn)
DIM SHARED L(32, MY)
RANDOMIZE (TIMER)
FOR a = 1 TO pn
READ p$(a)
NEXT a
DATA "*L*RD*R*"
DATA "*R*LD*L*"
DATA "*L*RR*D*"
DATA "*R*LL*D*"
DATA "*L*RR*LU*"
DATA "*L*RR*R*"
DATA "*D*L*U*"
DATA "*"
DATA "*L*RU*DR*LD*"
DATA "*L*U*DRR*U*"
DATA "*L*U*DRD*UR*"
DATA *R*U*DLD*UL*"
CALL DRAWIT
died = 0
ns = INT(pn * RND + 1)
DO
X = MX / 2 * RND + MX / 4
y = 1
DI = 0
G = 2
LOCATE 1, 31: COLOR 15: PRINT "Tetris"
LOCATE 3, 31: COLOR 9: PRINT "Score"; STR$(PT)
LOCATE 4, 31: COLOR 12: PRINT "Level"; level + 1
os = ns
ns = INT(pn * RND + 1)
LINE (21 * 10 - 10, 5 * 10 - 10)-(30 * 10 - 1, 15 * 10 - 1), 0, BF
Piece 26, 10, ns, 1
S = os
DO
IF G > 1 THEN G = 10 - level
ox = X: oy = y: ODI = DI
a$ = INKEY$
'DO: LOOP WHILE INKEY$ <> ""
IF a$ = "2" THEN G = 0
IF a$ = "1" OR a$ = " " THEN DI = (DI + 1) MOD 4
IF a$ = "3" OR a$ = "8" THEN DI = DI - 1: IF DI = -1 THEN DI = 3
IF a$ = "4" THEN X = X - 1: G = 2
IF a$ = "6" THEN X = X + 1: G = 2
IF X = ox THEN y = y + 1
Fixit ox, oy, S, ODI
IF Canput(X, y, S, DI) = 0 THEN X = ox: y = oy: DI = ODI
Piece X, y, S, DI
DO: LOOP WHILE TIMER - zme < G / 30
zme = TIMER
SOUND 2000, .1: SOUND 1000, .1
LOOP WHILE X <> ox OR y <> oy OR a$ <> ""
FOR sy = 3 TO MY
r = 1
FOR sX = 1 TO MX
IF L(sX, sy) = 0 THEN sX = MX: r = 0
NEXT sX
IF r = 1 THEN RowFall sy: PT = PT + 50: rw = rw + 1: IF rw > 4 THEN level = level + 1: rw = 0: PT = PT + 150
NEXT sy
IF S = 8 THEN BLOWUP X, y: y = 2
IF S = 9 THEN BLOWUPA X, y: y = 2
FOR sy = 3 TO MY
r = 1
FOR sX = 1 TO MX
IF L(sX, sy) = 0 THEN sX = MX: r = 0
NEXT sX
IF r = 1 THEN RowFall sy: PT = PT + 50: rw = rw + 1: IF rw > 4 THEN level = level + 1: rw = 0: PT = PT + 150
NEXT sy
CALL DRAWIT
IF y = 1 THEN died = 1
PT = PT + 10
LOOP WHILE died = 0

SUB BLOWUP (X, y)
FOR r = 0 TO 5
FOR a = -r TO r
px = X + a
py = y - r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN IF L(px, py) = 0 THEN L(px, py) = 8: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + a
py = y + r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN IF L(px, py) = 0 THEN L(px, py) = 8: pbloc px, py
NEXT a
FOR a = -r TO r
px = X - r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN IF L(px, py) = 0 THEN L(px, py) = 8: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN IF L(px, py) = 0 THEN L(px, py) = 8: pbloc px, py
NEXT a
SOUND 400 + 5 * r, .1
SOUND 300 + 8 * r, .1
SOUND 200 + 10 * r, .1
SOUND 100 + 13 * r, .1
NEXT r
SOUND 100, 0
END SUB

SUB BLOWUPA (X, y)
FOR r = 0 TO 3
FOR a = -r TO r
px = X + a
py = y - r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 3: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + a
py = y + r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 3: pbloc px, py
NEXT a
FOR a = -r TO r
px = X - r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 3: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 3: pbloc px, py
NEXT a
SOUND 400 + 5 * r, .1
SOUND 300 + 8 * r, .1
SOUND 200 + 10 * r, .1
SOUND 100 + 13 * r, .1
NEXT r
FOR r = 0 TO 3
FOR a = -r TO r
px = X + a
py = y - r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 0: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + a
py = y + r
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 0: pbloc px, py
NEXT a
FOR a = -r TO r
px = X - r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 0: pbloc px, py
NEXT a
FOR a = -r TO r
px = X + r
py = y + a
IF px >= 1 AND py >= 1 AND px <= MX AND py <= MY THEN L(px, py) = 0: pbloc px, py
NEXT a
SOUND 400 + 5 * r, .1
SOUND 300 + 8 * r, .1
SOUND 200 + 10 * r, .1
SOUND 100 + 13 * r, .1
NEXT r
SOUND 100, 0

END SUB

DEFINT Z
FUNCTION Canput (gx, gy, gc, DI)
X = gx: y = gy: C = gc
cn = 1
C$ = p$(C)
FOR a = 1 TO LEN(C$)
a$ = MID$(C$, a, 1)
IF a$ = "*" THEN
IF X < 1 OR y < 1 OR X > MX OR y > MY THEN cn = 0 ELSE IF L(X, y) <> 0 THEN cn = 0
ELSE
IF a$ = "U" THEN d = 0
IF a$ = "R" THEN d = 1
IF a$ = "D" THEN d = 2
IF a$ = "L" THEN d = 3
d = (d + DI) MOD 4
IF d = 0 THEN y = y - 1
IF d = 1 THEN X = X + 1
IF d = 2 THEN y = y + 1
IF d = 3 THEN X = X - 1
END IF
NEXT a
Canput = cn
END FUNCTION

SUB DRAWIT
FOR y = 1 TO MY
FOR X = 1 TO MX
pbloc X, y
NEXT X
NEXT y
END SUB

SUB Fixit (gx, gy, C, DI)
X = gx: y = gy
C$ = p$(C)
FOR a = 1 TO LEN(C$)
a$ = MID$(C$, a, 1)
IF a$ = "*" THEN
L(X, y) = 0: pbloc X, y
ELSE
d = 0
IF a$ = "U" THEN d = 0
IF a$ = "R" THEN d = 1
IF a$ = "D" THEN d = 2
IF a$ = "L" THEN d = 3
d = (d + DI) MOD 4
IF d = 0 THEN y = y - 1
IF d = 1 THEN X = X + 1
IF d = 2 THEN y = y + 1
IF d = 3 THEN X = X - 1
END IF
NEXT a
END SUB

SUB pbloc (X, y)
G = L(X, y)
C = G
IF G = 1 THEN C = 5
IF G = 2 THEN C = 1
IF G = 3 THEN C = 4
IF G = 4 THEN C = 3
IF G = 5 THEN C = 2
IF G = 6 THEN C = 6
IF G = 7 THEN C = 7
IF C = 0 THEN LINE (X * 10 - 10, y * 10 - 10)-(X * 10 - 1, y * 10 - 1), 7, BF: LINE (X * 10 - 5, y * 10 - 10)-(X * 10 - 5, y * 10 - 1), 15: LINE (X * 10 - 6, y * 10 - 10)-(X * 10 - 6, y * 10 - 1), 8: GOTO skip
IF G = 8 THEN C = 0
IF G = 9 THEN C = 0
LINE (X * 10 - 10, y * 10 - 10)-(X * 10 - 1, y * 10 - 1), C + 8, BF
LINE (X * 10 - 10, y * 10 - 10)-(X * 10 - 1, y * 10 - 1), C, B
LINE (X * 10 - 10, y * 10 - 10)-(X * 10 - 1, y * 10 - 10), 15
LINE (X * 10 - 10, y * 10 - 10)-(X * 10 - 10, y * 10 - 1), 15
skip:
END SUB

SUB Piece (gx, gy, gc, DI)
X = gx: y = gy: C = gc
C$ = p$(C)
FOR a = 1 TO LEN(C$)
a$ = MID$(C$, a, 1)
IF a$ = "*" THEN
L(X, y) = C: pbloc X, y
ELSE
d = 0
IF a$ = "U" THEN d = 0
IF a$ = "R" THEN d = 1
IF a$ = "D" THEN d = 2
IF a$ = "L" THEN d = 3
d = (d + DI) MOD 4
IF d = 0 THEN y = y - 1
IF d = 1 THEN X = X + 1
IF d = 2 THEN y = y + 1
IF d = 3 THEN X = X - 1
END IF
NEXT a
END SUB

SUB RowFall (gy)
FOR y = gy - 1 TO 1 STEP -1
FOR X = 1 TO MX
L(X, y + 1) = L(X, y): L(X, y) = 0
NEXT X
SOUND 100 + a * 10, .1: SOUND 37 + (ABS(1000 - t * 30)), .1
NEXT y
FOR a = 1 TO 10: SOUND 100 + a * 10, .1: SOUND 200 + a * 5, .1: NEXT a
END SUB

