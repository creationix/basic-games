DECLARE SUB load ()
DECLARE SUB save ()
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE SUB mousestatus (lb%, rb%, xmouse%, ymouse%)

DEFINT A-Z
SCREEN 12

DIM SHARED mouse$

GOSUB mouse
MouseShow
load
FOR A = 1 TO 2
FOR Y = 1 TO 398
FOR X = 1 TO 638
IF POINT(X, Y) = 1 AND POINT(X, Y + 1) <> 1 THEN PSET (X, Y), 15
IF POINT(X, Y) = 1 AND POINT(X + 1, Y) <> 1 THEN PSET (X, Y), 7
NEXT X
NEXT Y
FOR Y = 398 TO 1 STEP -1
FOR X = 638 TO 1 STEP -1
IF POINT(X, Y) = 1 AND POINT(X, Y - 1) <> 1 THEN PSET (X, Y), 0
IF POINT(X, Y) = 1 AND POINT(X - 1, Y) <> 1 THEN PSET (X, Y), 8
NEXT X
NEXT Y
BEEP
NEXT A
BEEP: BEEP: BEEP: BEEP
pic = 1
DO
A$ = INKEY$
IF A$ = "1" THEN pic = 1
IF A$ = "2" THEN pic = 2
IF A$ = "3" THEN pic = 3
IF A$ = "4" THEN pic = 4
IF A$ = "5" THEN pic = 5
mousestatus lb, rb, X, Y
IF lb THEN
IF pic = 1 THEN RESTORE pic1
IF pic = 2 THEN RESTORE pic2
IF pic = 3 THEN RESTORE pic3
IF pic = 4 THEN RESTORE pic4
IF pic = 5 THEN RESTORE pic5
MouseHide
FOR sy = 1 TO 10
FOR sx = 1 TO 10
READ c: IF c > 0 THEN PSET (sx + X - 5, sy + Y - 5), c
NEXT sx
NEXT sy
MouseShow
END IF
LOOP WHILE NOT rb
save
MouseHide
END






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
  PRINT "Mouse not found": LET AMOUSE$ = "NO":
  PRINT "This Game Won't Run Without Mouse"
  END
END IF
LET AMOUSE$ = "YES"
RETURN

DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00

pic1:
DATA 0,0,0,0,7,7,0,0,0,0
DATA 0,0,0,7,2,2,7,0,0,0
DATA 0,0,7,2,2,2,2,7,0,0
DATA 0,0,0,7,2,6,7,0,0,0
DATA 0,0,7,2,6,2,2,7,0,0
DATA 0,7,2,2,2,2,2,2,7,0
DATA 0,0,7,6,2,6,6,7,0,0
DATA 0,7,2,6,2,2,2,2,7,0
DATA 7,2,2,2,6,6,2,2,2,7
DATA 0,8,8,8,6,6,8,8,8,8
pic2:
DATA 0,0,0,0,7,0,0,0,0,0
DATA 0,0,0,7,6,7,0,0,0,0
DATA 0,0,7,6,6,6,7,0,0,0
DATA 0,7,6,6,0,6,6,7,0,0
DATA 7,6,6,8,8,8,6,7,7,0
DATA 7,6,6,8,0,0,7,6,6,7
DATA 7,6,6,8,0,7,6,6,6,6
DATA 6,6,8,0,7,7,6,8,8,6
DATA 6,8,0,7,6,6,7,0,0,8
DATA 8,0,7,6,8,8,6,7,0,0
pic3:

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,1,1,0,0,0,0
DATA 0,0,0,1,1,1,1,0,0,0
DATA 0,0,1,1,1,1,1,1,0,0
DATA 0,1,1,1,1,1,1,1,1,0
DATA 0,1,1,1,1,1,1,1,1,0
DATA 0,0,1,1,1,1,1,1,0,0
DATA 0,0,0,1,1,1,1,0,0,0
DATA 0,0,0,0,1,1,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
pic4:

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
pic5:

DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0

SUB load
MouseHide
DIM tmp%(32000)
DEF SEG = VARSEG(tmp%(0))
BLOAD "map0.gfx", 0: PUT (0, 0), tmp%, PSET
BLOAD "map1.gfx", 0: PUT (320, 0), tmp%, PSET
BLOAD "map2.gfx", 0: PUT (0, 200), tmp%, PSET
BLOAD "map3.gfx", 0: PUT (320, 200), tmp%, PSET
DEF SEG
MouseShow
END SUB

DEFSNG A-Z
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

SUB MouseShow
  AX% = 1
  MouseDriver AX%, 0, 0, 0

END SUB

SUB mousestatus (lb%, rb%, xmouse%, ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xmouse% = CX%
  ymouse% = DX%
END SUB

DEFINT A-Z
SUB save
MouseHide
DIM tmp%(32000)
DEF SEG = VARSEG(tmp%(0))
GET (0, 0)-(319, 199), tmp%: BSAVE "map0.gfx", 0, 32000
GET (320, 0)-(639, 199), tmp%: BSAVE "map1.gfx", 0, 32000
GET (0, 200)-(319, 399), tmp%: BSAVE "map2.gfx", 0, 32000
GET (320, 200)-(639, 399), tmp%: BSAVE "map3.gfx", 0, 32000
DEF SEG
MouseShow
END SUB

