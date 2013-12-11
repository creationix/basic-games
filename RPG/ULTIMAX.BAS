DEFINT A-Z
SCREEN 7
DIM p%(200, 65)
DIM OB(20, 3), L(50, 50), O$(200), CHEST(10, 10), SIGN(5, 3), BED(5, 3)
DIM SIGN$(5), TALK$(15, 30), PERSON(15, 15), f$(26), n$(26)
DEF SEG = VARSEG(p%(0, 0))
BLOAD "light.pic", 0
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
OPEN "items.lst" FOR INPUT AS #1
O$(0) = "                "
FOR A = 1 TO 200
INPUT #1, O$(A)
O$(A) = LEFT$(O$(A) + "----------------", 15)
FOR B = 0 TO 7
INPUT #1, C
NEXT B
NEXT A
CLOSE #1
SCREEN 7
LD = 1
GOSUB LEVEL
X = 1: Y = 1
DO
A$ = INKEY$
OX = X: OY = Y
LR = R: LD = D
IF OLV = 48 THEN
G = 0
FOR A = 1 TO 15
IF PERSON(A, 0) > 0 AND PERSON(A, 14) = X AND PERSON(A, 15) = Y THEN G = A
NEXT A
'IF G > 0 AND L(OX, OY) < 48 THEN L(OX, OY) = 48
END IF
OLV = L(X, Y)
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF A$ = "'" THEN GOSUB DEST:
IF A$ = "v" THEN GOSUB LOOK: dt = 0
IF A$ = "8" THEN Y = Y - 1
IF A$ = "2" THEN Y = Y + 1
IF A$ = "4" THEN X = X - 1
IF A$ = "6" THEN X = X + 1
IF A$ = "1" THEN X = X - 1: Y = Y + 1
IF A$ = "3" THEN X = X + 1: Y = Y + 1
IF A$ = "7" THEN X = X - 1: Y = Y - 1
IF A$ = "9" THEN X = X + 1: Y = Y - 1
IF A$ = "Q" THEN L(X, Y) = 1
IF A$ = "W" THEN L(X, Y) = 2
IF A$ = "E" THEN L(X, Y) = 3
IF A$ = "R" THEN L(X, Y) = 4
IF A$ = "T" THEN L(X, Y) = 5
IF A$ = "Y" THEN L(X, Y) = 6
IF A$ = "U" THEN L(X, Y) = 7
IF A$ = "I" THEN L(X, Y) = 8
IF A$ = "O" THEN L(X, Y) = 9
IF A$ = "P" THEN L(X, Y) = 10
IF A$ = "A" THEN L(X, Y) = 11
IF A$ = "S" THEN L(X, Y) = 12
IF A$ = "D" THEN L(X, Y) = 13
IF A$ = "F" THEN L(X, Y) = 14
IF A$ = "G" THEN L(X, Y) = 15
IF A$ = "H" THEN L(X, Y) = 16
IF A$ = "J" THEN L(X, Y) = 17
IF A$ = "K" THEN L(X, Y) = 18
IF A$ = "L" THEN L(X, Y) = 19
IF A$ = ";" THEN L(X, Y) = 20
IF A$ = "p" THEN
  PER = 0
  FOR A = 1 TO 15
    IF PERSON(A, 14) = X AND PERSON(A, 15) = Y THEN PER = A
  NEXT A
  IF PER = 0 THEN L(X, Y) = 48: GOSUB NPERSON ELSE GOSUB PERSON
END IF
IF A$ = "b" AND X < 50 THEN L(X, Y) = 17: L(X + 1, Y) = 18: LX = X + 1: LY = Y: PX = X + 1 - R: PY = Y - D: GOSUB PP
IF A$ = "s" THEN GOSUB SAVE: dt = 0
IF A$ = "l" THEN GOSUB LOAD: dt = 0: X = SPX: Y = SPY: R = X - 3: D = Y - 3: GOSUB LEVEL
IF A$ = "+" THEN GOSUB HIDE: dt = 0
IF A$ = "-" THEN GOSUB SUBT: dt = 0
IF A$ = "*" THEN SPX = X: SPY = Y: dt = 0
IF A$ = "0" THEN L(X, Y) = LLL
IF A$ = "." THEN LLL = LLL + 1
IF A$ = "," THEN LLL = LLL - 1
IF A$ = "&" THEN GOSUB NCTY
IF A$ = "/" THEN GOSUB DELETE
IF LLL < 0 THEN LLL = 49
IF LLL > 49 THEN LLL = 0
IF A$ = "t" THEN L(X, Y) = 29: L(X + 1, Y) = 33: L(X, Y - 1) = 34: L(X - 1, Y) = 35: L(X, Y + 1) = 36
IF X - 1 < R THEN R = R - 2: GOSUB LEVEL
IF X - 7 > R THEN R = R + 2: GOSUB LEVEL
IF Y - 1 < D THEN D = D - 2: GOSUB LEVEL
IF Y - 7 > D THEN D = D + 2: GOSUB LEVEL
IF X < 1 + R THEN X = 1 + R
IF X > 7 + R THEN X = 7 + R
IF Y < 1 + D THEN Y = 1 + D
IF Y > 7 + D THEN Y = 7 + D
IF X < 1 THEN X = 1
IF X > 50 THEN X = 50
IF Y < 1 THEN Y = 1
IF Y > 50 THEN Y = 50
IF X <> OX OR Y <> OY OR A$ <> "" THEN
LX = OX: PX = OX - R: LY = OY: PY = OY - D: GOSUB PP
CIRCLE (X * 20 - 10 - R * 20, Y * 20 - 10 - D * 20), 7, 15
END IF
MD = 0
IF dt = 0 THEN GOSUB dAT: dt = 1
LOCATE 3, 19: COLOR 12: PRINT "X-"; X; "Y"; Y
LOCATE 4, 19: COLOR 12: PRINT "CURRENT CODE"; L(X, Y)
LOCATE 14, 19: COLOR 12: PRINT "PLACE CODE"; LLL
PX = 9: PY = 5: L = LLL: GOSUB PPP
GOSUB PEK: LOCATE 5, 19: COLOR 13: PRINT "OVER "; O$(OB(G, 3))
LOOP
DELETE:
BEEP
RETURN
NPERSON:
G = 0
FOR A = 15 TO 1 STEP -1
IF PERSON(A, 0) = 0 THEN G = A
NEXT A
IF G = 0 THEN LOCATE 24, 1: COLOR 15: PRINT "There are already 15 people"; : DO: LOOP WHILE INKEY$ = "": LOCATE 24, 1: PRINT "                           "; : RETURN
PERSON(G, 14) = X
PERSON(G, 15) = Y: BEEP
LOCATE 24, 1: PRINT "Which 3-merchant 4-Boat seller 5-Healer";
DO: A$ = INKEY$:
v = VAL(A$)
LOOP WHILE v < 1 OR v > 6
PERSON(G, 0) = v
TALK$(G, 1) = "Name"
TALK$(G, 2) = "My name is..."
TALK$(G, 3) = "Job"
IF v = 1 THEN t$ = "to sell things."
IF v = 2 THEN t$ = "to buy things."
IF v = 3 THEN t$ = "to be a merchent."
IF v = 4 THEN t$ = "to sell boats."
IF v = 5 THEN t$ = "to help you get better."
TALK$(G, 4) = "My job is " + t$
PERSON:
G = 0
FOR A = 1 TO 15
    IF PERSON(A, 14) = X AND PERSON(A, 15) = Y THEN G = A
NEXT A
IF G = 0 THEN GOTO NPERSON
LOCATE 24, 1: PRINT "                                    ";
LINE (140, 0)-(319, 148), 0, BF
LINE (140, 0)-(319, 148), 9, B
COLOR 15
C = 1
DO
IF C < 1 THEN C = 15
IF C > 15 THEN C = 1
FOR A = -5 TO 5
K = A + C
IF K < 1 THEN K = K + 15
IF K > 15 THEN K = K - 15
LOCATE 7 + A, 19
COLOR 7: IF C = K THEN COLOR 15
PRINT K; LEFT$(TALK$(G, K * 2 - 1) + "                     ", 10);
NEXT A
t$ = LEFT$(TALK$(G, C * 2) + "                                                                    ", 80)
LOCATE 15, 19
PRINT MID$(t$, 1, 20);
LOCATE 16, 19
PRINT MID$(t$, 21, 20);
LOCATE 17, 19
PRINT MID$(t$, 41, 20);
LOCATE 18, 19
PRINT MID$(t$, 61, 20);
DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "8" THEN C = C - 1
IF A$ = "2" THEN C = C + 1
IF A$ = "K" THEN LOCATE 7, 22: INPUT TALK$(G, C * 2 - 1)
IF A$ = "R" THEN A$ = "": GOSUB RESP
LOOP WHILE A$ <> "+"
LINE (140, 0)-(319, 148), 0, BF
LINE (140, 0)-(319, 148), 9, B
IF PERSON(G, 0) <= 3 AND PERSON(G, 0) >= 1 THEN
    DO
    A$ = INKEY$
    FOR A = -5 TO 5
    K = A + C
    IF K < 1 THEN K = K + 13
    IF K > 13 THEN K = K - 13
    LOCATE 7 + A, 19
    COLOR 7: IF C = K THEN COLOR 15
    PRINT K; LEFT$(O$(PERSON(G, K)) + "                     ", 10); " "
    NEXT A
    IF A$ = "8" THEN C = C - 1
    IF A$ = "2" THEN C = C + 1
    IF C < 1 THEN C = 13
    IF C > 13 THEN C = 1
    IF A$ = "6" THEN PERSON(G, C) = PERSON(G, C) + 1
    IF A$ = "4" THEN PERSON(G, C) = PERSON(G, C) - 1
    IF A$ = "." THEN PERSON(G, C) = PERSON(G, C) + 10
    IF A$ = "," THEN PERSON(G, C) = PERSON(G, C) - 10
    IF PERSON(G, C) < 1 THEN PERSON(G, C) = 200
    IF PERSON(G, C) > 200 THEN PERSON(G, C) = 1
    LOOP WHILE A$ <> "+"
END IF
IF PERSON(G, 0) = 5 THEN
    DO
    A$ = INKEY$
    LOCATE 3, 19: PRINT "1-"; PERSON(G, 1): LOCATE 3, 30: PRINT "HEAL"
    IF A$ = "1" THEN LOCATE 3, 20: INPUT PERSON(G, 1)
    LOCATE 4, 19: PRINT "2-"; PERSON(G, 2): LOCATE 4, 30: PRINT "CURE"
    IF A$ = "2" THEN LOCATE 4, 20: INPUT PERSON(G, 2)
    LOCATE 5, 19: PRINT "3-"; PERSON(G, 3): LOCATE 5, 30: PRINT "RESURECT"
    IF A$ = "3" THEN LOCATE 5, 20: INPUT PERSON(G, 3)
    LOOP WHILE A$ <> "+"
END IF
IF PERSON(G, 0) = 4 THEN
    DO
    A$ = INKEY$
    LOCATE 3, 19: PRINT "1-"; PERSON(G, 1): LOCATE 3, 30: PRINT "SKIFF"
    IF A$ = "1" THEN LOCATE 3, 20: INPUT PERSON(G, 1)
    LOCATE 4, 19: PRINT "2-"; PERSON(G, 2): LOCATE 4, 30: PRINT "SHIP"
    IF A$ = "2" THEN LOCATE 4, 20: INPUT PERSON(G, 2)
    LOCATE 5, 19: PRINT "3-"; PERSON(G, 3): LOCATE 5, 30: PRINT "BARGE"
    IF A$ = "3" THEN LOCATE 5, 20: INPUT PERSON(G, 3)
    LOOP WHILE A$ <> "+"
END IF
A$ = ""
dt = 0
RETURN
RESP:
A$ = ""
TX = 19: TY = 15
LOCATE 15, 19
PRINT MID$(t$, 1, 20)
LOCATE 16, 19
PRINT MID$(t$, 21, 20)
LOCATE 17, 19
PRINT MID$(t$, 41, 20)
LOCATE 18, 19
PRINT MID$(t$, 61, 20)
DO
    IF TY < 15 THEN TY = 15
    IF TY > 18 THEN TY = 18
    IF TX < 19 THEN TX = 19
    IF TX > 39 THEN TX = 39
    otX = TX: otY = TY
    CR = 1
    
    IF A$ = "7" THEN TX = 19: A$ = ""
    IF A$ = "8" THEN TY = TY - 1: A$ = ""
    IF A$ = "2" THEN TY = TY + 1: A$ = ""
    IF A$ = "4" THEN TX = TX - 1: A$ = ""
    IF A$ = "6" THEN TX = TX + 1: A$ = ""
    IF A$ = "+" THEN CR = 0: A$ = ""
    IF A$ = "\" OR A$ = CHR$(8) THEN TX = TX - 1: A$ = " ": RC = 1
    IF TX < 19 THEN TX = 38: TY = TY - 1
    IF TX > 38 THEN TX = 19: TY = TY + 1
    IF TY < 15 THEN TY = 15
    IF TY > 18 THEN TY = 18
    OMD = MD: MD = (TX - 18) + (TY - 15) * 20
    IF A$ <> "" AND OMD > 0 THEN
        t$ = LEFT$(t$, OMD - 1) + A$ + RIGHT$(t$, 80 - OMD)
        IF RC = 0 THEN TX = TX + 1 ELSE RC = 0
        IF TX > 38 THEN TX = 19: TY = TY + 1: IF TY > 18 THEN TY = 18
        MD = (TX - 18) + (TY - 15) * 20
    END IF
    MD = (TX - 18) + (TY - 15) * 20
    IF OMD > 0 THEN h$ = MID$(t$, OMD, 1): IF h$ = " " THEN h$ = "_"
    IF OMD > 0 THEN LOCATE otY, otX: COLOR 7: PRINT h$
    h$ = MID$(t$, MD, 1): IF h$ = " " THEN h$ = "_"
    LOCATE TY, TX: COLOR 15: PRINT h$
    A$ = INKEY$
LOOP WHILE CR = 1
TALK$(G, C * 2) = t$
CR = 1: A$ = ""
RETURN
NCTY:
FOR AX = 1 TO 50
FOR AY = 1 TO 50
L(AX, AY) = CINT(RND - .3) * 15
NEXT AY
NEXT AX
SPX = 0: SPY = 0
HON = 0: CNH = 0
GOSUB LEVEL
RETURN
MAP:
SCREEN 12
WINDOW SCREEN (0, 0)-(639, 479)
CLS
FOR AX = 1 TO 50
FOR AY = 1 TO 50
L = L(AX, AY)
IF L = 0 THEN L = 10
sx = AX * 12 - 12: sy = AY * 9 - 9
GGG:
IF INKEY$ <> "" THEN AX = 50
NEXT AY
NEXT AX
DO: LOOP WHILE INKEY$ = ""
CLS
SCREEN 7
WINDOW SCREEN (0, 0)-(319, 199)
X = OX: Y = OY
RETURN
DEST:
FOR AX = 1 TO 50
FOR AY = 1 TO 50
IF L(AX, AY) = 0 OR L(AX, AY) = 15 THEN L(AX, AY) = 13 ELSE IF L(AX, AY) = 13 THEN L(AX, AY) = CINT(RND - .3) * 15
NEXT AY
NEXT AX
GOSUB LEVEL
RETURN
SUBT:
GOSUB PEK:
IF G = 0 THEN BEEP: RETURN
OB(G, 0) = 0
OB(G, 1) = 0
OB(G, 2) = 0
OB(G, 3) = 0
HON = 20
DO
IF OB(HON, 0) = 0 THEN HON = HON - 1
LOOP WHILE OB(HON, 0) = 0 AND HON > 0
RETURN
PEK:
G = 0
FOR A = 1 TO HON
IF OB(A, 1) = X AND OB(A, 2) = Y THEN G = A
NEXT A
RETURN
HIDE:
GOSUB PEK
IF G <> 0 THEN RETURN
DO
G = 0
FOR A = HON TO 1 STEP -1
IF OB(A, 0) = 0 THEN G = A
NEXT A
IF G = 0 THEN HON = HON + 1
LOOP WHILE HON < 20 AND G = 0
IF HON > 20 THEN HON = 20
OB(G, 0) = 1
OB(G, 1) = X
OB(G, 2) = Y
CR = 1
DO
A$ = INKEY$
IF A$ = "4" THEN t = t - 1
IF A$ = "6" THEN t = t + 1
IF t < 1 THEN t = 200
IF t > 200 THEN t = 1
LOCATE 23, 1: PRINT "Item#"; t; O$(t);
IF A$ = " " THEN CR = 0
LOOP WHILE CR = 1
LOCATE 23, 1: PRINT "                                  ";
A$ = ""
OB(G, 3) = t
RETURN
dAT:
LINE (140, 0)-(319, 140), 0, BF
IF L$ = "" THEN L$ = "Untitled"
LOCATE 2, 19: COLOR 15: PRINT "CITY NAME: "; L$
LOCATE 3, 19: COLOR 12: PRINT "X-"; X; "Y"; Y
LOCATE 4, 19: COLOR 12: PRINT "CURRENT CODE"; L(X, Y)
LOCATE 6, 19: COLOR 10: PRINT "START:"; SPX; SPY
LOCATE 7, 19: COLOR 10: PRINT "HIDDEN OBJ#"; HON
LOCATE 8, 19: COLOR 10: PRINT "CHEST#"; CHN
LINE (140, 0)-(319, 160), 9, B
RETURN
LOOK:
SCREEN 12
OMD = MD
MD = 2
R = R - 16
D = D - 12
IF R < 0 THEN R = 0
IF D < 0 THEN D = 0
IF R > 18 THEN R = 18
IF D > 24 THEN D = 24
FOR LY = 1 + D TO 24 + D
FOR LX = 1 + R TO 32 + R
PX = LX - R: PY = LY - D
GOSUB PP
NEXT LX
NEXT LY
MD = OMD
DO: LOOP WHILE INKEY$ = ""
R = LR
D = LD
SCREEN 7
GOSUB LEVEL
RETURN
SAVE:
IF L$ <> "" THEN PRINT "WAS: "; L$
OL$ = L$
INPUT "SAVE AS"; L$
IF L$ = "" THEN L$ = OL$
IF RIGHT$(L$, 4) <> ".UTX" THEN L$ = L$ + ".UTX"
OPEN L$ FOR OUTPUT AS #1
FOR sy = 1 TO 50
A$ = ""
FOR sx = 1 TO 50
A$ = A$ + CHR$(L(sx, sy) + 100)
NEXT sx
PRINT #1, A$
NEXT sy
PRINT #1, SPX, SPY
PRINT #1, HON
FOR G = 1 TO HON
FOR B = 0 TO 3
PRINT #1, OB(G, B)
NEXT B
NEXT G
PRN = 0
FOR A = 1 TO 15
IF PERSON(A, 0) > 0 THEN PRN = A
NEXT A
PRINT #1, PRN
FOR A = 1 TO PRN
A$ = ""
FOR B = 0 TO 15
A$ = A$ + CHR$((PERSON(A, B)) MOD 200 + 55)
NEXT B
PRINT #1, A$
FOR B = 0 TO 30
PRINT #1, TALK$(A, B)
NEXT B
NEXT A
CLOSE #1
GOSUB LEVEL
RETURN
LOAD:
FOR A = 1 TO 26 STEP 2
    LOCATE A / 2 + .5, 1
    PRINT A; n$(A)
    LOCATE A / 2 + .5, 20
    PRINT A + 1; n$(A + 1)
NEXT A
INPUT "LOAD WHICH"; L
L$ = f$(L)
IF L$ = "" THEN GOSUB LEVEL: RETURN
OPEN L$ FOR INPUT AS #1
FOR sy = 1 TO 50
    INPUT #1, A$
    FOR sx = 1 TO 50
        L(sx, sy) = ASC(MID$(A$, sx, 1)) - 100
    NEXT sx
NEXT sy
INPUT #1, SPX, SPY
X = SPX: Y = SPY
INPUT #1, HON
FOR G = 0 TO 20
    FOR B = 0 TO 3
        OB(G, B) = 0
    NEXT B
NEXT G
FOR G = 1 TO HON
    FOR B = 0 TO 3
        INPUT #1, OB(G, B)
    NEXT B
NEXT G
INPUT #1, PRN
FOR A = 1 TO 15
    FOR B = 0 TO 15
        PERSON(A, B) = 0
    NEXT B
    FOR B = 0 TO 30
        TALK$(A, B) = ""
    NEXT B
NEXT A
FOR A = 1 TO PRN
    INPUT #1, A$
    IF A$ <> "" THEN
        FOR B = 0 TO 15
            PERSON(A, B) = ASC(MID$(A$, B + 1, 1)) - 55
        NEXT B
    END IF
    FOR B = 0 TO 30
        LINE INPUT #1, TALK$(A, B)
    NEXT B
NEXT A
CLOSE #1
X = SPX: Y = SPY
RETURN
LEVEL:
IF R < 0 - MD THEN R = 0 - MD
IF D < 0 - MD THEN D = 0 - MD
IF R > 43 + MD THEN R = 43 + MD
IF D > 43 + MD THEN D = 43 + MD
FOR LX = 1 + R TO 7 + R
FOR LY = 1 + D TO 7 + D
PX = LX - R: PY = LY - D
GOSUB PP
NEXT LY
NEXT LX
RETURN
PP:
IF LX > 0 AND LY > 0 AND LX < 51 AND LY < 51 THEN L = L(LX, LY) ELSE L = 0
PPP:
sx = PX * 20 - 20: sy = PY * 20 - 20
IF sx < 0 OR sy < 0 THEN RETURN
IF MD <> 2 THEN IF sx > 299 OR sy > 189 THEN RETURN
IF L = 0 THEN L = 10
PUT (sx, sy), p%(0, L + 16), PSET
RETURN

