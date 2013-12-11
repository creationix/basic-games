CHDIR "\TIM"
SCREEN 12
DEFINT A-Z
DIM p%(1152, 1 TO 5)
DEF SEG = VARSEG(p%(1, 1))
BLOAD "Icons.pic", 0
OPEN "names.dat" FOR INPUT AS #1
l = 0
DO
  l = l + 1
  INPUT #1, n$, f$, r, t
  LINE INPUT #1, h$
LOOP WHILE NOT EOF(1)
CLOSE #1
DIM n$(l), f$(l), h$(l), r(l), t(l)
OPEN "names.dat" FOR INPUT AS #1
FOR a = 1 TO l
  INPUT #1, n$(a), f$(a), r(a), t(a)
  LINE INPUT #1, h$(a)
NEXT a
CLOSE #1
CLS

SCREEN 12
ch = 0



DO
FOR a = 1 TO 5
h = ((a + ch) MOD l) + 1
IF a = 3 THEN COLOR 15 ELSE COLOR 7
LOCATE a * 3 - 2, 38: PRINT n$(h); "               "
IF a = 3 THEN COLOR 9 ELSE COLOR 1
LOCATE a * 3 - 1, 38: PRINT f$(h); "              "
y = a * 48 - 48
PUT (0, a * 48 - 48), p%(0, t(h) + 1), PSET
FOR b = 1 TO 5
IF r(h) >= b THEN PUT (b * 48, y), p%(0, 1), PSET ELSE LINE (b * 48, y)-(b * 48 + 48, y + 48), 0, BF
NEXT b
NEXT a
DO
a$ = INKEY$
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN ch = ch - 1
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN ch = ch + 1
IF ch < 1 THEN ch = l
IF ch > l THEN ch = 1
LOOP WHILE a$ = ""
LOOP WHILE a$ <> " " AND a$ <> CHR$(13)
ch = ((3 + ch) MOD l) + 1
d$ = f$(ch)
fd$ = LEFT$(d$, 13)
pr$ = MID$(d$, 16)
CHDIR fd$
RUN pr$




