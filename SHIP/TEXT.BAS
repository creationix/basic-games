DECLARE SUB font (x%, y%, t$(), txt$, pt%, c%)


DEFINT A-Z
DIM t$(127)
OPEN "font1.fon" FOR INPUT AS #1
FOR a = 0 TO 127
INPUT #1, t$(a)
NEXT a
CLOSE #1
CLS

SCREEN 8
LINE (0, 0)-(640, 480), 3, BF
t$ = "TEXT in DIFFERENT COLORS And SIZES is fun!"
font 0, 0, t$(), t$, 8, 12
font 0, 30, t$(), t$, 5, 11
font 0, 50, t$(), t$, 4, 15
font 0, 70, t$(), t$, 3, 9
font 0, 90, t$(), t$, 2, 10
font 0, 100, t$(), t$, 1, 10
SLEEP: CLS
LINE (0, 0)-(640, 480), 4, BF
FOR a = 1 TO 100
font 640 * RND - 40, 200 * RND, t$(), "Tim's Text", INT(18 * RND + 1), INT(9 + 5 * RND)
NEXT a
SLEEP

SUB font (x, y, t$(), txt$, pt, c)
sz = pt * 4: sp = pt * 3 + 2
DRAW "S=" + VARPTR$(sz)
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
sh = 2
IF pt < 3 THEN sh = 1
PSET (x - 1 + r * sp - sp, y + sp - 1), cb: DRAW "c0" + t$(L)
PSET (x + sh + r * sp - sp, y + sp - 1), cb: DRAW "c0" + t$(L)
PSET (x + sh + r * sp - sp, y + sp + sh), cb: DRAW "c0" + t$(L)
PSET (x - 1 + r * sp - sp, y + sp + sh), cb: DRAW "c0" + t$(L)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c0" + t$(L)
PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c0" + t$(L)
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c0" + t$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c0" + t$(L)
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(c) + t$(L)
IF pt > 1 THEN
PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(c) + t$(L)
IF pt > 2 THEN
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(c) + t$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(c) + t$(L)
END IF
END IF
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
END SUB

