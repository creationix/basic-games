DECLARE SUB texture (x1%, y1%, x2%, y2%, x3%, y3%, x4%, y4%, file$)
DECLARE SUB font (x%, y%, text$, col1%, col2%)
DECLARE SUB colorpalette (file$)
DECLARE SUB negative (x1%, y1%, x2%, y2%)
DECLARE SUB antialias (x1%, y1%, x2%, y2%)
DECLARE SUB fliphoriz (x1%, y1%, x2%, y2%)
DECLARE SUB flipvert (x1%, y1%, x2%, y2%)
DECLARE SUB fade (x1%, y1%, x2%, y2%, f%)
DECLARE SUB grayscale (x1%, y1%, x2%, y2%)
SCREEN 13
colorpalette "rpg"
ini
DEFINT A-Y
zpi = 3.14 / 180
RANDOMIZE (TIMER)
DIM Tmp%(32000), tp%(1000)
DIM s(6, 210), o(200, 10), n(6, 10), l(33, 21)
DIM money AS INTEGER
DIM n$(6)
DIM s$(12)
DIM o$(200)
kx = 9: ky = 9
money = 1000
'screen 7 'Must be 13
FOR A = 1 TO 5
PALETTE A, A + 8
NEXT A
PALETTE 7, 15
PALETTE 8, 7
PALETTE 9, 8
CLS
SCREEN , , 0, 0
FOR A = 1 TO 300
x = 320 * RND: y = 200 * RND: LINE (x - 20, y - 20)-(x + 20, y + 20), 7: LINE (x - 20, y - 20 + 1)-(x + 20, y + 20 + 1), 8: LINE (x - 20, y - 20 + 2)-(x + 20, y + 20 + 2), 9
SOUND 200 + A, .1: SOUND 1000, .1: SOUND 800 - A, .1: SOUND 1000, .1
IF INKEY$ = " " THEN A = 300
NEXT A
LOCATE 13, 15: PRINT "QUEST LAND"
PLAY "MBo2 t80 l8 a o3 d f l4 e  l8 f l4 d"
OPEN "questlnd.001" FOR INPUT AS #1
spec = 0
FOR y = 1 TO 20
INPUT #1, l$
FOR x = 1 TO 32
l = ASC(MID$(l$, x, 1)) - 100
l(x, y) = l
IF l = 7 THEN spec = spec + 1: l = -spec
NEXT x
NEXT y
DIM sp$(spec, 5), sp(spec, 20)
FOR sp = 1 TO spec
FOR A = 1 TO 5
READ sp$(spec, A)
NEXT A
FOR A = 1 TO 20
READ sp(spec, A)
NEXT A
NEXT sp
CLOSE #1
OPEN "questlnd.itm" FOR INPUT AS #1
itm = 0
cr = 1
DO
itm = itm + 1
INPUT #1, n$
IF n$ <> "END" THEN
o$(itm) = n$
FOR A = 1 TO 10
INPUT #1, o(itm, A)
NEXT A
ELSE cr = 0
END IF
LOOP WHILE cr = 1
CLOSE #1
FOR A = 1 TO 6
READ n$(A)
p = 60
FOR B = 1 TO 5
DO
U = INT(10 * RND + 5)
LOOP WHILE U > p
p = p - U
U = U + 1
IF B = 1 THEN U = U * 10
IF B = 3 THEN U = U * 5
n(A, B) = U
NEXT B
n(A, 6) = p
n(A, 7) = n(A, 1)
n(A, 8) = n(A, 3)
n(A, 9) = A
n(A, 10) = A
NEXT A
DATA "Keldor"
DATA "Lucas"
DATA "Meldrion"
DATA "Jade"
DATA "BlackEye"
DATA "McRocker"
FOR A = 1 TO 12
READ s$(A)
NEXT A
DATA "Poisin"
DATA "Stone"
DATA "Insanity"
DATA "Charm"
DATA "Explosion1"
DATA "Explosion2"
DATA "Explosion3"
DATA "Sleep"
DATA "Make Sane"
DATA "Awake"
DATA "Heal Other"
DATA "Heal Self"
SCREEN , , 7, 0
LINE (0, 0)-(319, 20), 1, B
c1 = 7: c2 = 8: c3 = 4: c4 = 1
COLOR c1
LINE (0, 21)-(159, 199), 4, B
LINE (160, 21)-(319, 50), 2, B
LINE (160, 51)-(319, 150), 3, B
LINE (160, 151)-(319, 199), 14, B
LOCATE 2, 12: PRINT "--The Trading Post--"
CIRCLE (90, 50), 10, , 270 * zpi, 180 * zpi, 1
CIRCLE (70, 150), 10, , 90 * zpi, 360 * zpi, 1
CIRCLE (50, 50), 10, , 90 * zpi, 180 * zpi, 1
CIRCLE (30, 150), 10, , 90 * zpi, 270 * zpi, 1
LINE (80, 50)-(80, 150)
LINE (40, 50)-(40, 140)
LINE (50, 40)-(90, 40)
LINE (90, 60)-(80, 60)
LINE (70, 140)-(30, 140)
LINE (70, 160)-(30, 160)
COLOR 7
LOCATE 4, 22: PRINT "____________"
COLOR 2
LOCATE 6, 22: PRINT "Cost _______"
LOCATE 9, 22: PRINT "Name"
COLOR 1
LOCATE 11, 22: PRINT "A"
LOCATE 12, 22: PRINT "B"
LOCATE 13, 22: PRINT "C"
LOCATE 14, 22: PRINT "E"
LOCATE 15, 22: PRINT "D"
LOCATE 16, 22: PRINT "F"
COLOR 2
LOCATE 18, 22: PRINT "MONEY"
FOR x = 85 TO 255
FOR y = 7 TO 16
IF POINT(x, y) = 0 THEN IF POINT(x + 1, y) = c1 OR POINT(x - 1, y) = c1 OR POINT(x, y - 1) = c1 OR POINT(x, y + 1) = c1 THEN PSET (x, y), c2
IF POINT(x, y) = 0 THEN IF POINT(x + 1, y) = c2 OR POINT(x - 1, y) = c2 OR POINT(x, y - 1) = c2 OR POINT(x, y + 1) = c2 THEN PSET (x, y), c3
IF POINT(x, y) = 0 THEN IF POINT(x + 1, y) = c3 OR POINT(x - 1, y) = c3 OR POINT(x, y - 1) = c3 OR POINT(x, y + 1) = c3 THEN PSET (x, y), c4
NEXT y
NEXT x
SCREEN , , 6, 0
c1 = 4: c2 = 2
LOCATE 2, 2: COLOR c1: PRINT "Quest Land"
DIM C(92 - 8, 12)
FOR x = 7 TO 97 - 8 STEP 1
FOR y = 7 TO 17 STEP 1
IF POINT(x, y) = 0 THEN IF POINT(x - 1, y) = c1 OR POINT(x + 1, y) = c1 OR POINT(x, y - 1) = c1 OR POINT(x, y + 1) = c1 THEN PSET (x, y), c2
C = POINT(x, y)
C(x - 6, y - 6) = C
NEXT y
NEXT x
CLS
FOR A = 0 TO 100
C = A / 100 * 6 + 1
LINE (A, 100)-(160, 100 - A), C
LINE (320 - A, 100)-(160, 100 + A), C
LINE (A, 100)-(160, 100 + A), C
LINE (320 - A, 100)-(160, 100 - A), C
NEXT A
sy = 10: sx = 40
FOR x = 1 TO 91 - 8 STEP 1
FOR y = 1 TO 11 STEP 1
C = C(x, y)
IF C > 0 THEN
PSET (x * 3 - 2 + sx, y * 3 - 2 + sy), C
PSET (x * 3 - 3 + sx, y * 3 - 3 + sy), (C(x - 1, y - 1) + C) / 2
PSET (x * 3 - 3 + sx, y * 3 - 1 + sy), (C(x - 1, y + 1) + C) / 2
PSET (x * 3 - 1 + sx, y * 3 - 1 + sy), (C(x + 1, y + 1) + C) / 2
PSET (x * 3 - 1 + sx, y * 3 - 3 + sy), (C(x + 1, y - 1) + C) / 2
PSET (x * 3 - 3 + sx, y * 3 - 2 + sy), (C(x - 1, y) + C) / 2
PSET (x * 3 - 1 + sx, y * 3 - 2 + sy), (C(x + 1, y) + C) / 2
PSET (x * 3 - 2 + sx, y * 3 - 3 + sy), (C(x, y - 1) + C) / 2
PSET (x * 3 - 2 + sx, y * 3 - 1 + sy), (C(x, y + 1) + C) / 2
END IF
NEXT y
NEXT x
FOR A = 0 TO 50 STEP 10
LINE (50 + A, 50 + A)-(320 - 50 - A, 200 - 50 - A), A / 10 + 1, B
NEXT A
COLOR 5
LOCATE 8, 16: PRINT "Main Menu"
COLOR 2:
LOCATE 10, 10: PRINT "1-Load Game"
LOCATE 12, 10: PRINT "2-Save & Resume"
LOCATE 14, 10: PRINT "3-Quit Game"
LOCATE 16, 10: PRINT "4-New"
SCREEN , , 5, 0
LINE (0, 21)-(165, 107), 14, B
LINE (0, 0)-(319, 20), 1, B
IF POINT(x, y) = 0 THEN IF POINT(x + 1, y) = 9 OR POINT(x - 1, y) = 9 OR POINT(x, y - 1) = 9 OR POINT(x, y + 1) = 9 THEN PSET (x, y), 4
LINE (166, 21)-(319, 107), 5, B
LINE (0, 108)-(319, 199), 3, B
COLOR 9
LOCATE 2, 12: PRINT "Character Generation"
FOR x = 85 TO 255
FOR y = 7 TO 16
IF POINT(x, y) = 0 THEN IF POINT(x + 1, y) = 9 OR POINT(x - 1, y) = 9 OR POINT(x, y - 1) = 9 OR POINT(x, y + 1) = 9 THEN PSET (x, y), 4
NEXT y
NEXT x
COLOR 5
LOCATE 4, 2: PRINT "Name ____________"
COLOR 2
LOCATE 6, 2: PRINT "1 Hit Points..___"
LOCATE 7, 2: PRINT "2 Speed.......___"
LOCATE 8, 2: PRINT "3 Magic.......___"
LOCATE 9, 2: PRINT "4 Strength....___"
LOCATE 10, 2: PRINT "5 Lock Pick...___"
LOCATE 11, 2: PRINT "6 Defence.....___"
COLOR 1
LOCATE 13, 2: PRINT "(1-6) Edit Item"
FOR A = 2 TO 31
FOR B = 13 TO 19
C = 1
IF A / 2 = INT(A / 2) THEN C = -C
IF B / 2 = INT(B / 2) THEN C = -C
IF C = -1 THEN C = 4 ELSE C = 14
LINE (A * 10 - 10, B * 10 - 10)-(A * 10 - 1, B * 10 - 1), C, B
NEXT B
NEXT A
COLOR 3
LOCATE 4, 27: PRINT "Commands"
COLOR 14: LOCATE 6, 23: PRINT "R"; : COLOR 8: PRINT "eroll"
COLOR 14: LOCATE 7, 23: PRINT "A"; : COLOR 8: PRINT "dd"
COLOR 14: LOCATE 8, 23: PRINT "S"; : COLOR 8: PRINT "ubtract"
COLOR 14: LOCATE 9, 23: PRINT "N"; : COLOR 8: PRINT "ame"
COLOR 14: LOCATE 10, 23: PRINT "E"; : COLOR 8: PRINT "xit"
COLOR 14: LOCATE 11, 23: PRINT "K"; : COLOR 8: PRINT "eep"
SCREEN , , 4, 0
LINE (0, 0)-(319, 99), 1, B
LINE (0, 100)-(319, 199), 2, B
COLOR 3: LOCATE 2, 2: PRINT "Name ____________"
COLOR 5
LOCATE 4, 2: PRINT "Hit Points..___"
LOCATE 5, 2: PRINT "Speed.......___"
LOCATE 6, 2: PRINT "Magic.......___"
LOCATE 7, 2: PRINT "Strength....___"
LOCATE 8, 2: PRINT "Lock Pick...___"
LOCATE 9, 2: PRINT "Defence.....___"
COLOR 2
LOCATE 11, 2: PRINT "Money _____"
COLOR 4: LOCATE 2, 20: PRINT "Object ____________"
COLOR 1
FOR A = 4 TO 11
LOCATE A, 20: PRINT "..........__________"
NEXT A
COLOR 2
LOCATE 12, 20: PRINT "Cost......_____"
COLOR 14: LOCATE 14, 16: PRINT "Inventory"
FOR A = 2 TO 31
FOR B = 13 TO 19
C = 1
IF A / 2 = INT(A / 2) THEN C = -C
IF B / 2 = INT(B / 2) THEN C = -C
LINE (A * 10 - 10, B * 10 - 10)-(A * 10 - 1, B * 10 - 1), C + 2, B
NEXT B
NEXT A
SCREEN , , 3, 0
FOR x = 1 TO 16
FOR y = 1 TO 20
T = 1
IF x / 2 = INT(x / 2) THEN T = -T
IF y / 2 = INT(y / 2) THEN T = -T
IF T = 1 THEN LINE (x * 10 - 10, y * 10 - 10)-(x * 10 - 1, y * 10 - 1), 8, B
IF T = -1 THEN LINE (x * 10 - 10, y * 10 - 10)-(x * 10 - 1, y * 10 - 1), 9, B
NEXT y
NEXT x
LINE (160, 0)-(319, 99), 1, B
LINE (160, 100)-(319, 163), 2, B
LINE (160, 164)-(319, 199), 4, B
LOCATE 2, 26: COLOR 2: PRINT "Quest Land"
COLOR 5: LOCATE 3, 22: PRINT "# Name         HP"
COLOR 1
LOCATE 5, 22: PRINT "A"
LOCATE 6, 22: PRINT "B"
LOCATE 7, 22: PRINT "C"
LOCATE 8, 22: PRINT "D"
LOCATE 9, 22: PRINT "E"
LOCATE 10, 22: PRINT "F"
COLOR 4: LOCATE 12, 22: PRINT "(A-F) Chose"
COLOR 1: LOCATE 14, 27: PRINT "Tactics"
COLOR 2
LOCATE 16, 22: PRINT "1"
LOCATE 17, 22: PRINT "2"
LOCATE 18, 22: PRINT "3"
LOCATE 19, 22: PRINT "4"
LOCATE 20, 22: PRINT "5"
COLOR 4
LOCATE 16, 24: PRINT "Attack"
LOCATE 17, 24: PRINT "Shoot"
LOCATE 18, 24: PRINT "Equip"
LOCATE 19, 24: PRINT "Cast"
LOCATE 20, 24: PRINT "Move"
COLOR 1: LOCATE 22, 27: PRINT "Mesages"
SCREEN , , 2, 0
WINDOW SCREEN (-.5, -1)-(1.5, 1)
FOR ay = 0 TO 5
zy1 = (1) / 2 ^ ay
zy2 = zy1 / 2
LINE (-2, zy1)-(2, zy1), 1
'LINE (-2, -ZY1)-(2, -ZY1), 1
FOR ax = (-2 ^ (ay + 1) + 1) TO (2 ^ (ay + 1) - 1) STEP 2
zx2 = ax / 2 ^ (ay + 1)
zx3 = ax / 2 ^ (ay + 2)
'LINE (ZX2, ZY1)-(ZX2, -ZY1), 1
LINE (zx2, zy1)-(zx3, zy2), 1
'LINE (ZX2, -ZY1)-(ZX3, -ZY2), 1
NEXT ax
NEXT ay
WINDOW SCREEN (0, 0)-(319, 199)
LINE (0, 99)-(160, 101), 1, BF
LINE (160, 0)-(319, 199), 0, BF
LINE (160, 0)-(319, 99), 7, B
LINE (160, 100)-(319, 199), 4, B
LOCATE 2, 26: COLOR 2: PRINT "Quest Land"
COLOR 5: LOCATE 3, 22: PRINT "# Name         HP"
COLOR 1
LOCATE 5, 22: PRINT "A"
LOCATE 6, 22: PRINT "B"
LOCATE 7, 22: PRINT "C"
LOCATE 8, 22: PRINT "D"
LOCATE 9, 22: PRINT "E"
LOCATE 10, 22: PRINT "F"
COLOR 4: LOCATE 12, 22: PRINT "(A-F) Inventory"
COLOR 1: LOCATE 14, 27: PRINT "Messages"
PLAY "MBo2 t80 l8 a o3 d f l4 e  l8 f l4 d"
SCREEN , , 1, 0
FOR y = 0 TO 9
FOR x = 100 TO 109
READ C
PSET (x, y), C
NEXT x
NEXT y
DATA 7,7,7,7,7,7,7,7,7,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,0,0,0,0,0,0,0,0,7
DATA 7,7,7,7,7,7,7,7,7,7
GOTO SKIP5
OPEN "QUESTLND.PIC" FOR INPUT AS #1
FOR n = 1 TO 7
FOR y = 0 TO 199
FOR x = 1 TO 10
INPUT #1, C
IF C > 0 THEN PSET (x + n * 10 - 10, y), C
NEXT x
NEXT y
NEXT n
CLOSE #1
SKIP5:
'FOR Y = 0 TO 99
'FOR X = 0 TO 9
'READ c
'IF c = 8 THEN
'PSET (X + 70, Y), 1
'PSET (X + 70, Y + 100), 2
'PSET (X + 80, Y), 3
'PSET (X + 80, Y + 100), 4
'PSET (X + 90, Y), 5
'PSET (X + 90, Y + 100), 6
'PSET (X + 100, Y), 7
'PSET (X + 100, Y + 100), 8
'END IF
'NEXT X
'NEXT Y
menu:
sc = 6: GOSUB fscreen
DO
A$ = INKEY$:
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF A$ = "1" THEN GOSUB load
IF A$ = CHR$(0) + "P" OR A$ = "2" THEN GOSUB save
IF A$ = "3" THEN RUN "\tim\menu.bas"
IF A$ = CHR$(0) + "K" OR A$ = "4" THEN GOSUB create:
LOOP
load: RETURN
save: GOTO go:
create:
opl = 0: pl = 1
DO
GOSUB fix5
opl = pl: DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "q" THEN CHDIR "\TIM": RUN "TIM"
IF A$ = CHR$(0) + "M" OR A$ = "6" THEN pl = pl + 1
IF A$ = CHR$(0) + "K" OR A$ = "4" THEN pl = pl - 1
IF pl < 1 THEN pl = 6
IF pl > 6 THEN pl = 1
IF A$ = "R" OR A$ = "r" THEN GOSUB reroll:
IF A$ = "A" OR A$ = "a" THEN GOSUB add:
IF A$ = "S" OR A$ = "s" THEN GOSUB subtract:
IF A$ = "N" OR A$ = "n" THEN GOSUB NME:
IF A$ = "E" OR A$ = "e" THEN sc = 6: GOSUB fscreen: RETURN
IF A$ = "K" OR A$ = "k" THEN GOTO go:
LOOP
reroll:
p = 60
FOR B = 1 TO 5
DO
U = INT(10 * RND + 5)
LOOP WHILE U > p
p = p - U
U = U + 1 + 2 * RND
IF B = 1 THEN U = U * 10
IF B = 3 THEN U = U * 5
n(pl, B) = U
NEXT B
n(pl, 6) = p
n(pl, 7) = n(pl, 1)
n(pl, 8) = n(pl, 3)
RETURN
add: RETURN
subtract: RETURN
NME:
COLOR 5: LOCATE 4, 2: PRINT "Name ____________"
LOCATE 4, 2: INPUT "Name"; n$
n$(pl) = n$
RETURN
fix5:
sc = 5: GOSUB fscreen
LOCATE 4, 7: COLOR 5: PRINT n$(pl)
FOR A = 1 TO 6
LOCATE 5 + A, 16: COLOR 2: PRINT n(pl, A)
NEXT A
RETURN
go:
sc = 2: GOSUB fscreen
okd = -1
DO
GOSUB fix2
IF okx <> kx OR oky <> ky OR okd <> kd THEN GOSUB fix3d
DO: A$ = INKEY$: LOOP WHILE A$ = ""
okd = kd: okx = kx: oky = ky
IF A$ = "q" OR A$ = "Q" THEN sc = 6: GOSUB fscreen: RETURN
IF A$ = "a" OR A$ = "A" THEN pl = 1: GOTO inventory:
IF A$ = "b" OR A$ = "B" THEN pl = 2: GOTO inventory:
IF A$ = "c" OR A$ = "C" THEN pl = 3: GOTO inventory:
IF A$ = "d" OR A$ = "D" THEN pl = 4: GOTO inventory:
IF A$ = "e" OR A$ = "E" THEN pl = 5: GOTO inventory:
IF A$ = "f" OR A$ = "F" THEN pl = 6: GOTO inventory:
f = 0
IF A$ = CHR$(0) + "H" OR A$ = "8" THEN f = 1
IF A$ = CHR$(0) + "P" OR A$ = "2" THEN f = -1
IF A$ = CHR$(0) + "K" OR A$ = "4" THEN kd = kd - 1
IF A$ = CHR$(0) + "M" OR A$ = "6" THEN kd = kd + 1
IF kd < 1 THEN kd = 4
IF kd > 4 THEN kd = 1
IF kd = 1 THEN ky = ky - f
IF kd = 2 THEN kx = kx + f
IF kd = 3 THEN ky = ky + f
IF kd = 4 THEN kx = kx - f
IF l(kx, ky) = 1 THEN kx = okx: ky = oky: FOR A = 1 TO 10: SOUND 100 + A * 10, .1: SOUND 100, 0: NEXT A
LOOP
fix3d:
SCREEN , , 1, 1
VIEW SCREEN (160, 0)-(319, 199), 0, 1
LINE (160, 100)-(320, 200), 2, BF

WINDOW SCREEN (-150, -100)-(50, 100)
FOR ay = 3 TO 0 STEP -1
SOUND 100 + ay * 100, .1: SOUND 1000 - ay * 100, .1
zy1 = (1) / 2 ^ ay
zy2 = zy1 / 2
p1 = -ay - 1
p2 = ay + 1
IF p1 < -2 THEN p1 = -2
IF p2 > 2 THEN p2 = 2
FOR G = 1 TO 2
FOR ax = p1 TO p2
zx1 = (ax * 2 - 1) / 2 ^ (ay + 1) * 100
zx2 = (ax * 2 + 1) / 2 ^ (ay + 1) * 100
zx3 = (ax * 2 - 1) / 2 ^ (ay + 2) * 100
zx4 = (ax * 2 + 1) / 2 ^ (ay + 2) * 100
texture CINT(zx1), CINT(y1), CINT(zx2), CINT(y1), CINT(zx3), CINT(y2), CINT(zx4), CINT(y2), "brick"
NEXT ax
NEXT G
NEXT ay
WINDOW SCREEN (0, 0)-(319, 199)
GET (160, 0)-(319, 199), Tmp%
SCREEN , , 0, 0
VIEW SCREEN (0, 0)-(159, 199)
PUT (0, 0), Tmp%, PSET
'BEEP
RETURN
fix2:
COLOR 1
FOR A = 1 TO 6
LOCATE 4 + A, 24
PRINT n$(A)
n = n(A, 7)
GOSUB ntos
LOCATE 4 + A, 37: PRINT LEFT$(n$ + "   ", 3)
NEXT A
RETURN
inventory:
sc = 4: GOSUB fscreen
DO
GOSUB FIX4
IF x < 1 THEN x = 30
IF x > 30 THEN x = 1
IF y < 1 THEN y = 7
IF y > 7 THEN y = 1
DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "q" OR A$ = "Q" THEN GOTO go
ox = x: oy = y
IF A$ = CHR$(0) + "H" OR A$ = "8" THEN y = y - 1
IF A$ = CHR$(0) + "P" OR A$ = "2" THEN y = y + 1
IF A$ = CHR$(0) + "K" OR A$ = "4" THEN x = x - 1
IF A$ = CHR$(0) + "M" OR A$ = "6" THEN x = x + 1
IF x < 1 THEN x = 30
IF x > 30 THEN x = 1
IF y < 1 THEN y = 7
IF y > 7 THEN y = 1
i = s(pl, ox + (oy - 1) * 30)
ty = o(i, 1)
IF A$ = " " AND i > 0 AND ty > 0 THEN
COLOR 4
LOCATE 2, 27: PRINT LEFT$(o$(i) + "____________", 13)
LOCATE 12, 30: COLOR 2: n = o(i, 10): GOSUB ntos: PRINT LEFT$(n$ + "_____", 5)
COLOR 1
IF ty = 1 THEN LOCATE 4, 20: PRINT "Sword Type          "
IF ty = 2 THEN LOCATE 4, 20: PRINT "Bow Type            "
IF ty = 3 THEN LOCATE 4, 20: PRINT "Arrow Type          "
IF ty = 4 THEN LOCATE 4, 20: PRINT "Spell Type          "
IF ty = 5 THEN LOCATE 4, 20: PRINT "Armor Type          "
IF ty = 6 THEN LOCATE 4, 20: PRINT "Misc Type           "
IF ty = 5 THEN LOCATE 5, 20: PRINT "+Head....."; :
IF ty >= 1 AND ty <= 4 THEN LOCATE 5, 20: PRINT "Damage....";
IF ty < 6 THEN n = o(i, 2): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
IF ty >= 2 AND ty <= 4 THEN LOCATE 6, 20: PRINT "Range....."; : n = o(i, 3): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
IF ty = 2 OR ty = 3 THEN LOCATE 7, 20: PRINT "Type......"; : n = o(i, 4): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
IF ty = 4 THEN LOCATE 7, 20: PRINT "Magic Use."; : n = o(i, 5): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
IF ty < 5 THEN
IF ty = 1 THEN s1 = 3 ELSE s1 = 5
s2 = 8
FOR p = s1 TO s2
LOCATE p + 3, 20:
pp = o(i, p)
IF pp > 0 THEN PRINT "Special..."; :  n$ = s$(pp): PRINT LEFT$(n$ + "__________", 10)
IF pp = 0 THEN PRINT "..........__________"
NEXT p
END IF
IF ty = 5 THEN
LOCATE 6, 20: PRINT "+Body....."; : : n = o(i, 3): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
LOCATE 7, 20: PRINT "+Hands...."; : : n = o(i, 4): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
LOCATE 8, 20: PRINT "+Arms....."; : : n = o(i, 5): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
LOCATE 9, 20: PRINT "+Legs....."; : : n = o(i, 6): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
LOCATE 10, 20: PRINT "+Feet....."; : : n = o(i, 7): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
LOCATE 11, 20: PRINT "+Magic...."; : : n = o(i, 8): GOSUB ntos: PRINT LEFT$(n$ + "________", 10)
END IF
IF ty = 6 THEN
FOR p = 2 TO 7
LOCATE p + 3, 20: PRINT ".........._____"
NEXT p
END IF
END IF
it = o(i, 9)
IF i = 0 THEN
    sx = ox * 10: sy = oy * 10 + 110: x1 = sx: y1 = sy: x2 = sx + 9: y2 = sy + 9: sc = 4: tt = 1: GOSUB mkv
ELSE
    sx = ox * 10: sy = oy * 10 + 110: GOSUB itxy: sc = 1: tt = 1: GOSUB mkv
END IF
sx = x * 10: sy = y * 10 + 110: x1 = 100: y1 = 0: x2 = 109: y2 = 9: sc = 1: tt = 0: GOSUB mkv
IF A$ = "," OR A$ = "<" THEN
    pl = pl - 1: IF pl < 1 THEN pl = 6
    GOSUB FIX4
END IF
IF A$ = "." OR A$ = ">" THEN
    pl = pl + 1: IF pl > 6 THEN pl = 1
    GOSUB FIX4
END IF
LOOP
itxy:
x1 = INT(it / 20) * 10 + 1
y1 = ((it / 20 - INT(it / 20)) * 20) * 10 - 10
x2 = x1 + 9
y2 = y1 + 9
RETURN
FIX4:
COLOR 2: LOCATE 11, 8: n = money: GOSUB ntos: PRINT LEFT$(n$ + "_____", 7)
LOCATE 2, 7: COLOR 3: PRINT LEFT$(n$(pl) + "_____________", 12)
FOR A = 1 TO 6
LOCATE 3 + A, 13: COLOR 5: PRINT n(pl, A)
NEXT A
RETURN
ntos:
IF n = 0 THEN n$ = "0": RETURN
RN = n: n$ = "": d = 0
DO: d = d + 1: LOOP WHILE 10 ^ d <= n
FOR NN = d TO 1 STEP -1
CN = INT(n / 10 ^ (NN - 1))
BON = INT(RN / 10 ^ (NN - 1))
IF BON = 0 THEN CN$ = "" ELSE CN$ = CHR$(CN + 48): n = n - INT(n / 10 ^ (NN - 1)) * 10 ^ (NN - 1)
n$ = n$ + CN$
NEXT NN
RETURN
fscreen:
SCREEN , , sc, 0
GET (0, 0)-(319, 199), Tmp%
SCREEN , , 0, 0
VIEW
PUT (0, 0), Tmp%, PSET
RETURN

'
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
'
DATA 0,0,0,8,8,8,8,0,0,0
DATA 0,0,8,8,8,8,8,8,0,0
DATA 0,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,0
DATA 0,0,8,8,8,8,8,8,0,0
DATA 0,0,0,8,8,8,8,0,0,0
'
DATA 0,0,0,0,0,0,0,8,8,8
DATA 0,0,0,0,8,8,8,8,8,8
DATA 0,0,0,8,8,8,8,8,8,8
DATA 0,0,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
'
DATA 8,8,0,0,0,0,0,0,0,0
DATA 8,8,8,8,8,0,0,0,0,0
DATA 8,8,8,8,8,8,8,0,0,0
DATA 8,8,8,8,8,8,8,8,0,0
DATA 8,8,8,8,8,8,8,8,0,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
'
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,8,8,8,8,8,8,8,8,8
DATA 0,0,8,8,8,8,8,8,8,8
DATA 0,0,0,8,8,8,8,8,8,8
DATA 0,0,0,0,8,8,8,8,8,8
DATA 0,0,0,0,0,0,0,0,0,0
'
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,8,0
DATA 8,8,8,8,8,8,8,8,0,0
DATA 8,8,8,8,8,8,8,0,0,0
DATA 8,8,8,8,8,8,0,0,0,0
DATA 8,8,0,0,0,0,0,0,0,0
'
DATA 8,8,8,8,8,8,8,8,0,0
DATA 8,8,8,8,0,0,0,0,0,0
DATA 8,8,8,0,0,0,0,0,0,0
DATA 8,8,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
'
DATA 0,0,8,8,8,8,8,8,8,8
DATA 0,0,0,0,0,0,8,8,8,8
DATA 0,0,0,0,0,0,0,8,8,8
DATA 0,0,0,0,0,0,0,0,8,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,0,0,0,0,0,0,0,0,0
DATA 8,8,0,0,0,0,0,0,0,0
DATA 8,8,8,0,0,0,0,0,0,0
DATA 8,8,8,8,0,0,0,0,0,0
DATA 8,8,8,8,8,8,8,8,0,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,0,8
DATA 0,0,0,0,0,0,0,0,8,8
DATA 0,0,0,0,0,0,0,8,8,8
DATA 0,0,0,0,0,0,8,8,8,8
DATA 0,0,8,8,8,8,8,8,8,8
mkv: SCREEN , , sc, 0: GET (x1, y1)-(x2, y2), tp%: SCREEN , , 0, 0
IF tt = 1 THEN PUT (sx, sy), tp%, PSET
IF tt = 0 THEN PUT (sx, sy), tp%

RETURN

