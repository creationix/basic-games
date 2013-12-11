'
'        ±   ± ±±±±  ±±  ±±±±±  ±±±  ±±±±          ±±±    ±±   ±±±±±
'        ±   ± ±    ±  ±   ±   ±   ± ±   ±        ±   ±  ±  ±    ±
'        ±   ± ±±±± ±      ±   ±   ± ±±±±   ±±±±  ±      ±±±±    ±
'         ± ±  ±    ±  ±   ±   ±   ± ±   ±        ±   ± ±    ±   ±
'          ±   ±±±±  ±±    ±    ±±±  ±   ±         ±±±  ±    ±   ±
'
'                           By Tim Caswell
'
'                              Controls
'
'        W   `   - Set Bomb      I   / - Set Bomb     8    + - Set bomb
'        |   Tab - Set off       |   ' - Set off      |    - - Set off
'      A-*-D       Detinator   J-*-L     Detinator  4-*-6      Detinator
'        |                       |                    |
'        S                       K                    2
'
'
'
OPEN "VECTOCAT.DAT" FOR INPUT AS #1
RANDOMIZE (TIMER)
SCREEN 12
DEFINT A-Y
PALETTE 4, 0
COLOR 4: PRINT "Vector-Cat"
SX = 98
SY = 100
FOR X = 0 TO 80
FOR Y = 0 TO 15
cc = POINT(X, Y)
IF cc > 0 THEN
LINE (X * 6 - 6 + SX, Y * 6 - 6 + SY)-(X * 6 - 1 + SX, Y * 6 - 1 + SY), 12, B
LINE (X * 6 - 5 + SX, Y * 6 - 5 + SY)-(X * 6 - 2 + SX, Y * 6 - 2 + SY), 4, B
END IF
NEXT Y
NEXT X
LOCATE 1, 1: PRINT "           "
FOR A = 1 TO 14
FOR B = 1 TO 6
LINE (A * 32 - 32 + 107, B * 30 - 30 + 240)-(A * 32 - 1 + 107, B * 30 - 1 + 240), 12, B
LINE (A * 32 - 22 + 107, B * 30 - 20 + 240)-(A * 32 - 10 + 107, B * 30 - 10 + 240), 4, B
NEXT B
NEXT A
PALETTE 4, 53
COLOR 4
LOCATE 14, 35
PRINT "Loading....."
FOR N = 1 TO 18
SX = N * 32 - 32
FOR Y = 1 TO 30
INPUT #1, A$
FOR X = 1 TO 32
L$ = MID$(A$, X, 1)
C = ASC(L$) - 200
PSET (X + SX, Y), C
NEXT X
NEXT Y
NEXT N
CLOSE #1
DIM B1%(480), B2%(480), B3%(480), B4%(480), B5%(480), B6%(480), B7%(480), B8%(480), B9%(480), B10%(480), B11%(480), B12%(480), P1%(480), P2%(480), P3%(480), P4%(480), B13%(480), B14%(480)
GET (1, 1)-(32, 30), B1%
GET (33, 1)-(64, 30), B2%
GET (65, 1)-(96, 30), B3%
GET (97, 1)-(128, 30), B4%
GET (129, 1)-(160, 30), B5%
GET (161, 1)-(192, 30), B6%
GET (193, 1)-(224, 30), B7%
GET (225, 1)-(256, 30), B8%
GET (257, 1)-(288, 30), B9%
GET (289, 1)-(320, 30), B10%
GET (321, 1)-(352, 30), B11%
GET (353, 1)-(384, 30), B12%
GET (385, 1)-(416, 30), P1%
GET (417, 1)-(448, 30), P2%
GET (449, 1)-(480, 30), P3%
GET (481, 1)-(512, 30), P4%
GET (513, 1)-(544, 30), B13%
GET (545, 1)-(576, 30), B14%
DIM L(21, 17), B(50, 5), X(4), Y(4), OX(4), OY(4), BN(4), BT(4), BS(4), S(4), w(4)
start:
CLS
FOR Y = 1 TO 16
FOR X = 1 TO 20
L = 0
IF RND < .6 THEN L = 2
IF RND < .2 THEN L = 1
IF (X) MOD 2 = 0 AND Y MOD 2 = 0 THEN L = 1
IF (X) MOD 2 = 1 AND Y MOD 2 = 1 AND RND > .5 THEN L = 8
IF X = 1 AND Y = 1 THEN L = 0
IF X = 2 AND Y = 1 THEN L = 0
IF X = 1 AND Y = 2 THEN L = 0
IF X = 20 AND Y = 1 THEN L = 0
IF X = 20 AND Y = 2 THEN L = 0
IF X = 19 AND Y = 1 THEN L = 0
IF X = 1 AND Y = 16 THEN L = 0
IF X = 2 AND Y = 16 THEN L = 0
IF X = 1 AND Y = 15 THEN L = 0
IF X = 20 AND Y = 16 THEN L = 0
IF X = 20 AND Y = 15 THEN L = 0
IF X = 19 AND Y = 16 THEN L = 0
L(X, Y) = L
SX = X: SY = Y: GOSUB PUTIT:
NEXT X
NEXT Y
FOR X = 0 TO 21
L(X, 0) = 9
L(X, 17) = 9
NEXT X
FOR Y = 1 TO 16
L(0, Y) = 9
L(21, Y) = 9
NEXT Y
FOR N = 1 TO 4
OX(N) = 10: OY(N) = 10
NEXT N
X(1) = 1: Y(1) = 1
X(2) = 20: Y(2) = 1
X(3) = 1: Y(3) = 16
X(4) = 20: Y(4) = 16
FOR N = 1 TO 4
BN(N) = 1
BS(N) = 1
BT(N) = 0
NEXT N
'***************************************************************************************************************************************************
'***************************************************************************************************************************************************
GZ = 0
DO
DO: LOOP WHILE TIMER - ZME < .001
'ZME = TIMER
FOR N = 1 TO 4
A$(N) = ""
NEXT N
GZ = GZ + 1
IF GZ > 3000 THEN GOSUB DISASTER: GZ = 2500
FOR N = 1 TO 2
A$ = INKEY$
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF S(1) = 0 THEN
IF A$ = "A" THEN A$(1) = "<"
IF A$ = "D" THEN A$(1) = ">"
IF A$ = "W" THEN A$(1) = "^"
IF A$ = "S" THEN A$(1) = "v"
IF A$ = "`" THEN A$(1) = "*"
IF A$ = CHR$(9) THEN A$(1) = "%"
END IF
IF S(2) = 0 THEN
IF A$ = "4" THEN A$(2) = "<"
IF A$ = "6" THEN A$(2) = ">"
IF A$ = "8" THEN A$(2) = "^"
IF A$ = "2" THEN A$(2) = "v"
IF A$ = "+" THEN A$(2) = "*"
IF A$ = "-" THEN A$(2) = "%"
END IF
IF S(3) = 0 THEN
IF A$ = "J" THEN A$(3) = "<"
IF A$ = "L" THEN A$(3) = ">"
IF A$ = "I" THEN A$(3) = "^"
IF A$ = "K" THEN A$(3) = "v"
IF A$ = "/" THEN A$(3) = "*"
IF A$ = "'" THEN A$(3) = "%"
END IF
IF S(4) = 0 THEN
IF RND < .1 THEN A$(4) = "<"
IF RND < .1 THEN A$(4) = ">"
IF RND < .1 THEN A$(4) = "^"
IF RND < .1 THEN A$(4) = "v"
IF RND < .005 THEN A$(4) = "*"
IF RND < .005 THEN A$(4) = "%"
END IF
NEXT N
FOR N = 1 TO 4
IF A$(N) = "<" THEN X(N) = X(N) - 1: GOSUB S1
IF A$(N) = ">" THEN X(N) = X(N) + 1: GOSUB S1
IF A$(N) = "^" THEN Y(N) = Y(N) - 1: GOSUB S1
IF A$(N) = "v" THEN Y(N) = Y(N) + 1: GOSUB S1
IF A$(N) = "*" THEN GOSUB BOMB:
IF X(N) < 0 THEN X(N) = 0
IF X(N) > 21 THEN X(N) = 21
IF Y(N) < 0 THEN Y(N) = 0
IF Y(N) > 17 THEN Y(N) = 17
LV = L(X(N), Y(N))
IF LV = 1 OR LV = 2 OR LV < 0 OR LV = 9 OR LV = 8 THEN X(N) = OX(N): Y(N) = OY(N)
IF LV = 3 THEN BS(N) = BS(N) + 1: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 4 THEN BN(N) = BS(N) + 1: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 5 AND BT(N) <> 2 THEN BT(N) = 1: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 6 THEN BT(N) = 2: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 20 THEN BT(N) = 3: L(X(N), Y(N)) = 0: GOSUB S2:
NEXT N
FOR N = 1 TO 4
IF OX(N) <> X(N) OR OY(N) <> Y(N) THEN
IF L(OX(N), OY(N)) > 10 THEN L(OX(N), OY(N)) = 0
SX = OX(N): SY = OY(N): GOSUB PUTIT
L = N + 10: SX = X(N): SY = Y(N): GOSUB PUTG: IF L(X(N), Y(N)) = 0 THEN L(X(N), Y(N)) = N + 10
END IF
NEXT N
FOR N = 1 TO 4
OX(N) = X(N): OY(N) = Y(N)
NEXT N
FOR ZN = 1 TO 50
IF B(ZN, 0) > 0 THEN
T = B(ZN, 0)
BX = B(ZN, 1)
BY = B(ZN, 2)
BT = B(ZN, 3)
IF BT = 3 THEN T = T + 1
FOR TH = 1 TO 4
IF BT = 3 AND B(ZN, 5) = TH AND A$(TH) = "%" THEN T = 0
NEXT TH
BS = B(ZN, 4)
T = T - 1
IF T <= 0 THEN GOSUB BLOWUP
B(ZN, 0) = T
END IF
NEXT ZN
LOOP
'***************************************************************************************************************************************************

'***************************************************************************************************************************************************
BLOWUP:
FOR WH = 1 TO 4
IF X(WH) = BX AND Y(WH) = BY THEN S(WH) = 1: GOSUB CHECK
NEXT WH
WH = 0
LX = BX - BS
FOR CX = BX - BS TO BX - 1
IF CX >= 0 AND CX <= 21 THEN
IF L(CX, BY) < 0 THEN LX = CX
IF L(CX, BY) > 0 AND BT = 0 THEN LX = CX
IF L(CX, BY) = 1 AND BT <> 2 THEN LX = CX + 1
IF L(CX, BY) = 9 THEN LX = CX + 1
END IF
NEXT CX
LY = BY - BS
FOR CY = BY - BS TO BY - 1
IF CY >= 0 AND CY <= 17 THEN
IF L(BX, CY) < 0 THEN LY = CY
IF L(BX, CY) > 0 AND BT = 0 THEN LY = CY
IF L(BX, CY) = 1 AND BT <> 2 THEN LY = CY + 1
IF L(BX, CY) = 9 THEN LY = CY + 1
END IF
NEXT CY
RX = BX + BS
FOR CX = BX + BS TO BX + 1 STEP -1
IF CX >= 0 AND CX <= 21 THEN
IF L(CX, BY) < 0 THEN RX = CX
IF L(CX, BY) > 0 AND BT = 0 THEN RX = CX
IF L(CX, BY) = 1 AND BT <> 2 THEN RX = CX - 1
IF L(CX, BY) = 9 THEN RX = CX - 1
END IF
NEXT CX
RY = BY + BS
FOR CY = BY + BS TO BY + 1 STEP -1
IF CY >= 0 AND CY <= 17 THEN
IF L(BX, CY) < 0 THEN RY = CY
IF L(BX, CY) > 0 AND BT = 0 THEN RY = CY
IF L(BX, CY) = 1 AND BT <> 2 THEN RY = CY - 1
IF L(BX, CY) = 9 THEN RY = CY - 1
END IF
NEXT CY
IF LX < 0 THEN LX = 0
IF RX > 21 THEN RX = 21
IF LY < 0 THEN LY = 0
IF RY > 17 THEN RY = 16
LINE (LX * 32 - 32, BY * 30 - 30)-(RX * 32 - 1, BY * 30 - 1), 14, BF
LINE (LX * 32 - 32, BY * 30 - 30)-(RX * 32 - 1, BY * 30 - 1), 12, B
LINE (BX * 32 - 32, LY * 30 - 30)-(BX * 32 - 1, RY * 30 - 1), 14, BF
LINE (BX * 32 - 32, LY * 30 - 30)-(BX * 32 - 1, RY * 30 - 1), 12, B
IF BT = 2 THEN CIRCLE (BX * 32 - 16, BY * 30 - 15), 40, 15: PAINT (BX * 32 - 16, BY * 30 - 15), 11, 15: PAINT (BX * 32 - 16, BY * 30 - 15), 14, 15: CIRCLE (BX * 32 - 16, BY * 30 - 15), 40, 12
FOR CX = LX TO RX
IF CX >= 0 AND CX <= 21 THEN
IF L(CX, BY) < 0 THEN B(-L(CX, BY), 0) = 1
IF L(CX, BY) > 10 AND L(CX, BY) < 19 THEN S(L(CX, BY) - 10) = 1: WH = L(CX, BY) - 10
IF L(CX, BY) = 8 THEN X(0) = CX: Y(0) = BY: N = 0: BS(0) = 2: BT(0) = 0: BN(0) = 20: TT = -45 + 7 * RND: GOSUB BOMB: TT = 0
BB = 0: IF RND < .5 THEN IF L(CX, BY) = 2 OR L(CX, BY) = 1 THEN GOSUB BBF:
IF L(CX, BY) = 8 THEN BB = 7
SOUND 37 + 100 * RND, .1
L(CX, BY) = BB
END IF
NEXT CX
FOR CY = LY TO RY
IF CY >= 0 AND CY <= 17 THEN
IF L(BX, CY) < 0 THEN B(-L(BX, CY), 0) = 1
IF L(BX, CY) > 10 AND L(BX, CY) < 19 THEN S(L(BX, CY) - 10) = 1: WH = L(BX, CY) - 10
IF L(BX, CY) = 8 THEN X(0) = BX: Y(0) = CY: N = 0: BS(0) = 2: BT(0) = 0: BN(0) = 8: TT = -45 + 7 * RND: GOSUB BOMB: TT = 0
BB = 0: IF RND < .5 THEN IF L(BX, CY) = 2 OR L(BX, CY) = 1 THEN GOSUB BBF:                             
IF L(BX, CY) = 8 THEN BB = 7
SOUND 37 + 100 * RND, .1
L(BX, CY) = BB
END IF
NEXT CY
FOR CX = LX TO RX
SX = CX: SY = BY: GOSUB PUTIT:
NEXT CX
FOR CY = LY TO RY
SX = BX: SY = CY: GOSUB PUTIT:
NEXT CY
IF BT = 2 THEN
FOR CX = BX - 1 TO BX + 1
FOR CY = BY - 1 TO BY + 1
SX = CX: SY = CY: GOSUB PUTIT:
NEXT CY
NEXT CX
END IF
IF WH > 0 THEN GOSUB CHECK
RETURN
'***************************************************************************************************************************************************

S1:
 SOUND 1000, .1: : SOUND 2000, .1:  RETURN
'***************************************************************************************************************************************************

S2:
 FOR A = 1 TO 2: SOUND 1000, .1: SOUND 2000, .1: SOUND 1200, .1:  NEXT A: RETURN
'***************************************************************************************************************************************************
BOMB:
SOUND 200, .1: SOUND 100, .1
IF N = 1 THEN N1 = 1
IF N = 2 THEN N1 = 6
IF N = 3 THEN N1 = 11
IF N = 4 THEN N1 = 16
IF N = 0 THEN N1 = 21
N2 = N1 + BN(N) - 1
IF N2 > 20 THEN N2 = 20
IF N = 0 THEN N2 = 50
S = 0
FOR A = N1 TO N2
IF B(A, 0) <= 0 THEN S = A
NEXT A
DIS:
IF S = 0 THEN RETURN
B(S, 0) = 50 + TT
B(S, 1) = X(N)
B(S, 2) = Y(N)
B(S, 3) = BT(N)
B(S, 4) = BS(N)
B(S, 5) = N
L(X(N), Y(N)) = -S
FOR A = 1 TO 10: SOUND 40 + A * 10, .1: NEXT A: FOR A = 1 TO 5: SOUND 100 - A * 10, .1: NEXT A
RETURN
'***************************************************************************************************************************************************
PUTIT:
IF SX < 1 OR SY < 1 OR SX > 20 OR SY > 16 THEN RETURN
L = L(SX, SY)
PUTG:
GX = SX * 32 - 32: GY = SY * 30 - 30
IF GX < 0 OR GY < 0 OR GX > 619 OR GY > 459 THEN RETURN
IF L = 0 THEN PUT (GX, GY), B5%, PSET
IF L = 1 THEN PUT (GX, GY), B6%, PSET
IF L = 2 THEN PUT (GX, GY), B7%, PSET
IF L = 3 THEN PUT (GX, GY), B10%, PSET
IF L = 4 THEN PUT (GX, GY), B9%, PSET
IF L = 5 THEN PUT (GX, GY), B12%, PSET
IF L = 6 THEN PUT (GX, GY), B11%, PSET
IF L = 7 THEN PUT (GX, GY), B4%, PSET
IF L = 8 THEN PUT (GX, GY), B8%, PSET
IF L = 19 THEN PUT (GX, GY), B13%, PSET
IF L = 20 THEN PUT (GX, GY), B14%, PSET
IF L < 0 THEN
IF B(-L, 3) = 0 THEN PUT (GX, GY), B1%, PSET
IF B(-L, 3) = 1 THEN PUT (GX, GY), B3%, PSET
IF B(-L, 3) = 2 THEN PUT (GX, GY), B2%, PSET
IF B(-L, 3) = 3 THEN PUT (GX, GY), B13%, PSET
END IF
IF L = 11 THEN PUT (GX, GY), P1%, PSET
IF L = 12 THEN PUT (GX, GY), P2%, PSET
IF L = 13 THEN PUT (GX, GY), P3%, PSET
IF L = 14 THEN PUT (GX, GY), P4%, PSET
RETURN
'***************************************************************************************************************************************************
CHECK:
'IF A$(1)<>"" THEN
LINE ((X(WH) - 2) * 32 - 32, (Y(WH) - 2) * 30 - 30)-((X(WH) + 2) * 32 - 1, (Y(WH) + 2) * 30 - 1), 14, BF
LINE ((X(WH) - 2) * 32 - 32, (Y(WH) - 2) * 30 - 30)-((X(WH) + 2) * 32 - 1, (Y(WH) + 2) * 30 - 1), 12, B
FOR A = 1 TO 40: SOUND 37 + A * 5 * RND, .1: SOUND 300, .1: NEXT A
FOR SX = X(WH) - 3 TO X(WH) + 3
FOR SY = Y(WH) - 3 TO Y(WH) + 3
IF SX > 0 AND SY > 0 AND SX < 21 AND SY < 17 THEN L(SX, SY) = 3: GOSUB PUTIT
NEXT SY
NEXT SX
L(X(WH), Y(WH)) = 0
X(WH) = -10: Y(WH) = -10
FOR A = 1 TO BN(WH)
GG = 0
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
GG = GG + 1
LOOP WHILE L(PX, PY) <> 0 AND GG < 10
IF GG < 10 THEN L(PX, PY) = 4
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
BN(WH) = 0
FOR A = 1 TO BS(WH)
GG = 0
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
GG = GG + 1
LOOP WHILE L(PX, PY) <> 0 AND GG < 10
IF GG < 10 THEN L(PX, PY) = 3
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
BS(WH) = 0
FOR A = 1 TO BT(WH)
GG = 0
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
GG = GG + 1
LOOP WHILE L(PX, PY) <> 0 AND GG < 10
IF GG < 10 THEN L(PX, PY) = 5
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
BT(WH) = 0
D = 0
FOR k = 1 TO 4
IF S(k) = 1 THEN D = D + 1
NEXT k
IF D < 3 THEN RETURN
CLS
FOR k = 1 TO 4
IF S(k) = 0 THEN w(k) = w(k) + 1
NEXT k
FOR k = 1 TO 4
LOCATE k * 2, 3
COLOR k + 9
PRINT "Player"; k; "has won"; w(k); "rounds."
NEXT k
FOR N = 1 TO 4
S(N) = 0
NEXT N
DO: LOOP WHILE INKEY$ <> ""
DO
: LOOP WHILE INKEY$ = ""
GOTO start
'***************************************************************************************************************************************************
BBF:
BF = INT(11 * RND + 1)
IF BF = 1 THEN BB = 3
IF BF = 2 THEN BB = 3
IF BF = 3 THEN BB = 3
IF BF = 4 THEN BB = 4
IF BF = 5 THEN BB = 4
IF BF = 6 THEN BB = 4
IF BF = 7 THEN BB = 4
IF BF = 8 THEN BB = 5
IF BF = 9 THEN BB = 5
IF BF = 10 THEN BB = 6
IF BF = 11 THEN BB = 20
RETURN
DISASTER:
BN(0) = 50
BS(0) = 2
S(0) = 0
BT(0) = 0
N = 0
FOR S = 1 TO 50
DO
TT = 20 * RND
X(0) = INT(20 * RND + 1)
Y(0) = INT(16 * RND + 1)
LOOP WHILE L(X(0), Y(0)) <> 0
FOR A = 1 TO 30 STEP 2
SX = X(0): SY = Y(0)
L(X(0), Y(0)) = 7: GOSUB PUTIT:
NEXT A
LINE (0, Y(0) * 30 - 30)-(640, Y(0) * 30 - 1), 9, B
LINE (X(0) * 32 - 32, 0)-(X(0) * 32 - 1, 480), 9, B
GOSUB DIS
NEXT S
TT = 0
FOR N = 1 TO 5:
FOR A = 1 TO 50: SOUND 37 + A * 3, .1: SOUND 70, .1: NEXT A: SOUND 0, 0
NEXT N
RETURN



