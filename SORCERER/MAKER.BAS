DEFINT A-Z
RANDOMIZE (TIMER)
SCREEN 9
DIM B%(112, 36)
DIM L(39, -3 TO 25)
OPEN "SORCERER.DAT" FOR INPUT AS #1
FOR N = 1 TO 36
SX = N * 16 - 16
INPUT #1, A$
FOR AY = 1 TO 14
FOR AX = 1 TO 16
C = ASC(MID$(A$, AX + AY * 16 - 16, 1)) - 100
IF C > 0 THEN PSET (AX + SX, AY), C
NEXT AX
NEXT AY
X1 = N * 16 - 15: X2 = N * 16
GET (X1, 1)-(X2, 14), B%(0, N)
NEXT N
CLOSE #1
CLS
GET (1, 1)-(16, 14), B%(0, 0)
FOR LEVEL = 12 TO 20
GOSUB MAKE:
GOSUB ADD
A$ = "Sorcerer.l" + ADD$
OPEN A$ FOR OUTPUT AS #1
PRINT A$
FOR Y = 1 TO 21
A$ = ""
FOR X = 1 TO 38
PUT (X * 16 - 16, Y * 14 - 14), B%(0, L(X, Y)), PSET
A$ = A$ + CHR$(100 + L(X, Y))
NEXT X
PRINT #1, A$
NEXT Y
FOR A = 1 TO 4
PRINT #1, INT(63 * RND) + 1
NEXT A
PRINT #1, 0, 0
CLOSE #1
NEXT LEVEL
END
ADD:
LLT = LEVEL MOD 10
LTT = LEVEL \ 10
ADD$ = ""
IF LTT = 1 THEN ADD$ = ADD$ + "1"
IF LTT = 2 THEN ADD$ = ADD$ + "2"
IF LTT = 3 THEN ADD$ = ADD$ + "3"
IF LTT = 4 THEN ADD$ = ADD$ + "4"
IF LTT = 5 THEN ADD$ = ADD$ + "5"
IF LTT = 6 THEN ADD$ = ADD$ + "6"
IF LTT = 7 THEN ADD$ = ADD$ + "7"
IF LTT = 8 THEN ADD$ = ADD$ + "8"
IF LTT = 9 THEN ADD$ = ADD$ + "9"
IF LTT = 10 THEN ADD$ = ADD$ + "0"
IF LLT = 1 THEN ADD$ = ADD$ + "1"
IF LLT = 2 THEN ADD$ = ADD$ + "2"
IF LLT = 3 THEN ADD$ = ADD$ + "3"
IF LLT = 4 THEN ADD$ = ADD$ + "4"
IF LLT = 5 THEN ADD$ = ADD$ + "5"
IF LLT = 6 THEN ADD$ = ADD$ + "6"
IF LLT = 7 THEN ADD$ = ADD$ + "7"
IF LLT = 8 THEN ADD$ = ADD$ + "8"
IF LLT = 9 THEN ADD$ = ADD$ + "9"
IF LLT = 0 THEN ADD$ = ADD$ + "0"
RETURN

MAKE:
FOR X = 1 TO 38
FOR Y = 1 TO 21
L(X, Y) = 0 + RND * .8
NEXT Y
NEXT X
FOR X = 1 TO 38
FOR Y = 1 TO 21
LV = L(X, Y)
LD = L(X, Y + 1)
LL = L(X - 1, Y)
LR = L(X + 1, Y)
IF LV = 0 AND L(X, Y - 1) = 0 THEN
IF LD = 1 AND LR = 1 THEN L(X, Y) = 3 + CINT(RND) * 2
IF LD = 1 AND LL = 1 THEN L(X, Y) = 2 + CINT(RND) * 2
IF LD = 1 AND LL = 0 AND LR = 0 THEN L(X - 1, Y + 1) = 1: L(X + 1, Y + 1) = 1
END IF
NEXT Y
NEXT X
FOR N = 1 TO 3
FOR Y = 1 TO 21
FOR X = 1 TO 38
IF L(X, Y) = 3 OR L(X, Y) = 5 THEN L(X - 1, Y) = 0: L(X, Y - 1) = 0: L(X + 1, Y) = 1: L(X, Y + 1) = 1
IF L(X, Y) = 2 OR L(X, Y) = 4 THEN L(X + 1, Y) = 0: L(X, Y - 1) = 0: L(X - 1, Y) = 1: L(X, Y + 1) = 1
NEXT X
NEXT Y
NEXT N
FOR Y = 1 TO 21
FOR X = 1 TO 38
NEXT X
NEXT Y
FOR Y = 1 TO 21
FOR X = 1 TO 38
IF L(X, Y) = 0 THEN
C = 0
IF L(X - 1, Y) = 1 THEN C = C + 1
IF L(X + 1, Y) = 1 THEN C = C + 1
IF L(X, Y - 1) = 1 THEN C = C + 1
IF L(X, Y + 1) = 1 THEN C = C + 1
IF C > 2 THEN L(X, Y) = 1
END IF
NEXT X
NEXT Y
FOR Y = 1 TO 21
FOR X = 1 TO 38
IF L(X, Y) = 1 THEN
C = 0
IF L(X - 1, Y) = 0 THEN C = C + 1
IF L(X + 1, Y) = 0 THEN C = C + 1
IF L(X, Y - 1) = 0 THEN C = C + 1
IF L(X, Y + 1) = 0 THEN C = C + 1
IF C > 2 THEN L(X, Y) = 0
END IF
NEXT X
NEXT Y
FOR A = 1 TO 40
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y) = 1 THEN
C = 0
IF L(X - 1, Y) = 0 THEN C = C + 1
IF L(X + 1, Y) = 0 THEN C = C + 1
IF L(X, Y - 1) = 0 THEN C = C + 1
IF L(X, Y + 1) = 0 THEN C = C + 1
IF C > 1 THEN L(X, Y) = 0
END IF
NEXT A
FOR A = 1 TO 20
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y) = 1 THEN
C = 0
IF L(X - 1, Y) = 0 THEN C = C + 1
IF L(X + 1, Y) = 0 THEN C = C + 1
IF L(X, Y - 1) = 0 THEN C = C + 1
IF L(X, Y + 1) = 0 THEN C = C + 1
IF C > 0 THEN L(X, Y) = 0
END IF
NEXT A
FOR A = 1 TO 100
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X - 1, Y) = 0 AND L(X + 1, Y) = 0 AND L(X - 1, Y - 1) = 0 AND L(X, Y - 1) = 0 AND L(X + 1, Y - 1) = 0 AND L(X - 1, Y + 1) = 1 AND L(X + 1, Y + 1) = 1 AND L(X, Y + 1) = 1 THEN GOSUB ARCH
NEXT A
FOR A = 1 TO 100
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y) = 1 AND L(X - 1, Y) > 0 AND L(X + 1, Y) > 0 AND L(X, Y - 1) = 0 THEN L(X, Y - 1) = 7
NEXT A
FOR A = 1 TO 200
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y - 1) = 1 AND L(X - 1, Y + 1) = 0 AND L(X + 1, Y + 1) = 0 AND L(X, Y + 1) = 0 THEN L(X, Y) = 29
NEXT A
FOR A = 1 TO 20
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y) = 0 THEN L(X, Y) = 10 + INT(4 * RND)
NEXT A
FOR A = 1 TO 30
X = INT(38 * RND + 1)
Y = INT(21 * RND + 1)
IF L(X, Y) = 0 THEN L(X, Y) = 14 + INT(4 * RND)
NEXT A
CLS
RETURN

ARCH:
L(X, Y) = 10 + INT(8 * RND)
L(X - 1, Y) = 23
L(X + 1, Y) = 23
L(X - 1, Y - 1) = 21
L(X + 1, Y - 1) = 22
L(X, Y - 1) = 20
RETURN

