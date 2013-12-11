RANDOMIZE (TIMER)
SCREEN 7
DIM A1%(64), A2%(64), A3%(64), A4%(64), X(1000), Y(1000)
FOR N = 1 TO 3
FOR Y = 1 TO 8
FOR X = 1 TO 8
READ C
PSET (X, Y), C
NEXT X
NEXT Y
IF N = 1 THEN GET (1, 1)-(8, 8), A1%
IF N = 2 THEN GET (1, 1)-(8, 8), A2%
IF N = 3 THEN GET (1, 1)-(8, 8), A3%
NEXT N
'
DATA 15,15,15,15,15,15,15,7
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 7,8,8,8,8,8,8,8
'
DATA 15,15,15,15,15,15,15,7
DATA 15,7,1,1,4,7,7,8
DATA 15,7,1,1,4,7,7,8
DATA 15,7,7,7,4,7,7,8
DATA 15,7,7,7,4,7,7,8
DATA 15,7,7,4,4,4,7,8
DATA 15,7,7,7,7,7,7,8
DATA 7,8,8,8,8,8,8,8
'
DATA 15,15,15,15,15,15,15,7
DATA 15,7,7,9,9,7,7,8
DATA 15,7,9,7,7,9,7,8
DATA 15,7,9,7,7,9,7,8
DATA 15,7,7,7,9,7,7,8
DATA 15,7,7,7,7,7,7,8
DATA 15,7,7,7,9,7,7,8
DATA 7,8,8,8,8,8,8,8
15
INPUT "X-"; MX
INPUT "Y-"; MY
IF MX > 40 THEN SCREEN 8
IF MX > 80 THEN MX = 80
IF MY > 22 THEN MY = 22
PRINT "X-"; MX; "Y-"; MY
DIM L(MX + 1, MY + 1)
INPUT "Mines"; MN
5 FOR A = 1 TO MN
RD:
X = INT(MX * RND + 1)
Y = INT(MY * RND + 1)
IF L(X, Y) = 0 THEN L(X, Y) = 1 ELSE GOTO RD
NEXT A
GOSUB 2
X = INT(MX / 2 + .5)
Y = INT(MY / 2 + .5)
BN = MX * MY - MN
BB = 0
1 A$ = INKEY$
OX = X: OY = Y
IF BN = 0 THEN FOR A = 1 TO 100: COLOR 15 * RND, 15 * RND: NEXT A: REDIM L(MX + 1, MY + 1): DEAD = 0: COLOR , 0: GOTO 5
IF JOY = 1 THEN
JX = STICK(0)
JY = STICK(1)
B1 = STRIG(0)
B2 = STRIG(4)
IF JX < 70 THEN X = X - 1
IF JX > 130 THEN X = X + 1
IF JY < 70 THEN Y = Y - 1
IF JY > 130 THEN Y = Y + 1
IF B1 = -1 THEN A$ = " "
IF B2 = -1 THEN A$ = "F"
END IF
IF A$ = "`" THEN RUN "HEXMINE"
IF A$ = "R" THEN GOTO 15
IF A$ = "Q" THEN DEAD = 1
IF A$ = "8" THEN Y = Y - 1:                              
IF A$ = "4" THEN X = X - 1:
IF A$ = "2" THEN Y = Y + 1:
IF A$ = "6" THEN X = X + 1:
IF Y < 1 THEN Y = 1
IF X < 1 THEN X = 1
IF Y > MY THEN Y = MY
IF X > MX THEN X = MX
IF DEAD = 1 THEN FOR A = 1 TO 10: CIRCLE (X * 8 - 4, Y * 8 - 4), A, 12: CIRCLE (X * 8 - 4, Y * 8 - 5), A, 4: NEXT A: REDIM L(MX + 1, MY + 1): DEAD = 0: GOTO 5
IF A$ = " " THEN
L = L(X, Y)
IF L = 1 THEN DEAD = 1
IF L = 4 THEN DEAD = 1
IF L(X, Y) = 5 THEN L(X, Y) = 6: BN = BN - 1
IF L = 0 OR L = 6 THEN
IF L = 0 THEN L(X, Y) = 6: BN = BN - 1
XX = X: YY = Y
GOSUB 3
IF B = 0 THEN LN = 0: X(0) = X: Y(0) = Y: GOSUB 6
X = XX
Y = YY
END IF
END IF
'**************
IF A$ = "F" THEN
L = L(X, Y)
IF L = 0 THEN L = 3: BB = BB + 1: GOTO 7
IF L = 1 THEN L = 2: BB = BB + 1: GOTO 7
IF L = 2 THEN L = 4: BB = BB - 1: GOTO 7
IF L = 3 THEN L = 5: BB = BB - 1: GOTO 7
IF L = 4 THEN L = 1: GOTO 7
IF L = 5 THEN L = 0: GOTO 7
7
L(X, Y) = L
END IF
XX = X: YY = Y: X = OX: Y = OY: GOSUB 3
X = XX: Y = YY
LINE (X * 8 - 8, Y * 8 - 8)-(X * 8 - 1, Y * 8 - 1), 7, B
COLOR 15
LOCATE MY + 1, 1: PRINT "BOMBS LEFT"; MN - BB
LOCATE MY + 1, 21: PRINT "BRICKS LEFT"; BN
LINE (MX * 8, 0)-(MX * 8, MY * 8 - 1), 9
GOTO 1
6
X = X(LN) + 1: Y = Y(LN): GOSUB 9
X = X(LN): Y = Y(LN) - 1: GOSUB 9
X = X(LN) - 1: Y = Y(LN): GOSUB 9
X = X(LN): Y = Y(LN) + 1: GOSUB 9
X = X(LN) + 1: Y = Y(LN) + 1: GOSUB 9
X = X(LN) - 1: Y = Y(LN) + 1: GOSUB 9
X = X(LN) - 1: Y = Y(LN) - 1: GOSUB 9
X = X(LN) + 1: Y = Y(LN) - 1: GOSUB 9
LN = LN - 1
RETURN
9 IF X <= 0 OR Y <= 0 OR X > MX OR Y > MY THEN RETURN
IF L(X, Y) = 0 THEN
L(X, Y) = 6
BN = BN - 1
COLOR 15
LOCATE MY + 1, 21: PRINT "BRICKS LEFT"; BN
GOSUB 3
IF B = 0 THEN LN = LN + 1: X(LN) = X: Y(LN) = Y: GOSUB 6
END IF
RETURN
2
FOR Y = 1 TO MY: FOR X = 1 TO MX: GOSUB 3: NEXT X: NEXT Y: RETURN
3
IF L(X, Y) = 0 THEN PUT (X * 8 - 8, Y * 8 - 8), A1%, PSET
IF L(X, Y) = 1 THEN PUT (X * 8 - 8, Y * 8 - 8), A1%, PSET
IF L(X, Y) = 3 THEN PUT (X * 8 - 8, Y * 8 - 8), A2%, PSET
IF L(X, Y) = 4 THEN PUT (X * 8 - 8, Y * 8 - 8), A3%, PSET
IF L(X, Y) = 2 THEN PUT (X * 8 - 8, Y * 8 - 8), A2%, PSET
IF L(X, Y) = 5 THEN PUT (X * 8 - 8, Y * 8 - 8), A3%, PSET
IF L(X, Y) = 6 THEN
B = 0
FOR AY = Y - 1 TO Y + 1: FOR AX = X - 1 TO X + 1
LL = 0: IF AX > 0 AND AY > 0 AND AY < MY + 1 AND AX < MX + 1 THEN LL = L(AX, AY)
IF LL = 1 OR LL = 2 OR LL = 4 THEN B = B + 1
NEXT AX: NEXT AY
IF Y > 0 AND X > 0 AND Y < MY + 1 AND X < MX + 1 THEN LOCATE Y, X: IF B = 0 THEN COLOR 7: PRINT CHR$(206) ELSE IF B >= 1 THEN COLOR B + 8: PRINT CHR$(B + 48)
END IF:
RETURN

