SCREEN 1
DEFINT A-Z
DIM a%(200)
CIRCLE (10, 10), 6, 11
CIRCLE (10, 4), 3, 11
LINE (7, 12)-(9, 20), 11, B
LINE (13, 12)-(11, 20), 11, B
GET (1, 1)-(20, 20), a%
CLS
LINE (0, 0)-(320, 200), 3, BF
sx = 160 - 16
FOR a = 1 TO 200 STEP 3
LINE (sx + 16 * RND, a)-(sx + 16 + 16 * RND, a + 1), 8, B
NEXT a
RANDOMIZE (TIMER)
DIM l(9, 5, 3)
FOR y = 1 TO 5
FOR x = 1 TO 9
IF x <> 5 AND y <> 3 AND RND > .8 THEN l(x, y, 1) = INT(3 * RND) + 1: 'mountains
IF x <> 5 AND y <> 3 AND RND > .999 THEN l(x, y, 1) = INT(5 * RND) + 1: 'mountains
IF x = 5 AND y <> 3 THEN l(x, y, 1) = 10: 'River
IF x = 5 AND y = 3 THEN l(x, y, 0) = 8: 'store
IF x <> 5 AND y <> 3 THEN IF RND > .5 THEN l(x, y, 0) = CINT(4 * RND) + 1
IF l(x, y, 0) > 0 AND l(x, y, 0) < 8 THEN l(x, y, 2) = INT(5 * RND)
IF l(x, y, 0) > 0 AND l(x, y, 0) < 8 THEN l(x, y, 3) = INT(4 * RND) + 1
NEXT x
NEXT y
FOR x = 1 TO 9
FOR y = 1 TO 5
GOSUB BOX
NEXT y
NEXT x
d = 1
DO
a$ = INKEY$
IF a$ = "q" THEN CHDIR "\tim": RUN "Tim.bas"
ox = x: oy = y
IF a$ = "8" THEN y = y - 2
IF a$ = "2" THEN y = y + 2
IF a$ = "4" THEN x = x - 2
IF a$ = "6" THEN x = x + 2
IF a$ = "7" THEN y = y - 1: x = x - 1
IF a$ = "9" THEN y = y - 1: x = x + 1
IF a$ = "1" THEN y = y + 1: x = x - 1
IF a$ = "3" THEN y = y + 1: x = x + 1
IF x < 0 THEN x = 0
IF y < 0 THEN y = 0
IF x > 299 THEN x = 299
IF y > 179 THEN y = 179
IF ox <> x OR oy <> y THEN
IF d = 0 THEN PUT (ox, oy), a%
PUT (x, y), a%
END IF
d = 0
LOOP
BOX:
c = l(x, y, 0)
mn = l(x, y, 1)
s = l(x, y, 2)
p = l(x, y, 3)
sx = x * 32 - 16
sy = y * 32 - 16
LINE (sx, sy)-(sx + 31, sy + 31), 3, BF
IF mn = 10 THEN
FOR a = sy TO sy + 31 STEP 3
LINE (sx + 16 * RND, a)-(sx + 16 + 16 * RND, a + 1), 0, B
NEXT a
mn = 0
END IF
FOR a = 1 TO mn
mx = x * 32 + 20 * RND - 10
my = y * 32 + 20 * RND - 10
LINE (mx - 1, my - 2)-(mx + 1, my + 2), 0, BF
FOR B = 1 - 2 * RND TO 3 + 2 * RND
LINE (mx - B * 2, my + B)-(mx + B * 2, my + B), CINT(RND) * 0
NEXT B
NEXT a
IF c > 0 THEN
IF c <> 8 THEN
c = 2
IF c = 11 THEN c = 14
FOR a = 1 TO 2
LINE (sx + a, sy + a)-(sx + 32 - a, sy + 32 - a), c - (a - 1) * 8, B
NEXT a
IF s = 0 THEN
p = 0
LINE (sx + 16, sy + 14)-(sx + 20, sy + 18), c, B
LINE (sx + 15, sy + 14)-(sx + 21, sy + 14), c, B
LINE (sx + 17, sy + 13)-(sx + 19, sy + 13), c, B
END IF
IF s = 1 THEN
LINE (sx + 21, sy + 13)-(sx + 23, sy + 20), c, BF
FOR a = 1 TO 6
LINE (sx + 16 + a, sy + 9 + a)-(sx + 18 + a, sy + 8 + a), c
NEXT a
LINE (sx + 22, sy + 9)-(sx + 24, sy + 10), c, BF
LINE (sx + 20, sy + 20)-(sx + 24, sy + 20), c
END IF
IF s = 2 THEN
LINE (sx + 21, sy + 10)-(sx + 23, sy + 20), c, BF
LINE (sx + 16, sy + 12)-(sx + 19, sy + 12), c
LINE (sx + 16, sy + 14)-(sx + 25, sy + 14), c
LINE (sx + 16, sy + 16)-(sx + 19, sy + 16), c
LINE (sx + 19, sy + 12)-(sx + 19, sy + 16), c
LINE (sx + 19, sy + 22)-(sx + 22, sy + 22), c
LINE (sx + 24, sy + 20)-(sx + 22, sy + 22), c
LINE (sx + 25, sy + 20)-(sx + 26, sy + 22), c, BF
END IF
IF s = 3 THEN
LINE (sx + 17, sy + 16)-(sx + 26, sy + 16), c
LINE (sx + 24, sy + 14)-(sx + 24, sy + 18), c
LINE (sx + 24, sy + 14)-(sx + 26, sy + 16), c
LINE (sx + 26, sy + 16)-(sx + 24, sy + 18), c
LINE (sx + 18, sy + 10)-(sx + 23, sy + 10), c
LINE (sx + 20, sy + 10)-(sx + 21, sy + 20), c, BF
END IF
IF s = 4 THEN
LINE (sx + 17, sy + 13)-(sx + 26, sy + 13), c
LINE (sx + 24, sy + 11)-(sx + 24, sy + 15), c
LINE (sx + 24, sy + 11)-(sx + 26, sy + 13), c
LINE (sx + 26, sy + 13)-(sx + 24, sy + 15), c
LINE (sx + 17, sy + 18)-(sx + 26, sy + 18), c
LINE (sx + 19, sy + 16)-(sx + 19, sy + 20), c
LINE (sx + 19, sy + 16)-(sx + 17, sy + 18), c
LINE (sx + 17, sy + 18)-(sx + 19, sy + 20), c
END IF
FOR a = 0 TO 1
IF p = 1 THEN CIRCLE (sx + 22, sy + 26), a, c
IF p = 2 THEN
CIRCLE (sx + 20, sy + 24), a, c
CIRCLE (sx + 24, sy + 24), a, c
END IF
IF p = 3 THEN
CIRCLE (sx + 20, sy + 24), a, c
CIRCLE (sx + 24, sy + 24), a, c
CIRCLE (sx + 22, sy + 28), a, c
END IF
IF p = 4 THEN
CIRCLE (sx + 20, sy + 24), a, c
CIRCLE (sx + 24, sy + 24), a, c
CIRCLE (sx + 20, sy + 28), a, c
CIRCLE (sx + 24, sy + 28), a, c
END IF
NEXT a
ELSE
LINE (sx, sy)-(sx + 31, sy + 31), 0, BF
LINE (sx + 4, sy + 4)-(sx + 8, sy + 8), 1, BF
LINE (sx + 12, sy + 4)-(sx + 18, sy + 8), 1, BF
LINE (sx + 24, sy + 4)-(sx + 28, sy + 8), 1, BF
LINE (sx + 4, sy + 16)-(sx + 8, sy + 26), 1, BF
LINE (sx + 12, sy + 16)-(sx + 16, sy + 22), 1, BF
LINE (sx + 20, sy + 16)-(sx + 28, sy + 28), 1, BF
END IF
END IF
RETURN

