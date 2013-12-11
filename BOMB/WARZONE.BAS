'
'         ±     ±     ±±±     ±±±±    ±±±±±    ±±±    ±±    ±   ±±±±±
'         ±     ±    ±   ±    ±   ±      ±    ±   ±   ± ±   ±   ±
'         ±  ±  ±    ±±±±±    ±±±±      ±     ±   ±   ±  ±  ±   ±±±±
'         ±  ±  ±   ±     ±   ±   ±    ±      ±   ±   ±   ± ±   ±
'          ±± ±±    ±     ±   ±   ±   ±±±±±    ±±±    ±    ±±   ±±±±±
'
'
'                           By Tim Caswell
'
'                              Controls
'
'        W   `   - Set Bomb      I   / - Set Bomb     8    + - Set bomb
'        |                       |                    |              
'      A-*-D                   J-*-L                4-*-6               
'        |                       |                    |
'        S                       K                    2
'
'
'
OPEN "WARZONE.DAT" FOR INPUT AS #1
RANDOMIZE (TIMER)
SCREEN 12
DEFINT A-Y
FOR N = 1 TO 11
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
DIM B1%(480), B2%(480), B3%(480), B4%(480), B5%(480), B6%(480), B7%(480), P1%(480), P2%(480), P3%(480), P4%(480)
GET (1, 1)-(32, 30), B1%
GET (33, 1)-(64, 30), B2%
GET (65, 1)-(96, 30), B3%
GET (97, 1)-(128, 30), B4%
GET (129, 1)-(160, 30), B5%
GET (161, 1)-(192, 30), B6%
GET (193, 1)-(224, 30), B7%
GET (225, 1)-(256, 30), P1%
GET (257, 1)-(288, 30), P2%
GET (289, 1)-(320, 30), P3%
GET (321, 1)-(352, 30), P4%
DIM L(21, 17), B(25, 4), X(5), Y(5), OX(5), OY(5), BN(5), BT(5), BS(5), S(5), w(5)
start:
CLS
FOR Y = 1 TO 16
FOR X = 1 TO 20
L = 0
IF RND < .6 THEN L = 2
IF RND < .05 THEN L = 1
IF X / 2 = INT(X / 2) AND Y / 2 = INT(Y / 2) THEN L = 1
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
L(X, 0) = 1
L(X, 17) = 1
NEXT X
FOR Y = 1 TO 16
L(0, Y) = 1
L(21, Y) = 1
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
DO
DO: LOOP WHILE TIMER - ZME < .001
ZME = TIMER
FOR N = 1 TO 4
A$(N) = ""
NEXT N
FOR N = 1 TO 4
A$ = INKEY$
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF S(1) = 0 THEN
IF A$ = "A" THEN A$(1) = "<"
IF A$ = "D" THEN A$(1) = ">"
IF A$ = "W" THEN A$(1) = "^"
IF A$ = "S" THEN A$(1) = "v"
IF A$ = "`" THEN A$(1) = "*"
END IF
IF S(2) = 0 THEN
IF A$ = "4" THEN A$(2) = "<"
IF A$ = "6" THEN A$(2) = ">"
IF A$ = "8" THEN A$(2) = "^"
IF A$ = "2" THEN A$(2) = "v"
IF A$ = "+" THEN A$(2) = "*"
END IF
IF S(3) = 0 THEN
IF A$ = "J" THEN A$(3) = "<"
IF A$ = "L" THEN A$(3) = ">"
IF A$ = "I" THEN A$(3) = "^"
IF A$ = "K" THEN A$(3) = "v"
IF A$ = "/" THEN A$(3) = "*"
END IF
IF S(4) = 0 THEN
IF RND < .1 THEN A$(4) = "<"
IF RND < .1 THEN A$(4) = ">"
IF RND < .1 THEN A$(4) = "^"
IF RND < .1 THEN A$(4) = "v"
IF RND < .005 THEN A$(4) = "*"
END IF
NEXT N
FOR N = 1 TO 4
IF A$(N) = "<" THEN X(N) = X(N) - 1: GOSUB S1
IF A$(N) = ">" THEN X(N) = X(N) + 1: GOSUB S1
IF A$(N) = "^" THEN Y(N) = Y(N) - 1: GOSUB S1
IF A$(N) = "v" THEN Y(N) = Y(N) + 1: GOSUB S1
IF A$(N) = "*" THEN GOSUB BOMB:
LV = L(X(N), Y(N))
IF LV = 1 OR LV = 2 OR LV < 0 THEN X(N) = OX(N): Y(N) = OY(N)
IF LV = 3 THEN BS(N) = BS(N) + 1: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 4 THEN BN(N) = BS(N) + 1: L(X(N), Y(N)) = 0: GOSUB S2:
IF LV = 5 THEN BT(N) = 1: L(X(N), Y(N)) = 0: GOSUB S2:
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
IF RND < .01 THEN N = 5: GOSUB BOMB
FOR ZN = 1 TO 25
IF B(ZN, 0) > 0 THEN
T = B(ZN, 0)
BX = B(ZN, 1)
BY = B(ZN, 2)
BT = B(ZN, 3)
BS = B(ZN, 4)
T = T - 1
IF T <= 0 THEN GOSUB BLOWUP
B(ZN, 0) = T
END IF
NEXT ZN
FOR A = 1 TO 50: NEXT A
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
IF L(CX, BY) > 0 AND BT <> 1 THEN LX = CX
IF L(CX, BY) < 0 THEN LX = CX: B(-L(CX, BY), 0) = 1
IF L(CX, BY) = 1 THEN LX = CX + 1
END IF
NEXT CX
LY = BY - BS
FOR CY = BY - BS TO BY - 1
IF CY >= 0 AND CY <= 17 THEN
IF L(BX, CY) > 0 AND BT <> 1 THEN LY = CY
IF L(BX, CY) < 0 THEN LY = CY: B(-L(BX, CY), 0) = 1
IF L(BX, CY) = 1 THEN LY = CY + 1
END IF
NEXT CY
RX = BX + BS
FOR CX = BX + BS TO BX + 1 STEP -1
IF CX >= 0 AND CX <= 21 THEN
IF L(CX, BY) > 0 AND BT <> 1 THEN RX = CX
IF L(CX, BY) < 0 THEN RX = CX: B(-L(CX, BY), 0) = 1
IF L(CX, BY) = 1 THEN RX = CX - 1
END IF
NEXT CX
RY = BY + BS
FOR CY = BY + BS TO BY + 1 STEP -1
IF CY >= 0 AND CY <= 17 THEN
IF L(BX, CY) > 0 AND BT <> 1 THEN RY = CY
IF L(BX, CY) < 0 THEN RY = CY: B(-L(BX, CY), 0) = 1
IF L(BX, CY) = 1 THEN RY = CY - 1
END IF
NEXT CY
IF LX < 0 THEN LX = 0
IF RX > 21 THEN RX = 21
IF LY < 0 THEN LY = 0
IF RY > 17 THEN RY = 16
FOR CX = LX TO RX
IF L(CX, BY) > 10 THEN S(L(CX, BY) - 10) = 1: WH = L(CX, BY) - 10
LINE (CX * 32 - 32, BY * 30 - 30)-(CX * 32 - 1, BY * 30 - 1), 14, BF
CIRCLE (CX * 32 - 16, BY * 30 - 15), 14, 9
CIRCLE (CX * 32 - 16, BY * 30 - 15), 13, 12
IF CX >= 0 AND CX <= 21 THEN
bb = 0: IF RND < .8 AND L(CX, BY) = 2 THEN bb = 3 + INT(RND + .2): IF RND < .1 THEN bb = 5
FOR S = 1 TO 3: SOUND 37 + 100 * RND, .1: NEXT S
IF CX > 0 AND CX < 21 THEN L(CX, BY) = bb
END IF
NEXT CX
FOR CY = LY TO RY
IF L(BX, CY) > 10 THEN S(L(BX, CY) - 10) = 1: WH = L(BX, CY) - 10:
LINE (BX * 32 - 32, CY * 30 - 30)-(BX * 32 - 1, CY * 30 - 1), 14, BF
CIRCLE (BX * 32 - 16, CY * 30 - 15), 14, 9
CIRCLE (BX * 32 - 16, CY * 30 - 15), 13, 12
IF CY >= 0 AND CY <= 17 THEN
bb = 0: IF RND < .8 AND L(BX, CY) = 2 THEN bb = 3 + INT(RND + .2): IF RND < .1 THEN bb = 5
FOR S = 1 TO 3: SOUND 37 + 100 * RND, .1: NEXT S
IF CY >= 0 AND CY <= 17 THEN L(BX, CY) = bb
END IF
NEXT CY
FOR CX = LX TO RX
LINE (CX * 32 - 27, BY * 30 - 25)-(CX * 32 - 5, BY * 30 - 5), 12, BF
CIRCLE (CX * 32 - 16, BY * 30 - 15), 9, 10
NEXT CX
FOR CY = LY TO RY
LINE (BX * 32 - 27, CY * 30 - 25)-(BX * 32 - 5, CY * 30 - 5), 12, BF
CIRCLE (BX * 32 - 16, CY * 30 - 15), 9, 10
NEXT CY
FOR CX = LX TO RX
SX = CX: SY = BY: GOSUB PUTIT:
NEXT CX
FOR CY = LY TO RY
SX = BX: SY = CY: GOSUB PUTIT:
NEXT CY
IF WH > 0 THEN GOSUB CHECK
RETURN
'***************************************************************************************************************************************************

S1:
 SOUND 100, .1: RETURN
'***************************************************************************************************************************************************

S2:
 FOR A = 1 TO 3: SOUND 200 + A * 20, .1: NEXT A: SOUND 100, .2: SOUND 300, .1: RETURN
'***************************************************************************************************************************************************

BOMB:
SOUND 200, .1: SOUND 100, .1
IF N = 1 THEN N1 = 1
IF N = 2 THEN N1 = 6
IF N = 3 THEN N1 = 11
IF N = 4 THEN N1 = 16
IF N = 5 THEN N1 = 21: BN(N) = 5: BS(N) = 3 * RND: BT(N) = INT(2 * RND + 1): X(N) = 20 * RND: Y(N) = 16 * RND
N2 = N1 + BN(N) - 1
IF N2 > N1 + 5 THEN N2 = N1 + 4
S = 0
FOR A = N1 TO N2
IF B(A, 0) <= 0 THEN S = A
NEXT A
IF S = 0 THEN RETURN
B(S, 0) = 50
B(S, 1) = X(N)
B(S, 2) = Y(N)
B(S, 3) = BT(N)
B(S, 4) = BS(N)
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
IF L = 0 THEN LINE (GX, GY)-(GX + 31, GY + 29), 0, BF
IF L = 1 THEN PUT (GX, GY), B1%, PSET
IF L = 2 THEN PUT (GX, GY), B2%, PSET
IF L = 3 THEN PUT (GX, GY), B3%, PSET
IF L = 4 THEN PUT (GX, GY), B4%, PSET
IF L = 5 THEN PUT (GX, GY), B5%, PSET
IF L < 0 THEN
IF B(-L, 3) = 0 THEN PUT (GX, GY), B6%, PSET
IF B(-L, 3) = 1 THEN PUT (GX, GY), B7%, PSET
END IF
IF L = 11 THEN PUT (GX, GY), P1%, PSET
IF L = 12 THEN PUT (GX, GY), P2%, PSET
IF L = 13 THEN PUT (GX, GY), P3%, PSET
IF L = 14 THEN PUT (GX, GY), P4%, PSET
RETURN
CHECK:
FOR A = 1 TO 50
GX = X(WH) * 32 - 32 * RND
GY = Y(WH) * 30 - 30 * RND
C = INT(15 * RND)
FOR B = 1 TO 50 * RND STEP 5
CIRCLE (GX, GY), B, C
SOUND 373 + 100 * RND, .1
NEXT B
NEXT A
FOR SX = X(WH) - 2 TO X(WH) + 2
FOR SY = Y(WH) - 2 TO Y(WH) + 2
IF SX > 0 AND SY > 0 AND SX < 21 AND SY < 17 THEN L(SX, SY) = 3: GOSUB PUTIT
NEXT SY
NEXT SX
FOR A = 1 TO BN(WH)
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
LOOP WHILE L(PX, PY) <> 0
L(PX, PY) = 4
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
FOR A = 1 TO BS(WH)
GG = 0
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
GG = GG + 1
LOOP WHILE L(PX, PY) <> 0 AND GG < 10
L(PX, PY) = 3
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
FOR A = 1 TO BT(WH)
DO
PX = INT(20 * RND + 1)
PY = INT(16 * RND + 1)
LOOP WHILE L(PX, PY) <> 0
L(PX, PY) = 5
SX = PX: SY = PY: GOSUB PUTIT
NEXT A
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
DO: LOOP WHILE INKEY$ = ""
GOTO start

