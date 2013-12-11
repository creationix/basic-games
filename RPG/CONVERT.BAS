DEFINT A-Z
DIM P%(200, 65)
SCREEN 7
OPEN "ITEMS.PIC" FOR INPUT AS #1
FOR N = 1 TO 16
FOR y = 1 TO 20
INPUT #1, A$
FOR x = 1 TO 20
C = ASC(MID$(A$, x, 1)) - 100
PSET (x, y), C + CINT(RND) * 8
NEXT x
NEXT y
GET (1, 1)-(20, 20), P%(0, N)
NEXT N
CLOSE #1
OPEN "ULTIMA.PIC" FOR INPUT AS #1
FOR N = 1 TO 49
INPUT #1, A$
FOR y = 1 TO 20
INPUT #1, A$
A$ = A$ + STRING$(20, 48)
FOR x = 1 TO 20

C = ASC(MID$(A$, x, 1)) - 48
IF N < 49 THEN
  IF C = 7 THEN C = 15
  IF C = 8 THEN C = 7
  IF C = 9 THEN C = 14
  IF C > 0 AND C < 6 THEN C = C + CINT(RND) * 8
END IF
PSET (x, y), C
NEXT x
NEXT y
GET (1, 1)-(20, 20), P%(0, N + 16)
NEXT N
CLOSE #1
DEF SEG = VARSEG(P%(0, 0))
BSAVE "LIGHT.PIC", 0, VARPTR(P%(200, 65))
BEEP
BLOAD "LIGHT.PIC", 0
DO
FOR A = 1 TO 65
x = INT(16 * RND)
y = INT(10 * RND)
PUT (x * 20, y * 20), P%(0, A), PSET
NEXT A
LOOP

