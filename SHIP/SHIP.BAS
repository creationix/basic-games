DECLARE SUB font (x%, y%, T$(), txt$, pt%, c%)
DECLARE SUB init (T$())

DEFINT A-Z

DIM T$(127)

CALL init(T$())


SUB font (x, y, T$(), txt$, pt, c)
sz = pt * 4: sp = pt * 3 + 2
DRAW "S=" + VARPTR$(sz)
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
sh = 2
IF pt < 3 THEN sh = 1
PSET (x - 1 + r * sp - sp, y + sp - 1), cb: DRAW "c0" + T$(L)
PSET (x + sh + r * sp - sp, y + sp - 1), cb: DRAW "c0" + T$(L)
PSET (x + sh + r * sp - sp, y + sp + sh), cb: DRAW "c0" + T$(L)
PSET (x - 1 + r * sp - sp, y + sp + sh), cb: DRAW "c0" + T$(L)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c0" + T$(L)
PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c0" + T$(L)
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c0" + T$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c0" + T$(L)
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(c) + T$(L)
IF pt > 1 THEN
PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(c) + T$(L)
IF pt > 2 THEN
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(c) + T$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(c) + T$(L)
END IF
END IF
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
END SUB

SUB init (T$())
SCREEN 8
OPEN "font1.fon" FOR INPUT AS #1
FOR a = 0 TO 127
INPUT #1, T$(a)
NEXT a
CLOSE #1
CALL font(110, 70, T$(), "LOADING SHIPWAR...", 9, 4)
CALL font(108, 68, T$(), "LOADING SHIPWAR...", 9, 7)
CALL font(106, 66, T$(), "LOADING SHIPWAR...", 9, 15)
CALL font(220, 100, T$(), "BY TIM CASWELL", 4, 7)
CALL font(218, 98, T$(), "BY TIM CASWELL", 4, 15)
END SUB

