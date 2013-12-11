DECLARE SUB GET.PIC (ARRAY%())
DECLARE SUB MILLIDELAY (msecs%)
DECLARE SUB TITLE ()
DECLARE SUB MESSAGE (M$, OK$)
DECLARE SUB SHOW.SCORES (L%, H%)
DECLARE SUB FORWARD ()
DECLARE SUB SHOW.LEVEL ()
DECLARE SUB SHOW (A%, TX%, TY%)
DECLARE SUB CHECK.SCORES ()
DECLARE SUB BAR (X1%, Y1%, MIN.COL%, COLOURS%, H.OR.V%, W%, CS%)
DECLARE SUB BOX.BAR (X1%, Y1%, X2%, Y2%, COL1%, COL2%, CS%, WIDE%)
DECLARE SUB WIDE.BAR (X1%, Y1%, MIN.COL%, COLOURS%, H.OR.V%, W%, CS%)
DECLARE SUB WORD (PROMPT$, VAR$)
DECLARE SUB SORT.SCORES ()
DECLARE SUB SAVE.SCORES ()
DECLARE FUNCTION GET.SIZE% (X1%, Y1%, X2%, Y2%)
DECLARE FUNCTION MENU% (OPT$(), VALID%())
DECLARE SUB MIDDLE (row%, Text$)
DECLARE SUB MIDDLE2 (row%, Text$)
DEFINT A-Z
OPTION BASE 1

SCREEN 12: WIDTH 80, 60: CLS
RANDOMIZE TIMER
DIM SHARED KP AS STRING
DIM SHARED P1(202): GET.PIC P1()
DIM SHARED P2(202): GET.PIC P2()
DIM SHARED P3(202): GET.PIC P3()
DIM SHARED P4(202): GET.PIC P4()
DIM SHARED P5(202): GET.PIC P5()
'DIM SHARED P6(202): GET.PIC P6()

DIM SHARED LEVEL(32, 23)
DIM SHARED PX(2), PA(2), PS(2) AS LONG, N(2) AS STRING
MILLIDELAY 0
DIM SHARED LEVEL: LEVEL = 1
DIM SHARED BLOCKS: BLOCKS = 16
DIM SHARED SPEED: SPEED = 20
DIM SHARED TIMES: TIMES = 100
DIM SHARED PLAYERS: PLAYERS = 1
DIM SHARED COUNT: COUNT = 0
DIM SHARED DIST: DIST = 0
DIM MAIN$(4), MAINV(4)
FOR A = 1 TO 4: MAINV(A) = 1: NEXT A
MAIN$(1) = "One Player"
MAIN$(2) = "Two Players"
MAIN$(3) = "High Scores"
MAIN$(4) = "Exit"

DIM LEV$(11), LEVV(11)
LEVV(1) = 1
LEVV(11) = 1
LEV$(1) = "Level One"
LEV$(2) = "Level Two"
LEV$(3) = "Level Three"
LEV$(4) = "Level Four"
LEV$(5) = "Level Five"
LEV$(6) = "Level Six"
LEV$(7) = "Level Seven"
LEV$(8) = "Level Eight"
LEV$(9) = "Level Nine"
LEV$(10) = "Level Ten"
LEV$(11) = "Main Menu"

DIM SHARED PERSON(10, 10) AS STRING
DIM SHARED SCORE(10, 10)
FOR A = 1 TO 10
FOR B = 1 TO 10
PERSON(A, B) = "Mr. Nobody": SCORE(A, B) = 0
NEXT B
NEXT A
ON ERROR GOTO MAKE.FILE
F = FREEFILE
OPEN "DROIDS.DAT" FOR INPUT AS #F
FOR A = 1 TO 10
FOR B = 1 TO 10
INPUT #F, PERSON(A, B), SCORE(A, B)
NEXT B
NEXT A
CLOSE #F

STARTUP:
TITLE
MESSAGE "DROIDS - By Andre'", "OK"
ST2:
ON ERROR GOTO BAD
A = MENU(MAIN$(), MAINV())
SELECT CASE A
CASE 1 TO 2: PLAYERS = A
CASE 3
FOR A = 1 TO 10
SHOW.SCORES A, 0
NEXT A
GOTO ST2
CASE ELSE
MESSAGE "End Program?", "OK"
SYSTEM
END SELECT

A = MENU(LEV$(), LEVV())
SELECT CASE A
CASE 1 TO 10: LEVEL = A
CASE ELSE: GOTO ST2
END SELECT

START:
IF LEVEL > 10 THEN MESSAGE "Game is Done - You won!", "OK": GOTO STARTUP
SELECT CASE LEVEL
CASE 1: TIMES = 50: BLOCKS = 20
CASE 2: TIMES = 45: BLOCKS = 22
CASE 3: TIMES = 41: BLOCKS = 24
CASE 4: TIMES = 37: BLOCKS = 26
CASE 5: TIMES = 34: BLOCKS = 28
CASE 6: TIMES = 30: BLOCKS = 30
CASE 7: TIMES = 27: BLOCKS = 30
CASE 8: TIMES = 25: BLOCKS = 30
CASE 9: TIMES = 23: BLOCKS = 30
CASE 10: TIMES = 15: BLOCKS = 32
END SELECT
LEVV(LEVEL) = 1
CLS
FOR Y = 1 TO 23
FOR X = 1 TO 32
LEVEL(X, Y) = 0
NEXT X
NEXT Y
COUNT = 0
FOR A = 1 TO PLAYERS
PX(A) = INT(RND * 32) + 1
PA(A) = 1
PS(A) = 0
NEXT A
DIST = 0

FOR A = 1 TO 15: FORWARD: NEXT A
SHOW.LEVEL
MESSAGE "Level" + STR$(LEVEL) + "!", "GO"
DO
DO
C = 0
FOR A = 1 TO PLAYERS
IF PA(A) THEN
IF PX(A) < 8 THEN PX(A) = 24
IF PX(A) > 24 THEN PX(A) = 8
SHOW A, PX(A), 24
ELSE
C = C + 1
SHOW 5, PX(A), 24
END IF
NEXT A
IF C = PLAYERS THEN
MESSAGE "GAME OVER!", "No"
IF PLAYERS = 2 THEN
IF PS(1) > PS(2) THEN MESSAGE "Player One Won! Score -" + STR$(PS(1)), "OK"
IF PS(2) > PS(1) THEN MESSAGE "Player Two Won! Score -" + STR$(PS(2)), "OK"
IF PS(1) = PS(2) THEN MESSAGE "It's a draw! Score -" + STR$(PS(1)), "OK"
ELSE
MESSAGE "Your Score -" + STR$(PS(1)), "OK"
END IF
CHECK.SCORES
GOTO STARTUP
END IF
MILLIDELAY SPEED
COUNT = COUNT + 1
IF COUNT > TIMES THEN FORWARD: COUNT = 0: DIST = DIST + 1: SHOW.LEVEL
IF DIST = 20 AND COUNT = 1 THEN MESSAGE "You're halfway there!", "OK"
IF DIST = 35 AND COUNT = 1 THEN MESSAGE "Almost done it!", "OK"
IF DIST > 40 THEN
MESSAGE "You did it!", "OK"
IF PLAYERS = 2 THEN
IF PS(1) > PS(2) THEN MESSAGE "Player One Won! Score -" + STR$(PS(1)), "OK"
IF PS(2) > PS(1) THEN MESSAGE "Player Two Won! Score -" + STR$(PS(2)), "OK"
IF PS(1) = PS(2) THEN MESSAGE "It's a draw! Score -" + STR$(PS(1)), "OK"
ELSE
MESSAGE "Your Score -" + STR$(PS(1)), "OK"
END IF
CHECK.SCORES
LEVEL = LEVEL + 1: GOTO START
END IF
KP = UCASE$(INKEY$)
FOR A = 1 TO PLAYERS
SHOW 0, PX(A), 24
NEXT A
LOOP WHILE KP = ""
SELECT CASE KP
CASE "P": MESSAGE "Game is Paused", "OK"
CASE CHR$(27): MESSAGE "Exit Now?", "OK": GOTO STARTUP
CASE CHR$(0) + "K": IF PA(1) THEN PX(1) = PX(1) - 1
CASE CHR$(0) + "M": IF PA(1) THEN PX(1) = PX(1) + 1
CASE "A": IF PA(2) THEN PX(2) = PX(2) - 1
CASE "D": IF PA(2) THEN PX(2) = PX(2) + 1
CASE "~": LEVEL = LEVEL + 1: MESSAGE "Cheat!!? ---> Yes", "OK": GOTO START
CASE CHR$(0) + "H"
IF PA(1) THEN
FOR Y = 23 TO 10 STEP -1
X = PX(1)
SELECT CASE LEVEL(X, Y)
CASE 3
PS(1) = PS(1) + 1
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 9, BF
SHOW 5, X, Y
PLAY "O5MBT255L64ABCDEFGABCDEFG"
MILLIDELAY 50
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 0, BF
SHOW 0, X, Y
LEVEL(X, Y) = 0
EXIT FOR
CASE 4
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 12, BF
PLAY "O3MBT255L64ABCDEFGABCDEFG"
MILLIDELAY 50
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 0, BF
EXIT FOR
END SELECT
NEXT Y
END IF
CASE "W"
IF PA(2) THEN
FOR Y = 23 TO 10 STEP -1
X = PX(2)
SELECT CASE LEVEL(X, Y)
CASE 3
PS(2) = PS(2) + 1
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 9, BF
SHOW 5, X, Y
PLAY "O5MBT255L64ABCDEFGABCDEFG"
MILLIDELAY 100
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 0, BF
SHOW 0, X, Y
LEVEL(X, Y) = 0
EXIT FOR
CASE 4
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 12, BF
PLAY "O3MBT255L64ABCDEFGABCDEFG"
MILLIDELAY 100
LINE (((X - 1) * 20) + 4, 460)-((X * 20) - 4, (Y * 20)), 0, BF
EXIT FOR
END SELECT
NEXT Y
END IF
END SELECT
LOOP

END

BAD:
MESSAGE "Whoops! An error has come up!", "OK"
RESUME STARTUP

MAKE.FILE:
ON ERROR GOTO BAD
F = FREEFILE
OPEN "DROIDS.DAT" FOR OUTPUT AS #F
FOR A = 1 TO 10
FOR B = 1 TO 10
WRITE #F, PERSON(A, B), SCORE(A, B)
NEXT B
NEXT A
CLOSE #F
RESUME STARTUP

DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,15,15,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,15,15,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,12,12,12,  ,  ,15,15,  ,  ,12,12,12,  ,  ,  ,
DATA   ,  ,  ,  ,12,14,12,  ,  ,15,15,  ,  ,12,14,12,  ,  ,  ,
DATA   ,  ,  ,  ,12,12,12,  ,  ,15,15,  ,  ,12,12,12,  ,  ,  ,
DATA   ,  ,  ,  ,12,12,12,12,  ,15,15,  ,12,12,12,12,  ,  ,  ,
DATA   ,  ,  ,  ,  ,12,12,12,12,12,12,12,12,12,12,  ,  ,  ,  ,
DATA   ,  ,12,  ,  ,  ,12,12,12,13,13,12,12,12,  ,  ,  ,12,  ,
DATA   ,12,14,12,  ,  ,12,10,10,13,13,10,10,12,  ,  ,12,14,12,
DATA   ,12,12,12,  ,  ,12,10,10, 7, 7,10,10,12,  ,  ,12,12,12,
DATA   ,12,12,12,  ,  ,12,10,10,13,13,10,10,12,  ,  ,12,12,12,
DATA   ,12,12,12,  ,  ,12,12,12, 7, 7,12,12,12,  ,  ,12,12,12,
DATA   ,12,12,12,12,12,12,12,12,13,13,12,12,12,12,12,12,12,12,
DATA   ,  ,12,12,12,12,12,12,12, 7, 7,12,12,12,12,12,12,12,  ,
DATA   ,  ,  ,12,12,12,12,12,12,12,12,12,12,12,12,12,12,  ,  ,
DATA   ,  ,15,  ,  ,12,12,12,12,  ,  ,12,12,12,12,  ,  ,15,  ,
DATA   ,  ,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,  ,
DATA   ,  ,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,  ,

DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,15,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,15,  ,
DATA   ,  ,15,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,15,  ,
DATA   ,  ,15,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,15,  ,
DATA   ,  ,15,15,  ,  ,  ,10,  ,  ,  ,  ,10,  ,  ,  ,15,15,  ,
DATA   ,  ,12,12,  ,  ,  ,10,10,10,10,10,10,  ,  ,  ,12,12,  ,
DATA   ,  ,12,12,12,  ,  ,10,13,10,10,13,10,  ,  ,12,12,12,  ,
DATA   ,  ,  ,12,12,12,  ,10,13,10,10,13,10,  ,12,12,12,  ,  ,
DATA   ,  ,  ,  ,12,12,12,12,12,12,12,12,12,12,12,12,  ,  ,  ,
DATA   ,  ,  ,  ,  ,12,12,12,12,12,12,12,12,12,12,  ,  ,  ,  ,
DATA   ,  ,  ,  ,12,12,14,14,12,12,12,12,14,14,12,12,  ,  ,  ,
DATA   ,  ,  ,12,12,14,  ,  ,14,12,12,14,  ,  ,14,12,12,  ,  ,
DATA   ,  ,  ,12,12,14,  ,  ,14,12,12,14,  ,  ,14,12,12,  ,  ,
DATA   ,  ,12,12,12,12,14,14,12,12,12,12,14,14,12,12,12,12,  ,
DATA   ,  ,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,  ,
DATA   ,  ,  ,12,12,12,12,12,12,  ,  ,12,12,12,12,12,12,  ,  ,
DATA   ,  ,  ,12,12,12,12,12,  ,  ,  ,  ,12,12,12,12,12,  ,  ,
DATA   ,  ,15,  ,12,12,12,12,  ,  ,  ,  ,12,12,12,12,  ,15,  ,
DATA   ,  ,15,  ,  ,12,12,  ,  ,  ,  ,  ,  ,12,12,  ,  ,15,  ,
DATA   ,  ,15,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,15,  ,

DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,10,10,10,10,10,  ,  ,  ,  ,10,10,10,10,10,  ,  ,
DATA   ,  ,10,10,10,  ,10,10,10,  ,  ,10,10,10,  ,10,10,10,  ,
DATA   ,10,10,10,10,10,  ,10,10,10,10,10,10,  ,10,10,10,10,10,
DATA   ,10,10,10,10,12,10,  ,10,10,1 ,10,  ,10,12,10,10,10,10,
DATA   ,10,10,10,12,  ,12,10,  ,10,10,  ,10,12,  ,12,10,10,10,
DATA   ,  ,10,10,10,12,10,10,10,10,10,10,10,10,12,10,10,10,  ,
DATA   ,  ,  ,10,10,10,10,10,10,10,10,10,10,10,10,10,10,  ,  ,
DATA   ,  ,  ,10,10,10,10,10,12,12,12,12,10,10,10,10,10,  ,  ,
DATA   ,  ,  ,10,10,10,10,12,10,10,10,10,12,10,10,10,10,  ,  ,
DATA   ,  ,10,10,10,10,12,10,10,  ,  ,10,10,12,10,10,10,10,  ,
DATA   ,  ,10,  ,10,10,10,10,  ,  ,  ,  ,10,10,10,10,  ,10,  ,
DATA   ,  ,10,  ,10,  ,  ,10,  ,  ,  ,  ,10,  ,  ,10,  ,10,  ,
DATA   ,  ,10,  ,10,  ,  ,10,  ,  ,  ,  ,10,  ,  ,10,  ,10,  ,
DATA   ,  ,10,  ,10,  ,  ,  ,10,  ,  ,10,  ,  ,  ,10,  ,10,  ,
DATA   ,10,  ,  ,  ,10,  ,  ,10,  ,  ,10,  ,  ,10,  ,  ,  ,10,
DATA   ,10,  ,  ,  ,10,  ,10,  ,  ,  ,  ,10,  ,10,  ,  ,  ,10,
DATA   ,10,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,10,

DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  , 7, 7, 7,  ,  ,  ,  , 7, 7,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  , 7, 8, 7, 8, 7,  , 7, 7, 7, 8, 7,  , 7, 7,  ,  ,  ,
DATA   , 7, 8, 7, 7, 8, 7, 7, 8, 7, 7, 7, 8, 7, 7, 8, 7, 7,  ,
DATA   , 7, 7, 8, 7, 7, 7, 8, 7, 7, 7, 8, 7, 7, 8, 7, 8, 7, 7,
DATA   ,  , 7, 7, 7, 8, 7, 7, 7, 8, 7, 7, 7, 8, 7, 7, 7, 8, 7,
DATA   ,  , 7, 7, 8, 7, 7, 7, 7, 7, 8, 7, 7, 7, 7, 8, 7, 7, 7,
DATA   ,  ,  , 7, 7, 7, 8, 7, 7, 7, 7, 7, 7, 8, 7, 7, 7, 7, 7,
DATA   ,  ,  ,  , 7, 7, 7, 7, 8, 7, 7, 7, 7, 7, 7, 8, 7, 7,  ,
DATA   ,  ,  ,  , 7, 8, 8, 7, 7, 7, 7, 7, 8, 7, 7, 7, 7,  ,  ,
DATA   ,  ,  ,  , 7, 7, 7, 7, 7, 7, 8, 7, 7, 7, 7, 8, 7,  ,  ,
DATA   ,  ,  , 7, 7, 7, 8, 7, 7, 7, 7, 8, 7, 7, 7, 7,  ,  ,  ,
DATA   ,  ,  , 7, 8, 7, 7, 7, 8, 7, 7, 7, 7, 7, 8, 7, 7,  ,  ,
DATA   ,  , 7, 8, 7, 8, 7, 7, 7, 7, 8, 7, 7, 7, 8, 7, 7,  ,  ,
DATA   ,  , 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 8, 7, 7, 8, 7,  ,  ,
DATA   ,  , 7, 8, 7, 8, 7, 7, 7, 8, 7, 8, 7, 7, 7, 7,  ,  ,  ,
DATA   ,  ,  , 7, 7, 7, 7,  ,  ,  , 7, 7, 7, 7, 8, 7,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 7, 7, 7,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,

DATA   ,  ,  ,  ,  ,15,15,  ,  ,15,15,  ,15,15,15,  ,15,15,  ,
DATA   ,  ,  ,  ,  ,15,  ,15,  ,15,  ,  ,15,  ,15,  ,15,  ,15,
DATA   ,  ,  ,  ,  ,15,  ,15,  ,15,15,  ,15,15,15,  ,15,  ,15,
DATA   ,  ,  ,  ,  ,15,  ,15,  ,15,  ,  ,15,  ,15,  ,15,  ,15,
DATA   ,  ,  ,  ,  ,15,15,  ,  ,15,15,  ,15,  ,15,  ,15,15,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,12,12,  ,12,12,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,12,12,12,12,12,12,12,12,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,12,12,12,12,12,12,12,12,12,12,  ,  ,  ,  ,
DATA   ,  ,  ,  ,12,12,12,12,12, 4,12,12,12,12,12,12,12,  ,  ,
DATA   ,  ,  ,12,12,12,12,12,12, 4,12,12,12,12, 4,12,12,12,  ,
DATA   ,  ,12,12, 4,12, 4,12,12, 4,12,12,12,12, 4,12, 4,12,12,
DATA   ,  ,12,12, 4,12, 4,12,12, 4,12,12,12,12, 4,12, 4,12,12,
DATA   ,  ,  ,12, 4,12, 4,12,12, 4,12,12,12,12, 4,12, 4,12,12,
DATA   ,  ,  ,12, 4,12, 4,12,12, 4,12, 4,12,12,  ,12, 4,12, 4,
DATA   ,  ,  ,  , 4,  , 4,12,12, 4,12, 4,12,12,  ,  , 4,12, 4,
DATA   ,  ,  ,  ,  ,  , 4,12,12,12,12, 4,12,12,  ,  , 4,12, 4,
DATA   ,  ,  ,  ,  ,  ,  ,12,  ,12,12, 4,12,  ,  ,  ,  ,12,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,12, 4,  ,  ,  ,  ,  ,  ,  ,
DATA   ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 4,  ,  ,  ,  ,  ,  ,  ,

TS:
DATA  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1, 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1,  , 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1,  , 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1,  , 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,1 ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1,  , 1,  , 1, 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,1 ,  ,  ,  ,  ,  , 1
DATA  1,  ,  , 1, 1,  ,  , 1,  , 1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  , 1, 1,  ,  ,1 ,1 ,1 ,  , 1,  ,1 ,1 ,  ,  ,  ,  ,1 ,  ,1 ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  , 1,  , 1,  ,1 ,  ,1 ,  , 1,  ,1 ,  ,1 ,  ,1 ,1 ,1 ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  , 1,  , 1,  ,1 ,  ,1 ,  , 1,  ,1 ,  ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  , 1,  , 1,  ,1 ,  ,1 ,  , 1,  ,1 ,  ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,  , 1,  ,1 ,  ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,  , 1,  ,1 ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,1 ,1 ,  ,  ,  ,  ,  ,  ,  ,1 ,1 ,1 ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,  ,  ,1 , 1,1 ,  , 1
DATA  1,  ,1 ,  ,1 ,  ,  ,  ,  ,  ,  ,1 ,  ,1 ,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,  ,  ,1 ,  ,1 ,  , 1
DATA  1,  ,1 ,1 ,  ,  ,1 ,  ,1 ,  ,  ,1 , 1,1 ,  ,1 ,1 ,1 ,  ,1 ,1 ,1 ,  ,1 ,1 ,1 ,  ,1 ,1 ,1 ,  , 1
DATA  1,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,  ,  ,1 ,  ,  ,  , 1
DATA  1,  ,1 ,1 ,  ,  ,  ,1 ,1 ,  ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,  ,1 ,1 ,1 ,  ,1 ,  ,  ,  ,1 , 1,1 ,  , 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,1 ,1 ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  ,  , 1
DATA  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1

SUB BAR (X1, Y1, MIN.COL, COLOURS, H.OR.V, W, CS)

H = 0
V = 1

X = X1: Y = Y1

FOR Col = MIN.COL TO COLOURS STEP CS
SELECT CASE H.OR.V
CASE H
LINE (X, Y)-(X + (W - 1), Y), Col
Y = Y + 1
CASE ELSE
LINE (X, Y)-(X, Y + (W - 1)), Col
X = X + 1
END SELECT

NEXT Col
END SUB

SUB BOX.BAR (X1, Y1, X2, Y2, COL1, COL2, CS, WIDE)

IF WIDE THEN
SELECT CASE SGN(COL2 - COL1)
CASE -1: WID = (COL1 - COL2) - -1
CASE 1: WID = (COL2 - COL1) - -1
END SELECT

WIDE.BAR X1, Y1, COL1, COL2, 1, Y2 - Y1, CS
WIDE.BAR X1, Y2 - (WID * 2), COL1, COL2, 0, X2 - X1, CS
WIDE.BAR X1, Y1, COL1, COL2, 0, X2 - X1, CS
WIDE.BAR X2 - (WID * 2), Y1, COL1, COL2, 1, Y2 - Y1, CS
ELSE
SELECT CASE SGN(COL2 - COL1)
CASE -1: WID = (COL1 - COL2) - -1
CASE 1: WID = (COL2 - COL1) - -1
END SELECT
BAR X1, Y1, COL1, COL2, 1, Y2 - Y1, CS
BAR X1, Y2 - WID, COL1, COL2, 0, X2 - X1, CS
BAR X1, Y1, COL1, COL2, 0, X2 - X1, CS
BAR X2 - WID, Y1, COL1, COL2, 1, Y2 - Y1, CS
END IF
END SUB

SUB CHECK.SCORES
IF PLAYERS = 2 THEN

IF PS(1) > SCORE(LEVEL, 10) AND PS(1) > PS(2) THEN
MESSAGE "Player One has a high score!", "OK"
WORD "Name of Player One: ", N(1)
N(1) = RTRIM$(LEFT$(N(1), 15))
SCORE(LEVEL, 10) = PS(1): PERSON(LEVEL, 10) = N(1)
SORT.SCORES
IF PS(2) > SCORE(LEVEL, 10) THEN
MESSAGE "Player Two has a high score!", "OK"
WORD "Name of Player Two: ", N(2)
N(2) = RTRIM$(LEFT$(N(2), 15))
SCORE(LEVEL, 10) = PS(2): PERSON(LEVEL, 10) = N(2)
SORT.SCORES
END IF
END IF

IF PS(2) > SCORE(LEVEL, 10) AND PS(2) > PS(1) THEN
MESSAGE "Player Two has a high score!", "OK"
WORD "Name of Player Two: ", N(2)
N(2) = RTRIM$(LEFT$(N(2), 15))
SCORE(LEVEL, 10) = PS(2): PERSON(LEVEL, 10) = N(2)
SORT.SCORES
IF PS(1) > SCORE(LEVEL, 10) THEN
MESSAGE "Player One has a high score!", "OK"
WORD "Name of Player One: ", N(1)
N(1) = RTRIM$(LEFT$(N(1), 15))
SCORE(LEVEL, 10) = PS(1): PERSON(LEVEL, 10) = N(1)
SORT.SCORES
END IF
END IF

IF PS(1) > SCORE(LEVEL, 10) AND PS(2) = PS(1) THEN
MESSAGE "You both have a high score!", "OK"
WORD "Combined Name: ", N(1)
N(1) = RTRIM$(LEFT$(N(1), 15))
SCORE(LEVEL, 10) = PS(1): PERSON(LEVEL, 10) = N(1)
SORT.SCORES
END IF
ELSE
IF PS(1) > SCORE(LEVEL, 10) THEN
MESSAGE "You have a high score!", "OK"
WORD "Your name: ", N(1)
N(1) = RTRIM$(LEFT$(N(1), 15))
SCORE(LEVEL, 10) = PS(1): PERSON(LEVEL, 10) = N(1)
SORT.SCORES
END IF
SORT.SCORES
END IF
SAVE.SCORES
SHOW.SCORES LEVEL, 1
END SUB

SUB FORWARD

FOR A = 1 TO PLAYERS
IF LEVEL(PX(A), 23) = 4 OR LEVEL(PX(A), 23) = 3 THEN PA(A) = 0: PLAY "O3MBT255L64ABCDEFGABCDEFG"
NEXT A
FOR Y = 22 TO 1 STEP -1
FOR X = 1 TO 32
LEVEL(X, Y + 1) = LEVEL(X, Y)
NEXT X
NEXT Y
FOR X = 1 TO 32
LEVEL(X, 1) = 0
NEXT X
FOR A = 1 TO BLOCKS
DO
X = INT(RND * 32) + 1
IF LEVEL(X, 1) = 0 THEN LEVEL(X, 1) = 2 + (INT(RND * 2) + 1): EXIT DO
LOOP
NEXT A
END SUB

SUB GET.PIC (ARRAY())
FOR Y = 1 TO 20
FOR X = 1 TO 20
READ A: PSET (X - 1, Y - 1), A
NEXT X
NEXT Y
GET (0, 0)-(19, 19), ARRAY
END SUB

FUNCTION GET.SIZE (X1, Y1, X2, Y2)
GET.SIZE = 4 + INT(((PMAP(X2, 0) - PMAP(X1, 0) + 1) * (8) + 7) / 8) * 1 * (PMAP(Y2, 1) - PMAP(Y1, 1) + 1)
END FUNCTION

FUNCTION MENU (OPT$(), VALID())

VCOL = 14
NCOL = 12
BCOL = 4
SBARCOL = 9

OPTIONS = UBOUND(OPT$)

MAX.LEN = 0

FOR A = 1 TO OPTIONS
IF LEN(OPT$(A)) > MAX.LEN THEN MAX.LEN = LEN(OPT$(A))
NEXT A

XWIDTH = (MAX.LEN + 2) * 8
YWIDTH = (OPTIONS + 2) * 8

DIM TMP(GET.SIZE(0, 0, XWIDTH, YWIDTH))
DIM SBAR(GET.SIZE(0, 0, MAX.LEN * 8, 7))
GET (0, 0)-(XWIDTH, YWIDTH), TMP
LINE (0, 0)-(MAX.LEN * 8, 7), SBARCOL, BF
GET (0, 0)-(MAX.LEN * 8, 7), SBAR

LINE (0, 0)-(XWIDTH, YWIDTH), 0, BF
BOX.BAR 0, 0, XWIDTH, YWIDTH, 4, 6, 1, 1
LINE (6, 6)-(XWIDTH - 7, YWIDTH - 7), BCOL, B
LINE (0, 0)-(XWIDTH, YWIDTH), BCOL, B

FOR A = 1 TO OPTIONS
IF VALID(A) THEN COLOR VCOL ELSE COLOR NCOL
LOCATE A + 1, 2: PRINT OPT$(A)
NEXT A

row = 1

DO
IF row < 1 THEN row = OPTIONS
IF row > OPTIONS THEN row = 1
PUT (8, (row * 8)), SBAR
DO

KP = UCASE$(INKEY$)

LOOP WHILE KP = ""

PUT (8, (row * 8)), SBAR:
SELECT CASE KP
CASE CHR$(27): row = 0: EXIT DO
CASE CHR$(13), "5", " ": IF VALID(row) THEN EXIT DO
CASE CHR$(0) + "H", "8": row = row - 1
CASE CHR$(0) + "P", "2": row = row + 1
CASE CHR$(0) + "K", "4": row = row - 1
CASE CHR$(0) + "M", "6": row = row + 1
END SELECT

LOOP

PUT (0, 0), TMP, PSET
MENU = row
END FUNCTION

SUB MESSAGE (M$, OK$)

L = LEN(M$)
MaxCol = 80
Col = MaxCol \ 2

C1 = ((Col - L / 2) - 2) + .5: C2 = C1 + (L + 3)

DIM TMP(1 TO GET.SIZE(((C1 - 1) * 8), (28 - 1) * 8, (C2 * 8), (34 - 1) * 8))
GET (((C1 - 1) * 8), (28 - 1) * 8)-((C2 * 8), (34 - 1) * 8), TMP
LINE (((C1 - 1) * 8), (28 - 1) * 8)-((C2 * 8) - 1, (34 - 1) * 8 - 1), 0, BF
BOX.BAR ((C1 - 1) * 8), (28 - 1) * 8, (C2 * 8), (34 - 1) * 8, 4, 6, 1, 1
COLOR 11
LOCATE 29, Col - L / 2 + .5: PRINT M$

LINE (((39 - 1) * 8), (30 - 1) * 8)-((43 - 1) * 8 - 1, 32 * 8 - 1), 2, BF
BOX.BAR ((39 - 1) * 8), (30 - 1) * 8, (43 - 1) * 8, 32 * 8, 6, 8, 1, 1
COLOR 14: LOCATE 31, 40: PRINT OK$

DO
KP = UCASE$(INKEY$)
LOOP UNTIL KP = CHR$(13)

BOX.BAR ((39 - 1) * 8), (30 - 1) * 8, (43 - 1) * 8, 32 * 8, 12, 14, 1, 1
COLOR 10: LOCATE 31, 40: PRINT OK$

MILLIDELAY 1000 / 4
PUT (((C1 - 1) * 8), (28 - 1) * 8), TMP, PSET

END SUB

SUB MIDDLE (row, Text$)
  MaxCol = 80
  Col = MaxCol \ 2
  LOCATE row, Col - (LEN(Text$) / 2 + .5)
  PRINT Text$;
END SUB

SUB MIDDLE2 (row, Text$)
  MaxCol = 40
  Col = MaxCol \ 2
  LOCATE row, Col - (LEN(Text$) / 2 + .5)
  PRINT Text$;
END SUB

SUB MILLIDELAY (msecs) STATIC

    IF sysfact& THEN                             'calc- system speed yet?
        IF msecs THEN                            'have to want a delay
            COUNT& = (sysfact& * msecs) \ -54    'calc- # of loops needed
            DO
                COUNT& = COUNT& + 1              'negative - add to get to 0
                IF COUNT& = z THEN EXIT DO       'when its 0 we're done
            LOOP UNTIL t2 = PEEK(&H6C)           'make it the same as below
        END IF
    ELSE                                         'calc- system speed
        DEF SEG = &H40                           'point to low memory
        t1 = PEEK(&H6C)                          'get tick count
        DO
            t2 = PEEK(&H6C)                      'get tick count
        LOOP UNTIL t2 <> t1                      'wait 'til its a new tick
        DO
            sysfact& = sysfact& + 1              'count number of loops
            IF sysfact& = z THEN EXIT DO         'make it the same as above
        LOOP UNTIL t2 <> PEEK(&H6C)              'wait 'til its a new tick
        t2 = 256                                 'prevent the above UNTIL
    END IF
END SUB

SUB SAVE.SCORES
ON ERROR GOTO BAD
F = FREEFILE
OPEN "DROIDS.DAT" FOR OUTPUT AS #F
FOR A = 1 TO 10
FOR B = 1 TO 10
WRITE #F, PERSON(A, B), SCORE(A, B)
NEXT B
NEXT A
CLOSE #F
END SUB

SUB SHOW (A, TX, TY)
X = (TX - 1) * 20: Y = (TY - 1) * 20
SELECT CASE A
CASE 0: LINE (X, Y)-(X + 19, Y + 19), 0, BF
CASE 1: PUT (X, Y), P1, PSET
CASE 2: PUT (X, Y), P2, PSET
CASE 3: PUT (X, Y), P3, PSET
CASE 4: PUT (X, Y), P4, PSET
CASE 5: PUT (X, Y), P5, PSET
'CASE 6: PUT (X, Y), P6, PSET
'CASE 7: PUT (X, Y), P7, PSET
'CASE 8: PUT (X, Y), P8, PSET
'CASE 9: PUT (X, Y), P9, PSET
CASE ELSE: LINE (X, Y)-(X + 19, Y + 19), 3, BF
END SELECT
END SUB

SUB SHOW.LEVEL
FOR Y = 10 TO 23
FOR X = 8 TO 24
SHOW LEVEL(X, Y), X, Y
NEXT X
NEXT Y
LINE (140, 179)-(480, 175), 12, BF
LINE (0, 0)-(139, 480), LEVEL, BF
LINE (481, 0)-(640, 480), LEVEL, BF
COLOR 10: MIDDLE 9, "Level" + STR$(LEVEL)
COLOR 9: MIDDLE 12, " Avoid the rocks and shoot the enemies!"
COLOR 11: MIDDLE 14, "Player 1: Arrow Keys move left & right"
COLOR 11: MIDDLE 15, "`Up' to Shoot"
IF PLAYERS > 1 THEN
COLOR 5: MIDDLE 17, "Player 2: `A' moves left, `D' moves right"
COLOR 5: MIDDLE 18, "`W' to Shoot"
END IF
END SUB

SUB SHOW.SCORES (L, H)
LINE (4.5 * 8, 4.5 * 8)-(34.5 * 8, 19.5 * 8), 0, BF
LINE (4.5 * 8, 4.5 * 8)-(34.5 * 8, 19.5 * 8), 14, B
COLOR 10: MIDDLE2 6, "   High Scores"
COLOR 11: MIDDLE2 7, "   Level" + STR$(L)
FOR A = 1 TO 10
COLOR 15
IF H THEN
FOR B = 1 TO PLAYERS
IF PERSON(L, A) = N(B) AND SCORE(L, A) = PS(B) THEN COLOR 12
NEXT B
END IF
SPACES = 29 - (LEN(PERSON(L, A)) + LEN(LTRIM$(STR$(SCORE(L, A)))))
LOCATE A + 8, 6: PRINT PERSON(L, A) + SPACE$(SPACES) + LTRIM$(STR$(SCORE(L, A)))
NEXT A
KP = INPUT$(1)
END SUB

SUB SORT.SCORES
FOR A = 1 TO 10
FOR B = 1 TO 9
FOR C = B + 1 TO 10
IF SCORE(A, B) < SCORE(A, C) THEN SWAP SCORE(A, B), SCORE(A, C): SWAP PERSON(A, B), PERSON(A, C)
NEXT C
NEXT B
NEXT A
END SUB

SUB TITLE
DIM TISC(32, 24)
RESTORE TS
FOR Y = 1 TO 24
FOR X = 1 TO 32
READ TISC(X, Y)
NEXT X
NEXT Y
DO
X = INT(RND * 32) + 1
Y = INT(RND * 24) + 1
IF TISC(X, Y) THEN SHOW INT(RND * 5) + 1, X, Y ELSE SHOW 6, X, Y
MILLIDELAY 5
KP = UCASE$(INKEY$)
LOOP WHILE KP = ""
FOR Y = 1 TO 24
FOR X = 1 TO 32
IF TISC(X, Y) THEN SHOW 6, X, Y ELSE SHOW INT(RND * 5) + 1, X, Y
NEXT X
NEXT Y
END SUB

SUB WIDE.BAR (X1, Y1, MIN.COL, COLOURS, H.OR.V, W, CS)

XP = X1: YP = Y1

SELECT CASE SGN(COLOURS - MIN.COL)
CASE -1
CSTEP1 = ((ABS(CS)) - (ABS(CS) * 2))
CSTEP2 = ABS(CS)
IF H.OR.V = 1 THEN XP = X1 + ((MIN.COL - COLOURS) + 1) ELSE YP = Y1 + ((MIN.COL - COLOURS) + 1)
CASE ELSE
CSTEP2 = ((ABS(CS)) - (ABS(CS) * 2))
CSTEP1 = ABS(CS)
IF H.OR.V = 1 THEN XP = X1 + ((COLOURS - MIN.COL) + 1) ELSE YP = Y1 + ((COLOURS - MIN.COL) + 1)
END SELECT

BAR X1, Y1, MIN.COL, COLOURS, H.OR.V, W, CSTEP1
BAR XP, YP, COLOURS, MIN.COL, H.OR.V, W, CSTEP2

END SUB

SUB WORD (PROMPT$, VAR$)
DIM TMP(GET.SIZE(0, 11 * 8, 39 * 8, 14 * 8))
GET (0, 11 * 8)-(39 * 8, 14 * 8), TMP
LINE (0, 11 * 8)-(39 * 8, 14 * 8), 0, BF
BOX.BAR 0, 11 * 8, 39 * 8, 14 * 8, 24, 26, 1, 1
COLOR 12: LOCATE 13, 2: PRINT PROMPT$; : COLOR 11: LINE INPUT VAR$
PUT (0, 11 * 8), TMP, PSET
END SUB

