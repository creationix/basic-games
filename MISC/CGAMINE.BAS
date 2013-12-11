CLEAR , , 10000
joy = 1
RANDOMIZE (TIMER)
DIM X(1000), Y(1000)
SCREEN 1
SCREEN 0
15
INPUT "X-"; MX
INPUT "Y-"; MY
IF MX > 40 THEN SCREEN 2: SCREEN 0
IF MX > 80 THEN MX = 80
IF MY > 22 THEN MY = 22
PRINT "X-"; MX; "Y-"; MY
REDIM L(MX + 1, MY + 1)
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
IF joy = 1 THEN
JX = STICK(0)
JY = STICK(1)
B1 = STRIG(0)
B2 = STRIG(4)
IF JX < 70 THEN X = X - 1: A$ = "+"
IF JX > 130 THEN X = X + 1: A$ = "+"
IF JY < 70 THEN Y = Y - 1: A$ = "+"
IF JY > 130 THEN Y = Y + 1: A$ = "+"
IF B1 = -1 THEN A$ = " "
IF B2 = -1 THEN A$ = "F"
END IF
IF BN = 0 THEN FOR A = 1 TO 100: COLOR , , 15 * RND: NEXT A: REDIM L(MX + 1, MY + 1): DEAD = 0: COLOR , 0: GOTO 5
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
CCX = X: CCY = Y
IF DEAD = 1 THEN SOUND 37, 2: SOUND 100, .2: REDIM L(MX + 1, MY + 1): DEAD = 0: GOTO 5
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
COLOR 15, 0
LOCATE MY + 1, 1: PRINT "BOMBS LEFT"; MN - BB
LOCATE MY + 1, 21: PRINT "BRICKS LEFT"; BN
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
COLOR 15, 0
LOCATE MY + 1, 21: PRINT "BRICKS LEFT"; BN
GOSUB 3
IF B = 0 THEN LN = LN + 1: X(LN) = X: Y(LN) = Y: GOSUB 6
END IF
RETURN
2
RD = 1
COLOR , 0, 0: CLS
FOR Y = 1 TO MY: FOR X = 1 TO MX: GOSUB 3: NEXT X: NEXT Y: RETURN
3
IF Y < 1 OR X < 1 OR X > MX OR Y > MY THEN RETURN
PB = 7: IF CCX = X AND CCY = Y THEN IF RD = 0 THEN PB = 1 ELSE RD = 0
IF L(X, Y) = 0 THEN P$ = CHR$(177): PF = 15
IF L(X, Y) = 1 THEN P$ = CHR$(177): PF = 15
IF L(X, Y) = 2 THEN P$ = CHR$(236): PF = 12
IF L(X, Y) = 3 THEN P$ = CHR$(236): PF = 12
IF L(X, Y) = 4 THEN P$ = CHR$(237): PF = 9
IF L(X, Y) = 5 THEN P$ = CHR$(237): PF = 9
IF L(X, Y) = 6 THEN
B = 0
FOR AY = Y - 1 TO Y + 1: FOR AX = X - 1 TO X + 1
LL = 0: IF AX > 0 AND AY > 0 AND AY < MY + 1 AND AX < MX + 1 THEN LL = L(AX, AY)
IF LL = 1 OR LL = 2 OR LL = 4 THEN B = B + 1
NEXT AX: NEXT AY
IF B = 0 THEN PF = 8: P$ = CHR$(206) ELSE IF B >= 1 THEN PF = B + 8: P$ = CHR$(B + 48)
END IF:
LOCATE Y, X: COLOR PF, PB: PRINT P$
RETURN

