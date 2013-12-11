DEFINT A-Z
DIM P%(200, 65)
SCREEN 1
OPEN "ITEMS.PIC" FOR INPUT AS #1
FOR N = 1 TO 16
FOR y = 1 TO 20
INPUT #1, A$
FOR x = 1 TO 20
C = ASC(MID$(A$, x, 1)) - 100
    IF C > 7 THEN C = C - 8
    IF C = 1 OR C = 2 OR C = 3 THEN C = 1
    IF C = 4 OR C = 5 OR C = 6 THEN C = 2
    IF C = 7 THEN C = 3
PSET (x, y), C
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
FOR x = 1 TO 20
IF LEN(A$) >= 20 THEN
C = ASC(MID$(A$, x, 1)) - 48
'IF N < 49 THEN
    IF C > 7 THEN C = C - 8
    IF C = 1 OR C = 2 OR C = 3 THEN C = 1
    IF C = 4 OR C = 5 OR C = 6 THEN C = 2
    IF C = 7 THEN C = 3
'END IF
ELSE C = 0
END IF
PSET (x, y), C
NEXT x
NEXT y
GET (1, 1)-(20, 20), P%(0, N + 16)
NEXT N
CLOSE #1
DEF SEG = VARSEG(P%(0, 0))
BSAVE "CLIGHT.PIC", 0, VARPTR(P%(200, 65))
BEEP
BLOAD "CLIGHT.PIC", 0
DO
FOR A = 1 TO 65
x = INT(16 * RND)
y = INT(10 * RND)
PUT (x * 20, y * 20), P%(0, A), PSET
NEXT A
LOOP

