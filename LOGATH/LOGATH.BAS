tp1 = 1: tP2 = 2
OPEN "Logath.DAT" FOR INPUT AS #1
RANDOMIZE (TIMER)
DIM C$(2, 6), RD(2, 5)
C$(1, 1) = "W": C$(1, 2) = "A": C$(1, 3) = "D"
C$(1, 4) = "S": C$(1, 5) = "`": C$(1, 6) = "Z"
C$(2, 1) = "8": C$(2, 2) = "4": C$(2, 3) = "6"
C$(2, 4) = "2": C$(2, 5) = "+": C$(2, 6) = "*"
SCREEN 12
DEFINT A-Y
SP = 500
EV(1) = 1: EV(2) = -1
PALETTE 4, 0
DIM LOGATH%(13140)
DIM zCH(320, 2)
LOCATE 1, 1
COLOR 4:
PRINT "Logath"
SX = 162: '354
SY = 100: '160
FOR X = 0 TO 48
IF X / 2 = INT(X / 2) THEN Y1 = 0: Y2 = 15: s = 1 ELSE Y1 = 15: Y2 = 0: s = -1
FOR Y = Y1 TO Y2 STEP s
IF POINT(X, Y) > 0 THEN
FOR a = 1 TO 5
CIRCLE (X * 6 - 3 + SX, Y * 6 - 3 + SY), a, 9 + CINT(RND * 2) * 3
NEXT a
SOUND X * 5 + 100, .1
END IF
NEXT Y
NEXT X
LOCATE 1, 1: PRINT "           "
PALETTE 4, 53
COLOR 4
LOCATE 14, 35
PRINT "Loading....."
FOR N = 1 TO 33
SX = N * 32 - 32
SY = 0
IF N > 20 THEN SX = SX - 640: SY = SY + 30
FOR Y = 1 TO 30
INPUT #1, a$
FOR X = 1 TO 32
L$ = MID$(a$, X, 1)
C = ASC(L$) - 200
IF C > 0 THEN PSET (X + SX, Y + SY), C
NEXT X
NEXT Y
NEXT N
CLOSE #1
DIM b1%(480), b2%(480), b3%(480), b4%(480), b5%(480), b6%(480), b7%(480)
DIM b8%(480), b9%(480), b10%(480), b11%(480), b12%(480), b13%(480), b14%(480)
DIM b15%(480), b16%(480), b17%(480), b18%(480), b19%(480), b20%(480), b21%(480)
DIM b23%(480), b24%(480), b22%(480)
DIM zp1%(480), zP2%(480)
DIM zP3%(480), zP4%(480), zP5%(480), zP6%(480), zP7%(480), zP8%(480), zP9%(480)
GET (1, 1)-(32, 30), b1%
GET (33, 1)-(64, 30), b2%
GET (65, 1)-(96, 30), b3%
GET (97, 1)-(128, 30), b4%
GET (129, 1)-(160, 30), b5%
GET (161, 1)-(192, 30), b6%
GET (193, 1)-(224, 30), b7%
GET (225, 1)-(256, 30), b8%
GET (257, 1)-(288, 30), b9%
GET (289, 1)-(320, 30), b10%
GET (321, 1)-(352, 30), b11%
GET (353, 1)-(384, 30), b12%
GET (385, 1)-(416, 30), b13%
GET (417, 1)-(448, 30), b14%
GET (449, 1)-(480, 30), b15%
GET (481, 1)-(512, 30), b16%
GET (513, 1)-(544, 30), b17%
GET (545, 1)-(576, 30), b18%
GET (577, 1)-(608, 30), b19%
GET (609, 1)-(639, 30), b20%
GET (1, 31)-(32, 60), b21%
GET (33, 31)-(64, 60), b22%
GET (65, 31)-(96, 60), zp1%
GET (97, 31)-(128, 60), zP2%
GET (129, 31)-(160, 60), zP3%
GET (161, 31)-(192, 60), zP4%
GET (193, 31)-(224, 60), zP5%
GET (225, 31)-(256, 60), zP6%
GET (257, 31)-(288, 60), zP7%
GET (289, 31)-(320, 60), zP8%
GET (321, 31)-(352, 60), zP9%
GET (353, 31)-(384, 60), b23%
GET (385, 31)-(416, 60), b24%
GET (152, 100)-(444, 190), LOGATH%
DIM L(21, 17), M(50, 15)
LINE (0, 0)-(640, 60), 0, BF
LOCATE 14, 35
PRINT "            "
START:
DO
LOCATE 18, 26: COLOR 9: PRINT "1-Play Logath"
LOCATE 20, 26: COLOR 9: PRINT "2-Edit a level"
LOCATE 22, 26: COLOR 12: PRINT "3-Exit Logath"
LOCATE 24, 26: COLOR 9: PRINT "4-Test Level"
LOCATE 26, 26: COLOR 9: PRINT "5-Instructions"
IF LVEL < 1 THEN LVEL = 1
IF LVEL > 50 THEN LVEL = 50
LOCATE 14, 28: COLOR 14: PRINT "Current Level-"; LVEL
LOCATE 16, 28: COLOR 14: PRINT "+ or - To Change"
DO: a$ = UCASE$(INKEY$)
PUT (152 + 3 - 6 * COS(TIMER * 3), 100 + 3 - 6 * SIN(TIMER * 2)), LOGATH%, PSET
LOOP WHILE a$ = ""
IF a$ = "1" THEN GOSUB goB:  CLS
IF a$ = "4" THEN LIFE(1) = 5: LIFE(2) = 5: GOSUB ACTION: CLS
IF a$ = "2" THEN GOSUB edit: CLS
IF a$ = "3" THEN RUN "\TIM\menu.bas"
IF a$ = "5" THEN GOSUB instruct: CLS
IF a$ = "-" THEN LVEL = LVEL - 1
IF a$ = "+" THEN LVEL = LVEL + 1
IF a$ = "/" THEN LVEL = LVEL - 10
IF a$ = "*" THEN LVEL = LVEL + 10
LOOP
goB:
FOR N = 1 TO 2
LIFE(N) = 5
K(N) = 0
B(N) = 0
P(N) = 0
NEXT N
LVEL = 0
DO
LVEL = LVEL + 1
CR = 1
FOR N = 1 TO 2
K(N) = 0
HP(N) = 10
NEXT N
IF LVEL / 5 = INT(LVEL / 5) THEN GOSUB STORE: CR = 1
GOSUB ACTION
LOOP WHILE LVEL < 50 AND CR = 1
DO: LOOP WHILE INKEY$ <> ""
RETURN
STORE:
CLS
PALETTE 4, 0
COLOR 4: PRINT "Store"
SX = 192
SY = 100
FOR X = 0 TO 48
FOR Y = 0 TO 15
IF POINT(X, Y) > 0 THEN
FOR a = 0 TO 2
LINE (X * 6 - 6 + SX + a, Y * 6 - 6 + SY + a)-(X * 6 - 1 + SX - a, Y * 6 - 1 + SY - a), 9 + a, B
CIRCLE (X * 6 - 3 + SX, Y * 6 - 3 + SY), a + 4, 14 - a
NEXT a
END IF
NEXT Y
NEXT X
LOCATE 1, 1: PRINT "           "
PALETTE 4, 53
FOR a = 0 TO 7
LINE (a, a)-(639 - a, 479 - a), a + 9, B
NEXT a
LOCATE 18, 30: COLOR 12: PRINT "Bombs: Buy-10, Sell-7"
LOCATE 20, 30: COLOR 14: PRINT "Lives: Buy-30, Sell-15"
LOCATE 24, 30: COLOR 9: PRINT "<<<<<<<< Done >>>>>>>>"
DO
FOR N = tp1 TO tP2
IF N = 1 THEN SX = 1
IF N = 2 THEN SX = 63
LINE (0 + SX * 8, 10)-(4 * 32 - 1 + SX * 8, 7 * 30 - 1 + 10), 0, BF
LINE (0 + SX * 8, 10)-(4 * 32 - 1 + SX * 8, 7 * 30 - 1 + 10), 9, B
LINE (1 + SX * 8, 11)-(4 * 32 - 2 + SX * 8, 7 * 30 - 2 + 10), 12, B
LOCATE 3, 4 + SX: COLOR 12: PRINT "Player"; N
LOCATE 5, 2 + SX: COLOR 15: PRINT "Hitpoints"; HP(N)
LOCATE 7, 2 + SX: COLOR 14: PRINT "Bombs"; B(N)
LOCATE 9, 2 + SX: COLOR 9: PRINT "Keys"; K(N)
LOCATE 11, 2 + SX: COLOR 13: PRINT "Lives"; LIFE(N)
LOCATE 13, 2 + SX: COLOR 10: PRINT "Score"; P(N)
NEXT N
FOR N = tp1 TO tP2
FOR G = 1 TO 4
LOCATE 16 + G * 2, 28 + (N - 1) * 25
COLOR 15:
IF PT(N) = G THEN PRINT "#" ELSE PRINT " "
NEXT G
NEXT N
DO: a$ = UCASE$(INKEY$): LOOP WHILE a$ = ""
FOR N = tp1 TO tP2
IF a$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF a$ = C$(N, 1) THEN a$(N) = "^"
IF a$ = C$(N, 2) THEN a$(N) = "<"
IF a$ = C$(N, 3) THEN a$(N) = ">"
IF a$ = C$(N, 4) THEN a$(N) = "v"
IF a$ = C$(N, 5) THEN a$(N) = "*"
IF a$ = C$(N, 6) THEN a$(N) = "I"
NEXT N
FOR N = tp1 TO tP2
IF PT(N) < 4 THEN
IF a$(N) = "^" THEN PT(N) = PT(N) - 1
IF a$(N) = "v" THEN PT(N) = PT(N) + 1
IF a$(N) = ">" AND PT(N) = 1 AND P(N) >= 10 THEN P(N) = P(N) - 10: B(N) = B(N) + 1
IF a$(N) = "<" AND PT(N) = 1 AND B(N) >= 1 THEN P(N) = P(N) + 7: B(N) = B(N) - 1
IF a$(N) = ">" AND PT(N) = 2 AND P(N) >= 30 THEN P(N) = P(N) - 30: LIFE(N) = LIFE(N) + 1
IF a$(N) = "<" AND PT(N) = 2 AND LIFE(N) >= 1 THEN P(N) = P(N) + 15: LIFE(N) = LIFE(N) - 1
END IF
IF a$(N) = "*" THEN PT(N) = 4
IF PT(N) < 1 THEN PT(N) = 1
IF PT(N) = 3 THEN PT(N) = 2
NEXT N
CR = 2
FOR N = tp1 TO tP2
IF PT(N) = 4 THEN CR = CR - 1
NEXT N
IF CR = 0 THEN CLS : RETURN
LOOP
ACTION:
FOR N = 1 TO 2
RD(N, 1) = HP(N)
RD(N, 2) = K(N)
RD(N, 3) = B(N)
RD(N, 4) = LIFE(N)
RD(N, 5) = P(N)
NEXT N
LINE (200, 200)-(440, 280), 0, BF
LINE (200, 200)-(440, 280), 9, B
LOCATE 15, 36
COLOR 12
PRINT "Level"; LVEL
GOSUB LOAD
FOR N = 1 TO 2: X(N) = SX(N): Y(N) = SY(N): L(X(N), Y(N)) = 0: OX(N) = X(N): OY(N) = Y(N):
HP(N) = 10
NEXT N
tp1 = 1: tP2 = 2
DO
FOR LA = 1 TO 7
LX = INT(20 * RND) + 1
LY = INT(16 * RND) + 1
IF L(LX, LY) = 7 THEN GOSUB LAZER
NEXT LA
DO: LOOP WHILE TIMER - ZME < .1
ZME = TIMER
a$(1) = "": a$(2) = ""
FOR L = 1 TO 4
a$ = UCASE$(INKEY$)
IF a$ = "^" THEN FOR N = 1 TO 2: HP(N) = RD(N, 1): K(N) = RD(N, 2): B(N) = RD(N, 3): LIFE(N) = RD(N, 4): P(N) = RD(N, 5): NEXT N: GOTO ACTION
IF a$ = "&" THEN CR = 0: RETURN
IF a$ = "," THEN SP = SP / 1.1
IF a$ = "." THEN SP = SP * 1.1
FOR N = tp1 TO tP2
IF HP(N) > 0 AND a$(N) = "" THEN
IF a$ = C$(N, 1) THEN a$(N) = "^"
IF a$ = C$(N, 2) THEN a$(N) = "<"
IF a$ = C$(N, 3) THEN a$(N) = ">"
IF a$ = C$(N, 4) THEN a$(N) = "v"
IF a$ = C$(N, 5) THEN a$(N) = "*"
IF a$ = C$(N, 6) THEN a$(N) = "I"
END IF
NEXT N
NEXT L
FOR N = tp1 TO tP2
IF a$(N) = "^" THEN IF L(X(N), Y(N)) = 18 THEN Y(N) = Y(N) - 1 ELSE IF L(X(N), Y(N) + 1) <> 0 THEN J(N) = -3
LD = L(X(N), Y(N) + 1)
IF a$(N) = "v" THEN IF LD = 0 OR LD = 18 THEN Y(N) = Y(N) + 1
IF a$(N) = "<" THEN X(N) = X(N) - 1
IF a$(N) = ">" THEN X(N) = X(N) + 1
IF a$(N) = "*" THEN IF B(N) > 0 THEN B(N) = B(N) - 1: GOSUB BOMB:
IF a$(N) = "I" THEN GOSUB INV
NEXT N
FOR N = tp1 TO tP2
IF X(N) < 1 THEN X(N) = 1
IF Y(N) < 1 THEN Y(N) = 1
IF X(N) > 20 THEN X(N) = 20
IF Y(N) > 16 THEN Y(N) = 16
LD = L(X(N), Y(N) + 1)
s = 0
IF LD = 1 OR LD = 2 OR LD = 3 OR LD = 7 OR LD = 9 OR LD = 10 OR LD = 12 OR LD = 13 OR LD = 14 OR LD = 17 OR LD = 16 OR LD = 18 OR LD = 22 OR L(X(N), Y(N)) = 18 OR LD < 0 THEN s = 1
IF J(N) < 0 THEN Y(N) = Y(N) - 1 ELSE IF s = 0 THEN Y(N) = Y(N) + 1
IF J(N) <= 0 THEN J(N) = J(N) + 1
IF X(N) < 1 THEN X(N) = 1
IF Y(N) < 1 THEN Y(N) = 1
IF X(N) > 20 THEN X(N) = 20
IF Y(N) > 16 THEN Y(N) = 16
NEXT N
FOR N = tp1 TO tP2
LV = L(X(N), Y(N))
LD = L(X(N), Y(N) + 1)
LV = L(X(N), Y(N))
IF LV = 1 THEN X(N) = OX(N): Y(N) = OY(N)
IF LV < 0 THEN X(N) = OX(N): Y(N) = OY(N)
IF LV = 2 THEN IF OX(N) < X(N) THEN Y(N) = Y(N) - 1 ELSE X(N) = OX(N): Y(N) = OY(N)
IF LV = 3 THEN IF OX(N) > X(N) THEN Y(N) = Y(N) - 1 ELSE X(N) = OX(N): Y(N) = OY(N)
IF LV = 4 THEN IF OY(N) < Y(N) THEN X(N) = X(N) - 1 ELSE IF OX(N) < X(N) THEN Y(N) = Y(N) - 1 ELSE X(N) = OX(N): Y(N) = OY(N)
IF LV = 5 THEN IF OY(N) < Y(N) THEN X(N) = X(N) + 1 ELSE IF OX(N) > X(N) THEN Y(N) = Y(N) - 1 ELSE X(N) = OX(N): Y(N) = OY(N)
IF LV = 6 THEN L(X(N), Y(N)) = 0: B(N) = B(N) + 1: P(N) = P(N) + 1: FOR a = 1 TO 10: SOUND 200 + a * 100, .1: NEXT a
IF LV = 7 THEN HP(N) = HP(N) - 1: X(N) = OX(N): Y(N) = OY(N): FOR a = 1 TO 10: SOUND 37 + a * 10 * RND, .1: NEXT a
IF LV = 8 THEN IF OY(N) < Y(N) THEN HP(N) = HP(N) - 2: FOR a = 1 TO 20: SOUND 37 + a * 10 * RND, .1: NEXT a ELSE : HP(N) = HP(N) - 1: FOR a = 1 TO 10: SOUND 37 + a * 10 * RND, .1: NEXT a
IF LV = 23 THEN IF OY(N) > Y(N) THEN HP(N) = HP(N) - 2: FOR a = 1 TO 20: SOUND 37 + a * 10 * RND, .1: NEXT a ELSE : HP(N) = HP(N) - 1: FOR a = 1 TO 10: SOUND 37 + a * 10 * RND, .1: NEXT a
IF LV = 24 THEN HP(N) = HP(N) + 1: P(N) = P(N) + 1: L(X(N), Y(N)) = 0: : FOR a = 1 TO 20: SOUND 3000 + a * 10 * RND, .1: NEXT a
IF X(N) < 1 THEN X(N) = 1
IF Y(N) < 1 THEN Y(N) = 1
IF X(N) > 20 THEN X(N) = 20
IF Y(N) > 16 THEN Y(N) = 16
IF LV = 12 THEN
 L(X(N), Y(N)) = 14
 qCH = 9
 C1 = 10
 C2 = 11
 GOSUB change
 px = X(N)
 py = Y(N)
 GOSUB pp
 X(N) = OX(N)
END IF
IF LV = 13 THEN L(X(N), Y(N)) = 12: qCH = 10: C1 = 9: C2 = 11: GOSUB change: px = X(N): py = Y(N): GOSUB pp: X(N) = OX(N)
IF LV = 14 THEN L(X(N), Y(N)) = 13: qCH = 11: C1 = 9: C2 = 10: GOSUB change: px = X(N): py = Y(N): GOSUB pp: X(N) = OX(N)
IF LV = 15 THEN L(X(N), Y(N)) = 0: P(N) = P(N) + 1: FOR a = 1 TO 10: SOUND 2000 + a * 50, .1: NEXT a
IF LV = 19 THEN LIFE(N) = LIFE(N) + 1: L(X(N), Y(N)) = 0: P(N) = P(N) + 3: FOR a = 1 TO 20: SOUND 1000 + a * 150, .1: NEXT a
IF LV = 21 THEN K(N) = K(N) + 1: L(X(N), Y(N)) = 0: P(N) = P(N) + 2: FOR a = 1 TO 5: SOUND 2000 + a * 50, .2: NEXT a
IF LV = 22 THEN IF K(N) > 0 THEN L(X(N), Y(N)) = 0: K(N) = K(N) - 1: P(N) = P(N) + 1 ELSE X(N) = OX(N): Y(N) = OY(N)
IF LV = 30 THEN GOSUB MACPUT: FOR a = 1 TO 10: SOUND 100 + a * 10, .1: SOUND 3000 - a * 100, .1: NEXT a
IF LV = 9 THEN X(N) = OX(N): Y(N) = OY(N)
IF LV = 10 THEN X(N) = OX(N): Y(N) = OY(N)
IF LD = 9 THEN X(N) = X(N) + 1
IF LD = 10 THEN X(N) = X(N) - 1
IF L(X(N), Y(N)) = 1 THEN X(N) = OX(N): Y(N) = OY(N)
IF LD = 17 AND Y(N) = OY(N) THEN
IF L(X(N) + EV(N), Y(N) + 1) = 0 THEN X(N) = X(N) + EV(N): L(X(N) - EV(N), Y(N) + 1) = 0: L(X(N), Y(N) + 1) = 17: py = Y(N) + 1: px = X(N) - EV(N): GOSUB pp: px = X(N): GOSUB pp
IF L(X(N) + EV(N), Y(N) + 1) <> 0 THEN EV(N) = -EV(N)
END IF
IF LD = 16 AND X(N) = OX(N) AND Y(N) < 16 THEN
PT(N) = 0
IF Y(N) < 1 THEN Y(N) = 1
IF Y(N) = 1 THEN EV(N) = 1
IF EV(N) = 1 AND L(X(N), Y(N) + 2) = 0 THEN Y(N) = Y(N) + 1: L(X(N), Y(N)) = 0: L(X(N), Y(N) + 1) = 16: px = X(N): py = Y(N) + 1: GOSUB pp:  py = Y(N) + 2: GOSUB pp
IF EV(N) = -1 AND L(X(N), Y(N) - 1) = 0 THEN Y(N) = Y(N) - 1: L(X(N), Y(N) + 2) = 0: L(X(N), Y(N) + 1) = 16: px = X(N): py = Y(N) + 1: GOSUB pp: py = Y(N) + 2: GOSUB pp
IF EV(N) = 1 AND L(X(N), Y(N) + 2) <> 0 THEN EV(N) = -1
IF EV(N) = -1 AND L(X(N), Y(N) - 1) <> 0 THEN EV(N) = 1
END IF
NEXT N
FOR N = 1 TO 2
IF HP(N) <= 0 AND LIFE(N) > 0 THEN LIFE(N) = LIFE(N) - 1: X(N) = SX(N): Y(N) = SY(N): HP(N) = 10: FOR a = 1 TO 10: SOUND 37 + a * 100, .1: SOUND 1100 - a * 100, .1: NEXT a
NEXT N
IF LIFE(1) <= 0 THEN tp1 = 2
IF LIFE(2) <= 0 THEN tP2 = 1
FOR N = tp1 TO tP2
IF OY(N) < Y(N) THEN Y(N) = OY(N) + 1
IF OX(N) <> X(N) OR OY(N) <> Y(N) OR J <= 0 THEN
IF L(X(N), Y(N)) = 0 THEN L(X(N), Y(N)) = -N
IF L(OX(N), OY(N)) = -N THEN L(OX(N), OY(N)) = 0
px = OX(N): py = OY(N): GOSUB pp
px = X(N): py = Y(N):
L = 31
IF Y(N) < OY(N) THEN PT(N) = 0
IF Y(N) < OY(N) THEN L = 33 ELSE IF Y(N) > OY(N) THEN L = 32: PT(N) = PT(N) + 1: IF PT(N) < 1 THEN PT(N) = 1
IF HP(N) < OHP(N) THEN L = 36
IF Y(N) = OY(N) THEN PT(N) = PT(N) - 1: IF PT(N) > -1 THEN PT(N) = -1
IF X(N) <> OX(N) THEN IF PT(N) < 0 THEN PT(N) = 0
IF PT(N) = -15 THEN L = 34
IF PT(N) = -16 THEN L = 35
IF PT(N) < -15 THEN PT(N) = -14
IF PT(N) = 4 THEN L = 39
IF PT(N) = 5 THEN L = 37
IF PT(N) = 6 THEN L = 38
IF PT(N) > 5 THEN PT(N) = 2
IF N = 1 THEN cc = 9
IF N = 2 THEN cc = 12
GOSUB PPP
END IF
NEXT N
FOR N = tp1 TO tP2
OX(N) = X(N): OY(N) = Y(N): OHP(N) = HP(N)
IF L(X(N), Y(N)) = 20 THEN P(N) = P(N) + 10: RETURN
NEXT N
LOOP
change:
CN = 0
CH(CN, 1) = X(N)
CH(CN, 2) = Y(N)
pCH:
ZX = -1: ZY = -1: GOSUB CHA
ZX = -1: ZY = 0: GOSUB CHA
ZX = -1: ZY = 1: GOSUB CHA
ZX = 0: ZY = -1: GOSUB CHA
ZX = 0: ZY = 0: GOSUB CHA
ZX = 0: ZY = 1: GOSUB CHA
ZX = 1: ZY = -1: GOSUB CHA
ZX = 1: ZY = 0: GOSUB CHA
ZX = 1: ZY = 1: GOSUB CHA
CN = CN - 1
RETURN
INV:
LINE (0, 0)-(4 * 32 - 1, 7 * 30 - 1), 0, BF
LINE (0, 0)-(4 * 32 - 1, 7 * 30 - 1), 9, B
LINE (1, 1)-(4 * 32 - 2, 7 * 30 - 2), 12, B
LOCATE 2, 4: COLOR 12: PRINT "Player"; N
LOCATE 4, 2: COLOR 15: PRINT "Hitpoints"; HP(N)
LOCATE 6, 2: COLOR 14: PRINT "Bombs"; B(N)
LOCATE 8, 2: COLOR 9: PRINT "Keys"; K(N)
LOCATE 10, 2: COLOR 13: PRINT "Lives"; LIFE(N)
LOCATE 12, 2: COLOR 10: PRINT "Score"; P(N)
DO: LOOP WHILE INKEY$ <> ""
L = 0
DO:
a$ = UCASE$(INKEY$)
IF a$ = "Z" AND N = 1 THEN L = 1
IF a$ = "*" AND N = 2 THEN L = 1
LOOP WHILE L = 0
FOR px = 1 TO 4
FOR py = 1 TO 7
GOSUB pp
NEXT py
NEXT px
RETURN
CHA:
CX = CH(CN, 1)
CY = CH(CN, 2)
IF L(CX + ZX, CY + ZY) <> C1 AND L(CX + ZX, CY + ZY) <> C2 THEN RETURN
L(CX + ZX, CY + ZY) = CH
px = CX + ZX
py = CY + ZY
GOSUB pp
CN = CN + 1
CH(CN, 1) = CX + ZX
CH(CN, 2) = CY + ZY
GOSUB pCH
RETURN
BOMB:
IF N = 1 THEN NN = 2
IF N = 2 THEN NN = 1
FOR py = Y(N) - 1 TO Y(N) + 1
FOR px = X(N) - 1 TO X(N) + 1
CIRCLE (px * 32 - 16, py * 30 - 15), 5, 12
CIRCLE (px * 32 - 16, py * 30 - 15), 10, 4
CIRCLE (px * 32 - 16, py * 30 - 15), 14, 12
IF px = X(NN) AND py = Y(NN) THEN HP(NN) = HP(NN) - 3: P(N) = P(N) + 1: SOUND 37, .2
SOUND 37 + 100 * RND, .1
IF L(px, py) = 8 THEN L(px, py) = 0
IF L(px, py) = 15 THEN L(px, py) = 0
IF L(px, py) = 23 THEN L(px, py) = 0
IF L(px, py) = 24 THEN L(px, py) = 0
IF L(px, py) = 4 THEN L(px, py) = 2
IF L(px, py) = 5 THEN L(px, py) = 3
IF L(px, py) = 7 THEN L(px, py) = 0
GOSUB pp
NEXT px
NEXT py
RETURN
MACPUT:
s = 0
FOR a = MCN TO 1 STEP -1
IF M(a, 1) = X(N) AND M(a, 2) = Y(N) THEN s = a
NEXT a
IF s = 0 THEN RETURN
L(X(N), Y(N)) = 0
P = 6
FOR py = M(s, 4) - 1 TO M(s, 4) + 1
FOR px = M(s, 3) - 1 TO M(s, 3) + 1
P = P + 1
L(px, py) = M(s, P): GOSUB pp
NEXT px
NEXT py
P(N) = P(N) + M(s, 5)
HP(N) = HP(N) - M(s, 6)
RETURN
LAZER:
LLX = LX
RLX = LX
FOR a = 1 TO 7
IF L(LLX - 1, LY) <= 0 AND LLX > 1 THEN LLX = LLX - 1
IF L(RLX + 1, LY) <= 0 AND RLX < 20 THEN RLX = RLX + 1
NEXT a
FOR a = 15 TO 0 STEP -4
LINE (LLX * 32 - 32, LY * 30 - 30 + a)-(RLX * 32 - 1, LY * 30 - 1 - a), 12, BF
NEXT a
FOR a = 1 TO 3: SOUND 37, .1: SOUND 200, .1: SOUND 500, .1: NEXT a
py = LY
FOR px = LLX TO RLX
GOSUB pp
IF px = X(1) AND py = Y(1) THEN HP(1) = HP(1) - 2: SOUND 37, .2
IF px = X(2) AND py = Y(2) THEN HP(2) = HP(2) - 2: SOUND 37, .2
NEXT px
RETURN
edit:
 GOSUB LOAD
DO
OX = X: OY = Y
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "c" THEN
FOR X = 1 TO 20
FOR Y = 1 TO 16
L(X, Y) = 0
NEXT Y
NEXT X
GOSUB LEVEL
MCN = 0
FOR a = 1 TO 50
FOR B = 1 TO 15
M(a, B) = 0
NEXT B
NEXT a
FOR N = tp1 TO tP2
SX(N) = 0: SY(N) = 0
NEXT N
END IF
IF a$ = "g" THEN
FOR a = 1 TO 10
X = INT(20 * RND + 1)
Y = INT(16 * RND) + 1
IF L(X, Y) = 0 THEN L(X, Y) = 15 ELSE IF L(X, Y) = 15 THEN L(X, Y) = 0
px = X: py = Y: GOSUB pp
NEXT a
END IF
IF a$ = "8" THEN Y = Y - 1
IF a$ = "2" THEN Y = Y + 1
IF a$ = "4" THEN X = X - 1
IF a$ = "6" THEN X = X + 1
IF a$ = "7" THEN X = X - 1: Y = Y - 1
IF a$ = "9" THEN X = X + 1: Y = Y - 1
IF a$ = "1" THEN X = X - 1: Y = Y + 1
IF a$ = "3" THEN X = X + 1: Y = Y + 1
IF MD = 0 THEN
IF a$ = "t" THEN GOSUB TESTA:
IF a$ = "M" THEN GOSUB MAC: IF s > 0 THEN GOSUB TEST:
IF a$ = "s" THEN GOSUB save:
IF a$ = "l" THEN GOSUB LOAD:
IF a$ = "v" THEN GOSUB MAC: IF s > 0 THEN GOSUB JJ
IF a$ = "m" THEN KX = X: KY = Y: MD = 1:
IF a$ = "Q" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 1
IF a$ = "W" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 2
IF a$ = "E" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 3
IF a$ = "R" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 4
IF a$ = "T" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 5
IF a$ = "Y" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 6
IF a$ = "U" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 7
IF a$ = "I" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 8
IF a$ = "O" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 9
IF a$ = "P" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 10
IF a$ = "A" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 11
IF a$ = "S" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 12
IF a$ = "D" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 13
IF a$ = "F" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 14
IF a$ = "G" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 15
IF a$ = "H" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 16
IF a$ = "J" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 17
IF a$ = "K" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 18
IF a$ = "L" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 19
IF a$ = "Z" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 20
IF a$ = "X" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 21
IF a$ = "C" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 22
IF a$ = "V" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 23
IF a$ = "B" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 24
IF a$ = "!" THEN L(SX(1), SY(1)) = 0: px = SX(1): py = SY(1): GOSUB pp: SX(1) = X: SY(1) = Y: L(X, Y) = 31: cc = 9
IF a$ = "@" THEN L(SX(2), SY(2)) = 0: px = SX(2): py = SY(2): GOSUB pp: SX(2) = X: SY(2) = Y: L(X, Y) = 31: cc = 12
IF a$ = "`" THEN IF L(X, Y) <= 24 THEN L(X, Y) = 0
IF a$ = "~" THEN CLS : RETURN
END IF
IF MD = 1 AND a$ = " " THEN GOSUB MACRO:  MD = 0
IF X < 1 THEN X = 1
IF Y < 1 THEN Y = 1
IF X > 20 THEN X = 20
IF Y > 16 THEN Y = 16
px = OX: py = OY: GOSUB pp
IF MD = 0 THEN
CIRCLE (X * 32 - 16, Y * 30 - 15), 10, 15
CIRCLE (X * 32 - 16, Y * 30 - 15), 13, 7
CIRCLE (X * 32 - 16, Y * 30 - 15), 7, 8
END IF
IF MD = 1 THEN
CIRCLE (X * 32 - 16, Y * 30 - 15), 5, 9
CIRCLE (X * 32 - 16, Y * 30 - 15), 10, 12
CIRCLE (X * 32 - 16, Y * 30 - 15), 14, 14
END IF
LOOP
TESTA:
KL = 1
FOR s = 1 TO MCN
X = M(s, 3)
Y = M(s, 4)
KX = M(s, 1)
KY = M(s, 2)
IF M(s, 0) = 1 THEN GOSUB TEST
NEXT s
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
KL = 2
FOR s = 1 TO MCN
X = M(s, 3)
Y = M(s, 4)
KX = M(s, 1)
KY = M(s, 2)
IF M(s, 0) = 1 THEN GOSUB TEST
NEXT s
KL = 0
TEST:
IF KL <> 2 THEN
P = 6
FOR LY = Y - 1 TO Y + 1
FOR LX = X - 1 TO X + 1
P = P + 1
px = LX: py = LY: L = M(s, P): GOSUB PPP
NEXT LX
NEXT LY
END IF
IF KL <> 1 THEN
IF KL <> 2 THEN
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
END IF
FOR LY = Y - 1 TO Y + 1
FOR LX = X - 1 TO X + 1
px = LX: py = LY:  GOSUB pp
NEXT LX
NEXT LY
X = KX: Y = KY
END IF
RETURN
MAC:
s = 0
FOR a = MCN TO 1 STEP -1
IF M(a, 1) = X AND M(a, 2) = Y AND M(a, 0) = 1 THEN s = a
NEXT a
IF s = 0 THEN RETURN
KX = M(s, 1): KY = M(s, 2)
X = M(s, 3): Y = M(s, 4)
RETURN
MACRO:
P = 6
DO
s = 0
FOR a = MCN TO 1 STEP -1
IF M(a, 0) = 0 THEN s = a
NEXT a
IF s = 0 THEN MCN = MCN + 1
LOOP WHILE s = 0
JJ:
CLS
P = 6
py = 0
FOR LY = Y - 1 TO Y + 1
py = py + 1: px = 0
FOR LX = X - 1 TO X + 1
px = px + 1
P = P + 1
IF MD = 1 THEN M(s, P) = L(LX, LY)
L = M(s, P): GOSUB PPP
NEXT LX
NEXT LY
M(s, 0) = 1
M(s, 1) = KX
M(s, 2) = KY
M(s, 3) = X
M(s, 4) = Y
L(KX, KY) = 30
MX = 1: MY = 1
DO
LOCATE 10, 1: COLOR 15
PRINT "Points"; M(s, 5)
PRINT "Damage"; M(s, 6)
DO: B$ = INKEY$: LOOP WHILE B$ = ""
OSX = MX: OSY = MY: OP = P
IF B$ = "*" THEN M(s, 0) = 0: L(M(s, 1), M(s, 2)) = 0: LOCATE 7, 10: COLOR 4: PRINT "Macro deleted": DO: LOOP WHILE INKEY$ <> "": DO: LOOP WHILE INKEY$ = "": GOSUB LEVEL: X = KX: Y = KY: RETURN
IF B$ = "P" THEN M(s, 5) = M(s, 5) + 1
IF B$ = "p" THEN M(s, 5) = M(s, 5) - 1
IF B$ = "D" THEN M(s, 6) = M(s, 6) + 1
IF B$ = "d" THEN M(s, 6) = M(s, 6) - 1
IF B$ = "7" THEN P = 7: MX = 1: MY = 1
IF B$ = "8" THEN P = 8: MX = 2: MY = 1
IF B$ = "9" THEN P = 9: MX = 3: MY = 1
IF B$ = "4" THEN P = 10: MX = 1: MY = 2
IF B$ = "5" THEN P = 11: MX = 2: MY = 2
IF B$ = "6" THEN P = 12: MX = 3: MY = 2
IF B$ = "1" THEN P = 13: MX = 1: MY = 3
IF B$ = "2" THEN P = 14: MX = 2: MY = 3
IF B$ = "3" THEN P = 15: MX = 3: MY = 3
IF B$ = "-" THEN M(s, P) = M(s, P) - 1
IF B$ = "+" THEN M(s, P) = M(s, P) + 1
IF B$ = "`" THEN M(s, P) = 0
IF M(s, P) < 0 THEN M(s, P) = 24
IF M(s, P) > 24 THEN M(s, P) = 0
px = OSX: py = OSY: L = M(s, OP): GOSUB PPP
CIRCLE (MX * 32 - 16, MY * 30 - 15), 5, 9
CIRCLE (MX * 32 - 16, MY * 30 - 15), 10, 12
CIRCLE (MX * 32 - 16, MY * 30 - 15), 14, 14
IF B$ = " " THEN GOSUB LEVEL: X = KX: Y = KY: RETURN
LOOP
save:
GOSUB add
OPEN "Logath.l" + ad$ FOR OUTPUT AS #1
FOR Y = 1 TO 16
a$ = ""
FOR X = 1 TO 20
a$ = a$ + CHR$(L(X, Y) + 200)
NEXT X
PRINT #1, a$
NEXT Y
PRINT #1, SX(1), SY(1), SX(2), SY(2)
PRINT #1, MCN
FOR a = 1 TO MCN
FOR B = 0 TO 15
PRINT #1, M(a, B)
NEXT B
NEXT a
CLOSE #1
RETURN
LOAD:
FOR a = 1 TO 50
FOR B = 0 TO 15
M(a, B) = 0
NEXT B
NEXT a
MCN = 0
FOR X = 1 TO 20
L(X, 17) = 1
L(X, 0) = 1
NEXT X
FOR Y = 0 TO 17
L(0, Y) = 1
L(21, Y) = 1
NEXT Y
GOSUB add
OPEN "logath.l" + ad$ FOR INPUT AS #1
FOR Y = 1 TO 16
INPUT #1, a$
FOR X = 1 TO 20
L$ = MID$(a$, X, 1)
L(X, Y) = ASC(L$) - 200
NEXT X
NEXT Y
INPUT #1, SX(1), SY(1), SX(2), SY(2)
INPUT #1, MCN
FOR a = 1 TO MCN
FOR B = 0 TO 15
INPUT #1, M(a, B)
NEXT B
NEXT a
CLOSE #1
KK:
GOSUB LEVEL
RETURN
LEVEL:
CLS
FOR Y = 1 TO 16
FOR X = 1 TO 20
px = X: py = Y: GOSUB pp
NEXT X
NEXT Y
X = 10: Y = 8
DO: LOOP WHILE INKEY$ <> ""
RETURN
pp:
IF px < 1 OR py < 1 OR px > 20 OR py > 16 THEN RETURN
L = L(px, py)
PPP:
IF px < 1 OR py < 1 OR px > 20 OR py > 16 THEN RETURN
SX = px * 32 - 32: SY = py * 30 - 30
IF L >= 0 THEN ON L + 1 GOSUB P0, p1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16, P17, P18, P19, P20, P21, P22, P23, P24
IF L > 30 THEN ON L - 30 GOSUB PP1, PP2, PP3, PP4, PP5, PP6, PP7, PP8, PP9
IF L = 30 THEN GOSUB P15: LINE (SX, SY)-(SX + 2, SY + 2), 9, B: LINE (SX + 31, SY + 29)-(SX + 29, SY + 27), 9, B
IF L > 30 THEN CIRCLE (SX + 16, SY + 15), 14, cc
RETURN
P0:
 LINE (SX, SY)-(SX + 31, SY + 29), 0, BF: RETURN
p1:
 PUT (SX, SY), b1%, PSET: RETURN
P2:
 PUT (SX, SY), b2%, PSET: RETURN
P3:
 PUT (SX, SY), b3%, PSET: RETURN
P4:
 PUT (SX, SY), b4%, PSET: RETURN
P5:
 PUT (SX, SY), b5%, PSET: RETURN
P6:
 PUT (SX, SY), b6%, PSET: RETURN
P7:
 PUT (SX, SY), b7%, PSET: RETURN
P8:
 PUT (SX, SY), b8%, PSET: RETURN
P9:
 PUT (SX, SY), b9%, PSET: RETURN
P10:
 PUT (SX, SY), b10%, PSET: RETURN
P11:
 PUT (SX, SY), b11%, PSET: RETURN
P12:
 PUT (SX, SY), b12%, PSET: RETURN
P13:
 PUT (SX, SY), b13%, PSET: RETURN
P14:
 PUT (SX, SY), b14%, PSET: RETURN
P15:
 PUT (SX, SY), b15%, PSET: RETURN
P16:
 PUT (SX, SY), b16%, PSET: RETURN
P17:
 PUT (SX, SY), b17%, PSET: RETURN
P18:
 PUT (SX, SY), b18%, PSET: RETURN
P19:
 PUT (SX, SY), b19%, PSET: RETURN
P20:
 PUT (SX, SY), b20%, PSET: RETURN
P21:
 PUT (SX, SY), b21%, PSET: RETURN
P22:
 PUT (SX, SY), b22%, PSET: RETURN
P23:
 PUT (SX, SY), b23%, PSET: RETURN
P24:
 PUT (SX, SY), b24%, PSET: RETURN
PP1:
 PUT (SX, SY), zp1%, PSET: RETURN
PP2:
 PUT (SX, SY), zP2%, PSET: RETURN
PP3:
 PUT (SX, SY), zP3%, PSET: RETURN
PP4:
 PUT (SX, SY), zP4%, PSET: RETURN
PP5:
 PUT (SX, SY), zP5%, PSET: RETURN
PP6:
 PUT (SX, SY), zP6%, PSET: RETURN
PP7:
 PUT (SX, SY), zP7%, PSET: RETURN
PP8:
 PUT (SX, SY), zP8%, PSET: RETURN
PP9:
 PUT (SX, SY), zP9%, PSET: RETURN
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,1,1,1,1,1,3,0,0,0,0,2,3,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,1,3,0,0,2,1,1,1,1,5,0,0,0
DATA 0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,0,1,5,0,0
DATA 0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,5,0
DATA 0,0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,0,1,0,4
DATA 0,0,0,0,0,0,0,0,0,0,1,0,0,2,1,1,1,1,0,1
DATA 0,0,0,0,0,0,0,0,0,0,1,3,0,0,0,0,0,0,0,1
DATA 0,0,0,0,0,0,0,0,0,0,1,1,1,1,5,0,0,0,0,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,5,0,0,0,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,5,0,4,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,4,1,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,5,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0
add:
IF LVEL = 0 THEN ad$ = "00"
IF LVEL = 1 THEN ad$ = "01"
IF LVEL = 2 THEN ad$ = "02"
IF LVEL = 3 THEN ad$ = "03"
IF LVEL = 4 THEN ad$ = "04"
IF LVEL = 5 THEN ad$ = "05"
IF LVEL = 6 THEN ad$ = "06"
IF LVEL = 7 THEN ad$ = "07"
IF LVEL = 8 THEN ad$ = "08"
IF LVEL = 9 THEN ad$ = "09"
IF LVEL = 10 THEN ad$ = "10"
IF LVEL = 11 THEN ad$ = "11"
IF LVEL = 12 THEN ad$ = "12"
IF LVEL = 13 THEN ad$ = "13"
IF LVEL = 14 THEN ad$ = "14"
IF LVEL = 15 THEN ad$ = "15"
IF LVEL = 16 THEN ad$ = "16"
IF LVEL = 17 THEN ad$ = "17"
IF LVEL = 18 THEN ad$ = "18"
IF LVEL = 19 THEN ad$ = "19"
IF LVEL = 20 THEN ad$ = "20"
IF LVEL = 21 THEN ad$ = "21"
IF LVEL = 22 THEN ad$ = "22"
IF LVEL = 23 THEN ad$ = "23"
IF LVEL = 24 THEN ad$ = "24"
IF LVEL = 25 THEN ad$ = "25"
IF LVEL = 26 THEN ad$ = "26"
IF LVEL = 27 THEN ad$ = "27"
IF LVEL = 28 THEN ad$ = "28"
IF LVEL = 29 THEN ad$ = "29"
IF LVEL = 30 THEN ad$ = "30"
IF LVEL = 31 THEN ad$ = "31"
IF LVEL = 32 THEN ad$ = "32"
IF LVEL = 33 THEN ad$ = "33"
IF LVEL = 34 THEN ad$ = "34"
IF LVEL = 35 THEN ad$ = "35"
IF LVEL = 36 THEN ad$ = "36"
IF LVEL = 37 THEN ad$ = "37"
IF LVEL = 38 THEN ad$ = "38"
IF LVEL = 39 THEN ad$ = "39"
IF LVEL = 40 THEN ad$ = "40"
IF LVEL = 41 THEN ad$ = "41"
IF LVEL = 42 THEN ad$ = "42"
IF LVEL = 43 THEN ad$ = "43"
IF LVEL = 44 THEN ad$ = "44"
IF LVEL = 45 THEN ad$ = "45"
IF LVEL = 46 THEN ad$ = "46"
IF LVEL = 47 THEN ad$ = "47"
IF LVEL = 48 THEN ad$ = "48"
IF LVEL = 49 THEN ad$ = "49"
IF LVEL = 50 THEN ad$ = "50"
RETURN
instruct:
CLS
COLOR 15
PRINT "Items in Logath:"
COLOR 13
PRINT
PRINT "____-Wall or floor (very solid)"
PRINT "____"
PUT (0, 32 * 1), b1%, PSET
PRINT "________-Stairs (these help you get around)"
PRINT "________"
PUT (0, 32 * 2), b2%, PSET
PUT (32 * 1, 32 * 2), b3%, PSET
PRINT "________-Slides (these are slippery and tricky to climb"
PRINT "________"
PUT (0, 32 * 3), b4%, PSET
PUT (32 * 1, 32 * 3), b5%, PSET
PRINT "____-Bombs are used to blow up dangers or hurt a friend"
PRINT "____"
PUT (0, 32 * 4), b6%, PSET
PRINT "____________-Dangers, The spike just hurts while the lazer shoots"
PRINT "____________"
PUT (0, 32 * 5), b7%, PSET
PUT (32 * 1, 32 * 5), b8%, PSET
PUT (32 * 2, 32 * 5), b23%, PSET
PRINT "____________-Morphing Floor controled by switches"
PRINT "____________  (the last one is fall through and the first move you)"
PUT (0, 32 * 6), b9%, PSET
PUT (32 * 1, 32 * 6), b10%, PSET
PUT (32 * 2, 32 * 6), b11%, PSET
PRINT "____________-Switched used to change morphing floor"
PRINT "____________"
PUT (0, 32 * 7), b12%, PSET
PUT (32 * 1, 32 * 7), b13%, PSET
PUT (32 * 2, 32 * 7), b14%, PSET
PRINT "________-Stars give points and sometimes change the level"
PRINT "________ (blue stars heal you)"
PUT (0, 32 * 8), b15%, PSET
PUT (32 * 1, 32 * 8), b24%, PSET
PRINT "________-Elevators move when you get on them"
PRINT "________"
PUT (0, 32 * 9), b16%, PSET
PUT (32 * 1, 32 * 9), b17%, PSET
PRINT "____-Ladder is helpful in going up"
PRINT "____"
PUT (0, 32 * 10), b18%, PSET
PRINT "____-This is an Extra Life"
PRINT "____"
PUT (0, 32 * 11), b19%, PSET
PRINT "____-Go here, it will pass the level"
PRINT "____"
PUT (0, 32 * 12), b20%, PSET
PRINT "________-Key and Door, The keys are used to open doors"
PRINT "________"
PUT (0, 32 * 13), b21%, PSET
PUT (32 * 1, 32 * 13), b22%, PSET
GOSUB pause
CLS
COLOR 12
PRINT "The main idea of this game is for two players to work together to"
PRINT "finish the 50 dangerous levels to become LOGATH.   "
PRINT
COLOR 14
PRINT "As you go on through the levels they get harder.  Some require both"
PRINT "players to be alive."
COLOR 10
PRINT "Every five levels you visit the store where you can spend points on lives"
PRINT "and bombs.  To buy press right and to sell press left. Up and down chose what"
PRINT "to buy or sell. When tou are done press the set bomb button."
PRINT
COLOR 11
PRINT "The controls are:"
COLOR 9: PRINT "      W   `-Bomb      "; : COLOR 12: PRINT "                  8  +-Bomb                "
COLOR 9: PRINT "      |               "; : COLOR 12: PRINT "                  |                        "
COLOR 9: PRINT "    A-*-D             "; : COLOR 12: PRINT "                4-*-6                      "
COLOR 9: PRINT "      |               "; : COLOR 12: PRINT "                  |                        "
COLOR 9: PRINT "      S   Z-Status    "; : COLOR 12: PRINT "                  2  *-Status              "
COLOR 13
PRINT " ^(Shift+6) restart level   &(Shift+7) end game"
COLOR 14
PRINT "***********************************************"
PRINT "Make sure to have Caps Lock on and Num Lock on."
PRINT "***********************************************"
COLOR 15
PRINT "When playing the up is jump unless you are on a ladder.  Then it is just up."
PRINT "Do not hold down buttens while playing.  For better playing press repeatly."
PRINT
COLOR 11
PRINT "When in the editor the right controls are used.  To place an item press a"
PRINT "CAPITAL LETTERS.  To make a Macro go to where it will appear."
PRINT "Then press 'm' or shift+'M' with caps lock on. Then go to where it will"
PRINT "affect and press space.  Here you will chose what it will do.  Use + and"
PRINT "- to change the picture.  When done press space.  To exit the editor press"
PRINT "'~'(shift+'`').  To save press s. To load press l. To clear press c.";
GOSUB pause
CLS
COLOR 15
PRINT
PRINT "                                  TIPS"
PRINT
COLOR 10
PRINT "1. When making hard jumps press up and quickly press right or left."
PRINT
PRINT "2. It is possuble to jump off of anything.  This includes the tip of"
PRINT "spikes or even the other person."
PRINT
PRINT "3. To climb a slide repeadly press up and the direction(right or left) very"
PRINT "fast."
PRINT
PRINT "4. To steal a elevator from the other person go under them and right when"
PRINT "they go a space above you press up several times."
PRINT
PRINT "5. Use bombs wisly.  You need the other person to finish the game so don't kill"
PRINT "them.  Bombs are best used on slides to make easier to climb and dangers."
PRINT
GOSUB pause
RETURN
pause:
COLOR 13
LOCATE 30, 23: PRINT "Press any key to Continue";
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
LOCATE 30, 23: PRINT "                         ";
RETURN

