DECLARE SUB load (f$)
DECLARE SUB save (f$)
DECLARE SUB Fillin ()
DECLARE SUB Grid ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseShow ()
DECLARE SUB MouseStatus (lb%, rb%, xmouse%, ymouse%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)

DEFINT A-Z

TYPE chore
    title AS STRING * 20
    week AS STRING * 7
END TYPE

DIM SHARED jb(7) AS chore
DIM SHARED jobs(7, 3, 31)
DIM SHARED dy$(6), mn$(3)
SCREEN 12

DIM SHARED mouse$

RESTORE
mouse$ = SPACE$(57)
FOR I% = 1 TO 57
  READ a$
  H$ = CHR$(VAL("&H" + a$))
  MID$(mouse$, I%, 1) = H$
NEXT I%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
CLS
MS% = MouseInit%
IF NOT MS% THEN
  PRINT "Mouse not found": LET AMOUSE$ = "NO":
END IF
LET AMOUSE$ = "YES"

jb(1).title = "Watch Niki         "
jb(1).week = "Ynnnnnn"
jb(2).title = "Dishes             "
jb(2).week = "nYnnnYY"
jb(3).title = "1st Bathroom       "
jb(3).week = "nnYnnnn"
jb(4).title = "Clean Living Room  "
jb(4).week = "nnnYnnn"
jb(5).title = "Repair Somthing"
jb(5).week = "nnnnYnn"
jb(6).title = "Clean Room         "
jb(6).week = "YYYYYYY"
jb(7).title = "Watch little kids  "
jb(7).week = "YYYYYYY"
dy$(0) = "Sunday"
dy$(1) = "Monday"
dy$(2) = "Tuesday"
dy$(3) = "Wednesday"
dy$(4) = "Thursday"
dy$(5) = "Friday"
dy$(6) = "Saturday"
mn$(1) = "March"
mn$(2) = "April"
mn$(3) = "May"
SCREEN 12
CLS
load "tim.dat"
CALL Grid
CALL Fillin
CALL MouseShow
DO
CALL MouseStatus(lb, rb, mx, my)
ok = 0
IF lb = -1 OR rb = -1 THEN
IF my \ 16 = 0 THEN ok = 1
y = my \ 16
d = (((mx - 4) / 8) - 16) / 2
IF y > 0 AND d > 0 AND d < 32 AND y < 29 THEN
j = ((y - 1) \ 4) + 1
m = (y - 1) MOD 4
IF m = 2 AND d = 31 THEN m = 0
IF m > 0 THEN
IF lb = -1 THEN jobs(j, m, d) = 1 ELSE jobs(j, m, d) = 0
SOUND 100, .1: SOUND 200, .1: SOUND 300, .1: SOUND 400, .2: SOUND 600, .1: SOUND 800, .3
CALL MouseHide
x = (d * 2 + 16) * 8 + 5
y = j * 64 + m * 16 - 32 - 8
C = 0
IF jobs(j, m, d) = 1 THEN C = 5
PAINT (x + 4, y), C, 15
IF POINT(x, y) = 15 THEN
CIRCLE (x, y), 1, 15: CIRCLE (x + 1, y), 1, 15
CIRCLE (x, y), 4, 8: CIRCLE (x + 1, y), 4, 8
CIRCLE (x, y), 3, 4: CIRCLE (x + 1, y), 3, 4
CIRCLE (x, y), 2, 12: CIRCLE (x + 1, y), 2, 12
END IF
d$ = DATE$: mn = VAL(LEFT$(d$, 2)) - 2: dy = VAL(MID$(d$, 4, 2)): IF mn = m AND dy = d THEN CIRCLE (x, y), 3, 1: CIRCLE (x, y), 4, 2
CALL MouseShow
END IF
END IF
END IF
pl = (pl + 1) MOD 64
PALETTE 1, pl
PALETTE 2, (32 + pl) MOD 64
LOOP WHILE ok = 0
save "tim.dat"
SHELL "diskpark"

SUB Fillin
week = -1
FOR m = 1 TO 3
mk = 31
IF m = 2 THEN mk = 30
FOR d = 1 TO mk
week = week + 1
FOR j = 1 TO 7
x = (d * 2 + 16) * 8 + 5
y = j * 64 + m * 16 - 32 - 8
C = 0
IF jobs(j, m, d) <> 0 THEN C = 5
PAINT (x, y), C, 15
dy = (week MOD 7) + 1
IF MID$(jb(j).week, dy, 1) = "Y" THEN
CIRCLE (x, y), 1, 15: CIRCLE (x + 1, y), 1, 15
CIRCLE (x, y), 4, 8: CIRCLE (x + 1, y), 4, 8
CIRCLE (x, y), 3, 4: CIRCLE (x + 1, y), 3, 4
CIRCLE (x, y), 2, 12: CIRCLE (x + 1, y), 2, 12
END IF
d$ = DATE$
mn = VAL(LEFT$(d$, 2)) - 2
dy = VAL(MID$(d$, 4, 2))
IF mn = m AND dy = d THEN CIRCLE (x, y), 3, 1: CIRCLE (x, y), 4, 2
NEXT j
NEXT d
NEXT m
END SUB

SUB Grid
FOR y = 1 TO 30
IF y < 29 THEN
d = ((y - 1) MOD 4)
LOCATE y + 1, 1
IF d > 0 THEN COLOR d + 8: PRINT mn$(d);
IF d = 0 THEN COLOR 15: PRINT jb(y \ 4 + 1).title;
END IF
LINE (0, y * 16)-(640, y * 16), 15
NEXT y
y = y - 2
FOR x = 1 TO 40
COLOR 12 + (x MOD 2)
IF x < 32 THEN LOCATE 1, x * 2 + 17: PRINT MID$(STR$(x) + " ", 2, 2)
IF x < 32 THEN LOCATE 30, x * 2 + 17: PRINT MID$(STR$(x) + " ", 2, 2);
LINE ((x * 2 + 16) * 8 - 1, 0)-((x * 2 + 16) * 8 - 1, 480), 15
NEXT x
LINE (0, y * 16)-(640, y * 16), 15
END SUB

SUB load (f$)
OPEN f$ FOR INPUT AS #1
FOR m = 1 TO 3
FOR d = 1 TO 31
INPUT #1, jobs(1, m, d), jobs(2, m, d), jobs(3, m, d), jobs(4, m, d), jobs(5, m, d), jobs(6, m, d), jobs(7, m, d)
NEXT d
NEXT m
CLOSE #1
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

SUB Mouseput
  AX% = 4
  CX% = x%
  DX% = y%
  MouseDriver AX%, 0, CX%, DX%

END SUB

SUB MouseShow
  AX% = 1
  MouseDriver AX%, 0, 0, 0

END SUB

SUB MouseStatus (lb%, rb%, xmouse%, ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xmouse% = CX%
  ymouse% = DX%
END SUB

DEFINT A-Z
SUB save (f$)
OPEN f$ FOR OUTPUT AS #1
FOR m = 1 TO 3
FOR d = 1 TO 31
WRITE #1, jobs(1, m, d), jobs(2, m, d), jobs(3, m, d), jobs(4, m, d), jobs(5, m, d), jobs(6, m, d), jobs(7, m, d)
NEXT d
NEXT m
CLOSE #1
END SUB

