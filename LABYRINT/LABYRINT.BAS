DECLARE SUB center (row%, text$)
'    ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл"
'    л                                                                   л
'    л   л        лл    лллл   лллл   ллллл  лл    л ллллллл  л    л     л
'    л   л       л  л   л   л  л   л    л    л л   л    л     л    л     л
'    л   л      лллллл  лллл   лллл     л    л  л  л    л     лллллл     л
'    л   л      л    л  л   л  л   л    л    л   л л    л     л    л     л
'    л   ллллл  л    л  лллл   л   л  ллллл  л    лл    л     л    л     л
'    л                                                                   л
'    ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
'
'                             By Tim Caswell
'
'                               Controls
'
'                                   8            
'                                 7  9  
'                                  \Г/   
'                                4ФФ6  
'                                  /Г\  
'                                 4  3  
'                                   2     
'
'
'
'
DECLARE SUB instruct ()
DEFINT A-S, U-Z
DIM c(11, 11), L(23, 17)
FOR X = 0 TO 22: L(X, 0) = 1: L(X, 17) = 1: NEXT X: FOR Y = 1 TO 16: L(0, Y) = 1: L(22, Y) = 1: NEXT Y
DIM TEMP%(10000), BAD(10, 5)
DIM X(1000), Y(1000)
MMD = -1: MMR = -1
MD = 1: MR = 1
'INPUT "SCREEN MODE(1-CGA 2-EGA 3-VGA 4-MONOCHROME 5-MONOCHROME)"; SCM
SCM = 3
IF SCM = 1 THEN SCREEN 1
IF SCM = 2 THEN SCREEN 9
IF SCM = 3 THEN SCREEN 12
IF SCM = 4 THEN SCREEN 12
IF SCM = 5 THEN SCREEN 12: FOR a = 0 TO 15: PALETTE a, a / 15 * 63: NEXT a
WINDOW SCREEN (0, 0)-(639, 479)
S = 1
OPEN "Labyrint.PIC" FOR INPUT AS #1
FOR N = 1 TO 15
FOR Y = 1 TO 10 STEP S
FOR X = 1 TO 10 STEP S
INPUT #1, c
IF c > 0 THEN
IF c = 8 THEN c = -1
c = c + 8
IF SCM = 1 THEN
IF c <> 15 AND c <> 7 THEN c = 1
IF c = 15 THEN c = 3
IF c = 7 THEN c = 2
END IF
IF SCM = 4 THEN
IF c <> 15 AND c <> 7 THEN c = 3.5
IF c = 15 THEN c = 7.5
IF c = 7 THEN c = 4
c = c * 2
END IF
IF SCM = 5 THEN
IF c <> 15 AND c <> 7 THEN c = .2
IF c = 15 THEN c = .3
IF c = 7 THEN c = .1
c = c * 10! / 3 * 15
END IF
END IF
c(X, Y) = c
NEXT X
NEXT Y
FOR X = 1 TO 10 STEP S
c(X, 0) = c(X, 1)
c(X, 11) = c(X, 10)
NEXT X
FOR Y = 0 TO 11 STEP S
c(0, Y) = c(1, Y)
c(11, Y) = c(10, Y)
NEXT Y
P = P + 1
FOR Y = 1 TO 10
FOR X = 1 TO 10
c = c(X, Y)
IF SCM <> 5 THEN
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 2), c
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 3), c
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 1), c
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 1), c
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 3), c
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 2), c(X - 1, Y)
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 2), c(X + 1, Y)
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 3), c(X, Y - 1)
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 1), c(X, Y + 1)
ELSE
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 2), c
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 3), (c(X - 1, Y - 1) + c) / 2
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 1), (c(X - 1, Y + 1) + c) / 2
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 1), (c(X + 1, Y + 1) + c) / 2
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 3), (c(X + 1, Y - 1) + c) / 2
PSET (X * 3 - 3 + P * 30 - 30, Y * 3 - 2), (c(X - 1, Y) + c) / 2
PSET (X * 3 - 1 + P * 30 - 30, Y * 3 - 2), (c(X + 1, Y) + c) / 2
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 3), (c(X, Y - 1) + c) / 2
PSET (X * 3 - 2 + P * 30 - 30, Y * 3 - 1), (c(X, Y + 1) + c) / 2
END IF
NEXT X
NEXT Y
IF N = 1 THEN DIM P1%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P1%
IF N = 2 THEN DIM P2%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P2%
IF N = 3 THEN DIM P3%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P3%
IF N = 4 THEN DIM P4%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P4%
IF N = 5 THEN DIM P5%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P5%
IF N = 6 THEN DIM P6%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P6%
IF N = 7 THEN DIM P7%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P7%
IF N = 8 THEN DIM P8%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P8%
IF N = 9 THEN DIM P9%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P9%
IF N = 10 THEN DIM P10%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P10%
IF N = 11 THEN DIM P11%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P11%
IF N = 12 THEN DIM P12%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P12%
IF N = 13 THEN DIM P13%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P13%
IF N = 14 THEN DIM P14%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P14%
IF N = 15 THEN DIM P15%(900): GET (1 + P * 30 - 30, 1)-(P * 30, 30), P15%
NEXT N
CLOSE #1
wow:
 CLS
CALL center(9, "Labyrinth")
CALL center(11, "1-PLAY GAME")
CALL center(12, "2-EDIT OR TEST")
CALL center(13, "3-QUIT")
CALL center(14, "4-Instructions")
DO: a$ = INKEY$
IF a$ = "1" THEN GOSUB START: GOTO wow
IF a$ = "2" THEN GOSUB EDIT: GOTO wow
IF a$ = "3" THEN RUN "\tim\menu.bas"
IF a$ = "4" THEN CALL instruct: GOTO wow
LOOP
START:
FOR LEVEL = 1 TO 30
IF LEVEL < 1 THEN LEVEL = 1
IF LEVEL = 1 THEN OPEN "Labyrint.001" FOR INPUT AS #1
IF LEVEL = 2 THEN OPEN "Labyrint.002" FOR INPUT AS #1
IF LEVEL = 3 THEN OPEN "Labyrint.003" FOR INPUT AS #1
IF LEVEL = 4 THEN OPEN "Labyrint.004" FOR INPUT AS #1
IF LEVEL = 5 THEN OPEN "Labyrint.005" FOR INPUT AS #1
IF LEVEL = 6 THEN OPEN "Labyrint.006" FOR INPUT AS #1
IF LEVEL = 7 THEN OPEN "Labyrint.007" FOR INPUT AS #1
IF LEVEL = 8 THEN OPEN "Labyrint.008" FOR INPUT AS #1
IF LEVEL = 9 THEN OPEN "Labyrint.009" FOR INPUT AS #1
IF LEVEL = 10 THEN OPEN "Labyrint.010" FOR INPUT AS #1
IF LEVEL = 11 THEN OPEN "Labyrint.011" FOR INPUT AS #1
IF LEVEL = 12 THEN OPEN "Labyrint.012" FOR INPUT AS #1
IF LEVEL = 13 THEN OPEN "Labyrint.013" FOR INPUT AS #1
IF LEVEL = 14 THEN OPEN "Labyrint.014" FOR INPUT AS #1
IF LEVEL = 15 THEN OPEN "Labyrint.015" FOR INPUT AS #1
IF LEVEL = 16 THEN OPEN "Labyrint.016" FOR INPUT AS #1
IF LEVEL = 17 THEN OPEN "Labyrint.017" FOR INPUT AS #1
IF LEVEL = 18 THEN OPEN "Labyrint.018" FOR INPUT AS #1
IF LEVEL = 19 THEN OPEN "Labyrint.019" FOR INPUT AS #1
IF LEVEL = 20 THEN OPEN "Labyrint.020" FOR INPUT AS #1
IF LEVEL = 21 THEN OPEN "Labyrint.021" FOR INPUT AS #1
IF LEVEL = 22 THEN OPEN "Labyrint.022" FOR INPUT AS #1
IF LEVEL = 23 THEN OPEN "Labyrint.023" FOR INPUT AS #1
IF LEVEL = 24 THEN OPEN "Labyrint.024" FOR INPUT AS #1
IF LEVEL = 25 THEN OPEN "Labyrint.025" FOR INPUT AS #1
IF LEVEL = 26 THEN OPEN "Labyrint.026" FOR INPUT AS #1
IF LEVEL = 27 THEN OPEN "Labyrint.027" FOR INPUT AS #1
IF LEVEL = 28 THEN OPEN "Labyrint.028" FOR INPUT AS #1
IF LEVEL = 29 THEN OPEN "Labyrint.029" FOR INPUT AS #1
IF LEVEL = 30 THEN OPEN "Labyrint.030" FOR INPUT AS #1
COIN = 0
FOR Y = 1 TO 16
INPUT #1, a$
FOR X = 1 TO 21
L$ = MID$(a$, X, 1)
L = ASC(L$) - 64
IF L$ = "." OR L$ = " " THEN L = 0
IF L = 6 THEN COIN = COIN + 1
IF L$ = "S" THEN L = 0: TTX = X: TTY = Y
IF L$ = "e" OR L = 16 THEN L = 16: FX = X: FY = Y
IF L < 0 OR L > 16 THEN L = 0
L(X, Y) = L
NEXT X
NEXT Y
CLOSE #1
CLS
FOR Y = 1 TO 16
FOR X = 1 TO 21
SX = X * 30 - 30
SY = Y * 30 - 30
IF L(X, Y) = .1 THEN L(X, Y) = 0
TX = X
TY = Y
LV = L(X, Y): GOSUB DD: NEXT X: NEXT Y
X = TTX: Y = TTY
GOSUB GO
IF LEVEL > 30 THEN RETURN
NEXT LEVEL: RETURN
GO:
DO: LOOP WHILE INKEY$ <> ""
HP = 0
J = 0
GET (100, 6 * 30)-(540, 7 * 30), TEMP%
CALL center(13, "PRESS SPACE TO PLAY")
DO: LOOP WHILE INKEY$ <> " "
PUT (100, 6 * 30), TEMP%, PSET


DO: a$ = INKEY$: OX = X: OY = Y: MN = 0
FOR a = 1 TO MN
MX = BAD(a, 1)
MY = BAD(a, 2)
MT = BAD(a, 3)
MHP = BAD(a, 4)
MJ = BAD(a, 5)
LOCATE a, 1: PRINT MT
PRINT L(MX - 1, MY); L(MX, MY); L(MX + 1, MY)
IF MT = 0 THEN GOTO SKIP
OMX = MX: OMY = MY
IF MT = 1 THEN IF L(MX + 1, MY) > 0 THEN MX = MX + 1 ELSE MT = -2
IF MT = -1 THEN IF L(MX - 1, MY) > 0 THEN MX = MX - 1 ELSE MT = 1
IF MT = -2 THEN MT = -1
IF MT = 2 THEN
IF MX < X THEN MX = MX + 1
IF MX > X THEN MX = MX - 1
IF MY > Y THEN IF L(MX, MY + 1) > 0 THEN MJ = -3
IF MY < Y THEN MJ = 0: IF L(MX, MY) = 8 OR L(MX, MY + 1) = 8 THEN MY = MY + 1
END IF
IF L(MX, MY) = 1 OR L(MX, MY) = 14 THEN MX = OMX: MY = OMY
MS = 0
IF MJ > 0 THEN MJ = MJ - 1: MY = MY - 1: MS = 1
IF L(MX, MY) = 8 THEN MS = 1
IF L(MX, MY) = 10 THEN MS = 1
IF L(MX, MY + 1) = 8 THEN MS = 1
IF L(MX, MY + 1) = 14 THEN MS = 1
IF L(MX, MY + 1) >= 1 AND L(MX, MY + 1) <= 3 THEN MS = 1
IF MS = 0 THEN MY = MY + 1
IF L(MX, MY) = 1 OR L(MX, MY) = 14 THEN MX = OMX: MY = OMY
IF L(MX, MY) = 15 THEN MHP = MHP - 5
IF L(MX, MY) = 2 THEN IF OMX < MX THEN MY = MY - 1 ELSE MX = OMX: Y = OMY
IF L(MX, MY) = 3 THEN IF OMX > MX THEN MY = MY - 1 ELSE MX = OMX: Y = OMY
IF L(MX, MY) = 4 THEN IF OMY < MY THEN MX = MX - 1 ELSE MX = OMX: Y = OMY
IF L(MX, MY) = 5 THEN IF OMY < MY THEN MX = MX + 1 ELSE MX = OMX: MY = OMY
IF L(MX, MY) = 9 THEN MHP = MHP - 10
IF L(MX, MY) = 12 THEN L(MX, MY) = 13: SX = MX * 30 - 30: SY = MY * 30 - 30: LV = 13: GOSUB DD: L1 = 15: L2 = 14: GOSUB C1: MX = OMX: MY = OMY
IF L(MX, MY) = 13 THEN L(MX, MY) = 12: SX = MX * 30 - 30: SY = MY * 30 - 30: LV = 12: GOSUB DD: L1 = 14: L2 = 15: GOSUB C1: MX = OMX: MY = OMY
IF L(MX, MY) = 7 AND OMY < MY THEN
IF MMD = 1 THEN IF L(MX, MY + 1) = 0 THEN L(MX, MY + 1) = 7: L(MX, MY) = 0 ELSE MD = -2: MY = OMY
IF MMD = -1 THEN IF L(MX, MY - 1) = 0 AND L(MX, MY - 2) = 0 THEN L(MX, MY) = 0: L(MX, MY - 1) = 7: MY = MY - 2 ELSE MMD = 2: MY = OMY
IF MMD = 2 THEN MMD = 1 ELSE IF MMD = -2 THEN MMD = -1
SX = MX * 30 - 30: SY = MY * 30: LV = 7: GOSUB DD
SX = MX * 30 - 30: SY = MY * 30 + 30: LV = L(MX, MY + 2): GOSUB DD
END IF
IF L(X, Y) = 11 AND OY <= Y THEN
IF MMR = 1 THEN IF L(MX + 1, MY) = 0 THEN L(MX + 1, MY) = 11: L(MX, MY) = 0: MX = MX + 1 ELSE MMR = -2
IF MMR = -1 THEN IF L(MX - 1, MY) = 0 THEN L(MX - 1, MY) = 11: L(MX, MY) = 0: MX = MX - 1 ELSE MMR = 2
IF MMR = 2 THEN MMR = 1 ELSE IF MMR = -2 THEN MMR = -1
SX = OMX * 30 - 30: SY = MY * 30 - 30: LV = L(OMX, MY): GOSUB DD
SX = MX * 30 - 30: SY = MY * 30 - 30: GOSUB D11
Y = OMY
END IF
IF MPH < 0 THEN MT = 0
BAD(a, 1) = MX
BAD(a, 2) = MY
BAD(a, 3) = MT
BAD(a, 4) = MHP
BAD(a, 5) = MJ
SKIP:
SX = OMX * 30 - 30: SY = OMY * 30 - 30: LV = L(OMX, OMY): GOSUB DD
IF MT <> 0 THEN CIRCLE (MX * 30 - 15, MY * 30 - 15), 10, 12: CIRCLE (MX * 30 - 15, MY * 30 - 15), 5, 10
NEXT a
MN = 0
IF HP > 150 THEN FOR a = 300 TO 37 STEP -3: SOUND a + 4 * RND, .1: CIRCLE (320, 240), 300 - a: SOUND 340 - a + 3 * RND, .1: NEXT a: HP = 0: LEVEL = LEVEL - 2: RETURN
IF a$ = "q" OR a$ = "Q" THEN LEVEL = 50: RETURN
IF a$ = "R" THEN HP = HP + 100
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN a$ = INKEY$: IF L(X, Y + 1) > 0 AND L(X, Y + 1) < 15 THEN J = 3 ELSE IF L(X, Y) = 8 OR L(X, Y) = 10 THEN J = 9
IF a$ = "7" OR a$ = CHR$(0) + "G" THEN a$ = "4": IF L(X, Y + 1) > 0 AND L(X, Y + 1) < 15 THEN J = 3 ELSE IF L(X, Y) = 8 OR L(X, Y) = 10 THEN J = 3
IF a$ = "9" OR a$ = CHR$(0) + "I" THEN a$ = "6": IF L(X, Y + 1) > 0 AND L(X, Y + 1) < 15 THEN J = 3 ELSE IF L(X, Y) = 8 OR L(X, Y) = 10 THEN J = 3
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN IF L(X, Y) = 8 OR L(X, Y + 1) = 8 OR L(X, Y) = 10 THEN IF Y < 16 THEN Y = Y + 1
IF a$ = "1" OR a$ = CHR$(0) + "O" THEN a$ = "4": IF L(X, Y) = 8 OR L(X, Y + 1) = 8 OR L(X, Y) = 10 THEN IF Y < 16 THEN Y = Y + 1
IF a$ = "3" OR a$ = CHR$(0) + "Q" THEN a$ = "6": IF L(X, Y) = 8 OR L(X, Y + 1) = 8 OR L(X, Y) = 10 THEN IF Y < 16 THEN Y = Y + 1
IF a$ = "4" OR a$ = CHR$(0) + "K" THEN X = X - 1
IF a$ = "6" OR a$ = CHR$(0) + "M" THEN X = X + 1
IF L(X, Y) = 1 THEN X = OX: Y = OY
IF L(X, Y) = 14 THEN X = OX: Y = OY
S = 0
IF J > 0 THEN J = J - 1: Y = Y - 1: S = 1
IF L(X, Y) = 8 THEN S = 1: J = 0
IF L(X, Y) = 10 THEN S = 1
IF L(X, Y + 1) = 8 THEN S = 1
IF L(X, Y + 1) = 14 THEN S = 1
IF L(X, Y + 1) >= 1 AND L(X, Y + 1) <= 3 THEN S = 1
IF S = 0 THEN Y = Y + 1
IF X < OX THEN X = OX - 1
IF X > OX THEN X = OX + 1
IF Y < OY THEN Y = OY - 1
IF Y > OY THEN Y = OY + 1
IF X < 1 THEN X = 1
IF X > 21 THEN X = 21
IF Y < 1 THEN Y = 1
IF Y > 16 THEN Y = 16
IF L(X, Y) = 1 THEN X = OX: Y = OY: SOUND 100, .2
IF L(X, Y) = 14 THEN X = OX: Y = OY: SOUND 1000, .1: SOUND 3000, .1
IF LEVEL <> 11 THEN IF L(X, Y) = 15 THEN HP = HP + 5: FOR a = 1 TO 10: SOUND 37 + ABS(100 - HP + a ^ 2), .1: NEXT a
IF LEVEL = 11 THEN IF L(X, Y) = 15 THEN HP = HP + 1: FOR a = 1 TO 2: SOUND 37 + ABS(100 - HP + a ^ 2), .1: NEXT a
IF L(X, Y) = 2 THEN IF OX < X THEN Y = Y - 1 ELSE X = OX: Y = OY
IF L(X, Y) = 3 THEN IF OX > X THEN Y = Y - 1 ELSE X = OX: Y = OY
IF L(X, Y) = 4 THEN IF OY < Y THEN X = X - 1 ELSE X = OX: Y = OY
IF L(X, Y) = 5 THEN IF OY < Y THEN X = X + 1 ELSE X = OX: Y = OY
IF COIN = 0 THEN COIN = -5: SX = FX * 30 - 30: SY = FY * 30 - 30: LV = 16: GOSUB DD
IF L(X, Y) = 6 THEN L(X, Y) = 0: FOR a = 1 TO 10: SOUND 100 + a * a * 10, .08 + a / 100: NEXT a: COIN = COIN - 1
IF L(X, Y) = 9 THEN HP = HP + 10: FOR a = 1 TO 20: SOUND 37 + ABS(100 - HP + a ^ 2), .1: NEXT a
IF L(X, Y) = 12 THEN L(X, Y) = 13: SX = X * 30 - 30: SY = Y * 30 - 30: LV = 13: GOSUB DD: L1 = 15: L2 = 14: GOSUB C1: X = OX: Y = OY
IF L(X, Y) = 13 THEN L(X, Y) = 12: SX = X * 30 - 30: SY = Y * 30 - 30: LV = 12: GOSUB DD: L1 = 14: L2 = 15: GOSUB C1: X = OX: Y = OY
IF L(X, Y) = 7 AND OY < Y THEN
IF MD = 1 THEN IF L(X, Y + 1) = 0 THEN L(X, Y + 1) = 7: L(X, Y) = 0 ELSE MD = -2: Y = OY
IF MD = -1 THEN IF L(X, Y - 1) = 0 AND L(X, Y - 2) = 0 THEN L(X, Y) = 0: L(X, Y - 1) = 7: Y = Y - 2 ELSE MD = 2: Y = OY
IF MD = 2 THEN MD = 1 ELSE IF MD = -2 THEN MD = -1
SX = X * 30 - 30: SY = Y * 30: LV = 7: GOSUB DD
SX = X * 30 - 30: SY = Y * 30 + 30: LV = L(X, Y + 2): GOSUB DD
END IF
IF L(X, Y) = 11 AND OY <= Y THEN
IF MR = 1 THEN IF L(X + 1, Y) = 0 THEN L(X + 1, Y) = 11: L(X, Y) = 0: X = X + 1 ELSE MR = -2
IF MR = -1 THEN IF L(X - 1, Y) = 0 THEN L(X - 1, Y) = 11: L(X, Y) = 0: X = X - 1 ELSE MR = 2
IF MR = 2 THEN MR = 1 ELSE IF MR = -2 THEN MR = -1
SX = OX * 30 - 30: SY = Y * 30 - 30: LV = L(OX, Y): GOSUB DD
SX = X * 30 - 30: SY = Y * 30 - 30: GOSUB D11
Y = OY
END IF
IF L(X, Y) = 6 THEN L(X, Y) = 0: FOR a = 1 TO 10: SOUND 100 + a * a * 10, .08 + a / 100: NEXT a: COIN = COIN - 1
SX = X * 30 - 30: SY = Y * 30 - 30: LV = L(X, Y): GOSUB DD
SX = OX * 30 - 30: SY = OY * 30 - 30
LV = L(OX, OY): GOSUB DD
CIRCLE (X * 30 - 15, Y * 30 - 15), 10, 15
CIRCLE (X * 30 - 15, Y * 30 - 15), 9, 7
DO: LOOP WHILE TIMER - TME < .1: TME = TIMER
IF L(X, Y) = 16 AND COIN < 0 THEN RETURN
LOOP
C1:
X(0) = X: Y(0) = Y: LN = 0
C3:
IF LN >= 0 THEN TX = X(LN) + 1: TY = Y(LN): GOSUB C2
IF LN >= 0 THEN TX = X(LN) - 1: TY = Y(LN): GOSUB C2
IF LN >= 0 THEN TX = X(LN): TY = Y(LN) - 1: GOSUB C2
IF LN >= 0 THEN TX = X(LN): TY = Y(LN) + 1: GOSUB C2
LN = LN - 1
RETURN
C2:
IF TX <= 0 OR TY <= 0 OR TX > 21 OR TY > 16 THEN RETURN
IF L(TX, TY) = L1 THEN
L(TX, TY) = L2
SX = TX * 30 - 30: SY = TY * 30 - 30: LV = L(TX, TY): GOSUB DD
LN = LN + 1: X(LN) = TX: Y(LN) = TY: GOSUB C3
END IF
RETURN
DD:
IF SX >= 0 AND SY >= 0 AND SX <= 640 - 30 AND SY <= 480 - 30 THEN ON LV + 1 GOSUB D0, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16
RETURN
D0:
 LINE (SX, SY)-(SX + 29, SY + 29), 0, BF: RETURN
D1:
 PUT (SX, SY), P1%, PSET: RETURN
D2:
 PUT (SX, SY), P2%, PSET: RETURN
D3:
 PUT (SX, SY), P3%, PSET: RETURN
D4:
 PUT (SX, SY), P4%, PSET: RETURN
D5:
 PUT (SX, SY), P5%, PSET: RETURN
D6:
 PUT (SX, SY), P6%, PSET: RETURN
D7:
 PUT (SX, SY), P7%, PSET: RETURN
D8:
 PUT (SX, SY), P8%, PSET: RETURN
D9:
 PUT (SX, SY), P9%, PSET: RETURN
D10:
 PUT (SX, SY), P10%, PSET: RETURN
D11:
 PUT (SX, SY), P11%, PSET: RETURN
D12:
 PUT (SX, SY), P12%, PSET: RETURN
D13:
 PUT (SX, SY), P13%, PSET: RETURN
D14:
 PUT (SX, SY), P14%, PSET: RETURN
D15:
 PUT (SX, SY), P15%, PSET: RETURN
D16:
 GOSUB D0
IF COIN < 0 THEN FOR a = 1 TO 15 STEP 1: LINE (SX + a, SY + a)-(SX + 29 - a, SY + 29 - a), 15 * RND, B: SOUND 1000 - a * 20, .3: NEXT a:  ELSE GOSUB D0
RETURN
EDIT:
 GOSUB REFRESH
DO: a$ = INKEY$
IF a$ = "q" OR a$ = "Q" THEN RETURN
IF a$ = "`" THEN
COIN = 0
SX = X: SY = Y
FOR Y = 1 TO 16
FOR X = 1 TO 21
IF L(X, Y) = 6 THEN COIN = COIN + 1
IF L(X, Y) = 16 THEN FX = X: FY = Y
NEXT X
NEXT Y
'SX = TTX: SY = TTY
X = SX: Y = SY
GOSUB GO
END IF
IF a$ = "5" THEN GOSUB REFRESH
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN Y = Y - 1
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN Y = Y + 1
IF a$ = "4" OR a$ = CHR$(0) + "K" THEN X = X - 1
IF a$ = "6" OR a$ = CHR$(0) + "M" THEN X = X + 1
IF a$ = "7" OR a$ = CHR$(0) + "G" THEN X = X - 1: Y = Y - 1
IF a$ = "9" OR a$ = CHR$(0) + "I" THEN X = X + 1: Y = Y - 1
IF a$ = "1" OR a$ = CHR$(0) + "O" THEN X = X - 1: Y = Y + 1
IF a$ = "3" OR a$ = CHR$(0) + "Q" THEN X = X + 1: Y = Y + 1
IF X < 1 THEN X = 1
IF Y < 1 THEN Y = 1
IF X > 21 THEN X = 21
IF Y > 16 THEN Y = 16
IF a$ = "s" THEN
DO: PRINT "SAVE AS WHAT LEVEL(1-30)WAS "; ADD$; : INPUT LEVEL
LOOP WHILE LEVEL < 0 OR LEVEL > 30
LEVEL$ = "Labyrint.0"
IF LEVEL = 1 THEN ADD$ = "00"
IF LEVEL = 1 THEN ADD$ = "01"
IF LEVEL = 2 THEN ADD$ = "02"
IF LEVEL = 3 THEN ADD$ = "03"
IF LEVEL = 4 THEN ADD$ = "04"
IF LEVEL = 5 THEN ADD$ = "05"
IF LEVEL = 6 THEN ADD$ = "06"
IF LEVEL = 7 THEN ADD$ = "07"
IF LEVEL = 8 THEN ADD$ = "08"
IF LEVEL = 9 THEN ADD$ = "09"
IF LEVEL = 10 THEN ADD$ = "10"
IF LEVEL = 11 THEN ADD$ = "11"
IF LEVEL = 12 THEN ADD$ = "12"
IF LEVEL = 13 THEN ADD$ = "13"
IF LEVEL = 14 THEN ADD$ = "14"
IF LEVEL = 15 THEN ADD$ = "15"
IF LEVEL = 16 THEN ADD$ = "16"
IF LEVEL = 17 THEN ADD$ = "17"
IF LEVEL = 18 THEN ADD$ = "18"
IF LEVEL = 19 THEN ADD$ = "19"
IF LEVEL = 20 THEN ADD$ = "20"
IF LEVEL = 21 THEN ADD$ = "21"
IF LEVEL = 22 THEN ADD$ = "22"
IF LEVEL = 23 THEN ADD$ = "23"
IF LEVEL = 24 THEN ADD$ = "24"
IF LEVEL = 25 THEN ADD$ = "25"
IF LEVEL = 26 THEN ADD$ = "26"
IF LEVEL = 27 THEN ADD$ = "27"
IF LEVEL = 28 THEN ADD$ = "28"
IF LEVEL = 29 THEN ADD$ = "29"
IF LEVEL = 30 THEN ADD$ = "30"
OPEN LEVEL$ + ADD$ FOR OUTPUT AS #1
FOR Y = 1 TO 16
a$ = ""
FOR X = 1 TO 21
L$ = CHR$(L(X, Y) + 64)
L = L(X, Y)
IF L = 0 THEN L$ = "."
IF L = 16 THEN L$ = "e"
IF X = TTX AND Y = TTY THEN L$ = "S"
a$ = a$ + L$
NEXT X
PRINT a$
PRINT #1, a$
NEXT Y
CLOSE #1
GOSUB REFRESH
END IF
IF a$ = "l" THEN
DO: INPUT "LOAD WHICH LEVEL(1-30)"; LEVEL
LOOP WHILE LEVEL < 0 OR LEVEL > 30
LEVEL$ = "Labyrint.0"
IF LEVEL = 0 THEN ADD$ = "00"
IF LEVEL = 1 THEN ADD$ = "01"
IF LEVEL = 2 THEN ADD$ = "02"
IF LEVEL = 3 THEN ADD$ = "03"
IF LEVEL = 4 THEN ADD$ = "04"
IF LEVEL = 5 THEN ADD$ = "05"
IF LEVEL = 6 THEN ADD$ = "06"
IF LEVEL = 7 THEN ADD$ = "07"
IF LEVEL = 8 THEN ADD$ = "08"
IF LEVEL = 9 THEN ADD$ = "09"
IF LEVEL = 10 THEN ADD$ = "10"
IF LEVEL = 11 THEN ADD$ = "11"
IF LEVEL = 12 THEN ADD$ = "12"
IF LEVEL = 13 THEN ADD$ = "13"
IF LEVEL = 14 THEN ADD$ = "14"
IF LEVEL = 15 THEN ADD$ = "15"
IF LEVEL = 16 THEN ADD$ = "16"
IF LEVEL = 17 THEN ADD$ = "17"
IF LEVEL = 18 THEN ADD$ = "18"
IF LEVEL = 19 THEN ADD$ = "19"
IF LEVEL = 20 THEN ADD$ = "20"
IF LEVEL = 21 THEN ADD$ = "21"
IF LEVEL = 22 THEN ADD$ = "22"
IF LEVEL = 23 THEN ADD$ = "23"
IF LEVEL = 24 THEN ADD$ = "24"
IF LEVEL = 25 THEN ADD$ = "25"
IF LEVEL = 26 THEN ADD$ = "26"
IF LEVEL = 27 THEN ADD$ = "27"
IF LEVEL = 28 THEN ADD$ = "28"
IF LEVEL = 29 THEN ADD$ = "29"
IF LEVEL = 30 THEN ADD$ = "30"
OPEN LEVEL$ + ADD$ FOR INPUT AS #1
FOR Y = 1 TO 16
INPUT #1, a$
FOR X = 1 TO 21
L$ = MID$(a$, X, 1)
L = ASC(L$) - 64
IF L$ = "S" THEN L = 0: TTX = X: TTY = Y
IF L$ = "." THEN L = 0
IF L$ = "e" THEN L = 16
L(X, Y) = L
NEXT X
NEXT Y
CLOSE #1
GOSUB REFRESH
X = TTX: Y = TTY
END IF
IF a$ = "A" THEN L(X, Y) = 0
IF a$ = "S" THEN
CIRCLE (TTX * 30 - 15, TTY * 30 - 15), 10, 0
CIRCLE (TTX * 30 - 15, TTY * 30 - 15), 9, 0
TTX = X: TTY = Y
END IF
IF a$ = " " THEN L(X, Y) = 1
IF a$ = "/" THEN L(X, Y) = 2
IF a$ = "\" THEN L(X, Y) = 3
IF a$ = "," THEN L(X, Y) = 4
IF a$ = "." THEN L(X, Y) = 5
IF a$ = "Q" THEN L(X, Y) = 6
IF a$ = "W" THEN L(X, Y) = 7
IF a$ = "E" THEN L(X, Y) = 8
IF a$ = "R" THEN L(X, Y) = 9
IF a$ = "T" THEN L(X, Y) = 10
IF a$ = "Y" THEN L(X, Y) = 11
IF a$ = "U" THEN L(X, Y) = 12
IF a$ = "I" THEN L(X, Y) = 13
IF a$ = "O" THEN L(X, Y) = 14
IF a$ = "P" THEN L(X, Y) = 15
IF a$ = "F" THEN L(X, Y) = 16
IF a$ = "Z" THEN
DO: X = INT(21 * RND) + 1: Y = INT(16 * RND) + 1: LOOP WHILE L(X, Y) <> 0
L(X, Y) = 6
END IF
IF a$ = "N" THEN
FOR Y = 1 TO 16
FOR X = 1 TO 21
L(X, Y) = 0
NEXT X
NEXT Y
GOSUB REFRESH
END IF
COIN = -1
SX = OX * 30 - 30: SY = OY * 30 - 30: LV = L(OX, OY): GOSUB DD
CIRCLE (TTX * 30 - 15, TTY * 30 - 15), 10, 15
CIRCLE (TTX * 30 - 15, TTY * 30 - 15), 9, 7
CIRCLE (X * 30 - 15, Y * 30 - 15), 3, 9
CIRCLE (X * 30 - 15, Y * 30 - 15), 7, 14
CIRCLE (X * 30 - 15, Y * 30 - 15), 10, 15
OX = X: OY = Y
TME = TIMER
DO: LOOP WHILE TIMER - TME < .05
LOOP
REFRESH:
 CLS
FOR X = 1 TO 21
FOR Y = 1 TO 16
SX = X * 30 - 30: SY = Y * 30 - 30: LV = L(X, Y): GOSUB DD
NEXT Y
NEXT X
RETURN

DEFINT T
'Center:
'  Centers text on given row
SUB center (row, text$)
    LOCATE row, 41 - LEN(text$) / 2
    PRINT text$;
END SUB

DEFSNG T
SUB instruct
CLS
COLOR 15
COLOR 9
PRINT
PRINT "         л        лл    лллл   лллл   ллллл  лл    л ллллллл  л    л"
PRINT "         л       л  л   л   л  л   л    л    л л   л    л     л    л"
PRINT "         л      лллллл  лллл   лллл     л    л  л  л    л     лллллл"
PRINT "         л      л    л  л   л  л   л    л    л   л л    л     л    л"
PRINT "         ллллл  л    л  лллл   л   л  ллллл  л    лл    л     л    л"
PRINT
COLOR 15
PRINT "                              By Tim Caswell"
PRINT
PRINT "                                Controls"
COLOR 10
PRINT
PRINT " 'q' - Quit and return to menu      7 8 9"
PRINT "                                     \Г/"
PRINT "                                    4ФФ6"
PRINT "                                     /Г\"
PRINT "                                    1 2 3"
PRINT
COLOR 13
PRINT "    The object of Labyrinth is to solve the puzzle of each level and"
PRINT "to pass it.  The exit is hidden somwhere in the level and cannot be"
PRINT "found until all the coins are collected."
COLOR 11
PRINT "    The switches are used to control the status of the touching squares."
PRINT "The blue squares are ice and are solid.  The red squares are fire. You "
PRINT "can go through them, but you get hurt.  The spikes just hurt you a lot."
PRINT "You can hang off of a bar to climb over a dangerous area.  The sliding"
PRINT "bridges help you get around also.  Once all the coins are collected, "
PRINT "the exit appears.  Some levels have other, not so visible, exits that can be"
PRINT "found."
DO:
c = (c + 1) MOD 5
COLOR c + 9
LOCATE 1, 1
PRINT
PRINT "         л        лл    лллл   лллл   ллллл  лл    л ллллллл  л    л"
PRINT "         л       л  л   л   л  л   л    л    л л   л    л     л    л"
PRINT "         л      лллллл  лллл   лллл     л    л  л  л    л     лллллл"
PRINT "         л      л    л  л   л  л   л    л    л   л л    л     л    л"
PRINT "         ллллл  л    л  лллл   л   л  ллллл  л    лл    л     л    л"
PRINT

LOOP WHILE INKEY$ = ""
END SUB

