DECLARE FUNCTION WP% (A%)
DECLARE SUB MAKEBOAT (T%)
DECLARE SUB SELL (K%)
DECLARE SUB iven ()
DECLARE SUB outbag (index%)
DECLARE SUB INVENTORY ()
DECLARE SUB INBAG (item%)
DECLARE SUB SHOPx (PER%)
DECLARE FUNCTION WALK% ()
DECLARE FUNCTION BCOV$ (CAR%)
DECLARE FUNCTION tcov$ (TM%)
DECLARE SUB Init ()
DECLARE FUNCTION ASKL% ()
DECLARE SUB InCity ()
DECLARE SUB RESTx ()
DECLARE SUB TALKx ()
DECLARE SUB PUSHx ()
DECLARE SUB LOOKx ()
DECLARE SUB ODORx ()
DECLARE SUB JIMMYx ()
DECLARE SUB SEARCHx ()
DECLARE SUB DRAWFTx ()
DECLARE SUB choose (L%)
DECLARE SUB DRAWMAP ()
DECLARE SUB OTHERS ()

DEFINT A-Z

CONST BAGSIZE = 30

DIM SHARED P%(200, 65), MAP(121, 121), ZME AS LONG, LP(100), WT(100), TT(100), LSTN, CTY, BOAT
DIM SHARED GOT(20, 26), OB(20, 3), O$(200), CHEST(10, 10), SIGN(5, 3), BED(5, 3), L(51, 51), INV(200)
DIM SHARED SIGN$(5), TALK$(15, 30), PERSON(15, 16), L$(55), LT(8, 8), SQX, SQY, item(200, 7)
DIM SHARED spx, spy, HON, PRN, TM, X, Y, f$(26), n$(26), FT, CL, MODE, UPDT, gold, bag(BAGSIZE)
SCREEN 7
Init    'LOADS GRAPHICS AND THE MAP
DO
choose WALK: InCity: 'Main loop
LOOP

DATA 0,0,0,1,1,1,1,1
DATA 1,0,0,0,0,0,1,0
DATA 0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,1,1
DATA 0,0,0,0,0,0,0,0
DATA 0,1,1,0,0,0
'
DATA 1,1,1,1,1,1,1,1
DATA 1,0,1,0,0,0,1,1
DATA 0,0,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1
DATA 0,0,0,0,1,0,1,1
DATA 1,1,1,1,0,0,0,0
DATA 0,1,1,0,0,0

'1-MOVEABLE
'0-FLOOR
'2-SOLID
DATA 1,1,1,2,2,2,2,2
DATA 2,0,0,0,0,0,2,2
DATA 2,2,2,2,2,2,2,2
DATA 1,1,2,2,1,2,2,2
DATA 1,1,1,1,1,0,2,2
DATA 2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2

FUNCTION ASKL
PRINT
PRINT "DO YOU WANT TO LEAVE (Y OR N)"
DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ <> "Y" AND A$ <> "N"
PRINT
IF A$ = "Y" THEN ASKL = 1 ELSE ASKL = 0
END FUNCTION

DEFSNG Z
FUNCTION BCOV$ (CAR)
IF CAR > 90 THEN A$ = "A WELL TRAINED SAINT": GOTO H
IF CAR > 80 THEN A$ = "A GOOD GUY": GOTO H
IF CAR > 70 THEN A$ = "A MODERATE PERSON": GOTO H
IF CAR > 60 THEN A$ = "AN AVEREAGE PERSON": GOTO H
IF CAR > 50 THEN A$ = "A SNEAKY LAD": GOTO H
IF CAR > 40 THEN A$ = "A PICKPOCKET": GOTO H
IF CAR > 30 THEN A$ = "A POOR MISLED WRETCH": GOTO H
IF CAR > 20 THEN A$ = "A DYING SOUL": GOTO H
IF CAR > 10 THEN A$ = "A MURDERING THIEF": GOTO H
A$ = "THE DEVIL HIMSELF"
H:
BCOV$ = A$
END FUNCTION

DEFINT Z
SUB choose (L)
CLS
IF L > 0 THEN L$ = f$(L)
IF L$ = "" THEN
  VIEW PRINT 1 TO 25
  SCREEN , , 0, 0
  CLS
  FOR B = 0 TO 1
    FOR A = 1 TO 12
      LOCATE A, B * 20 + 1
      PRINT A + B * 12; n$(A + B * 12)
    NEXT A
  NEXT B
  DO
  INPUT "LOAD WHICH"; L
  IF L > 0 AND L < 25 THEN L$ = f$(L)
  LOOP WHILE L$ = ""
END IF
CTY = L
 PRINT
 COLOR 15: PRINT n$(L)
IF UCASE$(RIGHT$(L$, 4)) <> ".UTX" THEN L$ = L$ + ".UTX"

OPEN L$ FOR INPUT AS #1

FOR SY = 1 TO 50
  INPUT #1, A$
  FOR SX = 1 TO 50
    L = ASC(MID$(A$, SX, 1)) - 100
    IF L = 0 THEN L = 10
    L(SX, SY) = L
  NEXT SX
NEXT SY

INPUT #1, spx, spy
INPUT #1, HON

FOR G = 1 TO HON
  FOR B = 0 TO 3
    INPUT #1, OB(G, B)
  NEXT B
NEXT G
INPUT #1, PRN

FOR A = 1 TO 15
  FOR B = 0 TO 16
    PERSON(A, B) = 0
  NEXT B
  FOR B = 0 TO 30
    TALK$(A, B) = ""
  NEXT B
NEXT A

FOR A = 1 TO PRN
  LINE INPUT #1, A$
  A$ = A$ + STRING$(16, CHR$(55))
  FOR B = 0 TO 15
    PERSON(A, B) = ASC(MID$(A$, B + 1, 1)) - 55
  NEXT B
  PERSON(A, 16) = L(PERSON(A, 14), PERSON(A, 15))
  FOR B = 0 TO 30
    LINE INPUT #1, TALK$(A, B)
  NEXT B
NEXT A
FOR A = 1 TO PRN
  L(PERSON(A, 14), PERSON(A, 15)) = 12
NEXT A
CLOSE #1

END SUB

SUB DRAWFTx
DIM TEMP(6, 6)
DK = COS(TM / 1440 * 6.28) * 4 + 1
IF DK < 0 THEN DK = 0
IF DK > 3 THEN DK = 3
FOR A = 0 TO 6
FOR B = 0 TO 6
LT(A, B) = 0
NEXT B
NEXT A
LT(3, 3) = 1
C = 1: SY = 0: DO: SY = SY - 1: IF Y + SY > 0 AND SY > -4 + DK THEN IF LP(L(X, Y + SY)) = 0 THEN LT(3, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SY = 0: DO: SY = SY + 1: IF Y + SY < 51 AND SY < 4 - DK THEN IF LP(L(X, Y + SY)) = 0 THEN LT(3, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: DO: SX = SX - 1: IF X + SX > 0 AND SX > -4 + DK THEN IF LP(L(X + SX, Y)) = 0 THEN LT(3 + SX, 3) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: DO: SX = SX + 1: IF X + SX < 51 AND SX < 4 - DK THEN IF LP(L(X + SX, Y)) = 0 THEN LT(3 + SX, 3) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX - 1: SY = SY - 1: IF X + SX > 0 AND Y + SY > 0 AND SX > -3 + DK THEN IF LP(L(X + SX, Y + SY)) = 0 THEN LT(3 + SX, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX - 1: SY = SY + 1: IF X + SX > 0 AND Y + SY < 51 AND SX > -3 + DK THEN IF LP(L(X + SX, Y + SY)) = 0 THEN LT(3 + SX, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX + 1: SY = SY - 1: IF X + SX < 51 AND Y + SY > 0 AND SX < 3 - DK THEN IF LP(L(X + SX, Y + SY)) = 0 THEN LT(3 + SX, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX + 1: SY = SY + 1: IF X + SX < 51 AND Y + SY < 51 AND SX < 3 - DK THEN IF LP(L(X + SX, Y + SY)) = 0 THEN LT(3 + SX, 3 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
FOR SY = 0 TO 6
FOR SX = 0 TO 6
IF LT(SX, SY) = 0 THEN
L = 0
FOR A = -1 TO 1
FOR B = -1 TO 1
IF SX + A >= 0 AND SY + B >= 0 AND SX + A <= 6 AND SY + B <= 6 THEN IF LT(SX + A, SY + B) = 1 THEN L = 2
NEXT B
NEXT A
LT(SX, SY) = L
END IF
NEXT SX
NEXT SY
CL = 0: 'CLOCK
FT = 0: 'FOUNTAIN
FOR SX = 0 TO 6
  FOR SY = 0 TO 6
    LX = X + SX - 3: LY = Y + SY - 3
    IF LT(SX, SY) > 0 AND LX > 0 AND LY > 0 AND LX < 51 AND LY < 51 THEN
      L = L(LX, LY)
      IF L <= 0 THEN L = 10 ELSE IF L = 49 OR L = 52 OR L = 53 THEN L = 12 ELSE IF L = 50 OR L = 51 THEN L = 6
      IF L = 100 THEN L = 49 ELSE IF L = 26 THEN CL = 1 ELSE IF L = 32 THEN FT = 1
    ELSE
      L = -1000
    END IF
    TEMP(SX, SY) = L
  NEXT SY
NEXT SX
FOR A = 1 TO PRN
  PX = PERSON(A, 14) - X + 3
  PY = PERSON(A, 15) - Y + 3
  IF PX >= 0 AND PY >= 0 AND PX <= 6 AND PY <= 6 THEN IF LT(PX, PY) > 0 THEN TEMP(PX, PY) = PERSON(A, 16)
NEXT A
TEMP(3, 3) = 49
FOR SX = 0 TO 6
  FOR SY = 0 TO 6
  IF TEMP(SX, SY) = -1000 THEN LINE (SX * 20, SY * 20)-(SX * 20 + 19, SY * 20 + 19), 0, BF ELSE PUT (SX * 20, SY * 20), P%(0, TEMP(SX, SY) + 16), PSET
  NEXT SY
NEXT SX
END SUB

SUB DRAWMAP
DK = COS(TM / 1440 * 6.28) * 4 + 1
IF DK < 0 THEN DK = 0
IF DK > 4 THEN DK = 4
FOR A = 0 TO 8
FOR B = 0 TO 8
LT(A, B) = 0
NEXT B
NEXT A
LT(4, 4) = 1
C = 1: SY = 0: DO: SY = SY - 1: IF SY > -5 + DK THEN IF MAP(X, WP(Y + SY)) <> 4 AND MAP(X, WP(Y + SY)) <> 2 THEN LT(4, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SY = 0: DO: SY = SY + 1: IF SY < 5 - DK THEN IF MAP(X, WP(Y + SY)) <> 4 AND MAP(X, WP(Y + SY)) <> 2 THEN LT(4, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: DO: SX = SX - 1: IF SX > -5 + DK THEN IF MAP(WP(X + SX), Y) <> 4 AND MAP(WP(X + SX), Y) <> 2 THEN LT(4 + SX, 4) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: DO: SX = SX + 1: IF SX < 5 - DK THEN IF MAP(WP(X + SX), Y) <> 4 AND MAP(WP(X + SX), Y) <> 2 THEN LT(4 + SX, 4) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX - 1: SY = SY - 1: IF SX > -4 + DK THEN IF MAP(WP(X + SX), WP(Y + SY)) <> 4 AND MAP(WP(X + SX), WP(Y + SY)) <> 2 THEN LT(4 + SX, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX - 1: SY = SY + 1: IF SX > -4 + DK THEN IF MAP(WP(X + SX), WP(Y + SY)) <> 4 AND MAP(WP(X + SX), WP(Y + SY)) <> 2 THEN LT(4 + SX, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX + 1: SY = SY - 1: IF SX < 4 - DK THEN IF MAP(WP(X + SX), WP(Y + SY)) <> 4 AND MAP(WP(X + SX), WP(Y + SY)) <> 2 THEN LT(4 + SX, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
C = 1: SX = 0: SY = 0: DO: SX = SX + 1: SY = SY + 1: IF SX < 4 - DK THEN IF MAP(WP(X + SX), WP(Y + SY)) <> 4 AND MAP(WP(X + SX), WP(Y + SY)) <> 2 THEN LT(4 + SX, 4 + SY) = 1 ELSE C = 0 ELSE C = 0
LOOP WHILE C = 1
FOR SY = 0 TO 8
FOR SX = 0 TO 8
IF LT(SX, SY) = 0 THEN
L = 0
FOR A = -1 TO 1
FOR B = -1 TO 1
IF SX + A >= 0 AND SY + B >= 0 AND SX + A <= 8 AND SY + B <= 8 THEN IF LT(SX + A, SY + B) = 1 THEN L = 2
NEXT B
NEXT A
LT(SX, SY) = L
END IF
NEXT SX
NEXT SY
FOR SX = 0 TO 8
  FOR SY = 0 TO 8
    IF LT(SX, SY) = 0 THEN
      LINE (SX * 20, SY * 20)-(SX * 20 + 19, SY * 20 + 19), 0, BF
    ELSE
      L = MAP(WP(X + SX - 4), WP(Y + SY - 4))
      IF L = 0 THEN L = 27 ELSE IF L = 1 THEN L = 26 ELSE IF L = 2 THEN L = 31 ELSE IF L = 3 THEN L = 29 ELSE IF L = 4 THEN L = 55 ELSE IF L < 0 THEN L = 61 ELSE IF L > 80 AND L < 90 THEN L = 62
      IF SX = 4 AND SY = 4 THEN L = 65: IF BOAT > 0 THEN L = 62
      IF LT(SX, SY) > 0 THEN PUT (SX * 20, SY * 20), P%(0, L), PSET
    END IF
  NEXT SY
NEXT SX

END SUB

SUB INBAG (item)
FOR A = 1 TO BAGSIZE
  IF bag(A) = 0 THEN bag(A) = item: LSTN = A - 2: A = BAGSIZE: SOUND 100, 1: SOUND 200, 1
NEXT A
iven
END SUB

SUB InCity
MODE = 1
VIEW: CLS
VIEW (0, 0)-(139, 139)
VIEW PRINT 19 TO 25
X = spx: Y = spy
DO
IF X <> OX OR Y <> OY THEN
IF L(OX, OY) = 49 THEN L(OX, OY) = 6
IF L(OX, OY) = 52 THEN L(OX, OY) = 7
IF L(OX, OY) = 53 THEN L(OX, OY) = 8
END IF
OX = X: OY = Y
IF A$ = "I" THEN INVENTORY
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF A$ = "R" THEN RESTx
IF A$ = "W" THEN PRINT "Your pocket watch says it is "; tcov$(TM): PRINT
IF A$ = "T" THEN TALKx
IF A$ = "P" THEN PUSHx
IF A$ = "L" THEN LOOKx
IF A$ = "O" THEN ODORx
IF A$ = "J" THEN JIMMYx
IF A$ = "S" THEN SEARCHx
IF A$ = " " THEN PRINT : PRINT "PASS": TM = TM + 10
IF A$ = "8" THEN Y = Y - 1: SOUND 37, .1
IF A$ = "2" THEN Y = Y + 1: SOUND 37, .1
IF A$ = "4" THEN X = X - 1: SOUND 37, .1
IF A$ = "6" THEN X = X + 1: SOUND 37, .1
IF X < 1 THEN X = 1: IF ASKL THEN EXIT SUB
IF Y < 1 THEN Y = 1: IF ASKL THEN EXIT SUB
IF X > 50 THEN X = 50: IF ASKL THEN EXIT SUB
IF Y > 50 THEN Y = 50: IF ASKL THEN EXIT SUB
IF WT(L(X, Y)) = 1 THEN X = OX: Y = OY
TM = TM + 1
IF TM > 1440 THEN TM = TM - 1440
IF A$ = ")" THEN DK = 0
IF A$ = "!" THEN DK = 1
IF A$ = "@" THEN DK = 2
IF A$ = "#" THEN DK = 3
DRAWFTx
DO: A$ = INKEY$:
DO: LOOP WHILE INKEY$ <> ""
IF TIMER - ZME >= 1 THEN ZME = TIMER
OSL = SL
SL = INT(((TIMER - ZME)) * 10) + 1
IF SL <> OSL THEN
SOUND 100, 0
IF CL = 1 AND SL = 5 THEN SOUND 3000, .08
IF CL = 1 AND SL = 9 THEN SOUND 2500, .1
IF FT = 1 AND SL = 1 THEN SOUND 2000, .1
IF FT = 1 AND SL = 2 THEN SOUND 400, .1
IF FT = 1 AND SL = 5 THEN SOUND 1000, .1
IF FT = 1 AND SL = 7 THEN SOUND 800, .1
G = (G + 1) MOD 10
IF G = 0 THEN TM = TM + 1
IF G MOD 2 = 0 THEN OTHERS
END IF
IF UPDT AND A$ = "" THEN DRAWFTx
LOOP WHILE A$ = ""
LOOP
END SUB

SUB Init
OPEN "NAMES.DAT" FOR INPUT AS #1
  FOR A = 1 TO 49
    INPUT #1, L$(A)
  NEXT A
CLOSE #1
OPEN "items.lst" FOR INPUT AS #1
  O$(0) = "                "
  FOR A = 1 TO 200
    INPUT #1, O$(A)
    O$(A) = LEFT$(O$(A) + "                  ", 18)
    FOR B = 0 TO 7: INPUT #1, item(A, B): NEXT B
  NEXT A
CLOSE #1
FOR A = 1 TO 54: READ LP(A): NEXT A
FOR A = 1 TO 54: READ WT(A): NEXT A
FOR A = 1 TO 54: READ TT(A): NEXT A
' ************************************************************************
' ******************HYPER GRAPHICS LOAD!!!********************************
' ************************************************************************
  DEF SEG = VARSEG(MAP(1, 1))
  BLOAD "LIGHT.MAP", 0
  DEF SEG = VARSEG(P%(0, 0))
  BLOAD "light.pic", 0
' ************************************************************************
GET (1, 1)-(20, 20), P%(0, 0)
f$(1) = "CITY_A.UTX": n$(1) = "SimBa¤o"
f$(2) = "CITY_B.UTX": n$(2) = "Capetown"
f$(3) = "CITY_C.UTX": n$(3) = "Cicero"
f$(4) = "CITY_D.UTX": n$(4) = "*Dunagrade"
f$(5) = "CITY_E.UTX": n$(5) = "Farout Post"
f$(6) = "CITY_F.UTX": n$(6) = "Hermit's House"
f$(7) = "CITY_G.UTX": n$(7) = "Moasis"
f$(8) = "CITY_H.UTX": n$(8) = "*Hexopolis"
f$(9) = "CITY_I.UTX": n$(9) = "*Inferno"
f$(10) = "CITY_J.UTX": n$(10) = "*Juqart Village"
f$(11) = "CITY_K.UTX": n$(11) = "Stone Haven"
f$(12) = "CITY_L.UTX": n$(12) = "*Leonis"
f$(13) = "CITY_M.UTX": n$(13) = "Ferudda"
f$(14) = "CITY_N.UTX": n$(14) = "Cliffport"
f$(15) = "CITY_O.UTX": n$(15) = "*Oshugan"
f$(16) = "CITY_P.UTX": n$(16) = "Marino"
f$(17) = "CITY_Q.UTX": n$(17) = "Fort Pine"
f$(18) = "CITY_R.UTX": n$(18) = "Mountainview"
f$(19) = "CITY_S.UTX": n$(19) = "*Sutteck"
f$(20) = "CITY_T.UTX": n$(20) = "*Tireon"
f$(21) = "CITY_U.UTX": n$(21) = "Your Home"
f$(22) = "CITY_V.UTX": n$(22) = "Vespil Castle"
f$(23) = "CITY_W.UTX": n$(23) = "*Workersville"
f$(24) = "CITY_X.UTX": n$(24) = "*Ant¡ba¤o"
f$(25) = "CITY_Y.UTX": n$(25) = "*Yeohamon"
f$(26) = "CITY_Z.UTX": n$(26) = "*Zenith"
SQX = 16: SQY = 41: TM = 600
gold = 500
FOR A = 1 TO 5
  bag(A) = A
NEXT A
END SUB

SUB INVENTORY
VIEW: VIEW PRINT
K = 1
DO
VIEW: VIEW PRINT
FOR A = 1 TO 6
  T = A + K - 3
  IF T < 1 THEN T = T + BAGSIZE ELSE IF T > BAGSIZE THEN T = T - BAGSIZE
  IT = bag(T)
  COLOR 7: IF T = K THEN COLOR 15
  LOCATE A * 3 - 1, 19: PRINT T; O$(IT)
  PUT (299, A * 24 - 24), P%(0, item(IT, 7)), PSET
NEXT A
DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ = ""
IF A$ = "8" THEN K = K - 1
IF A$ = "2" THEN K = K + 1
IF A$ = "D" THEN outbag K: SOUND 100, .1: SOUND 300, .5: SOUND 100, .3: SOUND 200, .8
LSTN = K
IF A$ = "S" AND MODE = 3 THEN SELL K
IF K < 1 THEN K = BAGSIZE
IF K > BAGSIZE THEN K = 1
LOOP WHILE A$ <> " " AND A$ <> CHR$(27) AND A$ <> CHR$(13)
FOR A = 1 TO 6
  T = A + K - 3
  IF T < 1 THEN T = T + BAGSIZE ELSE IF T > BAGSIZE THEN T = T - BAGSIZE
  IT = bag(T)
  COLOR 7
  LOCATE A * 3 - 1, 19: PRINT T; O$(IT)
  PUT (299, A * 24 - 24), P%(0, item(IT, 7)), PSET
NEXT A
LSTN = K
VIEW PRINT 19 TO 25
VIEW (0, 0)-(139, 139)
IF MODE = 2 THEN VIEW (0, 0)-(179, 179): VIEW PRINT 23 TO 25
COLOR 15
PRINT
PRINT
PRINT
PRINT
PRINT

END SUB

SUB iven
K = LSTN
VIEW
VIEW PRINT
FOR A = 1 TO 6
  T = A + K - 3
  IF T < 1 THEN T = T + BAGSIZE ELSE IF T > BAGSIZE THEN T = T - BAGSIZE
  IT = bag(T)
  COLOR 7
  LOCATE A * 3 - 1, 19: PRINT T; O$(IT)
  PUT (299, A * 24 - 24), P%(0, item(IT, 7)), PSET
NEXT A
COLOR 15
VIEW PRINT 19 TO 25
VIEW (0, 0)-(139, 139)
IF MODE = 2 THEN VIEW (0, 0)-(179, 179): VIEW PRINT 23 TO 25
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
SOUND 500, .2: SOUND 200, .1
SOUND 600, .2: SOUND 300, .1
SOUND 700, .2: SOUND 400, .1
END SUB

SUB JIMMYx
PRINT
PRINT "JIMMY WHICH WAY- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
IF L(X + SX, Y + SY) <> 7 AND L(X + SX, Y + SY) <> 8 THEN
IF L(X + SX, Y + SY) <> 7 AND L(X + SX, Y + SY) <> 8 THEN PRINT "HOW?"
ELSE
IF RND * 20 > L(X + SX, Y + SY) THEN
PRINT "UNLOCKED !"
L(X + SX, Y + SY) = L(X + SX, Y + SY) + 43
ELSE
PRINT "KEY BROKE!"
END IF
END IF

END SUB

SUB LOOKx
PRINT
PRINT "LOOK WHERE- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
LG = L(X + SX, Y + SY)
IF LG <= 48 THEN PRINT "YOU SEE A "; L$(LG)
IF LG = 26 THEN PRINT "IT SAYS IT IS "; tcov$(TM)
IF LG = 25 THEN PRINT "IN IT YOU SEE "; BCOV$(CHARMA)

END SUB

SUB MAKEBOAT (T)
TX = 0: TY = 0: R = 0
DO
R = R + 1
IF MAP(SQX + R, SQY + R) = 0 THEN TX = SQX + R: TY = SQY + R
IF MAP(SQX + R, SQY - R) = 0 THEN TX = SQX + R: TY = SQY - R
IF MAP(SQX - R, SQY + R) = 0 THEN TX = SQX - R: TY = SQY + R
IF MAP(SQX - R, SQY - R) = 0 THEN TX = SQX - R: TY = SQY - R
IF MAP(SQX + R, SQY) = 0 THEN TX = SQX + R: TY = SQY
IF MAP(SQX - R, SQY) = 0 THEN TX = SQX - R: TY = SQY
IF MAP(SQX, SQY + R) = 0 THEN TX = SQX: TY = SQY + R
IF MAP(SQX, SQY - R) = 0 THEN TX = SQX: TY = SQY - R
LOOP WHILE TX = 0
MAP(TX, TY) = 80 + T
PRINT TX, TY: BEEP
END SUB

SUB ODORx
PRINT
PRINT "OPEN WHICH WAY- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
IF L(X + SX, Y + SY) <> 6 AND L(X + SX, Y + SY) <> 50 AND L(X + SX, Y + SY) <> 51 THEN
IF L(X + SX, Y + SY) = 7 OR L(X + SX, Y + SY) = 8 THEN PRINT "LOCKED"
IF L(X + SX, Y + SY) <> 7 AND L(X + SX, Y + SY) <> 8 THEN PRINT "HOW?"
ELSE
IF L(X + SX, Y + SY) = 6 THEN L(X + SX, Y + SY) = 49
IF L(X + SX, Y + SY) = 50 THEN L(X + SX, Y + SY) = 52
IF L(X + SX, Y + SY) = 51 THEN L(X + SX, Y + SY) = 53
END IF

END SUB

' THIS SUB CONTROLS THE WALKING OF THE OTHER PLAYERS
SUB OTHERS
UPDT = 0
FOR P = 1 TO PRN
    PX = PERSON(P, 14): PY = PERSON(P, 15)
    LV = L(PX, PY): D = INT(4 * RND) + 1
    IF D = 1 THEN SX = 0: SY = -1 ELSE IF D = 2 THEN SX = 0: SY = 1
    IF D = 3 THEN SX = -1: SY = 0 ELSE IF D = 4 THEN SX = 1: SY = 0
    IF WT(L(PX + SX, PY + SY)) = 0 AND (PX + SX <> X OR PY + SY <> Y) THEN
      PX = PX + SX: PY = PY + SY
      IF PX < 1 THEN PX = 1
      IF PY < 1 THEN PY = 1
      IF PX > 49 THEN PX = 49
      IF PY > 49 THEN PY = 49
      IF ABS(X - PX) < 5 AND ABS(Y - PY) < 5 THEN UPDT = 1: SOUND 100, .2
    END IF
    PERSON(P, 14) = PX
    PERSON(P, 15) = PY
NEXT P
END SUB

SUB outbag (index)
bag(index) = 0
FOR A = index + 1 TO BAGSIZE
  bag(A - 1) = bag(A)
NEXT A
bag(BAGSIZE) = 0
iven
END SUB

SUB PUSHx
PRINT
PRINT "PUSH WHAT- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
LG = L(X + SX, Y + SY)
IF TT(LG) = 1 THEN
PH = 0
IF TT(L(X + SX * 2, Y + SY * 2)) = 0 THEN
TEMP = L(X + SX * 2, Y + SY * 2)
L(X + SX * 2, Y + SY * 2) = L(X + SX, Y + SY)
L(X + SX, Y + SY) = TEMP
PH = 1
END IF
IF TT(L(X, Y)) = 0 THEN
TEMP = L(X, Y)
L(X, Y) = L(X + SX, Y + SY)
L(X + SX, Y + SY) = TEMP
PH = 1
END IF
IF PH = 1 THEN PRINT "PUSHED": X = X + SX: Y = Y + SY ELSE PRINT "CAN'T"
END IF
IF TT(LG) = 0 THEN PRINT "THERE IS NOTHING THERE"
IF TT(LG) = 2 THEN PRINT "YOU CAN'T MOVE THAT"

END SUB

SUB RESTx
PRINT
PRINT "REST FOR HOW MANY HOURS (0-9) :";
A = -1
DO
A$ = INKEY$
IF A$ = "0" THEN A = 0
IF A$ = "1" THEN A = 1
IF A$ = "2" THEN A = 2
IF A$ = "3" THEN A = 3
IF A$ = "4" THEN A = 4
IF A$ = "5" THEN A = 5
IF A$ = "6" THEN A = 6
IF A$ = "7" THEN A = 7
IF A$ = "8" THEN A = 8
IF A$ = "9" THEN A = 9
LOOP WHILE A = -1
PRINT A$
A$ = ""
FOR G = 1 TO 15
PALETTE G, G MOD 2 + 7
NEXT G
FOR RST = 1 TO A
TM = TM + 60
IF TM > 1440 THEN TM = TM - 1440
PRINT
PRINT "Z Z z z z . . "
PRINT
ZME = TIMER:
IF MODE = 1 THEN OTHERS
IF MODE = 1 THEN DRAWFTx
IF MODE = 2 THEN DRAWMAP
DO: LOOP WHILE TIMER - ZME < 1
NEXT RST
FOR A = 1 TO 15
PALETTE A, A
NEXT A

END SUB

SUB SEARCHx
PRINT
PRINT "SEARCH WHICH WAY- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
FD = 0
IF L(X + SX, Y + SY) = 5 THEN L(X + SX, Y + SY) = 7: FD = 1: PRINT "FOUND A SECRET PASSAGE!"
FOR A = 1 TO 20
IF OB(A, 0) > 0 AND GOT(A, CTY) = 0 THEN
IF OB(A, 1) = X + SX AND OB(A, 2) = Y + SY THEN FD = OB(A, 3):  OB(A, 0) = 0: GOT(A, CTY) = 1: A = 20
END IF
NEXT A
IF FD = 0 THEN PRINT "NOTHING FOUND"
IF FD > 0 THEN PRINT "YOU FOUND A "; O$(FD): INBAG FD
END SUB

SUB SELL (K)
T = bag(K)
IF T = 0 OR item(T, 6) <= 0 THEN SOUND 300, 3: SOUND 400, 1: EXIT SUB
VIEW PRINT 19 TO 25
COLOR 15
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
PRINT
price = item(T, 6) * .7
PRINT "Do you want to sell your "; O$(T); " for"; price; "gold(Y or N)";
DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ <> "Y" AND A$ <> "N"
VIEW PRINT
VIEW
IF A$ = "N" THEN EXIT SUB
gold = gold + price
outbag K
VIEW PRINT
VIEW
FOR A = 1 TO 10
SOUND 100 + A * 50, .2
NEXT A
END SUB

SUB SHOPx (PER)

PRINT "******************************"
IF PERSON(PER, 0) <= 3 AND PERSON(PER, 0) >= 1 THEN
    DO
    COLOR 15
    PRINT
    PRINT
    PRINT
    PRINT "You have"; gold; "gold."
    IT = PERSON(PER, C)
    PRINT O$(IT); item(IT, 6); "GOLD"
    DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ = ""
    IF A$ = "I" THEN MODE = 3: INVENTORY: MODE = 1
    IF A$ = "8" THEN C = C - 1
    IF A$ = "2" THEN C = C + 1
    IF C < 1 THEN C = 13
    IF C > 13 THEN C = 1
    IF A$ <> " " THEN PRINT
    IF A$ = " " AND item(IT, 6) <> 0 THEN
      PRINT "Do you want to buy a "; O$(IT); "(Y or N)"
      DO: A$ = UCASE$(INKEY$): LOOP WHILE A$ <> "Y" AND A$ <> "N"
      IF A$ = "Y" THEN
        IF gold >= item(IT, 6) THEN
          gold = gold - item(IT, 6)
          PRINT "It is yours."
          INBAG IT
        ELSE
          PRINT "Sorry you can't afford that."
        END IF
      ELSE
        PRINT "Okay!, chose somthing else."
      END IF
    END IF
    IF PERSON(PER, C) < 1 THEN PERSON(PER, C) = 200
    IF PERSON(PER, C) > 200 THEN PERSON(PER, C) = 1
    LOOP WHILE A$ <> "d" AND A$ <> "D" AND A$ <> "Q" AND A$ <> "+"
END IF
IF PERSON(PER, 0) = 4 THEN
    PRINT "So you want to buy a ship"
    DO
    PRINT "Well, here's what I have."
    PRINT "You have"; gold; "gold."
    PRINT "1-Skiff "; PERSON(PER, 1) * 2; "gold."
    PRINT "2-Barge "; PERSON(PER, 2) * 10; "gold."
    PRINT "3-Boat "; PERSON(PER, 3) * 5; "gold."
    INPUT "Which do you need"; A$
    IF A$ = "1" THEN
    IF gold >= PERSON(PER, 1) * 2 THEN gold = gold - PERSON(PER, 1) * 2: PRINT "Nice doing business with you": MAKEBOAT 1 ELSE PRINT "You can't afford that."
    END IF
    IF A$ = "2" THEN
    IF gold >= PERSON(PER, 2) * 10 THEN gold = gold - PERSON(PER, 2) * 10: PRINT "Nice doing business with you": MAKEBOAT 2 ELSE PRINT "You can't afford that."
    END IF
    IF A$ = "3" THEN
    IF gold >= PERSON(PER, 3) * 5 THEN gold = gold - PERSON(PER, 3) * 5: PRINT "Nice doing business with you": MAKEBOAT 3 ELSE PRINT "You can't afford that."
    END IF
    LOOP WHILE A$ <> "" AND A$ <> "0" AND A$ <> "BYE"
END IF
IF PERSON(PER, 0) = 5 THEN
    PRINT "So you want to be healed."
    DO
    PRINT "What can I do for you"
    PRINT "You have"; gold; "gold."
    PRINT "1-Heal wounded "; PERSON(PER, 1); "gold."
    PRINT "2-Cure Poisined "; PERSON(PER, 2) * 2; "gold."
    PRINT "3-Resurect Dead "; PERSON(PER, 3) * 5; "gold."
    INPUT "Which do you need"; A$
    IF A$ = "1" THEN
    IF gold >= PERSON(PER, 1) THEN gold = gold - PERSON(PER, 1): PRINT "You feel better" ELSE PRINT "You can't afford a healing."
    END IF
    IF A$ = "2" THEN
    IF gold >= PERSON(PER, 2) * 2 THEN gold = gold - PERSON(PER, 2) * 2: PRINT "Your poisin stopped" ELSE PRINT "You can't afford a curing."
    END IF
    IF A$ = "3" THEN
    IF gold >= PERSON(PER, 3) * 5 THEN gold = gold - PERSON(PER, 3) * 5: PRINT "You feel ALIVE!" ELSE PRINT "You can't afford a resurection."
    END IF
    LOOP WHILE A$ <> "" AND A$ <> "0" AND A$ <> "BYE"
END IF

PRINT "******************************"

END SUB

SUB TALKx
PRINT
PRINT "TALK WHICH WAY- ";
SX = 0: SY = 0
DO
A$ = INKEY$
IF A$ = "8" THEN SY = -1: SX = 0: PRINT "UP"
IF A$ = "4" THEN SY = 0: SX = -1: PRINT "LEFT"
IF A$ = "6" THEN SY = 0: SX = 1: PRINT "RIGHT"
IF A$ = "2" THEN SY = 1: SX = 0: PRINT "DOWN"
A$ = ""
LOOP WHILE SX = 0 AND SY = 0
PRINT
D = 0
tcr = 0
PER = 0
FOR D = 1 TO 3
FOR A = 1 TO PRN
    IF PERSON(A, 14) = X + SX * D AND PERSON(A, 15) = Y + SY * D THEN PER = A
NEXT A
IF PER > 0 THEN D = 4
NEXT D
IF PER = 0 THEN PRINT "There's not a person there.": EXIT SUB
DO
PRINT
INPUT "ASK ABOUT:"; K$
IF K$ = "" THEN K$ = "BYE"
K$ = UCASE$(K$)
R$ = ""
FOR A = 1 TO 30 STEP 2
IF UCASE$(TALK$(PER, A)) = UCASE$(K$) THEN R$ = TALK$(PER, A + 1)
NEXT A
IF K$ = "BYE" AND R$ = "" THEN R$ = "Goodbye, come again."
IF R$ = "" THEN R$ = "What are you talking about."
IF K$ = "TRADE" OR K$ = "BUY" OR K$ = "SELL" OR K$ = "PURCHASE" OR K$ = "STORE" THEN SHOPx (PER): R$ = ""
PRINT
PRINT R$
LOOP WHILE K$ <> "BYE"
PRINT
PRINT
PRINT
END SUB

FUNCTION tcov$ (TM)
HOURS = INT(TM / 60)
min = TM - HOURS * 60
IF HOURS >= 12 THEN HOURS = HOURS - 12: A$ = "PM" ELSE A$ = "AM"
IF HOURS = 0 OR HOURS = 12 THEN T$ = "12:"
IF HOURS = 1 THEN T$ = "1:"
IF HOURS = 2 THEN T$ = "2:"
IF HOURS = 3 THEN T$ = "3:"
IF HOURS = 4 THEN T$ = "4:"
IF HOURS = 5 THEN T$ = "5:"
IF HOURS = 6 THEN T$ = "6:"
IF HOURS = 7 THEN T$ = "7:"
IF HOURS = 8 THEN T$ = "8:"
IF HOURS = 9 THEN T$ = "9:"
IF HOURS = 10 THEN T$ = "10:"
IF HOURS = 11 THEN T$ = "11:"
T$ = T$ + CHR$(INT(min / 10) + 48)
T$ = T$ + CHR$(min - INT(min / 10) * 10 + 48)
T$ = T$ + " " + A$
tcov$ = T$
END FUNCTION

FUNCTION WALK
X = SQX: Y = SQY
MODE = 2
VIEW: CLS
VIEW (0, 0)-(179, 179)
VIEW PRINT 23 TO 25
DO
IF X <> OX OR Y <> OY THEN
IF MAP(OX, OY) = 49 THEN MAP(OX, OY) = 6
IF MAP(OX, OY) = 52 THEN MAP(OX, OY) = 7
IF MAP(OX, OY) = 53 THEN MAP(OX, OY) = 8
END IF
OX = X: OY = Y
IF A$ = "I" THEN INVENTORY
IF A$ = "E" AND MAP(X, Y) < 0 THEN WALK = -MAP(X, Y): SQX = X: SQY = Y: EXIT FUNCTION
IF A$ = "q" THEN RUN "\tim\menu.bas"
IF A$ = "R" THEN RESTx
IF A$ = "W" THEN PRINT "Your pocket watch says it is "; tcov$(TM): PRINT
IF A$ = " " THEN PRINT : PRINT "PASS": TM = TM + 10
IF A$ = "7" THEN X = X - 1: Y = Y - 1: SOUND 37, .2
IF A$ = "9" THEN X = X + 1: Y = Y - 1: SOUND 37, .2
IF A$ = "1" THEN X = X - 1: Y = Y + 1: SOUND 37, .2
IF A$ = "3" THEN X = X + 1: Y = Y + 1: SOUND 37, .2
IF A$ = "8" THEN Y = Y - 1: SOUND 37, .1
IF A$ = "2" THEN Y = Y + 1: SOUND 37, .1
IF A$ = "4" THEN X = X - 1: SOUND 37, .1
IF A$ = "6" THEN X = X + 1: SOUND 37, .1
IF X < 1 THEN X = 120
IF Y < 1 THEN Y = 120
IF X > 120 THEN X = 1
IF Y > 120 THEN Y = 1
IF BOAT = 0 AND MAP(X, Y) = 0 THEN X = OX: Y = OY
IF MAP(X, Y) > 80 AND MAP(X, Y) < 90 AND BOAT = 0 THEN BOAT = MAP(X, Y) - 80: MAP(X, Y) = 0
IF BOAT > 0 AND MAP(X, Y) <> 0 THEN MAP(OX, OY) = 80 + BOAT: BOAT = 0
IF MAP(X, Y) = 4 THEN X = OX: Y = OY
TM = TM + 3
IF TM > 1440 THEN TM = TM - 1440
DRAWMAP
DO: A$ = INKEY$:
DO: LOOP WHILE INKEY$ <> ""
IF TIMER - ZME >= 1 THEN ZME = TIMER
LOOP WHILE A$ = ""
LOOP
END FUNCTION

FUNCTION WP (A)
IF A < 1 THEN A = A + 120 ELSE IF A > 120 THEN A = A - 120
WP = A
END FUNCTION

