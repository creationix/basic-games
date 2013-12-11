DECLARE FUNCTION BOMBAT% (x%, y%)
DECLARE SUB say (F$)
DECLARE SUB loadsound (F$())
DECLARE SUB INIT ()
DECLARE SUB PEOPLE ()
DECLARE SUB LEVELS (LVL%)
DECLARE SUB LEVEL (L%(), PIC%())
DECLARE SUB HELP ()
DECLARE SUB EFFECT (N%)
DECLARE SUB PUTIT (x%, y%, P%, PIC%())
DECLARE SUB EXPLOSION (x%, y%, S%, t%)
DECLARE SUB ADRAW ()
DECLARE SUB GOWIN (WINNER%)
DECLARE SUB SCOREB ()
DECLARE SUB FINISH (WINNER%)
DECLARE SUB font (x%, y%, txt$, pt%, C%)
DECLARE SUB gray ()
DECLARE SUB COLORS ()
DECLARE FUNCTION MMENU% ()
DECLARE FUNCTION TREASURE% ()
DECLARE SUB putsound (N%, F$)
DECLARE SUB PLAYSOUND (num%)
DECLARE SUB DELAY (N%)
CONST BADFILENAME = 53
'ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл
'л                                                                           л
'л      лл     л       л     л        л   л       ллллллл                    л
'л      л л    л       л     л        л  л        л                          л
'л      л  л   л       л     л        л л         л                          л
'л      л   л  л       л     л        лл          лллл       By...           л
'л      л    л л       л     л        л л         л                          л
'л      л     лл       л     л        л  л        л            Tim Caswell   л
'л      л      л        ллллл         л   л       ллллллл                    л
'л                                                                           л
'ллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллллл



CONST SOUNDS = 4
COMMON SHARED Channel%, pgport%, lenport%, timeconst%, freq&, modereg%, addport%, port%
DIM SHARED char AS STRING * 1
DIM SHARED wavbuffer(1 TO SOUNDS) AS STRING * 10000
DIM SHARED memloc&(SOUNDS)
DIM SHARED page%(SOUNDS), BLASTER
DIM SHARED segment&(SOUNDS)
DIM SHARED offset&(SOUNDS)
DIM SHARED length&(SOUNDS)

DEFINT A-Z                        'DEFINES ALL UNDEFINED VARIBLES AS INTS
CONST SPEED = 200                 'THE SPEED OF THE PROGRAM (SMALL IS FASTER)
								  '100 - 8.MHz       286
								  '200 - 16.MHz      386
								  '1000 - 40.MHz     486
								  '3000 - 120.MHz    586 OR PENTIUM
								  '.... AND SO ON
RANDOMIZE TIMER
PLYDATA:
'    NAME     |speed  |bombsize   |numbombs   |detinators |cherry|disease
'-------------|-------|-----------|-----------|-----------|------|----------
DATA Missie   ,0      ,3          ,3          ,0          ,0     ,2,0,0,0
DATA Myrian   ,0      ,0          ,2          ,0          ,0     ,0,0,1,0
DATA Bad Boy  ,0      ,0          ,0          ,0          ,1     ,3,0,0,0
DATA Sycho    ,0      ,0          ,0          ,1          ,0     ,3,0,0,0
DATA Bob      ,0      ,0          ,0          ,0          ,0     ,2,1,1,0
DATA Pyrex    ,0      ,1          ,1          ,0          ,0     ,0,1,0,0
DATA Theata   ,0      ,1          ,0          ,0          ,0     ,0,1,1,0
DIM TIMEOUT$
DIM SHARED t$(127)  'The Cool Font!
DIM SHARED S(7, 9), WINS(4), BLASTER
DIM SHARED x(4), y(4), OX(4), OY(4), tw(4)
DIM SHARED UP$(4), RT$(4), LT$(4), DN$(4), BOMB$(4), DET$(4)
DIM SHARED BX(40), BY(40), typ(40)
DIM bt(40), bs(40), OWN(40), DIR(40)
DIM BTN(4), SOLID(30)
DIM SHARED PIC(12800), PL(4), L(17, 11), N$(7)
DIM SHARED SAFE(16, 10)
DIM ER$(255)

RESTORE ERRORDATA
DO
READ E, E$
ER$(E) = E$
LOOP WHILE E < 255

ON ERROR GOTO BAD:

INIT

noch2:
'INPUT "Port of your Soundcard (220-280): "; port%
port% = 220
IF port% < 220 OR port% > 280 THEN GOTO noch2
port% = VAL("&H" + LTRIM$(STR$(port%)))

noch1:
'INPUT "8 Bit DMA-Channel (1/2/3): "; channel%
Channel% = 1
IF Channel% < 1 OR Channel% > 3 THEN GOTO noch1

DIM F$(SOUNDS)

'PATH$ = "\basic\"
F$(1) = PATH$ + "504.wav" 'dying and explosion
F$(2) = PATH$ + "step.WAV"    'setbomb
F$(3) = PATH$ + "wierd.wav"'teleport
F$(4) = PATH$ + "TREAS.wav"'get ITEM

loadsound F$()

PL(1) = 7
PL(2) = 7
PL(3) = 7
PL(4) = 7
RESTORE PLYDATA
FOR a = 1 TO 7
READ N$(a)
FOR B = 1 TO 9
READ S(a, B)
NEXT B
NEXT a

DO  'START OF MAIN LOOP
DO
C = MMENU
IF C = -1 THEN SYSTEM
IF C = 1 THEN PEOPLE
IF C = 2 THEN LEVELS LVL
LOOP WHILE C > 0
FOR N = 1 TO 4
WINS(N) = 0
NEXT N

'0-floor                            you walk on it Stupid!
'1-Unbreakable                      It's more solid than steel
SOLID(1) = 1
'2-Normal                           These are strong as brick
SOLID(2) = 1
'3-teleporter                       Where did I go?!?!
SOLID(3) = 1
'4-upslider                         Moving on up!
'5-left slider                      Not the West Side!!
'6-down slider                      I'm being sucked in
'7-right slider                     On to kill Russia.
'8-Generator?                       Where did these come from
SOLID(8) = 1
'9-Bomb
'10-extra bomb!!                    I can set complex traps now!
'11-flame                           More power to ya...
'12-goldenflame                     MAX flame on!
'13-cherryflame!!                   Bye-bye b'brick
'14-Kick                            Bowling for enemies!
'15-Punch                           Up and over
'16-detonator                       not untill I say when
'17-drop disease                    I didn't push that button!!!
'18-ghost                           Where am I?
'19-crazy                           Who am i?

FOR y = 0 TO 10
	FOR x = 0 TO 16
		L(x, y) = 0
	NEXT x
NEXT y
FOR y = 0 TO 10
	L(0, y) = 1
	L(16, y) = 1
NEXT y
FOR x = 1 TO 15
	L(x, 0) = 1
	L(x, 10) = 1
NEXT x
OJX = STICK(0)
OJY = STICK(1)
DO
RESTORE PLYDATA
FOR a = 1 TO 7
READ N$(a)
FOR B = 1 TO 9
READ S(a, B)
NEXT B
NEXT a


CLS
IF LVL = 0 THEN LVL = 21
SELECT CASE LVL
CASE 1: RESTORE LEVEL1
CASE 2: RESTORE LEVEL2
CASE 3: RESTORE LEVEL3
CASE 4: RESTORE LEVEL4
CASE 5: RESTORE LEVEL5
CASE 6: RESTORE LEVEL6
CASE 7: RESTORE LEVEL7
CASE 8: RESTORE LEVEL8
CASE 9: RESTORE LEVEL9
CASE 10: RESTORE LEVEL10
CASE 11: RESTORE LEVEL11
CASE 12: RESTORE LEVEL12
CASE 13: RESTORE LEVEL13
CASE 14: RESTORE LEVEL14
CASE 15: RESTORE LEVEL15
CASE 16: RESTORE LEVEL16
CASE 17: RESTORE LEVEL17
CASE 18: RESTORE LEVEL18
CASE 19: RESTORE LEVEL19
CASE 20: RESTORE LEVEL20
CASE 21
N = INT(20 * RND + 1)
IF N = 1 THEN RESTORE LEVEL1
IF N = 2 THEN RESTORE LEVEL2
IF N = 3 THEN RESTORE LEVEL3
IF N = 4 THEN RESTORE LEVEL4
IF N = 5 THEN RESTORE LEVEL5
IF N = 6 THEN RESTORE LEVEL6
IF N = 7 THEN RESTORE LEVEL7
IF N = 8 THEN RESTORE LEVEL8
IF N = 9 THEN RESTORE LEVEL9
IF N = 10 THEN RESTORE LEVEL10
IF N = 11 THEN RESTORE LEVEL11
IF N = 12 THEN RESTORE LEVEL12
IF N = 13 THEN RESTORE LEVEL13
IF N = 14 THEN RESTORE LEVEL14
IF N = 15 THEN RESTORE LEVEL15
IF N = 16 THEN RESTORE LEVEL16
IF N = 17 THEN RESTORE LEVEL17
IF N = 18 THEN RESTORE LEVEL18
IF N = 19 THEN RESTORE LEVEL19
IF N = 20 THEN RESTORE LEVEL20
END SELECT
ERASE SAFE
READ N$
READ FX, FY, TIMEOUT$
FOR y = 1 TO 9
FOR x = 1 TO 15
READ L
IF L = 0 AND RND > .1 THEN
	OK = 1
	IF x = 1 AND y = 1 THEN OK = 0: SAFE(x, y) = 10
	IF x = 1 AND y = 2 THEN OK = 0
	IF x = 2 AND y = 1 THEN OK = 0
	IF x = 15 AND y = 1 THEN OK = 0: SAFE(x, y) = 10
	IF x = 15 AND y = 2 THEN OK = 0
	IF x = 14 AND y = 1 THEN OK = 0
	IF x = 15 AND y = 9 THEN OK = 0: SAFE(x, y) = 10
	IF x = 15 AND y = 8 THEN OK = 0
	IF x = 14 AND y = 9 THEN OK = 0
	IF x = 1 AND y = 9 THEN OK = 0: SAFE(x, y) = 10
	IF x = 1 AND y = 8 THEN OK = 0
	IF x = 2 AND y = 9 THEN OK = 0
	IF OK = 1 THEN L = 2
END IF
L(x, y) = L
NEXT x
NEXT y
x(1) = 1: y(1) = 1
x(2) = 15: y(2) = 9
x(3) = 1: y(3) = 9
x(4) = 15: y(4) = 1
FOR N = 1 TO 4
IF PL(N) = 0 THEN x(N) = 0
NEXT N
FOR B = 1 TO 40
typ(B) = 0
NEXT B
CALL LEVEL(L(), PIC())
font 20, 180, N$, 5, 15
ALIVE = 4
GG = 0
DO
IF pt = 0 OR GG > 50 THEN
	GG = GG + 1
	IF GG > 50 AND GG - 50 <= LEN(TIMEOUT$) THEN
		L(FX, FY) = 1: PUTIT FX, FY, 1, PIC()
		M$ = UCASE$(MID$(TIMEOUT$, GG - 50, 1))
		IF M$ = "U" THEN FY = FY - 1
		IF M$ = "D" THEN FY = FY + 1
		IF M$ = "L" THEN FX = FX - 1
		IF M$ = "R" THEN FX = FX + 1
		L(FX, FY) = 27: PUTIT FX, FY, 27, PIC()
		EFFECT 3
		IF GG - 50 = LEN(TIMEOUT$) THEN L(FX, FY) = 1: PUTIT FX, FY, 1, PIC()
	END IF
END IF
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, 0
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
FOR N = 1 TO 4
	IF pt = 0 AND RND > .9 THEN S(PL(N), 6) = 0
	OX(N) = x(N)
	OY(N) = y(N)
	BTN(N) = 0
NEXT N
FOR S = 1 TO 5
	a$ = INKEY$
	IF a$ = CHR$(0) + CHR$(59) THEN CALL HELP: LEVEL L(), PIC()
	IF a$ = CHR$(0) + CHR$(60) THEN GOTO TEND
	IF a$ = CHR$(27) THEN FOR N = 1 TO 4: x(N) = 0: NEXT N
	FOR N = 1 TO 4
		IF PL(N) < 7 THEN
			IF a$ = UP$(N) THEN BTN(N) = 1
			IF a$ = LT$(N) THEN BTN(N) = 2
			IF a$ = RT$(N) THEN BTN(N) = 3
			IF a$ = DN$(N) THEN BTN(N) = 4
			IF a$ = BOMB$(N) THEN BTN(N) = 5
			IF a$ = DET$(N) THEN BTN(N) = 6
		END IF
	NEXT N
NEXT S
	FOR N = 1 TO 4
		IF PL(N) >= 7 THEN
			'find me
			IF x(N) > 0 THEN
				IF SAFE(x(N), y(N)) > 3 THEN
					
					BTN(N) = INT(4 * RND + 1)
					FOR t = 1 TO 4
						IF SAFE(x(N), y(N)) > SAFE(x(N), y(N) + 1) AND SOLID(L(x(N), y(N) + 1)) = 0 AND RND > .4 THEN BTN(N) = 4: tw(N) = 4
						IF SAFE(x(N), y(N)) > SAFE(x(N), y(N) - 1) AND SOLID(L(x(N), y(N) - 1)) = 0 AND RND > .4 THEN BTN(N) = 1: tw(N) = 1
						IF SAFE(x(N), y(N)) > SAFE(x(N) - 1, y(N)) AND SOLID(L(x(N) - 1, y(N))) = 0 AND RND > .4 THEN BTN(N) = 2: tw(N) = 2
						IF SAFE(x(N), y(N)) > SAFE(x(N) + 1, y(N)) AND SOLID(L(x(N) + 1, y(N))) = 0 AND RND > .4 THEN BTN(N) = 3: tw(N) = 3
					NEXT t
					
				ELSE
					IF L(x(N), y(N) + 1) > 8 AND L(x(N), y(N) + 1) < 17 AND RND > .4 THEN BTN(N) = 4
					IF L(x(N), y(N) - 1) > 8 AND L(x(N), y(N) - 1) < 17 AND RND > .4 THEN BTN(N) = 1
					IF L(x(N) + 1, y(N)) > 8 AND L(x(N) + 1, y(N)) < 17 AND RND > .4 THEN BTN(N) = 3
					IF L(x(N) - 1, y(N)) > 8 AND L(x(N) - 1, y(N)) < 17 AND RND > .4 THEN BTN(N) = 2

					IF ALIVE > 1 THEN
						IF RND > .8 THEN BTN(N) = 6
						IF RND > .9 THEN BTN(N) = 5
						IF RND > .5 THEN
							IF L(x(N), y(N) + 1) = 2 THEN BTN(N) = 5: tw(N) = 0
							IF L(x(N), y(N) - 1) = 2 THEN BTN(N) = 5: tw(N) = 0
							IF L(x(N) + 1, y(N)) = 2 THEN BTN(N) = 5: tw(N) = 0
							IF L(x(N) - 1, y(N)) = 2 THEN BTN(N) = 5: tw(N) = 0
						END IF
					END IF
					IF tw(N) = 0 THEN
						tw(N) = INT(4 * RND + 1)
						IF x(N) < 6 THEN tw(N) = 3
						IF x(N) > 10 THEN tw(N) = 2
						IF y(N) < 4 THEN tw(N) = 4
						IF y(N) > 6 THEN tw(N) = 1
					END IF
					t = tw(N)
					IF tw(N) = 1 AND SOLID(L(x(N), y(N) - 1)) = 1 THEN t = 2
					IF tw(N) = 2 AND SOLID(L(x(N) - 1, y(N))) = 1 THEN t = 4
					IF tw(N) = 3 AND SOLID(L(x(N) + 1, y(N))) = 1 THEN t = 1
					IF tw(N) = 4 AND SOLID(L(x(N), y(N) + 1)) = 1 THEN t = 3
					tw(N) = t
					IF BTN(N) = 0 THEN
						IF tw(N) = 1 AND SAFE(x(N), y(N) - 1) = 0 THEN BTN(N) = 1
						IF tw(N) = 2 AND SAFE(x(N) - 1, y(N)) = 0 THEN BTN(N) = 2
						IF tw(N) = 3 AND SAFE(x(N) + 1, y(N)) = 0 THEN BTN(N) = 1
						IF tw(N) = 4 AND SAFE(x(N), y(N) + 1) = 0 THEN BTN(N) = 4
					END IF
				END IF
			END IF
		END IF
	NEXT N


'SHOWSAFE

FOR N = 1 TO 4
IF x(N) > 0 THEN
	IF S(PL(N), 6) = 3 THEN BTN(N) = INT(4 * RND + 1): EFFECT 7
	IF BTN(N) = 1 THEN y(N) = y(N) - 1
	IF BTN(N) = 2 THEN x(N) = x(N) - 1
	IF BTN(N) = 3 THEN x(N) = x(N) + 1
	IF BTN(N) = 4 THEN y(N) = y(N) + 1
	IF BTN(N) = 5 OR S(PL(N), 6) = 1 THEN
		OK = 1
		FOR a = 1 TO 40
		IF BX(a) = x(N) AND BY(a) = y(N) AND typ(a) > 0 THEN OK = 0
		NEXT a
		IF OK = 1 THEN
			GOSUB FREEBOMB
			IF B > 0 THEN
				DIR(B) = 0
				BX(B) = x(N)
				BY(B) = y(N)
				bt(B) = 20
				bs(B) = S(PL(N), 2)
				typ(B) = S(PL(N), 5) + S(PL(N), 4) * 2 + S(PL(N), 9) * 4 + 1
				OWN(B) = N
			END IF
		END IF
	END IF
	IF x(N) < OX(N) THEN x(N) = OX(N) - 1
	IF x(N) > OX(N) THEN x(N) = OX(N) + 1
	IF y(N) < OY(N) THEN y(N) = OY(N) - 1
	IF y(N) > OY(N) THEN y(N) = OY(N) + 1
	B = 0
	FOR a = 1 TO 40
		IF BX(a) = x(N) AND BY(a) = y(N) AND typ(a) > 0 THEN B = a
	NEXT a
	IF B > 0 THEN
		IF S(PL(N), 7) > 0 OR S(PL(N), 8) > 0 THEN
			LOCATE 1, 1
			DX = x(N) - OX(N)
			DY = y(N) - OY(N)
			IF (DX <> 0 OR DY <> 0) THEN
				IF DX >= 1 THEN D = 1
				IF DX <= -1 THEN D = 2
				IF DY >= 1 THEN D = 3
				IF DY <= -1 THEN D = 4
				IF S(PL(N), 7) = 1 AND SOLID(L(x(N) + DX, y(N) + DY)) = 0 THEN DIR(B) = D
				IF S(PL(N), 8) = 1 AND SOLID(L(x(N) + DX, y(N) + DY)) > 0 THEN DIR(B) = -D
			END IF
		END IF
		x(N) = OX(N): y(N) = OY(N)
	END IF
	IF (pt + N) MOD 4 = 0 THEN
		L = L(x(N), y(N))
		IF L = 4 THEN y(N) = y(N) - 1
		IF L = 6 THEN y(N) = y(N) + 1
		IF L = 5 THEN x(N) = x(N) - 1
		IF L = 7 THEN x(N) = x(N) + 1
		IF L = 3 THEN
			FOR a = 1 TO 3
			x = INT(15 * RND + 1)
			y = INT(9 * RND + 1)
			IF SOLID(L(x, y)) = 0 THEN x(N) = x: y(N) = y: EFFECT 3
			NEXT a
		END IF
	END IF
	L = L(x(N), y(N))
	IF L = 1 OR L = 2 THEN x(N) = OX(N): y(N) = OY(N)
	IF L = 9 THEN S(PL(N), 9) = 1: EFFECT 3
	IF L = 10 THEN S(PL(N), 3) = S(PL(N), 3) + 1: IF S(PL(N), 3) > 10 THEN S(PL(N), 3) = 10: EFFECT 6
	IF L = 11 THEN S(PL(N), 2) = S(PL(N), 2) + 1: IF S(PL(N), 2) > 15 THEN S(PL(N), 2) = 15: EFFECT 6
	IF L = 12 THEN S(PL(N), 2) = 14
	IF L = 13 THEN S(PL(N), 5) = 1
	IF L = 14 THEN S(PL(N), 7) = 1
	IF L = 15 THEN S(PL(N), 8) = 1
	IF L = 16 THEN S(PL(N), 4) = 1
	IF L = 17 THEN S(PL(N), 6) = 1
	IF L = 18 THEN S(PL(N), 6) = 2
	IF L = 19 THEN S(PL(N), 6) = 3
	IF L >= 9 AND L <= 16 THEN L(x(N), y(N)) = 0: EFFECT 4
	IF L >= 17 AND L <= 19 THEN L(x(N), y(N)) = 0: EFFECT 4
	IF x(N) < 1 THEN x(N) = 1
	IF x(N) > 15 THEN x(N) = 15
	IF y(N) < 1 THEN y(N) = 1
	IF y(N) > 9 THEN y(N) = 9
	IF L(x(N), y(N)) = 27 THEN x(N) = 0: EFFECT 6
	CALL PUTIT(OX(N), OY(N), L(OX(N), OY(N)), PIC())
	IF S(PL(N), 6) <> 2 THEN CALL PUTIT(x(N), y(N), PL(N) + 19, PIC())
END IF
NEXT N
FOR a = 1 TO 10
x = INT(15 * RND) + 1
y = INT(9 * RND) + 1
IF L(x, y) >= 27 THEN
	L(x, y) = L(x, y) + 1
	IF L(x, y) = 31 THEN L(x, y) = 2
	CALL PUTIT(x, y, L(x, y), PIC())
END IF
NEXT a
BB = 0
FOR B = 1 TO 40
IF typ(B) > 0 THEN
	BB = BB + 1
	IF DIR(B) <> 0 THEN
		FOR a = -bs(B) - 1 TO bs(B) + 1                 'for computer players
			IF BX(B) + a > 0 AND BX(B) + a < 16 THEN SAFE(BX(B) + a, BY(B)) = 0
			IF BY(B) + a > 0 AND BY(B) + a < 10 THEN SAFE(BX(B), BY(B) + a) = 0
		NEXT a
		OX = BX(B)
		OY = BY(B)
		IF ABS(DIR(B)) = 1 THEN BX(B) = BX(B) + 1
		IF ABS(DIR(B)) = 2 THEN BX(B) = BX(B) - 1
		IF ABS(DIR(B)) = 3 THEN BY(B) = BY(B) + 1
		IF ABS(DIR(B)) = 4 THEN BY(B) = BY(B) - 1
		IF DIR(B) > 0 THEN
			IF BX(B) < 1 THEN BX(B) = 1
			IF BX(B) > 15 THEN BX(B) = 15
			IF BY(B) < 1 THEN BY(B) = 1
			IF BY(B) > 9 THEN BY(B) = 9
		ELSE
			IF BX(B) < 1 THEN BX(B) = 15
			IF BX(B) > 15 THEN BX(B) = 1
			IF BY(B) < 1 THEN BY(B) = 9
			IF BY(B) > 9 THEN BY(B) = 1
		END IF
		L = L(BX(B), BY(B))
		IF DIR(B) > 0 AND SOLID(L) > 0 THEN DIR(B) = 0: BX(B) = OX: BY(B) = OY
		IF DIR(B) < 0 AND SOLID(L) = 0 THEN DIR(B) = 0
		CALL PUTIT(OX, OY, L(OX, OY), PIC())
	END IF
	IF ((typ(B) - 1) \ 2) MOD 2 = 0 THEN bt(B) = bt(B) - 1
	IF ((typ(B) - 1) \ 2) MOD 2 = 1 THEN
		IF BTN(OWN(B)) = 6 THEN bt(B) = 0: EFFECT 5
		IF x(OWN(B)) = 0 THEN bt(B) = 0: EFFECT 5
		IF ALIVE <= 1 THEN bt(B) = bt(B) = 2: EFFECT 5
	END IF
	IF bt(B) = 0 THEN
		FOR a = -bs(B) - 1 TO bs(B) + 1                 'for computer players
			IF BX(B) + a > 0 AND BX(B) + a < 16 THEN SAFE(BX(B) + a, BY(B)) = 0
			IF BY(B) + a > 0 AND BY(B) + a < 10 THEN SAFE(BX(B), BY(B) + a) = 0
		NEXT a
		CALL EXPLOSION(BX(B), BY(B), bs(B), typ(B))
		typ(B) = 0
	ELSE
		IF pt MOD 2 = 0 THEN
			PC = 31
		ELSE
			IF typ(B) = 1 THEN PC = 31
			IF typ(B) = 2 THEN PC = 13
			IF typ(B) = 3 THEN PC = 16
			IF typ(B) = 4 THEN PC = 16
			IF typ(B) >= 5 THEN PC = 9
		END IF
		CALL PUTIT(BX(B), BY(B), PC, PIC())
		FOR a = -bs(B) - 1 TO bs(B) + 1                 'for computer players
			IF BX(B) + a > 0 AND BX(B) + a < 16 THEN SAFE(BX(B) + a, BY(B)) = 40 - bt(B)
			IF BY(B) + a > 0 AND BY(B) + a < 10 THEN SAFE(BX(B), BY(B) + a) = 40 - bt(B)
		NEXT a
		SAFE(BX(B), BY(B)) = 70 - bt(B)
	END IF
END IF
NEXT B


DELAY 10

ALIVE = 0
FOR a = 1 TO 4
IF x(a) > 0 THEN ALIVE = ALIVE + 1
NEXT a
LOOP WHILE ALIVE > 1 OR BB > 0
WINNER = 0
FOR a = 1 TO 4
IF x(a) > 0 THEN WINNER = a
NEXT a
IF WINNER = 0 THEN ADRAW
IF WINNER > 0 THEN GOWIN WINNER
WINS(WINNER) = WINS(WINNER) + 1
SCOREB
OK = 0
FOR a = 1 TO 4
IF WINS(a) = 7 THEN FINISH a
IF WINS(a) > 6 THEN OK = 1
NEXT a
LOOP WHILE OK = 0
LOOP                'END OF MAIN LOOP

FREEBOMB:
	B = 0
	FOR a = N * 10 - 9 TO N * 10 - 9 + S(PL(N), 3)
	IF a <= 40 THEN IF typ(a) = 0 THEN B = a
	NEXT a
	IF B > 0 THEN EFFECT 2
RETURN

LEVEL1:
DATA The Loop
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,7,7,7,7,7,7,7,7,7,7,6,0,0
DATA 0,1,4,1,0,1,0,1,0,1,0,1,6,1,0
DATA 0,0,4,0,0,0,0,0,0,0,0,0,6,0,0
DATA 0,1,4,1,0,1,0,1,0,1,0,1,6,1,0
DATA 0,0,4,5,5,5,5,5,5,5,5,5,5,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
LEVEL2:
DATA Race Track
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 7,7,7,7,7,7,7,7,7,7,7,7,7,7,6
DATA 4,1,1,1,0,1,0,1,0,1,0,1,1,1,6
DATA 4,1,8,0,0,0,1,0,1,0,0,0,8,1,6
DATA 4,1,0,1,0,1,0,0,0,1,0,1,0,1,6
DATA 4,0,0,0,0,0,0,8,0,0,0,0,0,0,6
DATA 4,1,0,1,0,1,0,0,0,1,0,1,0,1,6
DATA 4,1,8,0,0,0,1,0,1,0,0,0,8,1,6
DATA 4,1,1,1,0,1,0,1,0,1,0,1,1,1,6
DATA 4,5,5,5,5,5,5,5,5,5,5,5,5,5,5
LEVEL3:
DATA Flower - 1
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,6,0,6,0,0,0,0,0,0
DATA 0,1,1,1,0,1,6,1,6,1,0,1,1,1,0
DATA 0,1,3,0,0,0,6,0,6,0,0,0,3,1,0
DATA 0,1,0,1,0,1,6,1,6,1,0,1,0,1,0
DATA 0,7,7,7,7,7,7,8,5,5,5,5,5,5,0
DATA 0,1,0,1,0,1,4,1,4,1,0,1,0,1,0
DATA 0,1,3,0,0,0,4,0,4,0,0,0,3,1,0
DATA 0,1,1,1,0,1,4,1,4,1,0,1,1,1,0
DATA 0,0,0,0,0,0,4,0,4,0,0,0,0,0,0
LEVEL4:
DATA Flower - 2
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,4,0,4,0,0,0,0,0,0
DATA 0,1,0,1,0,1,4,1,4,1,0,1,0,1,0
DATA 0,0,3,0,0,0,4,1,4,0,0,0,3,0,0
DATA 0,1,0,1,0,1,4,8,4,1,0,1,0,1,0
DATA 0,5,5,5,5,5,5,0,7,7,7,7,7,7,0
DATA 0,1,0,1,0,1,6,8,6,1,0,1,0,1,0
DATA 0,0,3,0,0,0,6,1,6,0,0,0,3,0,0
DATA 0,1,0,1,0,1,6,1,6,1,0,1,1,1,0
DATA 0,0,0,0,0,0,6,0,6,0,0,0,0,0,0
LEVEL5:
DATA The Impass
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,6,0,6,0,6,0,6,0,6,0,6,0,0
DATA 0,1,6,1,6,1,6,1,6,1,6,1,6,1,0
DATA 7,7,0,0,0,0,0,0,0,0,0,0,0,5,5
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 7,7,0,0,0,0,0,0,0,0,0,0,0,5,5
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 7,7,0,0,0,0,0,0,0,0,0,0,0,5,5
DATA 0,1,4,1,4,1,4,1,4,1,4,1,4,1,0
DATA 0,0,4,0,4,0,4,0,4,0,4,0,4,0,0
LEVEL6:
DATA Catacombs
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,6,5,5,0,0,0,0,0,6,5,5,0,0
DATA 0,1,6,3,4,1,0,1,0,1,6,3,4,1,0
DATA 1,0,7,7,4,0,0,0,0,0,7,7,4,0,1
DATA 0,1,0,1,0,1,0,0,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,0,0,1,0,1,0,1,0
DATA 1,0,6,5,5,0,0,0,0,0,6,5,5,0,1
DATA 0,1,6,3,4,1,0,1,0,1,6,3,4,1,0
DATA 0,0,7,7,4,0,0,0,0,0,7,7,4,0,0
LEVEL7:
DATA WaterWorld
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 4,5,4,5,4,5,2,2,2,5,4,5,4,5,4
DATA 7,6,7,6,7,6,2,2,2,6,7,6,7,6,7
DATA 4,5,4,5,4,1,2,0,2,1,4,5,4,5,4
DATA 7,6,7,6,7,1,0,0,0,1,7,6,7,6,7
DATA 2,2,2,2,2,0,0,8,0,0,2,2,2,2,2
DATA 7,6,7,6,7,1,0,0,0,1,7,6,7,6,7
DATA 4,5,4,5,4,1,2,0,2,1,4,5,4,5,4
DATA 7,6,7,6,7,6,2,2,2,6,7,6,7,6,7
DATA 4,5,4,5,4,5,2,2,2,5,4,5,4,5,4
LEVEL8:
DATA Plain Level
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
LEVEL9:
DATA Starburst
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,1,3,0,0,0,0,0,0,0,3,1,0,0
DATA 0,0,0,1,0,0,0,1,0,0,0,1,0,0,0
DATA 0,0,0,0,1,0,0,0,0,0,1,0,0,0,0
DATA 0,0,0,0,0,1,4,4,4,1,0,0,0,0,0
DATA 1,1,1,1,0,0,0,0,0,0,0,1,1,1,1
DATA 0,0,0,0,0,1,6,6,6,1,0,0,0,0,0
DATA 0,0,0,0,1,0,0,0,0,0,1,0,0,0,0
DATA 0,0,0,1,0,0,0,1,0,0,0,1,0,0,0
DATA 0,0,1,3,0,0,0,0,0,0,0,3,1,0,0
LEVEL10:
DATA Spider Web
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,2,2,6,6,6,1,6,6,6,2,2,0,0
DATA 0,2,2,6,4,6,6,1,6,6,4,6,2,2,0
DATA 2,2,7,6,6,6,2,1,2,6,6,6,5,2,2
DATA 2,7,7,7,7,2,2,2,2,2,5,5,5,5,2
DATA 1,1,1,1,1,2,2,8,2,2,1,1,1,1,1
DATA 2,7,7,7,7,2,2,2,2,2,5,5,5,5,2
DATA 2,2,7,4,4,4,2,1,2,4,4,4,5,2,2
DATA 0,2,2,4,6,4,4,1,4,4,6,4,2,2,0
DATA 0,0,2,2,4,4,4,1,4,4,4,2,2,0,0
LEVEL11:
DATA Warzone
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,2,2,2,2,2,2,2,2,2,2,2,0,0
DATA 0,2,2,2,2,2,2,1,2,2,2,2,2,2,0
DATA 2,2,2,2,2,2,2,8,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,1,8,2,2,2,2,2,2,2,2,2,8,1,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,8,2,2,2,2,2,2,2
DATA 0,2,2,2,2,2,2,1,2,2,2,2,2,2,0
DATA 0,0,2,2,2,2,2,2,2,2,2,2,2,0,0
LEVEL12:
DATA Battlezone
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 4,0,0,0,0,0,0,4,0,0,0,0,0,0,4
DATA 4,1,0,0,0,0,0,4,0,0,0,0,0,1,4
DATA 4,0,0,0,0,0,0,4,0,0,0,0,0,0,4
DATA 4,0,0,8,0,0,0,4,0,0,0,8,0,0,4
DATA 0,0,1,1,1,0,0,0,0,0,1,1,1,0,0
DATA 6,0,0,8,0,0,0,6,0,0,0,8,0,0,6
DATA 6,0,0,0,0,0,0,6,0,0,0,0,0,0,6
DATA 6,1,0,0,0,0,0,6,0,0,0,0,0,1,6
DATA 6,0,0,0,0,0,0,6,0,0,0,0,0,0,6
LEVEL13:
DATA Caverns
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,1,0,1,0,1,0,1,0,1,0,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 1,0,1,0,1,1,1,1,1,1,1,0,1,0,1
DATA 0,0,1,0,0,0,0,1,0,0,0,0,1,0,0
DATA 1,1,1,1,1,0,0,1,0,0,1,1,1,1,1
DATA 0,0,1,0,0,0,0,1,0,0,0,0,1,0,0
DATA 1,0,1,0,1,1,1,1,1,1,1,0,1,0,1
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,1,0,1,0,1,0,1,0,1,0,1,0,0
LEVEL14:
DATA Sonic Zone
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,1,1,3,0,0,0,3,1,1,0,0,0
DATA 0,0,0,1,0,1,0,0,0,1,0,1,0,0,0
DATA 0,1,0,1,0,3,1,0,1,3,0,1,0,1,0
DATA 0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
DATA 3,1,0,3,0,1,1,0,1,1,0,3,0,1,3
DATA 0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
DATA 0,1,0,1,0,3,1,0,1,3,0,1,0,1,0
DATA 0,0,0,1,0,1,0,0,0,1,0,1,0,0,0
DATA 0,0,0,1,1,3,0,0,0,3,1,1,0,0,0
LEVEL15:
DATA Gleep-Bleep
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,6,1,1,1,0,0,0,1,1,1,6,0,0
DATA 0,0,6,7,7,7,3,0,3,5,5,5,6,0,0
DATA 0,1,3,0,0,0,4,0,4,0,0,0,3,1,0
DATA 0,0,0,0,0,0,0,8,0,0,0,0,0,0,0
DATA 0,1,3,0,0,0,6,0,6,0,0,0,3,1,0
DATA 0,0,4,7,7,7,3,0,3,5,5,5,4,0,0
DATA 0,0,4,1,1,1,0,0,0,1,1,1,4,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
LEVEL16:
DATA Whirl-A-Twirl
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 8,0,0,5,5,5,5,5,5,5,5,5,0,0,8
DATA 0,0,5,5,5,5,5,5,5,5,5,5,5,0,0
DATA 0,6,6,5,5,5,5,5,5,5,5,5,5,4,0
DATA 6,6,6,6,5,5,5,5,5,5,5,5,4,4,4
DATA 6,6,6,6,1,1,1,1,1,3,5,4,4,4,4
DATA 6,6,6,7,7,7,7,7,7,7,4,4,4,4,4
DATA 0,6,7,7,7,7,7,7,7,7,7,4,4,4,0
DATA 0,0,7,7,7,7,7,7,7,7,7,7,4,0,0
DATA 8,0,0,7,7,7,7,7,7,7,7,7,0,0,8
LEVEL17:
DATA The Arena
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUUURRRRRRRRRRDRDRDRDRLDLDLDLDLLLLLLULULULULRURURURRRRRRDRDRDRLDLDLDLLLLULULULRURUR"
DATA   0,0,1,1,2,2,2,2,2,2,2,1,1,0,0
DATA   0,3,1,2,2,2,2,2,2,2,2,2,1,3,0
DATA 1,1,2,2,2,11,10,11,10,11,2,2,2,1,1
DATA 1,2,2,2,2,10,11,10,11,10,2,2,2,2,1
DATA 2,2,2,2,2,11,10,8,10,11,2,2,2,2,2
DATA 1,2,2,2,2,10,11,10,11,10,2,2,2,2,1
DATA 1,1,2,2,2,11,10,11,10,11,2,2,2,1,1
DATA   0,3,1,2,2,2,2,2,2,2,2,2,1,3,0
DATA   0,0,1,1,2,2,2,2,2,2,2,1,1,0,0
LEVEL18:
DATA Fade-In
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA   0,0,28,28,28,28,28,28,28,28,28,28,28,0,0
DATA  0,28,28,28,28,28,28,28,28,28,28,28,28,28,0
DATA 28,28,28,28,28,28,28,28,28,28,28,28,28,28,28
DATA 28,28,28,28,28,28,28,09,28,28,28,28,28,28,28
DATA 28,28,28,28,28,28,09,09,09,28,28,28,28,28,28
DATA 28,28,28,28,28,28,28,09,28,28,28,28,28,28,28
DATA 28,28,28,28,28,28,28,28,28,28,28,28,28,28,28
DATA  0,28,28,28,28,28,28,28,28,28,28,28,28,28,0
DATA   0,0,28,28,28,28,28,28,28,28,28,28,28,0,0
LEVEL19:
DATA Astral Plane
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,3,0,3,0,3,0,3,0,3,0,3,0,3,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
LEVEL20:
DATA MINEFIELD
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,8,0,8,0,8,0,8,0,8,0,8,0,8,0
DATA 0,0,0,0,0,0,11,0,10,0,0,0,0,0,0
DATA 0,8,0,8,0,8,10,8,11,8,0,8,0,8,0
DATA 0,0,0,0,11,10,11,10,11,10,11,0,0,0,0
DATA 0,8,0,8,0,8,10,8,11,8,0,8,0,8,0
DATA 0,0,0,0,0,0,11,0,10,0,0,0,0,0,0
DATA 0,8,0,8,0,8,0,8,0,8,0,8,0,8,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
LEVEL21:
DATA Random Level
DATA 1,1,RRRRRRRRRRRRRRDDDDDDDDLLLLLLLLLLLLLLUUUUUUURRRRRRRRRRRRRDDDDDDLLLLLLLLLLLLUUUUU
DATA 1,1,1,1,1,3,3,3,3,3,1,1,1,1,1
DATA 1,1,1,1,3,3,1,1,1,3,3,1,1,1,1
DATA 1,1,1,3,3,1,1,1,1,3,3,1,1,1,1
DATA 1,1,1,1,3,3,1,1,3,3,1,1,1,1,1
DATA 1,1,1,1,1,1,1,3,3,1,1,1,1,1,1
DATA 1,1,1,1,1,1,3,3,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,3,3,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,3,3,1,1,1,1,1,1,1

TEND:
CALL font(44, 30, "N.U.K.E", 11, 5)
CALL font(42, 28, "N.U.K.E", 11, 9)
CALL font(40, 26, "N.U.K.E", 11, 15)
CALL font(72, 82, "BY TIM CASWELL", 4, 5)
CALL font(70, 80, "BY TIM CASWELL", 4, 9)
CALL font(68, 78, "BY TIM CASWELL", 4, 15)
font 29, 152, "3 - PLAY THE GAME!", 3, 5
font 27, 150, "3 - PLAY THE GAME!", 3, 9
font 25, 148, "3 - PLAY THE GAME!", 3, 15
font 29, 132, "2 - PICK LEVEL", 3, 5
font 27, 130, "2 - PICK LEVEL", 3, 9
font 25, 128, "2 - PICK LEVEL", 3, 15
font 29, 112, "1 - CHOOSE PLAYERS", 3, 5
font 27, 110, "1 - CHOOSE PLAYERS", 3, 9
font 25, 108, "1 - CHOOSE PLAYERS", 3, 15
font 10, 2, "F1 - HELP", 2, 15
font 10, 12, "F2 - EXIT", 2, 15

DEF SEG = &HA000
BSAVE "TITLE.PIC", 0, 64000
END

MHELP:

font 34, 4, "NUKE - HELP", 6, 4
font 32, 2, "NUKE - HELP", 6, 12
font 30, 0, "NUKE - HELP", 6, 15
DIM H$(10)

H$(0) = "   W        I      ARROWS     8"
H$(1) = "                           "
H$(2) = "   |        |        |        |"
H$(3) = "A--D  J--L   --   4--6"
H$(4) = "   |        |        |        |"
H$(5) = "                           "
H$(6) = "   S        K                 2"
H$(7) = "SET BOMB:    PLACES THE BOMBS"
H$(8) = "   `        /       DEL       +"
H$(9) = "BLOW DETONATOR: BLOWS THE DETONATORS"
H$(10) = "  TAB       '        \        0     "
FOR a = 0 TO 10
font 14, a * 12 + 34, H$(a), 2, 1
font 12, a * 12 + 32, H$(a), 2, 9
font 10, a * 12 + 30, H$(a), 2, 15
NEXT a
DEF SEG = &HA000
BSAVE "HELP.PIC", 0, 64000

SYSTEM

ERRORDATA:
DATA 1   ,    NEXT without FOR  
DATA   37,      Argument-count mismatch
DATA  2  ,     Syntax error     
DATA   38,      Array not defined
DATA  3  ,     RETURN without GOSUB
DATA   40,      Variable required
DATA  4  ,     Out of DATA      
DATA   50,      FIELD overflow
DATA  5  ,     Illegal function call
DATA   51,      Internal error
DATA  6  ,     Overflow         
DATA   52,      Bad file name or number
DATA  7  ,     Out of memory    
DATA   53,      File not found
DATA  8  ,     Label not defined
DATA   54,      Bad file mode
DATA  9  ,     Subscript out of range
DATA   55,      File already open
DATA  10 ,     Duplicate definition
DATA   56,      FIELD statement active
DATA  11 ,     Division by zero 
DATA   57,      Device I/O error
DATA  12 ,     Illegal in direct mode
DATA   58,      File already exists
DATA  13 ,     Type mismatch    
DATA   59,      Bad record length
DATA  14 ,     Out of string space
DATA   61,      Disk full
DATA  16 ,     String formula too complex
DATA   62,      Input past end of file
DATA  17 ,     Cannot continue  
DATA   63,      Bad record number
DATA  18 ,     Function not defined
DATA   64,      Bad file name
DATA  19 ,     No RESUME        
DATA   67,      Too many files
DATA  20 ,     RESUME without error
DATA   68,      Device unavailable
DATA  24 ,     Device timeout   
DATA   69,      Communication-buffer overflow
DATA  25 ,     Device fault     
DATA   70,      Permission denied
DATA  26 ,     FOR without NEXT 
DATA   71,      Disk not ready
DATA  27 ,     Out of paper    
DATA   72,      Disk-media error
DATA  29 ,     WHILE without WEND
DATA   73,      Feature unavailable
DATA  30 ,     WEND without WHILE
DATA   74,      Rename across disks
DATA  33 ,     Duplicate label  
DATA   75,      Path/File access error
DATA  35 ,     Subprogram not defined
DATA   76,      Path not found
DATA 255,END OF ERRORS

BAD:
RESUME NEXT
PRINT ER$(ERR)
BEEP
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
RESUME NEXT

SUB ADRAW
gray
font 44, 34, "DRAW", 20, 12
font 42, 32, "DRAW", 20, 14
font 40, 30, "DRAW", 20, 15
DO: LOOP WHILE INKEY$ <> ""
DO
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, C
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, C
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
DELAY 10

LOOP WHILE INKEY$ = " "
CLS
COLORS
END SUB

FUNCTION BOMBAT (x, y)
FOR a = 1 TO 40
IF typ(a) > 0 AND BX(a) = x AND BY(a) = y THEN EXIT FOR
NEXT a
IF a = 41 THEN a = 0
BOMBAT = a
END FUNCTION

SUB COLORS
'Main Palette [16-127], [144-255]
OUT &H3C8, 0
FOR z = 0 TO 1: FOR a = 0 TO 1: FOR B = 0 TO 1: FOR C = 0 TO 1: FOR D = 0 TO 15
OUT &H3C9, D * 4 * a + z * 63
OUT &H3C9, D * 4 * B + z * 63
OUT &H3C9, D * 4 * C + z * 63
NEXT D: NEXT C: NEXT B: NEXT a: NEXT z

'Basic Palette [0-15]
OUT &H3C8, 0
FOR D = 0 TO 1: FOR a = 0 TO 1: FOR B = 0 TO 1: FOR C = 0 TO 1
OUT &H3C9, a * 42 + D * 21
OUT &H3C9, B * 42 + D * 21
OUT &H3C9, C * 42 + D * 21
NEXT C: NEXT B: NEXT a: NEXT D

'Fire Palette [128-143]
OUT &H3C8, 128
FOR a = 0 TO 15
OUT &H3C9, 63
OUT &H3C9, a * 4
OUT &H3C9, 0
NEXT a

END SUB

SUB DELAY (N)
FOR a = 1 TO N
FOR B = 1 TO SPEED: NEXT B
NEXT a
END SUB

SUB EFFECT (N)
IF BLASTER = 0 OR N >= 5 THEN
SOUND 0, 0
IF N = 1 THEN PLAY "mbMSl32o0CDEFGFGDFEDCECCMN"
IF N = 2 THEN PLAY "mbl64o1aaap4bb"
IF N = 3 THEN PLAY "mbl64o2fgfgfgfg"
IF N = 4 THEN PLAY "mbl64o0fFE>DF"
IF N = 5 THEN PLAY "mbl64o0Ab"
IF N = 6 THEN PLAY "mbl64o2fd"
IF N = 7 THEN PLAY "mbl64o0D"
ELSE
'For soundblaster!
IF N < 5 THEN PLAYSOUND N
END IF
END SUB

SUB EXPLOSION (x, y, S, t)
EFFECT 1
IF L(x, y) = 8 THEN
FOR a = 1 TO 69
LINE (x * 20 - 10 - a, y * 20 - 10 - a)-(x * 20 - 10 + a, y * 20 - 10 + a), 128 + a \ 4, B
IF a MOD 5 = 0 THEN EFFECT 1
DELAY 1
NEXT a
FOR a = -3 TO 3
FOR B = -3 TO 3
IF x + a > 0 AND y + B > 0 AND x + a < 16 AND y + B < 10 THEN
	IF L(x + a, y + B) <> 1 AND L(x + a, y + B) <> 8 AND (L(x + a, y + B) < 4 OR L(x + a, y + B) > 7) THEN L(x + a, y + B) = 27
	CALL PUTIT(x + a, y + B, L(x + a, y + B), PIC())
END IF
NEXT B
NEXT a
FOR G = 1 TO 10
a = 6 * RND - 3
B = 6 * RND - 3
IF x + a > 0 AND y + B > 0 AND x + a < 16 AND y + B < 10 THEN IF L(x + a, y + B) <> 8 AND L(x + a, y + B) <> 1 THEN EXPLOSION x + a, y + B, 0, 1
NEXT G
END IF
FOR LT = 0 TO S
	IF x - LT <= 1 THEN EXIT FOR
	IF L(x - LT, y) = 1 THEN LT = LT - 1: EXIT FOR
	IF t MOD 2 = 1 THEN
		IF L(x - LT, y) = 2 THEN EXIT FOR
		IF L(x - LT, y) = 8 THEN EXIT FOR
	END IF
NEXT LT
FOR RT = 0 TO S
	IF x + RT >= 15 THEN EXIT FOR
	IF L(x + RT, y) = 1 THEN RT = RT - 1: EXIT FOR
	IF t MOD 2 = 1 THEN
		IF L(x + RT, y) = 2 THEN EXIT FOR
		IF L(x + RT, y) = 8 THEN EXIT FOR
	END IF
NEXT RT
FOR UP = 0 TO S
	IF y - UP <= 1 THEN EXIT FOR
	IF L(x, y - UP) = 1 THEN UP = UP - 1: EXIT FOR
	IF t MOD 2 = 1 THEN
		IF L(x, y - UP) = 2 THEN EXIT FOR
		IF L(x, y - UP) = 8 THEN EXIT FOR
	END IF
NEXT UP
FOR DN = 0 TO S
	IF y + DN >= 9 THEN EXIT FOR
	IF L(x, y + DN) = 1 THEN DN = DN - 1: EXIT FOR
	IF t MOD 2 = 1 THEN
		IF L(x, y + DN) = 2 THEN EXIT FOR
		IF L(x, y + DN) = 8 THEN EXIT FOR
	END IF
NEXT DN
IF t > 4 THEN
	FOR UL = 0 TO S
		IF x - UL <= 1 THEN EXIT FOR
		IF y - UL <= 1 THEN EXIT FOR
		IF L(x - UL, y - UL) = 1 THEN UL = UL - 1: EXIT FOR
		IF t MOD 2 = 1 THEN
			IF L(x - UL, y - UL) = 2 THEN EXIT FOR
			IF L(x - UL, y - UL) = 8 THEN EXIT FOR
		END IF
	NEXT UL
	FOR DL = 0 TO S
		IF x - DL <= 1 THEN EXIT FOR
		IF y + DL > 8 THEN EXIT FOR
		IF L(x - DL, y + DL) = 1 THEN DL = DL - 1: EXIT FOR
		IF t MOD 2 = 1 THEN
			IF L(x - DL, y + DL) = 2 THEN EXIT FOR
			IF L(x - DL, y + DL) = 8 THEN EXIT FOR
		END IF
	NEXT DL
	FOR UR = 0 TO S
		IF x + UR > 14 THEN EXIT FOR
		IF y - UR <= 1 THEN EXIT FOR
		IF L(x + UR, y - UR) = 1 THEN UR = UR - 1: EXIT FOR
		IF t MOD 2 = 1 THEN
			IF L(x + UR, y - UR) = 2 THEN EXIT FOR
			IF L(x + UR, y - UR) = 8 THEN EXIT FOR
		END IF
	NEXT UR
	FOR DR = 0 TO S
		IF x + DR > 14 THEN EXIT FOR
		IF y + DR > 8 THEN EXIT FOR
		IF L(x + DR, y + DR) = 1 THEN DR = DR - 1: EXIT FOR
		IF t MOD 2 = 1 THEN
			IF L(x + DR, y + DR) = 2 THEN EXIT FOR
			IF L(x + DR, y + DR) = 8 THEN EXIT FOR
		END IF
	NEXT DR
END IF
		
FOR a = -UL TO DR
	IF L(x + a, y + a) = 2 THEN L(x + a, y + a) = TREASURE
NEXT a
FOR a = -UR TO DL
	IF L(x - a, y + a) = 2 THEN L(x - a, y + a) = TREASURE
NEXT a
FOR a = x - LT TO x + RT
	IF L(a, y) = 2 THEN L(a, y) = TREASURE
NEXT a
FOR a = y - UP TO y + DN
	IF L(x, a) = 2 THEN L(x, a) = TREASURE
NEXT a

FOR N = 27 TO 30
	FOR a = -UL TO DR
		CALL PUTIT(x + a, y + a, N, PIC())
	NEXT a
	FOR a = -UR TO DL
		CALL PUTIT(x - a, y + a, N, PIC())
	NEXT a
	FOR a = x - LT TO x + RT
		CALL PUTIT(a, y, N, PIC())
	NEXT a
	FOR a = y - UP TO y + DN
		CALL PUTIT(x, a, N, PIC())
	NEXT a
	DELAY 4
NEXT N

FOR a = x - LT TO x + RT
	CALL PUTIT(a, y, L(a, y), PIC())
	FOR N = 1 TO 4
		IF x(N) = a AND y(N) = y THEN x(N) = -4: CALL EXPLOSION(a, y, 4, 1)
	NEXT N
NEXT a
FOR a = y - UP TO y + DN
	CALL PUTIT(x, a, L(x, a), PIC())
	FOR N = 1 TO 4
		IF x(N) = x AND y(N) = a THEN x(N) = -4: CALL EXPLOSION(x, a, 4, 1)
	NEXT N
NEXT a
FOR a = -UL TO DR
	CALL PUTIT(x + a, y + a, L(x + a, y + a), PIC())
	FOR N = 1 TO 4
		IF x(N) = x + a AND y(N) = y + a THEN x(N) = -4: CALL EXPLOSION(x + a, y + a, 4, 1)
	NEXT N
NEXT a
FOR a = -UR TO DL
	CALL PUTIT(x - a, y + a, L(x - a, y + a), PIC())
	FOR N = 1 TO 4
		IF x(N) = x - a AND y(N) = y + a THEN x(N) = -4: CALL EXPLOSION(x - a, y + a, 4, 1)
	NEXT N
NEXT a

END SUB

SUB FINISH (WINNER)
font 24, 64, "WINNER IS", 10, 12
font 22, 62, "WINNER IS", 10, 14
font 20, 60, "WINNER IS", 10, 15
font 24, 104, N$(PL(WINNER)), 12, 12
font 22, 102, N$(PL(WINNER)), 12, 14
font 20, 100, N$(PL(WINNER)), 12, 15
say "THE WINNER IS " + N$(PL(WINNER))
PLAY "MBo3<t255l4dp8l8ap4l2>d<l8ab->c<b-agab-gap8al4fl2d.p4l8defep4efgab-ap8gab-a>c<b-ap8>cl4fdl2c<l4b-"
DO: LOOP WHILE INKEY$ <> ""
DO
DELAY 3
IF RND > .98 THEN EFFECT INT(5 * RND) + 1
LOOP WHILE INKEY$ = ""
COLORS
END SUB

SUB font (x, y, txt$, pt, C)
pt = pt / 2
sz = pt * 4: sp = (pt + 1) * 4 + 2
DRAW "S=" + VARPTR$(sz)
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
sh = 2
IF pt < 3 THEN sh = 1
PSET (x - 1 + r * sp - sp, y + sp - 1), cb: DRAW "c0" + t$(L)
PSET (x + sh + r * sp - sp, y + sp - 1), cb: DRAW "c0" + t$(L)
PSET (x + sh + r * sp - sp, y + sp + sh), cb: DRAW "c0" + t$(L)
PSET (x - 1 + r * sp - sp, y + sp + sh), cb: DRAW "c0" + t$(L)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c0" + t$(L)
	PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c0" + t$(L)
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c0" + t$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c0" + t$(L)
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
FOR r = 1 TO LEN(txt$)
L = ASC(MID$(txt$, r, 1))
cb = POINT(x + r * sp - sp, y + sp)
PSET (x + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(C) + t$(L)
IF pt > 1 THEN
PSET (x + 1 + r * sp - sp, y + sp), cb: DRAW "c=" + VARPTR$(C) + t$(L)
IF pt > 2 THEN
PSET (x + 1 + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(C) + t$(L)
PSET (x + r * sp - sp, y + sp + 1), cb: DRAW "c=" + VARPTR$(C) + t$(L)
END IF
END IF
IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
END SUB

SUB GOWIN (WINNER)
gray
font 24, 44, N$(PL(WINNER)), 14, 12
font 22, 42, N$(PL(WINNER)), 14, 14
font 20, 40, N$(PL(WINNER)), 14, 15
DO: LOOP WHILE INKEY$ <> ""
DO
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, C
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, C
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
DELAY 10
LOOP WHILE INKEY$ = " "
CLS
COLORS
END SUB

SUB gray
SOUND 0, 0
PLAY "MBO1P4L16GFDGFDGFDL8<CP8C"
OUT &H3C8, 16
FOR a = 16 TO 255
OUT &H3C9, a * 4
OUT &H3C9, a * 4
OUT &H3C9, a * 4
NEXT a
END SUB

SUB HELP
DEF SEG = &HA000
BLOAD "HELP.PIC", 0
say "NUKE HELP"
DO: LOOP WHILE INKEY$ <> ""
DO
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, 0
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a

DELAY 10
LOOP WHILE INKEY$ = ""
END SUB

SUB INIT

SCREEN 13
CALL COLORS
DEF SEG = &HA000
BLOAD "TITLE.PIC", 0
OPEN "font2.fon" FOR INPUT AS #1
FOR a = 0 TO 127
INPUT #1, t$(a)
NEXT a
CLOSE #1

DEF SEG = VARSEG(PIC(0))
BLOAD "nuke.pic", 0
DEF SEG

UP$(1) = "8"
LT$(1) = "4"
RT$(1) = "6"
DN$(1) = "2"
BOMB$(1) = "+"
DET$(1) = "-"
UP$(2) = "W"
LT$(2) = "A"
RT$(2) = "D"
DN$(2) = "S"
BOMB$(2) = "`"
DET$(2) = CHR$(9)
UP$(3) = "I"
LT$(3) = "J"
RT$(3) = "L"
DN$(3) = "K"
BOMB$(3) = "/"
DET$(3) = "'"
UP$(4) = CHR$(0) + "H"
LT$(4) = CHR$(0) + "K"
RT$(4) = CHR$(0) + "M"
DN$(4) = CHR$(0) + "P"
BOMB$(4) = CHR$(0) + "S"
DET$(4) = "\"
END SUB

SUB LEVEL (L(), PIC())
FOR y = 1 TO 9
FOR x = 1 TO 15
CALL PUTIT(x, y, L(x, y), PIC())
NEXT x
NEXT y
END SUB

SUB LEVELS (LVL)
say "choose the plane of battle"
DO
IF LVL = 0 THEN LVL = 21
SELECT CASE LVL
CASE 1: RESTORE LEVEL1
CASE 2: RESTORE LEVEL2
CASE 3: RESTORE LEVEL3
CASE 4: RESTORE LEVEL4
CASE 5: RESTORE LEVEL5
CASE 6: RESTORE LEVEL6
CASE 7: RESTORE LEVEL7
CASE 8: RESTORE LEVEL8
CASE 9: RESTORE LEVEL9
CASE 10: RESTORE LEVEL10
CASE 11: RESTORE LEVEL11
CASE 12: RESTORE LEVEL12
CASE 13: RESTORE LEVEL13
CASE 14: RESTORE LEVEL14
CASE 15: RESTORE LEVEL15
CASE 16: RESTORE LEVEL16
CASE 17: RESTORE LEVEL17
CASE 18: RESTORE LEVEL18
CASE 19: RESTORE LEVEL19
CASE 20: RESTORE LEVEL20
CASE 21: RESTORE LEVEL21
END SELECT
READ N$
READ FX, FY, TIMEOUT$
FOR y = 1 TO 9
FOR x = 1 TO 15
READ L
IF L = 0 AND RND > .1 THEN
	OK = 1
	IF x = 1 AND y = 1 THEN OK = 0
	IF x = 1 AND y = 2 THEN OK = 0
	IF x = 2 AND y = 1 THEN OK = 0
	IF x = 15 AND y = 1 THEN OK = 0
	IF x = 15 AND y = 2 THEN OK = 0
	IF x = 14 AND y = 1 THEN OK = 0
	IF x = 15 AND y = 9 THEN OK = 0
	IF x = 15 AND y = 8 THEN OK = 0
	IF x = 14 AND y = 9 THEN OK = 0
	IF x = 1 AND y = 9 THEN OK = 0
	IF x = 1 AND y = 8 THEN OK = 0
	IF x = 2 AND y = 9 THEN OK = 0
	IF OK = 1 THEN L = 2
END IF
L(x, y) = L
NEXT x
NEXT y
CLS
CALL LEVEL(L(), PIC())
font 20, 180, N$, 5, 15
OK = 0
GG = 45
DO
FOR a = 1 TO 5
x = INT(15 * RND) + 1
y = INT(9 * RND) + 1
IF L(x, y) >= 27 THEN
	L(x, y) = L(x, y) + 1
	IF L(x, y) = 31 THEN L(x, y) = 2
	CALL PUTIT(x, y, L(x, y), PIC())
END IF
NEXT a
IF pt = 0 OR GG > 50 THEN
	GG = GG + 1
	IF GG > 50 AND GG - 50 <= LEN(TIMEOUT$) THEN
		L(FX, FY) = 1: PUTIT FX, FY, 1, PIC()
		M$ = UCASE$(MID$(TIMEOUT$, GG - 50, 1))
		IF M$ = "U" THEN FY = FY - 1
		IF M$ = "D" THEN FY = FY + 1
		IF M$ = "L" THEN FX = FX - 1
		IF M$ = "R" THEN FX = FX + 1
		L(FX, FY) = 27: PUTIT FX, FY, 1, PIC()
		EFFECT 3
		IF GG - 50 = LEN(TIMEOUT$) THEN L(FX, FY) = 1: PUTIT FX, FY, 1, PIC()
	END IF
END IF
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, 0
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a
DELAY 10
a$ = INKEY$
IF a$ = "4" THEN LVL = LVL - 1: OK = 1
IF a$ = "6" THEN LVL = LVL + 1: OK = 1
IF a$ = " " THEN OK = 1
IF LVL > 21 THEN LVL = 1
IF LVL < 1 THEN LVL = 21
LOOP WHILE OK = 0
IF a$ <> "" THEN EFFECT 3
LOOP WHILE a$ <> " "
END SUB

SUB loadsound (F$())
OUT port% + 6, 1
FOR I = 1 TO 4
   junk% = INP(port% + 6)
NEXT
OUT port% + 6, 0
IF INP(port% + 14) AND &H80 = &H80 AND INP(port% + 10) = &HAA THEN
   font 1, 100, "SOUND BLASTER !", 6, 9: BLASTER = 1
   say "sound blaster"
 ELSE
   COLOR 1
   font 1, 100, "PC-SPEAKER !", 6, 9: BLASTER = 0
   say "pee cee speaker"
   EFFECT 1
END IF

IF BLASTER = 0 THEN EXIT SUB
DO: LOOP WHILE INP(port% + 12) AND &H80
OUT port% + 12, &HD1
freq& = 11000
timeconst% = 256 - 1000000 \ freq&
SELECT CASE Channel%
	CASE 0
	   pgport% = &H87
	   addport% = &H0
	   lenport% = &H1
	   modereg% = &H48
	CASE 1
	   pgport% = &H83
	   addport% = &H2
	   lenport% = &H3
	   modereg% = &H49
	CASE 2
	   pgport% = &H81
	   addport% = &H4
	   lenport% = &H5
	   modereg% = &H4A
	CASE 3
	   pgport% = &H82
	   addport% = &H6
	   lenport% = &H7
	   modereg% = &H4B
	CASE ELSE
	   font 10, 10, "DMA channels 0-3 only are supported.", 6, 15
	   say "Dee eM Aie channels 0 to 3 only are supported"
END SELECT
FOR I = 1 TO SOUNDS
length&(I) = 10000
segment&(I) = VARSEG(wavbuffer(I))
offset&(I) = VARPTR(wavbuffer(I))
memloc&(I) = segment&(I) * 16 + offset&(I)
OUT &HA, &H4 + Channel%
OUT &HC, &H0
OUT &HB, modereg%
OUT addport%, memloc&(I) AND &HFF
OUT addport%, (memloc&(I) AND &HFFFF&) \ &H100
IF (memloc&(I) AND 65536) THEN page%(I) = page%(I) + 1
IF (memloc&(I) AND 131072) THEN page%(I) = page%(I) + 2
IF (memloc&(I) AND 262144) THEN page%(I) = page%(I) + 4
IF (memloc&(I) AND 524288) THEN page%(I) = page%(I) + 8
putsound I, F$(I)
PLAYSOUND I
NEXT I
END SUB

FUNCTION MMENU
DEF SEG = &HA000
BLOAD "TITLE.PIC", 0
DO
pt = (pt + 1) MOD 16
OUT &H3C8, 80
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, 0
	OUT &H3C9, C
NEXT a
OUT &H3C8, 48
FOR a = 0 TO 15
	C = (a + pt) * 4
	OUT &H3C9, 0
	OUT &H3C9, C
	OUT &H3C9, C
NEXT a

DELAY 10
C = 0
a$ = INKEY$
IF a$ = CHR$(0) + CHR$(59) THEN CALL HELP: DEF SEG = &HA000: BLOAD "TITLE.PIC", 0
IF a$ = CHR$(0) + CHR$(60) THEN C = -1
IF a$ = "1" THEN C = 1
IF a$ = "2" THEN C = 2
IF a$ = "3" THEN C = 3
LOOP WHILE C = 0
IF C = 3 THEN C = 0
MMENU = C
END FUNCTION

SUB PEOPLE
CLS
FOR y = 1 TO 9
FOR x = 1 TO 16
P = 0
IF x = 2 THEN P = y + 18
IF y = 1 OR y = 9 OR x = 1 OR x = 16 THEN P = 1
PUTIT x, y, P, PIC()
NEXT x
IF y > 1 AND y < 9 THEN font 50, y * 20 - 20, N$(y - 1), 4, 15
NEXT y
'DEF SEG = &HA000: BSAVE "score.pic", 0, 64000
DIM OK(4)
FOR a = 1 TO 4
OK(a) = 0
NEXT a
say "choose your destiny"
DO
bt = (bt + 1) MOD 4
FOR x = 9 TO 15
FOR y = 1 TO 7
P = 0
FOR N = 1 TO 4
IF PL(N) = y THEN P = 27 + (bt + x + N) MOD 4: IF OK(N) = 1 THEN P = 1
NEXT N
PUTIT x, y + 1, P, PIC()
NEXT y
NEXT x
FOR S = 1 TO 5
	a$ = INKEY$
	IF a$ = CHR$(27) THEN FOR a = 1 TO 4: OK(a) = 1: NEXT a
	FOR N = 1 TO 4
		IF OK(N) = 0 THEN
		IF a$ = UP$(N) THEN PL(N) = PL(N) - 1: EFFECT 6
		IF a$ = DN$(N) THEN PL(N) = PL(N) + 1: EFFECT 6
		IF a$ = BOMB$(N) THEN OK(N) = 1: EFFECT 5
		IF PL(N) < 0 THEN PL(N) = 7
		IF PL(N) > 7 THEN PL(N) = 0
		END IF
	NEXT N
NEXT S
OK = 0
FOR N = 1 TO 4
OK = OK + OK(N)
NEXT N
LOOP WHILE OK < 4
END SUB

SUB PLAYSOUND (num%)
IF BLASTER = 0 THEN EXIT SUB
OUT &HA, &H4 + Channel%
OUT &HC, &H0
OUT &HB, modereg%
OUT addport%, memloc&(num%) AND &HFF
OUT addport%, (memloc&(num%) AND &HFFFF&) \ &H100
OUT pgport%, page%(num%)
OUT lenport%, length&(num%) AND &HFF
OUT lenport%, (length&(num%) AND &HFFFF&) \ &H100
OUT &HA, Channel%
 DO: LOOP WHILE INP(port% + 12) AND &H80
 OUT port% + 12, &H40
 DO: LOOP WHILE INP(port% + 12) AND &H80
 OUT port% + 12, timeconst%
 DO: LOOP WHILE INP(port% + 12) AND &H80
 OUT port% + 12, &H14
 DO: LOOP WHILE INP(port% + 12) AND &H80
 OUT port% + 12, (length&(num%) AND &HFF)
 DO: LOOP WHILE INP(port% + 12) AND &H80
 OUT port% + 12, ((length&(num%) AND &HFFFF&) \ &H100)
DELAY 2
END SUB

SUB playwav (F$)
IF BLASTER = 0 THEN EXIT SUB
OPEN F$ FOR BINARY AS #1
FOR I = 1 TO 5450
	GET #1, I, char
	MID$(wavbuffer(1), I, 1) = char
NEXT I
CLOSE
PLAYSOUND 1
END SUB

SUB PUTIT (x, y, P, PIC())
IF x > 0 AND y > 0 AND x < 17 AND y < 11 THEN PUT (x * 20 - 20, y * 20 - 20), PIC(P * 400), PSET
END SUB

SUB putsound (N, F$)
IF BLASTER = 0 THEN EXIT SUB
OPEN F$ FOR BINARY AS #1
FOR I = 1 TO 10000
	GET #1, I, char
	MID$(wavbuffer(N), I, 1) = char
NEXT I
CLOSE
END SUB

SUB say (F$)
'OPEN "say.txt" FOR OUTPUT AS #1
'PRINT #1, f$
'CLOSE #1
'SHELL "tran say.txt"
'KILL "say.txt"
END SUB

SUB SCOREB
DEF SEG = &HA000
BLOAD "SCORE.PIC", 0
font 46, -2, "SCORES", 6, 1
font 44, -4, "SCORES", 6, 9
font 42, -6, "SCORES", 6, 15
FOR x = 9 TO 15
FOR y = 1 TO 7
P = 0
FOR N = 1 TO 4
IF PL(N) = y THEN
IF (x - 8) <= WINS(N) THEN P = 9
END IF
NEXT N
PUTIT x, y + 1, P, PIC()
NEXT y
NEXT x
say "nuke scores"
DO: LOOP WHILE INKEY$ <> ""
DO: a$ = INKEY$
LOOP WHILE a$ = ""
IF a$ = CHR$(27) THEN WINS(1) = 20: EFFECT 6
END SUB

SUB SHOWSAFE
FOR y = 1 TO 9
FOR x = 1 TO 15
'LOCATE y * 20 \ 8, x * 20 \ 8: PRINT safe(x, y)
LINE (x * 20 - 13, y * 20 - 13)-(x * 20 - 7, y * 20 - 7), SAFE(x, y) \ 2, B
NEXT x
NEXT y
END SUB

FUNCTION TREASURE
t = 0
IF RND > .95 THEN t = 18   '18-ghost                           Where am I?
IF RND > .95 THEN t = 19   '19-crazy                           Who am i?
IF RND > .95 THEN t = 17   '17-drop disease                    I didn't push that button!!!
IF RND > .9 THEN t = 9     '9-STAR BOMB!!!!!!!!                WATCH OUT!!!
IF RND > .9 THEN t = 13    '13-cherryflame!!                   Bye-bye b'brick
IF RND > .9 THEN t = 16    '16-detonator                       not untill I say when
IF RND > .85 THEN t = 12   '12-goldenflame                     MAX flame on!
IF RND > .85 THEN t = 15   '15-Punch                           Up and over
IF RND > .85 THEN t = 14   '14-Kick                            Bowling for enemies!
IF RND > .75 THEN t = 11   '11-flame                           More power to ya...
IF RND > .75 THEN t = 10   '10-extra bomb!!                    I can set complex traps now!
IF RND > .5 THEN t = 0
TREASURE = t
END FUNCTION

