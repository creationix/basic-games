DECLARE SUB MousePut (X%, Y%)
DECLARE SUB load ()
DECLARE SUB save ()
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE SUB MOUSESTATUS (lb%, RB%, xmouse%, ymouse%)

DIM SHARED mouse$, OMX, OMY

GOSUB mouse

DEFINT A-R
DEFINT U-Z
RANDOMIZE (TIMER)
SD = 1
SCREEN 0
DO
	CLS
	INPUT "1-PLAY FULL STRATAGY OR 2-BATTLE PRACTICE OR 0-QUIT"; NM: IF NM = 0 THEN RUN "\tim\menu.bas"
LOOP WHILE NM <> 1 AND NM <> 2
DO
	INPUT "HOW MANY PLAYERS"; pn
	CLS
	pn = INT(pn)
LOOP WHILE pn < 2 OR pn > 7

SCREEN 7
DIM SX(8), SY(8)
DIM MP(24, 24)
DIM L(24, 80)
DIM W$(20)
DIM MONEY(8), P(24, 3), A(20), W(20), E(20), S(20), n$(20)
DIM tmp%(32000), O%(13)
DIM S%(200)
DIM ST(8)
GET (1, 1)-(1, 1), O%
LOCATE 12, 12: COLOR 15: PRINT "Loading Wars of Melbon"
SCREEN , , 5, 0
DEF SEG = VARSEG(tmp%(0))
BLOAD "ships.gfx", 0
PUT (0, 0), tmp%
DEF SEG
OPEN "wars.dat" FOR INPUT AS #1
n$(0) = "NONE       "
FOR A = 1 TO 20
INPUT #1, W$(A)
W$(A) = LEFT$(W$(A) + "          ", 11)
NEXT A
FOR A = 1 TO 20
INPUT #1, n$(A)
n$(A) = LEFT$(n$(A) + "          ", 11)
NEXT A
FOR A = 1 TO 24
INPUT #1, P(A, 1), P(A, 2)
NEXT A
FOR A = 1 TO 20
INPUT #1, A(A), W(A), E(A), S(A)
NEXT A
FOR A = 1 TO 24
L(A, 21) = 500 + 500 * RND
NEXT A
IF NM = 1 THEN
	FOR A = 1 TO pn
		SOUND A * 100, .1
		DO: AA = INT(24 * RND) + 1: LOOP WHILE L(AA, 0) <> 0
		ST(A) = AA
		SX(A) = P(AA, 1)
		SY(A) = P(AA, 2)
		MONEY(A) = 2500
		L(AA, 21) = 2000
		L(AA, 0) = A
		L(AA, 22) = 3
		L(AA, 23) = 2
		L(AA, 24) = 1
	NEXT A
	FOR A = 1 TO 24
		INPUT #1, P(A, 3)
	NEXT A
	FOR A = 1 TO 24
		FOR B = 1 TO 24
		INPUT #1, MP(A, B)
		NEXT B
	NEXT A
END IF
SCREEN , , 0
CLOSE #1
IF NM = 1 THEN
2
	GOSUB UPDATE
	WHO = 1
1
	A$ = ""
	PLAY "MB O1 L16 AABA>C<A>D<A"
	COLOR WHO + 8
	LOCATE 13, 15: PRINT "PLAYER"; WHO
	DO: LOOP WHILE INKEY$ <> "": DO: LOOP WHILE INKEY$ = ""
	Y = SY(WHO) - 100
	SX = SX(WHO): SY = SY(WHO)
	IF Y < 0 THEN Y = 0
	IF Y > 199 THEN Y = 199
	ST = 1
	X = -10
	GOSUB GO:
	WHO = WHO + 1: IF WHO <= pn THEN GOTO 1
	CLS
	LOCATE 13, 15: COLOR 14: PRINT "UPDATING.."
GOTO 2
END IF
CLS
FOR A = 1 TO pn
L(A, 0) = A
NEXT A
DO
FC = 0
FOR G = 1 TO pn
WHO = L(G, 0)
	CR = 1
	TY = 1
	FST = 1
	DO
		IF A$ = "q" THEN SYSTEM
		IF A$ = "Q" THEN CR = 0
		IF (A$ = " ") OR lb <> 0 THEN
			DO
				LOCATE 1, 1: INPUT "ATTACK WHERE"; WH
			LOOP WHILE WH < 0 OR WH > pn
			IF WH = WHO THEN WH = 0
			L(G, TY + 60) = WH
		END IF
		IF A$ = "." THEN FC = FC + 1
		IF A$ = "," THEN FC = FC - 1
		IF FC < 0 THEN FC = 0
		IF FC > 8 THEN FC = 8
		IF A$ = "8" THEN TY = TY - 1
		IF A$ = "2" THEN TY = TY + 1
		IF TY < 1 THEN TY = 10
		IF TY > 10 THEN TY = 1
		TT = L(G, TY)
		IF A$ = "*" THEN TT = INT(20 * RND) + 1
		IF A$ = "4" THEN TT = TT - 1
		IF A$ = "6" THEN TT = TT + 1
		IF TT < 0 THEN TT = 20
		IF TT > 20 THEN TT = 0
		L(G, TY) = TT
		IF TT <= 10 THEN L(G, TY + 10) = 50 ELSE L(G, TY + 10) = 100
		L(G, TY + 30) = A(TT)
		L(G, TY + 40) = W(TT)
		L(G, TY + 50) = E(TT)
		L(G, TY + 70) = S(TT)
		COLOR WHO + 8
		LOCATE 1, 1: PRINT "                     PLAYER"; WHO
		COLOR 14
		LOCATE 2, 1: PRINT "NAME       HP     MOVING STATUS"
		FOR A = 1 TO 10
			LOCATE A + 2, 1
			COLOR 15
			IF A = TY THEN COLOR 9
			PRINT n$(L(G, A))
			IF L(G, A) > 0 THEN
				LOCATE A + 2, 12: COLOR 9
				IF L(G, A) <= 10 THEN PRINT 50 ELSE PRINT 100
				LOCATE A + 2, 19
				IF L(G, A + 60) = 0 OR L(G, A + 60) = G THEN
					COLOR WHO + 8: PRINT "DEFENDING"
				ELSE
					IF L(L(G, A + 60), 0) = WHO THEN COLOR WHO + 8: PRINT "MOVING   "
					IF L(L(G, A + 60), 0) <> 0 THEN COLOR L(G, A + 60) + 8: PRINT "ATTACKING"
				END IF
			ELSE
				LOCATE A + 2, 12
				PRINT "                           "
			END IF
		NEXT A
		LOCATE 13, 1: COLOR 10: PRINT "FORTS"; : COLOR 12
		FOR A = 1 TO FC: PRINT "#"; : NEXT A: PRINT "        "
		DO: A$ = INKEY$: LOOP WHILE A$ = "" AND FST = 0
		IF FST > 1 THEN FST = FST - .5
	LOOP WHILE CR = 1
	FOR A = 1 TO 8
	IF FC >= A THEN L(G, 21 + A) = 1 ELSE L(G, 21 + A) = 0
	NEXT A
NEXT G
GOSUB UPDATE:
LOOP
GO:
DO
   IF OX = X AND OY = Y THEN PUT (OSX - OX, OSY - OY), O%, PSET

	IF SX - X + 4 < 320 THEN GET (SX - X, SY - Y)-(SX - X + 4, SY - Y + 4), O%
	IF MV = 0 THEN
		CIRCLE (SX - X + 2, SY - Y + 2), 2, WHO + 8
		CIRCLE (SX - X + 2, SY - Y + 2), 0, WHO
		CIRCLE (SX - X + 2, SY - Y + 2), 1, 15
	ELSE
		LINE (SX - X, SY - Y)-(SX - X + 4, SY - Y + 4), 9, B
		LINE (SX - X + 1, SY - Y + 1)-(SX - X + 3, SY - Y + 3), 10, B
		LINE (SX - X + 2, SY - Y + 2)-(SX - X + 2, SY - Y + 2), WHO
	END IF
	OX = X: OY = Y: OSX = SX: OSY = SY
	IF MV = 1 AND A$ = "`" THEN MV = 0: A$ = ""
	IF A$ = "`" THEN RETURN
	IF MV = 1 AND A$ = " " THEN
		GOSUB WHICH:
		IF WH > 0 THEN
			
			MV = 0
			CT = WH: N1 = 1: N2 = 10
			MT = WH
			GOSUB FINDSPACE:
			'IF N > 0 THEN
		IF MP(OCT, WH) = 1 OR MP(WH, OCT) = 1 THEN
					L(OCT, NO + 60) = MT: A$ = ""
				ELSE
					CT = OCT: N1 = 22: N2 = 30: F = 5
					GOSUB CHECK:
					IF n > 0 AND P(OCT, 3) = 1 THEN
						L(OCT, NO + 60) = -MT: A$ = ""
						L(OCT, n) = -5
					ELSE
						CT = OCT: N1 = 22: N2 = 30: F = 4: GOSUB CHECK:
						IF n > 0 THEN
							L(OCT, NO + 60) = -MT: A$ = ""
							L(OCT, n) = -4
						END IF
					END IF
				END IF
			'END IF
		END IF
	END IF
	IF A$ = "W" AND MONEY(WHO) >= 200 THEN
		GOSUB WHICH:
		IF L(WH, O) = WHO THEN
			CT = WH: C1 = 22: N2 = 30: F = 7: GOSUB CHECK:
			IF n > 0 THEN
				GET (0, 0)-(319, 199), tmp%
				COLOR 15
				KY = 0
				DO
					LOCATE 2, 3: COLOR 10: PRINT "MONEY"; INT(MONEY(WHO))
					COLOR 15

					n$ = n$(ABS(L(CT, TY)))
					IF n$ = "" THEN n$ = "         "
					LOCATE 3, 3: PRINT TY; n$
					COLOR 9
					W$ = W$(L(CT, TY + 70))
					IF W$ = "" THEN W$ = "            "
					LOCATE 5, 3: PRINT W$
					COLOR 7
					LOCATE 6, 3: PRINT "ARMOR"; L(CT, TY + 30)
					LOCATE 7, 3: PRINT "WEAPON"; L(CT, TY + 40)
					LOCATE 8, 3: PRINT "ENGINE"; L(CT, TY + 50)
					LOCATE 9, 3: PRINT "HIT POINTS"; L(CT, TY + 10)
					IF L(CT, TY + 60) <> 0 THEN m$ = "MOVED " ELSE m$ = "HERE  "
					IF L(CT, TY) < 0 THEN m$ = "COMING"
					COLOR 12
					LOCATE 10, 3: PRINT m$
					FOR A = -5 TO 5
						LOCATE 10 + A, 20
						n = A + TTT
						IF n < 1 THEN n = n + 20
						IF n > 20 THEN n = n - 20
						IF A = 0 THEN COLOR 9 ELSE COLOR 7
						PRINT W$(n)
					NEXT A
					DO: m$ = INKEY$: LOOP WHILE m$ = ""
					IF m$ = "4" THEN TY = TY - 1: TY = TY + 1: DO: TY = TY - 1: LOOP WHILE L(CT, TY) = 0
					IF m$ = "6" THEN TY = TY + 1: TY = TY - 1: DO: TY = TY + 1: LOOP WHILE L(CT, TY) = 0
					IF m$ = "8" THEN TTT = TTT - 1
					IF m$ = "2" THEN TTT = TTT + 1
					IF TTT < 1 THEN TTT = 20
					IF TTT > 20 THEN TTT = 1
					TT = 0
					IF m$ = "+" THEN TT = TTT
					IF TT > 0 THEN MONEY(WHO) = MONEY(WHO) - 75: L(CT, TY + 70) = TT
					IF TY < 1 THEN TY = 10
					IF TY > 10 THEN TY = 1
					IF m$ = " " THEN KY = 1
				LOOP WHILE MONEY(WHO) >= 200 AND KY = 0
				PUT (0, 0), tmp%, PSET
			END IF
		END IF
	END IF
	IF A$ = "S" THEN
		GET (0, 0)-(319, 199), tmp%
		COLOR 15: LOCATE 3, 15: PRINT "SAVE GAME"
		COLOR 7
		FOR A = 0 TO 9
		 LOCATE 5 + A, 5: PRINT "GAME SLOT"; A
		NEXT A
		DO: LOOP WHILE INKEY$ <> ""
		KY = 0
		DO
			m$ = INKEY$
			IF m$ = " " THEN TY = -1: KY = 1
			IF m$ = "0" THEN TY = 0: KY = 1
			IF m$ = "1" THEN TY = 1: KY = 1
			IF m$ = "2" THEN TY = 2: KY = 1
			IF m$ = "3" THEN TY = 3: KY = 1
			IF m$ = "4" THEN TY = 4: KY = 1
			IF m$ = "5" THEN TY = 5: KY = 1
			IF m$ = "6" THEN TY = 6: KY = 1
			IF m$ = "7" THEN TY = 7: KY = 1
			IF m$ = "8" THEN TY = 8: KY = 1
			IF m$ = "9" THEN TY = 9: KY = 1
		LOOP WHILE KY = 0
		IF TY >= 0 THEN
			S$ = "wars.00" + CHR$(TY + 48)
			OPEN S$ FOR OUTPUT AS #1
			FOR A = 1 TO 24
				FOR B = 0 TO 80
					PRINT #1, L(A, B)
				NEXT B
			NEXT A
			PRINT #1, pn
			FOR A = 1 TO pn
				WRITE #1, MONEY(A), SX(A), SY(A)
			NEXT A
			PRINT #1, WHO
			CLOSE #1
		END IF
		PUT (0, 0), tmp%, PSET
	END IF
	IF A$ = "L" THEN
		GET (0, 0)-(319, 199), tmp%
		COLOR 15: LOCATE 3, 15: PRINT "LOAD GAME"
		COLOR 7
		FOR A = 0 TO 9
		 LOCATE 5 + A, 5: PRINT "GAME SLOT"; A
		NEXT A
		DO: LOOP WHILE INKEY$ <> ""
		KY = 0
		DO
			m$ = INKEY$
			IF m$ = " " THEN TY = -1: KY = 1
			IF m$ = "0" THEN TY = 0: KY = 1
			IF m$ = "1" THEN TY = 1: KY = 1
			IF m$ = "2" THEN TY = 2: KY = 1
			IF m$ = "3" THEN TY = 3: KY = 1
			IF m$ = "4" THEN TY = 4: KY = 1
			IF m$ = "5" THEN TY = 5: KY = 1
			IF m$ = "6" THEN TY = 6: KY = 1
			IF m$ = "7" THEN TY = 7: KY = 1
			IF m$ = "8" THEN TY = 8: KY = 1
			IF m$ = "9" THEN TY = 9: KY = 1
		LOOP WHILE KY = 0
		IF TY >= 0 THEN
			S$ = "wars.00" + CHR$(TY + 48)
			OPEN S$ FOR INPUT AS #1
			FOR A = 1 TO 24
				FOR B = 0 TO 80
					INPUT #1, L(A, B)
				NEXT B
			NEXT A
			INPUT #1, pn
			FOR A = 1 TO pn
				INPUT #1, MONEY(A), SX(A), SY(A)
			NEXT A
			INPUT #1, WHO
			CLOSE #1
		END IF
		IF m$ <> " " THEN GOSUB MAP1: GOSUB REFRESH: A$ = "C": X = -10
	END IF
	IF A$ = "F" AND MONEY(WHO) >= 500 THEN
		GOSUB WHICH:
		IF L(WH, 0) = WHO THEN
			CT = WH: N1 = 22: N2 = 23: F = 3: GOSUB CHECK:
			IF n = 0 THEN
				CT = WH: N1 = 22: N2 = 30: GOSUB FINDSPACE:
				IF n > 0 THEN
					MONEY(WHO) = MONEY(WHO) - 500
					L(CT, n) = 3
					PX = P(CT, 1)
					PY = P(CT, 2)
					IF PX < 320 AND PY < 200 THEN SCREEN , , 0, 4
					IF PX >= 320 AND PY < 200 THEN SCREEN , , 1, 4
					IF PX < 320 AND PY >= 200 THEN SCREEN , , 2, 4
					IF PX >= 320 AND PY >= 200 THEN SCREEN , , 3, 4
					IF PX > 320 THEN PX = PX - 320
					IF PY > 200 THEN PY = PY - 200
					LINE (PX - 23, PY - 23)-(PX + 23, PY + 23), WHO + 8, B
					LINE (PX - 24, PY - 24)-(PX + 24, PY + 24), WHO, B
					SCREEN , , 4, 4: OX = -10
				END IF
			END IF
		END IF
	END IF
	IF A$ = "B" THEN
		GOSUB WHICH:
		CT = WH: N1 = 22: N2 = 30: F = 3: GOSUB CHECK:
		IF L(WH, 0) = WHO AND n > 0 THEN
			N1 = 22: N2 = 30: CT = WH
			GOSUB FINDSPACE:
			IF n > 0 THEN
				GET (0, 0)-(319, 199), tmp%
				COLOR 15
				LOCATE 4, 5: PRINT "MONEY"; INT(MONEY(WHO))
				LOCATE 5, 5: PRINT "1-FORT      $1000"
				LOCATE 6, 5: PRINT "2-ARMORY    $2000"
				LOCATE 7, 5: PRINT "3-AIRPORT   $5000"
				LOCATE 8, 5: PRINT "4-SEADOCK   $3000"
				LOCATE 9, 5: PRINT "5-TRAINING  $2600"
				LOCATE 10, 5: PRINT "6-WEAPONORY $2400"
				FOR A = 22 TO 30
					LOCATE A - 10, 5
					COLOR 15
					IF ABS(L(WH, A)) = 1 THEN PRINT "FORT      ";
					IF ABS(L(WH, A)) = 2 THEN PRINT "ARMORY    ";
					IF ABS(L(WH, A)) = 3 THEN PRINT "CAPITAL   ";
					IF ABS(L(WH, A)) = 4 THEN PRINT "AIRPORT   ";
					IF ABS(L(WH, A)) = 5 THEN PRINT "SEADOCK   ";
					IF ABS(L(WH, A)) = 6 THEN PRINT "TRAINING  ";
					IF ABS(L(WH, A)) = 7 THEN PRINT "WEAPONARY ";
					COLOR 14
					IF L(WH, A) < 0 THEN PRINT "BUILDING" ELSE PRINT ""
				NEXT A
				DO: LOOP WHILE INKEY$ <> ""
				KY = 0
				DO
					A$ = INKEY$
					IF A$ = "q" THEN SYSTEM
					IF A$ = "1" AND MONEY(WHO) >= 1000 THEN MONEY(WHO) = MONEY(WHO) - 1000: L(CT, n) = -1: KY = 1
					IF A$ = "2" AND MONEY(WHO) >= 2000 THEN MONEY(WHO) = MONEY(WHO) - 2000: L(CT, n) = -2: KY = 1
					IF A$ = "3" AND MONEY(WHO) >= 5000 THEN MONEY(WHO) = MONEY(WHO) - 5000: L(CT, n) = -4: KY = 1
					IF A$ = "4" AND MONEY(WHO) >= 3000 AND P(CT, 3) = 1 THEN MONEY(WHO) = MONEY(WHO) - 3000: L(CT, n) = -5: KY = 1
					IF A$ = "5" AND MONEY(WHO) >= 2600 THEN MONEY(WHO) = MONEY(WHO) - 2600: L(CT, n) = -6: KY = 1
					IF A$ = "6" AND MONEY(WHO) >= 2400 THEN MONEY(WHO) = MONEY(WHO) - 2400: L(CT, n) = -7: KY = 1
					IF A$ = " " THEN KY = 1
					A$ = ""
				LOOP WHILE KY = 0
				PUT (0, 0), tmp%, PSET
			END IF
		END IF
	END IF
	IF A$ = "T" AND MONEY(WHO) >= 100 THEN
		GOSUB WHICH:
		IF L(WH, 0) = WHO THEN
			CT = WH
			N1 = 22: N2 = 30: F = 6
			GOSUB CHECK:
			IF n > 0 THEN
				GET (0, 0)-(319, 199), tmp%
				KY = 0
				TY = 1
				DO
					LOCATE 2, 3: COLOR 10: PRINT "MONEY"; INT(MONEY(WHO))
					COLOR 15
					n$ = n$(ABS(L(CT, TY)))
					IF n$ = "" THEN n$ = "         "
					LOCATE 3, 3: PRINT TY; n$
					W$ = W$(L(CT, TY + 70))
					IF W$ = "" THEN W$ = "            "
					LOCATE 4, 3: PRINT W$
					IF TT = 1 THEN COLOR 9 ELSE COLOR 7
					LOCATE 5, 3: PRINT "ARMOR"; L(CT, TY + 30)
					IF TT = 2 THEN COLOR 9 ELSE COLOR 7
					LOCATE 6, 3: PRINT "WEAPON"; L(CT, TY + 40)
					IF TT = 3 THEN COLOR 9 ELSE COLOR 7
					LOCATE 7, 3: PRINT "ENGINE"; L(CT, TY + 50)
					IF TT = 4 THEN COLOR 9 ELSE COLOR 7
					LOCATE 8, 3: PRINT "HIT POINTS"; L(CT, TY + 10)
					IF L(CT, TY + 60) <> 0 THEN m$ = "MOVED " ELSE m$ = "HERE  "
					IF L(CT, TY) < 0 THEN m$ = "COMING"
					COLOR 12
					LOCATE 9, 3: PRINT m$
					DO: m$ = INKEY$: LOOP WHILE m$ = ""
					IF m$ = "4" THEN TY = TY - 1: TY = TY + 1: DO: TY = TY - 1: LOOP WHILE L(CT, TY) = 0
					IF m$ = "6" THEN TY = TY + 1: TY = TY - 1: DO: TY = TY + 1: LOOP WHILE L(CT, TY) = 0
					IF m$ = "8" THEN TT = TT - 1
					IF m$ = "2" THEN TT = TT + 1
					IF m$ = "+" AND MONEY(WHO) >= 100 THEN
						MONEY(WHO) = MONEY(WHO) - 100
						IF TT = 1 AND L(CT, TY + 30) < A(ABS(L(CT, TY))) + 11 THEN L(CT, TY + 30) = L(CT, TY + 30) + 1
						IF TT = 2 AND L(CT, TY + 40) < W(ABS(L(CT, TY))) + 11 THEN L(CT, TY + 40) = L(CT, TY + 40) + 1
						IF TT = 3 AND L(CT, TY + 50) < E(ABS(L(CT, TY))) + 11 THEN L(CT, TY + 50) = L(CT, TY + 50) + 1
						IF TT = 4 AND L(CT, TY + 30) < 200 THEN L(CT, TY + 10) = L(CT, TY + 10) + 10
					END IF
					IF TY < 1 THEN TY = 10
					IF TY > 10 THEN TY = 1
					IF TT < 1 THEN TT = 4
					IF TT > 4 THEN TT = 1
					IF m$ = " " THEN KY = 1
				LOOP WHILE KY = 0
				PUT (0, 0), tmp%, PSET
			END IF
		END IF
	END IF
	IF A$ = "M" OR B2 <> 0 THEN
		IF MONEY(WHO) >= 700 THEN
			GOSUB WHICH:
			IF L(WH, 0) = WHO THEN
				CT = WH
				N1 = 22: N2 = 30: F = 2
				GOSUB CHECK:
				IF n > 0 THEN
					N1 = 1: N2 = 10
					GOSUB FINDSPACE:
					IF n > 0 THEN
						GET (0, 0)-(319, 199), tmp%
						KY = 1
						DO
							COLOR 15
							LOCATE 3, 5: PRINT "MONEY"; MONEY(WHO)
							FOR A = -4 TO 4
								LOCATE A + 10, 5
								n = TY + A
								IF n < 1 THEN n = n + 20
								IF n > 20 THEN n = n - 20
								IF n < 1 THEN n = 1 ELSE IF n > 20 THEN n = 20
								IF A = 0 THEN COLOR 9 ELSE IF n <= 10 THEN COLOR 7 ELSE COLOR 10
								PRINT n$(n)
							NEXT A
							KY = 0
							B1 = STRIG(1)
							STY = STICK(0)
							IF STY = 0 THEN DO: m$ = INKEY$: LOOP WHILE m$ = ""
							IF STY > 0 THEN DO: STY = STICK(0): LOOP WHILE ABS(STY - 100) < 20
							IF STY > 0 THEN
								B1 = STRIG(0)
								IF STY < 80 THEN TY = TY - 1
								IF STY > 120 THEN TY = TY + 1
							ELSE
								IF m$ = "8" THEN TY = TY - 1
								IF m$ = "2" THEN TY = TY + 1
							END IF
							IF TY < 1 THEN TY = 20
							IF TY > 20 THEN TY = 1
							IF m$ = "+" OR B1 <> 0 THEN
								N1 = 1: N2 = 10: GOSUB FINDSPACE:
								IF n > 0 THEN
								IF TY > 0 AND TY <= 10 THEN MONEY(WHO) = MONEY(WHO) - 700: L(CT, n) = -TY: L(CT, n + 10) = 50: L(CT, n + 30) = A(TY): L(CT, n + 40) = W(TY): L(CT, n + 50) = E(TY): L(CT, n + 60) = 0: L(CT, n + 70) = S(TY)
								IF TY > 10 AND TY <= 20 AND MONEY(WHO) >= 1300 THEN MONEY(WHO) = MONEY(WHO) - 1300: L(CT, n) = -TY: L(CT, n + 10) = 100: L(CT, n + 30) = A(TY): L(CT, n + 40) = W(TY): L(CT, n + 50) = E(TY): L(CT, n + 60) = 0: L(CT, n + 70) = S(TY)
								END IF
							END IF
							IF m$ = " " THEN KY = 1
							IF MONEY(WHO) < 700 THEN KY = 1
						LOOP WHILE KY = 0
						PUT (0, 0), tmp%, PSET
					END IF
				END IF
			END IF
		END IF
	END IF
	IF A$ = "I" THEN
		GET (0, 0)-(319, 199), tmp%
		LOCATE 5, 10: COLOR WHO + 8: PRINT "PLAYER"; WHO
		LOCATE 6, 10: PRINT "MONEY"; INT(MONEY(WHO) + .5)
		DO: LOOP WHILE INKEY$ <> "": DO: LOOP WHILE INKEY$ = ""
		PUT (0, 0), tmp%, PSET
	END IF
	IF A$ = " " THEN
		GOSUB WHICH:
		IF WH > 0 AND L(WH, 0) = WHO THEN
			GET (0, 0)-(319, 199), tmp%
			LOCATE 2, 1
			COLOR 15
			PRINT "#NAME      A W E  WEAPON      HP"
			FOR A = 1 TO 10
				IF L(WH, A) <> 0 THEN
					n$ = n$(ABS(L(WH, A)))
					AR = L(WH, A + 30)
					W = L(WH, A + 40)
					E = L(WH, A + 50)
					m = L(WH, A + 60)
					S = L(WH, A + 70)
					HP = L(WH, A + 10)
					LOCATE A + 3, 1
					COLOR 15
					IF A < 10 THEN PRINT CHR$(A + 48);  ELSE PRINT "0"
					COLOR 9
					LOCATE A + 3, 2
					PRINT n$
					COLOR 13
					LOCATE A + 3, 11
					PRINT AR
					COLOR 14
					LOCATE A + 3, 13
					PRINT W
					COLOR 12
					LOCATE A + 3, 15
					PRINT E
					LOCATE A + 3, 19
					COLOR 10
					PRINT W$(S)
					COLOR 15
					LOCATE A + 3, 30
					PRINT HP
					LOCATE A + 3, 34
					IF m <> 0 THEN m$ = "MOVING" ELSE m$ = ""
					IF L(WH, A) < 0 THEN m$ = "MAKING"
					COLOR 14
					PRINT m$

				END IF
			NEXT A
			LOCATE 15, 5: COLOR 15: PRINT "INCOME"; INT(L(WH, 21) + .5)
			COLOR L(WH, 0) + 8
			LOCATE 16, 5: PRINT "OWNED BY"; L(WH, 0)
			KY = 0
			MouseShow
			DO
				m$ = INKEY$
				MOUSESTATUS lb, RB, MX, my
				IF amouse$ = "YES" THEN n = (my \ 8) - 2: IF lb THEN m$ = " ": IF n > 0 AND n < 10 THEN m$ = RIGHT$(STR$(n), 1) ELSE IF n = 10 THEN m$ = " "
				IF m$ = "1" THEN OCT = WH: NO = 1: KY = 1: IF L(WH, 1) > 0 THEN MV = 1
				IF m$ = "2" THEN OCT = WH: NO = 2: KY = 1: IF L(WH, 2) > 0 THEN MV = 1
				IF m$ = "3" THEN OCT = WH: NO = 3: KY = 1: IF L(WH, 3) > 0 THEN MV = 1
				IF m$ = "4" THEN OCT = WH: NO = 4: KY = 1: IF L(WH, 4) > 0 THEN MV = 1
				IF m$ = "5" THEN OCT = WH: NO = 5: KY = 1: IF L(WH, 5) > 0 THEN MV = 1
				IF m$ = "6" THEN OCT = WH: NO = 6: KY = 1: IF L(WH, 6) > 0 THEN MV = 1
				IF m$ = "7" THEN OCT = WH: NO = 7: KY = 1: IF L(WH, 7) > 0 THEN MV = 1
				IF m$ = "8" THEN OCT = WH: NO = 8: KY = 1: IF L(WH, 8) > 0 THEN MV = 1
				IF m$ = "9" THEN OCT = WH: NO = 9: KY = 1: IF L(WH, 9) > 0 THEN MV = 1
				IF m$ = "0" THEN OCT = WH: NO = 10: KY = 1: IF L(WH, 10) > 0 THEN MV = 1
				IF m$ = " " THEN KY = 1
			LOOP WHILE KY = 0
			MouseHide
			PUT (0, 0), tmp%, PSET
		END IF
	END IF
	IF A$ = "~" THEN IF MONEY(WHO) >= 3000 THEN MONEY(WHO) = MONEY(WHO) - 3000: GOSUB DESTROY:
	IF A$ = "C" THEN SX = SX(WHO): SY = SY(WHO): X = SX - 160: Y = SY - 100
	IF A$ = "Z" THEN GOSUB WHICH: IF WH > 0 THEN SX = P(WH, 1): SY = P(WH, 2): X = SX - 160: Y = SY - 100
	IF A$ = "5" THEN SX = 320: SY = 200: X = 160: Y = 100
	IF A$ = "7" THEN X = 0: Y = 0: SX = 160: SY = 100
	IF A$ = "9" THEN X = 319: Y = 0: SX = 480: SY = 100
	IF A$ = "3" THEN X = 319: Y = 199: SX = 480: SY = 300
	IF A$ = "1" THEN X = 0: Y = 199: SX = 160: SY = 300
	IF A$ = "8" THEN SY = SY - 20
	IF A$ = "2" THEN SY = SY + 20
	IF A$ = "4" THEN SX = SX - 20
	IF A$ = "6" THEN SX = SX + 20
	OMX = MX: OMY = my
	MOUSESTATUS lb, RB, MX, my
	IF amouse$ = "YES" AND (MX <> OMX OR my <> OMY) THEN SX = MX + X - 2: SY = my + Y - 2
	IF RB THEN X = SX - 160: Y = SY - 100: MousePut 160, 100
	IF SY < 0 THEN SY = 0
	IF SX < 0 THEN SX = 0
	IF SX > 634 THEN SX = 643
	IF SY > 394 THEN SY = 394
	STX = 0: IF STX > 0 THEN STY = STICK(0)
	IF STX > 0 AND STY > 0 THEN
		IF ABS(STX - 100) < 20 THEN STX = 100
		IF ABS(STY - 100) < 20 THEN STY = 100
		B1 = STRIG(0)
		B2 = STRIG(4)
		SX = SX + (STX - 100) \ 3
		SY = SY + (STY - 100) \ 3
	END IF
	IF SX < X THEN X = SX
	IF SY < Y THEN Y = SY
	IF SX > X + 314 THEN X = SX - 314
	IF SY > Y + 194 THEN Y = SY - 194
	IF SX < 0 THEN SX = 0
	IF SY < 0 THEN SY = 0
	IF SX > 643 THEN SX = 643
	IF SY > 394 + 200 THEN SY = 394
	IF SX < X THEN Y = SY
	IF SY < Y THEN Y = SY
	IF SX > X + 314 THEN X = SX - 314
	IF SY > Y + 194 THEN Y = SY - 194
	IF X < 0 THEN X = 0
	IF Y < 0 THEN Y = 0
	IF X > 319 THEN X = 319
	IF Y > 199 THEN Y = 199
	IF OX <> X OR OY <> Y OR ST = 1 THEN
		SCREEN , , 0, 4
		GET (X, Y)-(319, 199), tmp%
		SCREEN , , 4, 4
		PUT (0, 0), tmp%, PSET
		SCREEN , , 1, 4
		GET (0, Y)-(X, 199), tmp%
		SCREEN , , 4, 4
		PUT (319 - X, 0), tmp%, PSET
		SCREEN , , 2, 4
		GET (X, 0)-(319, Y), tmp%
		SCREEN , , 4, 4
		PUT (0, 199 - Y), tmp%, PSET
		SCREEN , , 3, 4
		GET (0, 0)-(X, Y), tmp%
		SCREEN , , 4, 4
		PUT (319 - X, 199 - Y), tmp%, PSET
	END IF
	A$ = INKEY$
	IF lb THEN A$ = " "
	ST = 0
LOOP
WHICH:
 SOUND 400, .1: SOUND 3000, .1
WH = 0
FOR AZ = 1 TO 24
QX = P(AZ, 1)
QY = P(AZ, 2)
IF SX - 23 < QX AND SY - 23 < QY AND SX + 23 > QX AND SY + 23 > QY THEN WH = AZ
NEXT AZ
RETURN
UPDATE:
 IF NM = 1 THEN GOSUB MAP1:
'***UPDATE***
FOR AF = 1 TO 24
IF NM = 1 THEN
	'THINGS JUST BOUGHT
		FOR B = 0 TO 80
			L(AF, B) = ABS(L(AF, B))
		NEXT B
	'INCOME
	CT = AF: N1 = 22: N2 = 30: F = 3
	GOSUB CHECK:
	IF n > 0 THEN W = L(AF, 0): MONEY(W) = MONEY(W) + ABS(L(AF, 21))
END IF
	'MOVING
	FOR B = 1 TO 10
		IF L(AF, B) > 0 THEN
			WH = L(AF, B + 60)
			IF WH > 0 THEN
				IF L(WH, 0) = 0 OR L(WH, 0) = L(AF, 0) THEN
					CT = WH: N1 = 1: N2 = 10
					GOSUB FINDSPACE:
					IF n > 0 THEN
						TY = L(AF, B)
						L(AF, B) = 0
						L(WH, n) = TY
						L(WH, n + 10) = L(AF, B + 10)
						L(WH, n + 30) = L(AF, B + 30)
						L(WH, n + 40) = L(AF, B + 40)
						L(WH, n + 50) = L(AF, B + 50)
						L(WH, n + 70) = L(AF, B + 70)
						IF L(WH, 0) = 0 THEN L(WH, 0) = L(AF, 0)
					END IF
				ELSE
					TY1 = L(AF, B)
					L(AF, B) = 0
					HP1 = L(AF, B + 10)
					AR1 = L(AF, B + 30)
					W1 = L(AF, B + 40)
					E1 = L(AF, B + 50)
					FP = L(AF, B + 60)
					WP1 = L(AF, B + 70)
					P1 = 1: P2 = 0
					WH1 = L(AF, 0)
					WH2 = L(FP, 0)
					FOR AA = 1 TO 10
						IF L(WH, AA) > 0 THEN P2 = P2 + 1
					NEXT AA
					DO
						FC = 0
						FOR AA = 22 TO 30
							IF L(FP, AA) = 1 THEN FC = FC + 1
						NEXT AA
						IF P2 > 0 THEN DO: FO = INT(10 * RND) + 1: LOOP WHILE L(FP, FO) = 0: GOSUB FIGHT:
						IF HP2 <= 0 THEN L(FP, FO) = 0
					LOOP WHILE P1 = 1 AND P2 > 0
					IF P1 = 1 THEN
						L(FP, 0) = WH1
						L(FP, 1) = TY1
						L(FP, 11) = HP1
						L(FP, 31) = AR1
						L(FP, 41) = W1
						L(FP, 51) = E1
						L(FP, 71) = WP1
					ELSE
						L(FP, FO) = TY2
						L(FP, FO + 10) = HP2
						L(FP, FO + 30) = AR2
						L(FP, FO + 40) = W2
						L(FP, FO + 50) = E2
						L(FP, FO + 70) = WP2
						END IF
				END IF
			END IF
		END IF
	NEXT B
	FOR B = 1 TO 10
		L(AF, B + 60) = 0
	NEXT B
NEXT AF
REFRESH:
IF NM = 1 THEN
FOR AF = 1 TO 24
	SOUND 100, .2
	'UPDATING MAP
	FOR B = 22 TO 30
		L = L(AF, B)
		IF B = 30 THEN
			FOR C = 1 TO 10
			IF L(AF, C) > 0 THEN L = 8
			NEXT C
		END IF
		SX = P(AF, 1)
		SY = P(AF, 2)
		IF B = 22 THEN SX = SX - 22: SY = SY - 22
		IF B = 23 THEN SX = SX - 7: SY = SY - 22
		IF B = 24 THEN SX = SX + 8: SY = SY - 22
		IF B = 25 THEN SX = SX - 22: SY = SY - 7
		IF B = 26 THEN SX = SX - 7: SY = SY - 7
		IF B = 27 THEN SX = SX + 8: SY = SY - 7
		IF B = 28 THEN SX = SX - 22: SY = SY + 8
		IF B = 29 THEN SX = SX - 7: SY = SY + 8
		IF B = 30 THEN SX = SX + 8: SY = SY + 8
		IF SX < 320 AND SY < 200 THEN SCREEN , , 0, 4: sc = 0
		IF SX >= 320 AND SY < 200 THEN SCREEN , , 1, 4: SX = SX - 320: sc = 1
		IF SX < 320 AND SY >= 200 THEN SCREEN , , 2, 4: SY = SY - 200: sc = 2
		IF SX >= 320 AND SY >= 200 THEN SCREEN , , 3, 4: SX = SX - 320: SY = SY - 200: sc = 3
		IF SX < 0 THEN SX = 0
		IF SY < 0 THEN SY = 0
		IF SX > 299 + 5 THEN SX = 299 + 5
		IF SY > 179 + 5 THEN SY = 179 + 5
		C = L(AF, 0) + 8
		SCREEN , , 5, 4
		IF L < 8 AND L > 0 THEN GET (301, L * 15)-(315, L * 15 + 14), S%
		IF L = 8 THEN GET (301, 0)-(315, 14), S%
		SCREEN , , sc, 4
		IF L > 0 THEN PUT (SX, SY), S%, PSET
		IF L = 1 THEN PAINT (SX + 8, SY + 8), C, 15
		IF L = 2 THEN PAINT (SX + 8, SY + 3), C, 15
		IF L = 3 THEN LINE (SX, SY)-(SX + 5, SY + 5), L(AF, 0) + 8, BF: LINE (SX, SY)-(SX + 5, SY + 5), L(AF, 0), B
		IF L = 4 THEN PAINT (SX + 13, SY + 13), C, 15
		IF L = 5 THEN PAINT (SX + 8, SY + 2), C, 15: PAINT (SX + 8, SY + 13), C, 15
		IF L = 6 THEN PAINT (SX + 8, SY + 3), C, 15
		IF L = 7 THEN PAINT (SX + 8, SY + 3), C, 15
		IF L = 8 THEN PAINT (SX + 8, SY + 8), C, 15
		NEXT B
NEXT AF
END IF
SCREEN , , 4, 4
RETURN

MAP1:
 SOUND 800, .3
SCREEN , , 0, 4
DEF SEG = VARSEG(tmp%(0)): BLOAD "map0.gfx", 0: DEF SEG : PUT (0, 0), tmp%, PSET
SCREEN , , 1, 4
DEF SEG = VARSEG(tmp%(0)): BLOAD "map1.gfx", 0: DEF SEG : PUT (0, 0), tmp%, PSET
SCREEN , , 2, 4
DEF SEG = VARSEG(tmp%(0)): BLOAD "map2.gfx", 0: DEF SEG : PUT (0, 0), tmp%, PSET
SCREEN , , 3, 4
DEF SEG = VARSEG(tmp%(0)): BLOAD "map3.gfx", 0: DEF SEG : PUT (0, 0), tmp%, PSET
SCREEN , , 4, 4
RETURN
FINDSPACE: 'CT WHAT COUNTRY
n = 0: SOUND 300, .2: SOUND 500, .1
FOR AA = N2 TO N1 STEP -1
IF L(CT, AA) = 0 THEN n = AA
NEXT AA
RETURN
CHECK:
 'CHECK FOR A THING
	SOUND 100, .1: SOUND 200, .1
	n = 0
	FOR AA = N1 TO N2
		IF L(CT, AA) = F THEN n = AA
	NEXT AA
RETURN
FIGHT:
SCREEN , , 6, 6
CLS
X1 = 20: X2 = 300: Y1 = 80: Y2 = 120: D1 = 1: D2 = 3
TY2 = L(FP, FO)
HP2 = L(FP, FO + 10)
AR2 = L(FP, FO + 30)
W2 = L(FP, FO + 40)
E2 = L(FP, FO + 50)
WP2 = L(FP, FO + 70)
COLOR WH1 + 8
LOCATE 13, 5: PRINT "PLAYER"; WH1
COLOR 14
LOCATE 13, 19: PRINT "vs"
COLOR WH2 + 8
LOCATE 13, 25
PRINT "PLAYER"; WH2
DO: LOOP WHILE INKEY$ <> "": DO: LOOP WHILE INKEY$ = ""
CLS
TY1 = ABS(TY1)
TY2 = ABS(TY2)
REDIM MIS(10, 5)
DO
	FOR smooth = 0 TO 1 STEP 1 \ SD
		OD1 = D1: OD2 = D2
		A$ = ""
		DO: OA$ = A$: A$ = INKEY$: LOOP WHILE A$ <> "": A$ = OA$
		'STX = STICK(0): sTY = STICK(0)
		STX = 0: STY = 0
		IF STX > 0 AND STY > 0 THEN
			IF STX < 80 THEN IF OD1 = 1 THEN D1 = 2 ELSE D1 = 3
			IF STX > 120 THEN IF OD1 = 3 THEN D1 = 4 ELSE D1 = 1
			IF STY < 80 THEN IF OD1 = 2 THEN D1 = 3 ELSE D1 = 4
			IF STY > 120 THEN IF OD1 = 4 THEN D1 = 1 ELSE D1 = 2
			IF STRIG(0) <> 0 OR STRIG(4) <> 0 THEN GOSUB SHOOT1:
		END IF
		IF A$ = "W" THEN GOSUB SHOOT1:
		IF A$ = "A" THEN D1 = OD1 - 1
		IF A$ = "D" THEN D1 = OD1 + 1
		IF A$ = "8" THEN GOSUB SHOOT2:
		IF A$ = "4" THEN D2 = OD2 - 1
		IF A$ = "6" THEN D2 = OD2 + 1
	   
		FOR FF = 1 TO FC
			IF RND < .3 THEN GOSUB SHOOT3:
		NEXT FF
		IF D1 < 1 THEN D1 = 4
		IF D1 > 4 THEN D1 = 1
		IF D2 < 1 THEN D2 = 4
		IF D2 > 4 THEN D2 = 1
		IF D1 = 1 THEN X1 = X1 + E1 \ SD
		IF D1 = 2 THEN Y1 = Y1 + E1 \ SD
		IF D1 = 3 THEN X1 = X1 - E1 \ SD
		IF D1 = 4 THEN Y1 = Y1 - E1 \ SD
		IF D2 = 1 THEN X2 = X2 + E2 \ SD
		IF D2 = 2 THEN Y2 = Y2 + E2 \ SD
		IF D2 = 3 THEN X2 = X2 - E2 \ SD
		IF D2 = 4 THEN Y2 = Y2 - E2 \ SD
		IF X1 < 0 THEN X1 = 299
		IF X2 < 0 THEN X2 = 299
		IF X1 > 299 THEN X1 = 0
		IF X2 > 299 THEN X2 = 0
		IF Y1 < 0 THEN Y1 = 179
		IF Y2 < 0 THEN Y2 = 179
		IF Y1 > 179 THEN Y1 = 0
		IF Y2 > 179 THEN Y2 = 0
		SCREEN , , 5, 6
		IF TY1 <= 10 THEN GET (D1 * 20 - 19, TY1 * 20 - 20)-(D1 * 20, TY1 * 20 - 1), S%
		IF TY1 >= 11 THEN GET (D1 * 20 - 19 + 80, (TY1 - 10) * 20 - 20)-(D1 * 20 + 80, (TY1 - 10) * 20 - 1), S%
		SCREEN , , 6, 6
		LINE (OX1, OY1)-(OX1 + 20, OY1 + 20), 0, BF
		PUT (X1, Y1), S%, PSET
		SCREEN , , 5, 6
		IF TY2 <= 10 THEN GET (D2 * 20 - 19, TY2 * 20 - 20)-(D2 * 20, TY2 * 20 - 1), S%
		IF TY2 >= 11 THEN GET (D2 * 20 - 19 + 80, (TY2 - 10) * 20 - 20)-(D2 * 20 + 80, (TY2 - 10) * 20 - 1), S%
		SCREEN , , 6, 6
		LINE (OX2, OY2)-(OX2 + 20, OY2 + 20), 0, BF
		PUT (X2, Y2), S%, PSET
		OX1 = X1: OY1 = Y1: OX2 = X2: OY2 = Y2
		LOCATE 1, 3: COLOR WH1 + 8: PRINT "HP"; INT(HP1)
		LOCATE 1, 34: COLOR WH2 + 8: PRINT "HP"; INT(HP2)
		GOSUB BULLET:
		HP1 = HP1 - PS1 \ 5 \ SD
		HP2 = HP2 - PS2 \ 5 \ SD
	NEXT smooth
	TTY = TIMER - TME
	IF TTY < .06 THEN SD = SD + .1
	IF TTY > .08 THEN SD = SD - .1
	IF TTY < .05 THEN SD = SD + .2
	IF TTY > .09 THEN SD = SD - .2
	TME = TIMER
	SD = 1
LOOP WHILE HP1 > 0 AND HP2 > 0
PS1 = 0: PS2 = 0
IF HP1 <= 0 THEN
	P1 = 0
ELSE
	P2 = P2 - 1
END IF
CLS
IF HP1 <= 0 THEN LOCATE 13, 15: COLOR WH2 + 8: PRINT "PLAYER"; WH2; "WON!" ELSE LOCATE 13, 15: COLOR WH1 + 8: PRINT "PLAYER"; WH1; "WON"
DO: LOOP WHILE INKEY$ <> "": A$ = "": DO: LOOP WHILE INKEY$ = ""
RETURN
SHOOT1:
 IF MIS(1, 5) < 0 THEN MIS(1, 1) = X1 + 10: MIS(1, 2) = Y1 + 10: MIS(1, 3) = D1: MIS(1, 4) = WP1: MIS(1, 5) = 10
RETURN
SHOOT2:
 IF MIS(2, 5) < 0 THEN MIS(2, 1) = X2 + 10: MIS(2, 2) = Y2 + 10: MIS(2, 3) = D2: MIS(2, 4) = WP2: MIS(2, 5) = 10
RETURN
SHOOT3:
 IF MIS(2 + FF, 5) < 0 THEN MIS(2 + FF, 1) = 320 * RND: MIS(2 + FF, 2) = 200 * RND: MIS(2 + FF, 3) = INT(4 * RND) + 1: MIS(2 + FF, 4) = 13: MIS(2 + FF, 5) = 15
RETURN
BULLET:
FOR MS = 1 TO 2 + FC
MX = MIS(MS, 1)
my = MIS(MS, 2)
MD = MIS(MS, 3)
MT = MIS(MS, 4)
MR = MIS(MS, 5)
OMX = MX
OMY = my
IF MS = 1 THEN TX = X2 + 10: TY = Y2 + 10 ELSE TX = X1 + 10: TY = Y1 + 10
IF MS = 1 THEN C = WH1 ELSE C = WH2
IF MR >= 0 THEN
	IF MT = 1 THEN
		IF MD = 1 THEN MX = MX + MR + 10 \ SD
		IF MD = 2 THEN my = my + MR + 10 \ SD
		IF MD = 3 THEN MX = MX - MR - 10 \ SD
		IF MD = 4 THEN my = my - MR - 10 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 10: YY = 7
		IF MD = 2 OR MD = 4 THEN XX = 7: YY = 10
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 2 THEN
		IF MD = 1 THEN MX = MX + 25 \ SD + MR \ 2 \ SD
		IF MD = 2 THEN my = my + 25 \ SD + MR \ 2 \ SD
		IF MD = 3 THEN MX = MX - 25 \ SD - MR \ 2 \ SD
		IF MD = 4 THEN my = my - 25 \ SD - MR \ 2 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 35: YY = 2
		IF MD = 2 OR MD = 4 THEN XX = 2: YY = 35
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 3 THEN
		IF MD = 1 THEN MX = MX + 5 \ SD + ((10 - MR) + (10 - MR)) \ SD
		IF MD = 2 THEN my = my + 5 \ SD + ((10 - MR) + (10 - MR)) \ SD
		IF MD = 3 THEN MX = MX - 5 \ SD - ((10 - MR) + (10 - MR)) \ SD
		IF MD = 4 THEN my = my - 5 \ SD - ((10 - MR) + (10 - MR)) \ SD
		SS = MR \ 2 + 1
		IF MX < TX THEN MX = MX + SS \ SD ELSE MX = MX - SS \ SD
		IF my < TY THEN my = my + SS \ SD ELSE my = my - SS \ SD
		XX = 8: YY = 8
		LINE (OMX - 10, OMY - 10)-(OMX + 10, OMY + 10), 0, BF
		IF MR > 0 THEN LINE (MX - 2, my - YY)-(MX + 2, my + YY), C, BF: LINE (MX - XX, my - 2)-(MX + XX, my + 2), C, BF: CIRCLE (MX, my), 10, 14
	END IF
	IF MT = 4 THEN
		IF MD = 1 THEN MX = MX + 15 \ SD: IF MX > TX THEN ND = 4
		IF MD = 2 THEN my = my + 15 \ SD: IF my > TY THEN ND = 1
		IF MD = 3 THEN MX = MX - 15 \ SD: IF MX < TX THEN ND = 2
		IF MD = 4 THEN my = my - 15 \ SD: IF my < TY THEN ND = 3
		MD = ND
		XX = 8: YY = 8
		LINE (OMX - 10, OMY - 10)-(OMX + 10, OMY + 10), 0, BF
		IF MR > 0 THEN LINE (MX - 2, my - YY)-(MX + 2, my + YY), C, BF: LINE (MX - XX, my - 2)-(MX + XX, my + 2), C, BF: CIRCLE (MX, my), 10, 12
	END IF
	IF MT = 5 THEN
		IF MD = 1 THEN MX = MX + MR * MR \ 3 \ SD
		IF MD = 2 THEN my = my + MR * MR \ 3 \ SD
		IF MD = 3 THEN MX = MX - MR * MR \ 3 \ SD
		IF MD = 4 THEN my = my - MR * MR \ 3 \ SD
		XX = 13: YY = 13
		CIRCLE (OMX, OMY), 15, 0: CIRCLE (OMX - 4 + MR, OMY - 4 + MR), 5, 0
		IF MR > 0 THEN CIRCLE (MX, my), 15, 15: CIRCLE (MX - 5 + MR, my - 5 + MR), 5, 15
	END IF
	IF MT = 6 THEN
		IF MD = 1 THEN MX = MX + 10 \ SD
		IF MD = 2 THEN my = my + 10 \ SD
		IF MD = 3 THEN MX = MX - 10 \ SD
		IF MD = 4 THEN my = my - 10 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 7: YY = 25 - MR - MR
		IF MD = 2 OR MD = 4 THEN YY = 7: XX = 25 - MR - MR
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), 15 * RND, BF
	END IF
	IF MT = 7 THEN
		IF MD = 1 THEN MX = MX + 20 \ SD
		IF MD = 2 THEN my = my + 20 \ SD
		IF MD = 3 THEN MX = MX - 20 \ SD
		IF MD = 4 THEN my = my - 20 \ SD
		XX = 25 - MR - MR: YY = XX
		XY = 25 - MR - MR - 1
		CIRCLE (OMX, OMY), XY, 0: CIRCLE (OMX, OMY), XY \ 6, 0: CIRCLE (OMX, OMY), XY \ 3, 0
		IF MR > 0 THEN CIRCLE (MX, my), XX, 12: CIRCLE (MX, my), XX \ 6, 4: CIRCLE (MX, my), XX \ 3, 12
	END IF
	IF MT = 8 THEN
		IF MS = 1 THEN SP = E1 ELSE SP = E2
		IF MD = 1 THEN
		MX = MX + 3 + SP \ SD
		XX = (10 - MR) * 3
		YY = 20
		END IF
		IF MD = 2 THEN
		my = my + 3 + SP \ SD
		YY = (10 - MR) * 3
		XX = 20
		END IF
		IF MD = 3 THEN
		MX = MX - SP - 3 \ SD
		XX = (10 - MR) * 3
		YY = 20
		END IF
		IF MD = 4 THEN
		my = my - SP - 3 \ SD
		YY = (10 - MR) * 3
		XX = 20
		END IF
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 9 THEN
		IF MD = 1 THEN MX = MX + 14 \ SD: XO = 0: YO = (11 - MR) * 5
		IF MD = 2 THEN my = my + 14 \ SD: YO = 0: XO = (11 - MR) * 5
		IF MD = 3 THEN MX = MX - 14 \ SD: XO = 0: YO = (11 - MR) * 5
		IF MD = 4 THEN my = my - 14 \ SD: YO = 0: XO = (11 - MR) * 5
		XX = 10: YY = 10
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
		IF MX - XX - 10 - XO < TX AND MX + XX + 10 - XO > TX AND my - YY - 10 - YO < TY AND my + YY + 10 - YO > TY THEN
			IF MS = 1 THEN DM = (W1 \ SQR(AR2) + W1) \ 2 ELSE DM = (W2 \ SQR(AR1) + W1) \ 2
			IF MS = 1 THEN HP2 = HP2 - DM \ SD ELSE HP1 = HP1 - DM \ SD
			SOUND 100, .1: SOUND 300, .2: SOUND 37, .3
		END IF
		IF MX - XX - 10 + XO < TX AND MX + XX + 10 + XO > TX AND my - YY - 10 + YO < TY AND my + YY + 10 + YO > TY THEN
			IF MS = 1 THEN DM = (W1 \ SQR(AR2) + W1) \ 2 ELSE DM = (W2 \ SQR(AR1) + W1) \ 2
			IF MS = 1 THEN HP2 = HP2 - DM \ SD ELSE HP1 = HP1 - DM \ SD
			SOUND 100, .1: SOUND 300, .2: SOUND 37, .3
		END IF
		LINE (OMX - XX - XO - 5, OMY - YY - YO - 5)-(OMX + XX - XO + 5, OMY + YY - YO + 5), 0, BF
		IF MR > 0 THEN LINE (MX - XX - XO, my - YY - YO)-(MX + XX - XO, my + YY - YO), C + 8, BF
		LINE (OMX - XX + XO - 5, OMY - YY + YO - 5)-(OMX + XX + XO + 5, OMY + YY + YO + 5), 0, BF
		IF MR > 0 THEN LINE (MX - XX + XO, my - YY + YO)-(MX + XX + XO, my + YY + YO), C + 8, BF
	END IF
	IF MT = 10 THEN
		IF MS = 1 THEN SP = E1 ELSE SP = E2
		IF MD = 1 THEN
		MX = MX + 5 + SP \ SD
		XX = (10 - MR) * 5
		YY = 20
		END IF
		IF MD = 2 THEN
		my = my + 5 + SP \ SD
		YY = (10 - MR) * 5
		XX = 20
		END IF
		IF MD = 3 THEN
		MX = MX - SP - 5 \ SD
		XX = (10 - MR) * 5
		YY = 20
		END IF
		IF MD = 4 THEN
		my = my - SP - 5 \ SD
		YY = (10 - MR) * 5
		XX = 20
		END IF
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 11 THEN
		IF MD = 1 THEN MX = MX + (MR + MR) \ SD + 5 \ SD: my = my + 8 * RND \ SD - 4 \ SD
		IF MD = 2 THEN my = my + (MR + MR) \ SD + 5 \ SD: MX = MX + 8 * RND \ SD - 4 \ SD
		IF MD = 3 THEN MX = MX - (MR + MR) \ SD - 5 \ SD: my = my + 8 * RND \ SD - 4 \ SD
		IF MD = 4 THEN my = my - (MR + MR) \ SD - 5 \ SD: MX = MX + 8 * RND \ SD - 4 \ SD
		XX = 10: YY = 10
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN IF MD = 1 OR MD = 3 THEN LINE (MX - XX, my - YY)-(MX + XX, my - 5), C + 8, BF: LINE (MX - XX, my + YY)-(MX + XX, my + 5), C + 8, BF
		IF MR > 0 THEN IF MD = 2 OR MD = 4 THEN LINE (MX - XX, my - YY)-(MX - 5, my + YY), C + 8, BF: LINE (MX + XX, my - YY)-(MX + 5, my + YY), C + 8, BF
	END IF
	IF MT = 12 THEN
		IF MS = 1 THEN MX = X1 + 10: my = Y1 + 10 ELSE MX = X2 + 10: my = Y2 + 10
		XX = 11 - MR + 7: YY = 11 - MR + 7
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 13 THEN
		IF MR > 2 THEN
			IF MX > TX THEN MX = MX - 5 \ SD ELSE MX = MX + 5 \ SD
			IF my > TY THEN my = my - 5 \ SD ELSE my = my + 5 \ SD
			MX = MX + 5 * RND - 2.5: my = my + 5 * RND - 2.5: XX = 5: YY = 5
		END IF
		IF MR <= 1 THEN XX = 40: YY = 40: SOUND 400, .2: SOUND 300, .1
		IF MR = 2 THEN XX = 20: YY = 20: FOR S = 1 TO 10: SOUND 137 - S * 10, .1: NEXT S
		LINE (OMX - XX, OMY - XX)-(OMX + XX, OMY + XX), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - XX)-(MX + XX, my + XX), C + 8, BF
	END IF
	IF MT = 14 THEN
		IF MD = 1 THEN MX = MX + 15 \ SD
		IF MD = 2 THEN my = my + 15 \ SD
		IF MD = 3 THEN MX = MX - 15 \ SD
		IF MD = 4 THEN my = my - 15 \ SD
		IF MX > TX THEN MX = MX - 2 \ SD ELSE MX = MX + 2 \ SD
		IF my > TY THEN my = my - 2 \ SD ELSE my = my + 2 \ SD
		XX = (11 - MR) * 3
		YY = (11 - MR) * 3
		LINE (OMX - XX, OMY - XX)-(OMX + XX, OMY + XX), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - XX)-(MX + XX, my + XX), C + 8, BF
	END IF
	IF MT = 15 THEN
		IF MR \ 2 = INT(MR \ 2) THEN
			IF MX - 10 > TX THEN MD = 3 ELSE IF MX + 10 < TX THEN MD = 1
			IF my - 10 > TY THEN MD = 4 ELSE IF my + 10 < TY THEN MD = 2
		END IF
		IF MD = 1 THEN MX = MX + 25 \ SD + MR \ 2 \ SD
		IF MD = 2 THEN my = my + 25 \ SD + MR \ 2 \ SD
		IF MD = 3 THEN MX = MX - 25 \ SD - MR \ 2 \ SD
		IF MD = 4 THEN my = my - 25 \ SD - MR \ 2 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 15: YY = 2
		IF MD = 2 OR MD = 4 THEN XX = 2: YY = 15
		LINE (OMX - 15, OMY - 15)-(OMX + 15, OMY + 15), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 16 THEN
		IF MR \ 2 = INT(MR \ 2) THEN
			IF MX - 10 > TX THEN MD = 3 ELSE IF MX + 10 < TX THEN MD = 1
			IF my - 10 > TY THEN MD = 4 ELSE IF my + 10 < TY THEN MD = 2
		END IF
		IF MD = 1 THEN MX = MX + MR + 10 \ SD
		IF MD = 2 THEN my = my + MR + 10 \ SD
		IF MD = 3 THEN MX = MX - MR - 10 \ SD
		IF MD = 4 THEN my = my - MR - 10 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 10: YY = 7
		IF MD = 2 OR MD = 4 THEN XX = 7: YY = 10
		LINE (OMX - 10, OMY - 10)-(OMX + 10, OMY + 10), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 17 THEN
		IF MR > 3 THEN MR = 3
		IF MD = 1 THEN MX = MX + 45 \ SD
		IF MD = 2 THEN my = my + 45 \ SD
		IF MD = 3 THEN MX = MX - 45 \ SD
		IF MD = 4 THEN my = my - 45 \ SD
		IF MD = 1 OR MD = 3 THEN XX = 20: YY = 10
		IF MD = 2 OR MD = 4 THEN XX = 10: YY = 20
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 18 THEN
		XX = 25: YY = 25
		IF MS = 1 THEN MX = X1: my = Y1 ELSE MX = X2: my = Y2
		IF MX - XX - 10 < TX AND MX + XX + 10 > TX AND my - YY - 10 < TY AND my + YY + 10 > TY THEN
			IF MS = 1 THEN HP1 = HP1 + 5 ELSE HP2 = HP2 + 5
		END IF
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 19 THEN
		XX = (11 - MR) * 7: YY = XX
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C + 8, BF
	END IF
	IF MT = 20 THEN
		IF MD = 1 THEN MX = MX + 15 \ SD
		IF MD = 2 THEN my = my + 15 \ SD
		IF MD = 3 THEN MX = MX - 15 \ SD
		IF MD = 4 THEN my = my - 15 \ SD
		XX = 13: YY = 13
		LINE (OMX - XX, OMY - YY)-(OMX + XX, OMY + YY), 0, BF
		IF MR > 0 THEN LINE (MX - XX, my - YY)-(MX + XX, my + YY), C, BF
		IF MR > 0 THEN LINE (MX - XX \ 2, my - YY \ 2)-(MX + XX \ 2, my + YY \ 2), C + 8, BF
	END IF
	MR = MR - 1 \ SD
	XX = XX + 10: YY = YY + 10
	IF MS = 1 THEN DM = W1 \ SQR(AR2) ELSE DM = W2 \ SQR(AR1)
	IF MS > 2 THEN DM = 7 \ SQR(AR1)
	IF MX - XX < TX AND MX + XX > TX AND my - YY < TY AND my + YY > TY THEN
		IF MS = 1 THEN HP2 = HP2 - DM \ SD ELSE HP1 = HP1 - DM \ SD
		SOUND 100, .1: SOUND 300, .2: SOUND 37, .3
		IF MT = 20 THEN
			IF MS = 1 THEN PS2 = PS2 + 1 \ SD ELSE PS1 = PS1 + 1 \ SD
		END IF
	END IF
	MIS(MS, 1) = MX
	MIS(MS, 2) = my
	MIS(MS, 3) = MD
	MIS(MS, 4) = MT
	MIS(MS, 5) = MR
END IF
NEXT MS
RETURN
DESTROY:
	GOSUB WHICH:
	IF WH > 0 AND L(WH, O) <> WHO THEN
		FOR A = 1 TO 4 * RND + 1
			DS = INT(22 + 9 * RND)
			IF L(WH, DS) > 0 THEN L(WH, DS) = 0: FOR A = 1 TO 30: SOUND 37 + 200 * RND, .1: NEXT A
		NEXT A
		FOR A = 1 TO 4 * RND + 3
			DS = INT(11 + 11 * RND)
			L(WH, DS) = L(WH, DS) - 100 * RND
			IF L(WH, DS) <= 0 THEN L(WH, DS - 10) = 0: FOR A = 1 TO 40: SOUND 1000 - A * 20, .1: NEXT A
		NEXT A
	ELSE
		BEEP
	END IF
RETURN







'////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////

mouse:
RESTORE
mouse$ = SPACE$(57)
FOR I% = 1 TO 57
  READ A$
  H$ = CHR$(VAL("&H" + A$))
  MID$(mouse$, I%, 1) = H$
NEXT I%
CLS
MS% = MouseInit%
IF NOT MS% THEN
	PRINT "Mouse not found"
	PRINT "YOU WILL SUFFER WITH ONLY KEYS TO GUIDE YOUR PATH TO VICTORY!!"
	LET amouse$ = "NO":
ELSE
	PRINT "I have found your mouse!!"
	PRINT "I think it's pretty cool!!"
	LET amouse$ = "YES"
END IF
RETURN

DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00

SUB MouseDriver (AX%, bx%, CX%, DX%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(AX%, bx%, CX%, DX%, mouse%)
END SUB

SUB MouseHide
 AX% = 2
 MouseDriver AX%, 0, 0, 0

END SUB

FUNCTION MouseInit%
  AX% = 0
  MouseDriver AX%, 0, 0, 0
  MouseInit% = AX%

END FUNCTION

SUB MousePut (X%, Y%)
  AX% = 4
  CX% = X% * 2
  DX% = Y%
  MouseDriver AX%, 0, CX%, DX%

END SUB

SUB MouseShow
  AX% = 1
  MouseDriver AX%, 0, 0, 0

END SUB

SUB MOUSESTATUS (lb%, RB%, xmouse%, ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  lb% = ((bx% AND 1) <> 0)
  RB% = ((bx% AND 2) <> 0)
  xmouse% = CX% \ 2
  ymouse% = DX%
END SUB

