'
'                ±±±±     ±±±    ±         ±±±    ±    ±  ±     ±
'               ±    ±   ±   ±   ±        ±   ±    ±  ±    ±   ±
'               ±        ±   ±   ±        ±   ±     ±±      ±±±
'               ±  ±±±  ±±±±±±±  ±       ±±±±±±±    ±±       ±
'               ±    ±  ±     ±  ±       ±     ±   ±  ±      ±
'                ±±±±   ±     ±  ±±±±±±  ±     ±  ±    ±     ±
'
'                           By Tim Caswell
'
'
'       NOTE:  I found out Q-Basic has a buffer on the size of a
'              string because it will not read past 900 lines, but
'              this program works just fine in QuickBasic.
'

DECLARE FUNCTION power% ()
DECLARE SUB blowup (x%, y%, s%)
DECLARE FUNCTION fight% (sh%, n%)
DECLARE FUNCTION rumble% (typ1%, defen%)
DECLARE SUB Gship (n%)
DECLARE SUB Tship (n%)
DECLARE SUB attack (sh%, n%)
DECLARE SUB give (IT$)
DECLARE SUB take (IT$)
DECLARE SUB compress ()
DECLARE FUNCTION have% (IT$)
DECLARE FUNCTION speed% ()
DECLARE FUNCTION turn% ()
DECLARE SUB Move (Men%, g%, a%)
DECLARE SUB save (FILE$)
DECLARE SUB load (FILE$)
DECLARE SUB ACrew (a%)
DECLARE SUB addFriend (n%)
DECLARE FUNCTION Curtype% ()
DECLARE SUB Land (sys%, pl%)
DECLARE FUNCTION Shpspace% ()
DECLARE SUB Stars ()
DECLARE SUB dock ()
DECLARE SUB scanpln (sol%, plt%)
DECLARE SUB Starmap (x%, y%, a%)
DECLARE SUB Enter (x%, y%)
DECLARE SUB add (part%, cost%)
DECLARE SUB subt (part%, cost%)
DECLARE SUB fuelup (am%)
DECLARE FUNCTION maxfuel% ()
DECLARE FUNCTION nam$ (a%)
DECLARE SUB drawsys (s%, p%)
DECLARE SUB ship (p1%, p2%, p3%, p4%, p5%, p6%, p7%, p8%)
DECLARE SUB Menu (Men%, g%)
DECLARE SUB systemdat (sys%, pl%)
DECLARE SUB DangerBar (p%)
DECLARE SUB status (sp%, cr%, fuel%)
DECLARE SUB pship (sh1%, sh2%, sh3%, c1%, c2%, c3%)
DECLARE SUB frame (t%)
DECLARE SUB PAUSE ()
DECLARE SUB fPRINT (a$, l%)
DECLARE FUNCTION question% (cur%)
DECLARE SUB talk (lbl$)
DECLARE FUNCTION find% (lbl$)
DECLARE SUB pic (p%)
CLS
DEFINT A-Y
TYPE enemy
    x AS INTEGER
    y AS INTEGER
    crew AS INTEGER
    talk AS INTEGER
END TYPE

TYPE friend
    typ AS INTEGER
    crew AS INTEGER
END TYPE
TYPE ship
    cr AS INTEGER
    min AS INTEGER
    fuel AS INTEGER
    p1 AS INTEGER
    p2 AS INTEGER
    p3 AS INTEGER
    p4 AS INTEGER
    p5 AS INTEGER
    p6 AS INTEGER
    p7 AS INTEGER
    p8 AS INTEGER
    f1 AS friend
    f2 AS friend
    f3 AS friend
    credit AS INTEGER
    crew AS INTEGER
END TYPE
TYPE planet
    temp AS INTEGER
    rain AS INTEGER
    quake AS INTEGER
    min AS INTEGER
    life AS INTEGER
END TYPE
TYPE Solar
    nam AS STRING * 6
    col AS INTEGER
    typ AS INTEGER
    num AS INTEGER
    p1 AS INTEGER
    p2 AS INTEGER
    p3 AS INTEGER
    p4 AS INTEGER
    p5 AS INTEGER
    p6 AS INTEGER
    x AS INTEGER
    y AS INTEGER
END TYPE
TYPE location
    systm AS INTEGER
    plant AS INTEGER
    x AS INTEGER
    y AS INTEGER
    a AS INTEGER
    mx AS INTEGER
    my AS INTEGER
END TYPE

CONST shpn = 14
CONST SolarN = 55
CONST Partn = 11

DIM SHARED Item$(15), place(99)
DIM SHARED shp AS ship, CurFrame AS INTEGER
DIM SHARED col$(7), typ$(5), crew(shpn)
DIM SHARED tip%(480), pt%(225, Partn)
DIM SHARED syst(SolarN) AS Solar
DIM SHARED Master, me AS location
DIM SHARED p%(480, shpn), v%(480, shpn)
DIM SHARED bp%(50, shpn), bv%(50, shpn + 1)
DIM SHARED sn$(shpn), us%(480 * 2)
DIM SHARED r$(10), Fdn

r$(1) = "I": r$(2) = "II": r$(3) = "III": r$(4) = "IV": r$(5) = "V": r$(6) = "VI": r$(7) = "VII": r$(8) = "VIII": r$(9) = "IX": r$(10) = "X"
col$(0) = "Black": col$(1) = "Blue": col$(2) = "Green": col$(3) = "Cyan": col$(4) = "Red": col$(5) = "Purple": col$(6) = "Yellow": col$(7) = "White"
typ$(0) = "Hole": typ$(1) = "Dwarf": typ$(2) = "Star": typ$(3) = "Giant": typ$(4) = "": typ$(5) = "Ultimeter"
sn$(0) = "None   ": crew(0) = 0
sn$(1) = "Rocket ": crew(1) = 6
sn$(2) = "Viper  ": crew(2) = 6
sn$(3) = "Bolt   ": crew(3) = 6
sn$(4) = "Airloo ": crew(4) = 9
sn$(5) = "Wave   ": crew(5) = 7
sn$(6) = "Surge  ": crew(6) = 10
sn$(7) = "Ur-Quan": crew(7) = 20
sn$(8) = "Titan  ": crew(8) = 15
sn$(9) = "Supox  ": crew(9) = 11
sn$(10) = "Rock   ": crew(10) = 13
sn$(11) = "Bumble ": crew(11) = 15
sn$(12) = "Tricity": crew(12) = 21
sn$(13) = "Electra": crew(13) = 20
sn$(14) = "Watcher": crew(14) = 30
'PLAY "mbo1aaa"
ON PLAY(3) GOSUB g1
PLAY ON
RANDOMIZE (TIMER)
SCREEN 7

GOSUB loadSolar
syst(3).x = 285
syst(3).y = 222
syst(1).x = 223
syst(1).y = 229
syst(1).nam = "Hades  "
syst(3).nam = "Vortex "
syst(2).x = 273
syst(2).y = 279
syst(2).nam = "John's "
syst(20).x = 185
syst(20).y = 262
DIM SHARED length
OPEN "talk.dat" FOR INPUT AS #1
a = -1
DO
LINE INPUT #1, a$
a = a + 1
LOOP WHILE a$ <> "%EOF"
length = a
CLOSE #1
DIM SHARED t$(length)
OPEN "talk.dat" FOR INPUT AS #1
a = -1
PRINT length
FOR t = 1 TO length
LINE INPUT #1, t$(t)
NEXT t
CLOSE #1
'*******************
GOSUB loadgra

Master = 1
me.systm = 0
me.x = 2400: me.y = 2500
shp.f1.typ = 1: shp.f1.crew = crew(shp.f1.typ)
shp.f2.typ = 2: shp.f2.crew = crew(shp.f2.typ)
shp.f3.typ = 3: shp.f3.crew = crew(shp.f3.typ)
shp.fuel = 20
shp.p1 = 1: shp.p2 = 0
shp.p3 = 2: shp.p4 = 0
shp.p5 = 5: shp.p6 = 0
shp.p7 = 4: shp.p8 = 3
shp.cr = 0
Men = 1
frame 2
shp.crew = 200
GOSUB RunMenu
END
RunMenu:
DO
IF ABS(s) < 1 THEN s = 6
IF ABS(s) > 6 THEN s = 1
Menu Men, s
oa$ = a$
DO: a$ = INKEY$: LOOP WHILE a$ = "" AND oa$ = ""
DO: LOOP WHILE INKEY$ <> ""
IF RIGHT$(a$, 1) = "H" THEN s = s - 1
IF RIGHT$(a$, 1) = "P" THEN s = s + 1
IF a$ = "1" THEN s = 1
IF a$ = "2" THEN s = 2
IF a$ = "3" THEN s = 3
IF a$ = "4" THEN s = 4
IF a$ = "5" THEN s = 5
IF a$ = "6" THEN s = 6
status Shpspace, shp.cr, shp.fuel
s = ABS(s)
IF a$ = " " OR a$ = CHR$(13) THEN s = -s
LOOP
RETURN




loadSolar:
g = 1
FOR n = 1 TO SolarN
syst(n).nam = nam$(INT(4 * RND + 4))
syst(n).col = INT(8 * RND)
syst(n).typ = INT(4 * RND)
syst(n).num = INT(3 * RND + syst(n).typ + 1)
IF syst(n).num >= 1 THEN syst(n).p1 = g: g = g + 1
IF syst(n).num >= 2 THEN syst(n).p2 = g: g = g + 1
IF syst(n).num >= 3 THEN syst(n).p3 = g: g = g + 1
IF syst(n).num >= 4 THEN syst(n).p4 = g: g = g + 1
IF syst(n).num >= 5 THEN syst(n).p5 = g: g = g + 1
IF syst(n).num >= 6 THEN syst(n).p6 = g: g = g + 1
syst(n).x = INT(500 * RND)
syst(n).y = INT(500 * RND)
NEXT n
maxpln = g
DIM SHARED plant(g) AS planet
FOR a = 1 TO g
plant(a).temp = 2000 * RND - 200
plant(a).rain = 100 * RND
plant(a).quake = 100 * RND
plant(a).min = 400 * RND * CINT(RND + .1) + 100 * RND * CINT(RND - .3)
plant(a).life = 30
NEXT a
RETURN

loadgra:
OPEN "picture.dat" FOR INPUT AS #1
FOR n% = 0 TO shpn
LINE (1, 1)-(60, 30), 0, BF
FOR y% = 1 TO 15
INPUT #1, a$
FOR x% = 1 TO 30
c% = ASC(MID$(a$, x, 1)) - 100
IF c% > 0 THEN
PSET (x%, y%), c%: PSET (61 - x%, y%), c%
IF c% = 15 THEN c% = 8 ELSE IF c% = 8 THEN c% = 15
PSET (x%, 31 - y%), c%: PSET (61 - x%, 31 - y%), c%
END IF
NEXT x%
NEXT y%
GET (1, 1)-(30, 30), p%(0, n%)
GET (31, 1)-(60, 30), v%(0, n%)
NEXT n%
LINE (1, 1)-(60, 30), 0, BF
FOR n% = 0 TO Partn
LINE (1, 1)-(15, 30), 0, BF
FOR y% = 1 TO 15
INPUT #1, a$
FOR x% = 1 TO 15
c% = ASC(MID$(a$, x, 1)) - 100
IF c% > 0 THEN
PSET (x%, y%), c%
IF c% = 15 THEN c% = 8 ELSE IF c% = 8 THEN c% = 15
PSET (x%, 31 - y%), c%
END IF
NEXT x%
NEXT y%
GET (1, 1)-(15, 30), pt%(0, n%)
NEXT n%
LINE (1, 1)-(15, 30), 0, BF
FOR y% = 1 TO 15
INPUT #1, a$
FOR x% = 1 TO 30
c% = ASC(MID$(a$, x, 1)) - 100
IF c% > 0 THEN
PSET (x%, y%), c%
IF c% = 15 THEN c% = 8 ELSE IF c% = 8 THEN c% = 15
PSET (x%, 31 - y%), c%
END IF
NEXT x%
NEXT y%
GET (1, 1)-(30, 30), tip%
LINE (1, 1)-(30, 30), 0, BF
FOR a = 1 TO shpn
LINE (1, 1)-(20, 10), 0, BF
FOR y% = 1 TO 5
FOR x% = 1 TO 10
READ c%
IF c% > 0 THEN
IF c% = 8 THEN c% = 0
PSET (x%, y%), c% + 8
PSET (x%, 11 - y%), c% + 8
PSET (21 - x%, y%), c% + 8
PSET (21 - x%, 11 - y%), c% + 8
END IF
NEXT x
NEXT y
GET (1, 1)-(10, 10), bp%(0, a)
GET (11, 1)-(20, 10), bv%(0, a)
NEXT a
CLOSE #1
RETURN
g1:
RETURN
music = (music + 1) MOD 12
IF music = 0 THEN PLAY "mbl8 a p4 b"
IF music = 1 THEN PLAY "mbp2l4c"
IF music = 2 THEN PLAY "mbp4l8 >ab"
IF music = 3 THEN PLAY "mbp8l4a<l8b"
IF music = 4 THEN PLAY "mbp4l8dc"
IF music = 5 THEN PLAY "mbdp2"
IF music = 6 THEN PLAY "mbl8 a p4 b"
IF music = 7 THEN PLAY ">mbp2l4c"
IF music = 8 THEN PLAY "mbp4l8 >ab"
IF music = 9 THEN PLAY "mbp8l4a<l8b"
IF music = 10 THEN PLAY "mbp4l8dc"
IF music = 11 THEN PLAY "mbdp2<"
RETURN
'1
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 2,2,0,0,0,0,0,0,0,0
DATA 2,2,2,4,4,4,4,4,0,0
DATA 2,2,4,4,4,4,4,4,4,4
'2
DATA 0,0,0,0,0,0,0,0,0,0
DATA 2,2,2,2,2,0,0,2,0,0
DATA 0,0,0,0,0,0,2,0,0,0
DATA 2,2,2,2,0,0,0,0,0,0
DATA 4,4,4,4,2,2,2,0,0,0
'3
DATA 0,0,0,0,0,0,0,0,0,0
DATA 7,0,7,7,7,7,7,0,0,0
DATA 7,7,6,6,6,6,1,1,0,0
DATA 7,6,6,6,6,1,1,1,0,0
DATA 7,6,6,6,6,1,1,1,0,0
'4
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 6,6,6,6,6,6,6,6,6,6
DATA 1,1,1,1,1,1,1,1,1,1
'5
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,4,4,4,4,4,0,0,0
DATA 0,4,6,4,6,4,6,4,0,0
DATA 4,6,4,6,4,6,6,6,4,0
DATA 4,4,6,4,6,6,6,6,4,0
'6
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,2,2,2,0,0,0
DATA 0,0,2,2,2,2,7,2,0,0
DATA 0,2,2,2,2,2,2,7,2,0
DATA 2,2,2,2,2,2,2,7,2,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 4,4,4,4,4,4,4,4,0,0
DATA 5,5,5,5,5,5,5,5,4,4
DATA 0,0,0,0,0,0,0,0,5,5
'
DATA 0,0,0,0,1,0,1,0,0,0
DATA 0,0,1,0,0,0,0,0,0,0
DATA 0,0,0,7,7,7,0,0,1,0
DATA 1,0,7,6,6,6,7,0,0,0
DATA 0,0,7,6,6,6,7,0,1,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 1,2,2,2,2,2,1,1,0,0
DATA 2,2,2,2,2,2,2,1,1,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,7,7,0,0,0,0,0
DATA 0,0,7,8,8,7,0,0,0,0
DATA 0,0,7,8,7,8,7,0,0,0
DATA 0,7,8,7,8,8,7,7,0,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,6,6,4,4,6,6,0,0
DATA 0,6,6,4,4,6,6,4,4,0
DATA 0,6,4,4,6,6,4,4,6,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,6,6,6,6,0,0,0,0
DATA 0,6,0,0,0,0,6,0,0,0
DATA 6,0,6,6,6,0,0,6,0,0
DATA 0,6,0,0,0,6,0,0,6,0
'
DATA 0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,7,0,0,0
DATA 0,7,7,7,0,7,0,7,0,0
DATA 7,0,0,0,7,0,6,0,7,0
DATA 0,6,6,0,0,6,0,0,7,0
'
DATA 0,0,5,5,5,5,5,5,0,0
DATA 0,5,5,5,5,5,5,5,5,0
DATA 5,5,5,5,4,4,5,5,5,5
DATA 5,5,5,4,2,2,4,5,5,5
DATA 5,5,4,2,2,2,2,4,5,5

SUB ACrew (a)
IF Fdn = 1 THEN shp.f1.crew = shp.f1.crew + a: IF shp.f1.crew < 1 THEN shp.f1.crew = 0: shp.f1.typ = 0
IF Fdn = 2 THEN shp.f2.crew = shp.f2.crew + a: IF shp.f2.crew < 1 THEN shp.f2.crew = 0: shp.f2.typ = 0
IF Fdn = 3 THEN shp.f3.crew = shp.f3.crew + a: IF shp.f3.crew < 1 THEN shp.f3.crew = 0: shp.f3.typ = 0
END SUB

SUB add (part, cost)
IF cost > shp.cr THEN SOUND 100, .1: SOUND 37, .5: GOTO nobuy
n = 0
IF shp.p1 = 0 THEN n = 1
IF shp.p2 = 0 THEN n = 2
IF shp.p3 = 0 THEN n = 3
IF shp.p4 = 0 THEN n = 4
IF shp.p5 = 0 THEN n = 5
IF shp.p6 = 0 THEN n = 6
IF shp.p7 = 0 THEN n = 7
IF shp.p8 = 0 THEN n = 8
IF n = 1 THEN shp.p1 = part
IF n = 2 THEN shp.p2 = part
IF n = 3 THEN shp.p3 = part
IF n = 4 THEN shp.p4 = part
IF n = 5 THEN shp.p5 = part
IF n = 6 THEN shp.p6 = part
IF n = 7 THEN shp.p7 = part
IF n = 8 THEN shp.p8 = part
IF n > 0 THEN
ship shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
shp.cr = shp.cr - cost
status Shpspace, shp.cr, shp.fuel
END IF
nobuy:
END SUB

SUB addFriend (n)
IF Fdn = 1 THEN shp.f1.typ = n: IF shp.f1.crew < 1 THEN shp.f1.crew = crew(n)
IF Fdn = 2 THEN shp.f2.typ = n: IF shp.f2.crew < 1 THEN shp.f2.crew = crew(n)
IF Fdn = 3 THEN shp.f3.typ = n: IF shp.f3.crew < 1 THEN shp.f3.crew = crew(n)
END SUB

SUB attack (sh, n)
CLS
live = 1
FOR atk = n TO 1 STEP -1
IF fight(sh, atk) = 1 THEN live = 0: atk = 0
NEXT atk
IF live = 0 THEN talk "Died": END
shp.f1.crew = crew(shp.f1.typ)
shp.f2.crew = crew(shp.f2.typ)
shp.f3.crew = crew(shp.f3.typ)
END SUB

SUB blowup (x, y, s)
FOR a = 1 TO s
CIRCLE (x, y), a, 14
CIRCLE (x, y + 5), a, 15
CIRCLE (x + 3, y), a, 12
SOUND 37 + a * 10 * RND, .1
NEXT a
FOR a = 1 TO s
CIRCLE (x, y + 5), a, 0
CIRCLE (x + 3, y), a, 0
SOUND 37 + a * 10 * RND, .1
NEXT a
FOR a = 1 TO s
CIRCLE (x, y), a, 0
NEXT a
END SUB

SUB compress
DO
cm = 1
FOR a = 1 TO 14
IF Item$(a) = "" AND Item$(a + 1) <> "" THEN SWAP Item$(a), Item$(a + 1): cm = 0
NEXT a
LOOP WHILE cm = 0
END SUB

FUNCTION Curtype
IF Fdn = 1 THEN Curtype = shp.f1.typ
IF Fdn = 2 THEN Curtype = shp.f2.typ
IF Fdn = 3 THEN Curtype = shp.f3.typ
END FUNCTION

SUB DangerBar (p%)
COLOR 14
LOCATE 18, 19
PRINT "Danger%"
FOR a% = 1 TO 100
IF p% >= a% THEN c = 8 ELSE c = 0
LINE (219 + a%, 143)-(219 + a%, 136), c + (a% MOD 2) * 6
NEXT a%
END SUB

SUB dock
PLAY STOP
FOR a = 1 TO 30
CIRCLE (60, 85 - a), 10, 15, , , 1 / 2
CIRCLE (62, 85 - a), 10, 8, , , 1 / 2
CIRCLE (61, 85 - a), 10, 7, , , 1 / 2
SOUND 37 + a * 10, .1
NEXT a
FOR a = 0 TO 50 STEP 3
CIRCLE (60, 55 - a / 2), 4, 15, , , 1 / 2
CIRCLE (62, 55 - a / 2), 4, 9, , , 1 / 2
CIRCLE (61, 55 - a / 2), 4, 1, , , 1 / 2
CIRCLE (60, 55 - a / 3), ABS(SIN(a / 20) * 40), 15, , , 1 / 2
CIRCLE (62, 56 - a / 3), ABS(SIN(a / 20) * 40), 8, , , 1 / 2
CIRCLE (61, 55 - a / 3), ABS(SIN(a / 20) * 40), 7, , , 1 / 2
SOUND 100 + a * 20, .1: SOUND 200 + a * 5, .1
NEXT a

END SUB

SUB drawsys (s, p)
LINE (0, 0)-(129, 95), 0, BF
IF s = -1 THEN CALL dock: GOTO skip1
IF s = 0 THEN CALL Stars: GOTO skip1
typ = syst(s).typ
col = syst(s).col
pn = syst(s).num
FOR a = 1 TO 16
B = SIN(a / 10) * typ * 1
c = COS(a / 10) * typ * 2
CIRCLE (59 + B, 40 + B), c, 15
CIRCLE (61 + B, 41 + B), c, col + 8
CIRCLE (60 + B, 40 + B), c, col
SOUND 100 + a, .1: SOUND 200 - a * 10, .1
NEXT a
B = 100
FOR a = 1 TO pn
B = B + 400 / pn
CIRCLE (60, 40), B / 9, 7, , , 1 / 2
IF a = p THEN CIRCLE (61, 40), B / 9, 15, , , 1 / 2
SOUND a * 100 + 37, .1: SOUND 1000, .1: SOUND 2000, .1: SOUND 0, 0
NEXT a
skip1:
END SUB

SUB Enter (x, y)
d = 1000
e = 0
FOR a% = 1 TO SolarN
g = ABS(x / 10 - syst(a).x) + ABS(y / 10 - syst(a).y)
IF g < d THEN d = g: e = a%
NEXT a%
g = ABS(x / 10 - 250) + ABS(y / 10 - 250)
IF g < d THEN d = g: e = -1
IF d > 5 THEN e = 0
me.systm = e
r = 1
IF e = -1 THEN talk "StarBase": r = 0
IF e = 3 THEN talk "Vender": r = 0
IF e = 10 THEN talk "Venderk": r = 0
IF e = 15 THEN talk "Warp": r = 0
IF e = 20 THEN talk "Supox": r = 0
IF e = 25 THEN talk "Airloo": r = 0
IF e = 30 THEN talk "Watcher": r = 0
IF e = 37 THEN talk "Ur-Quan": r = 0
IF e = 2 THEN talk "John": r = 0
IF e = 18 THEN talk "Electra": r = 0
IF e = 17 THEN talk "Tricity": r = 0
IF e = 1 THEN talk "Arena": r = 0
IF r = 1 THEN systemdat me.systm, me.plant
END SUB

FUNCTION fight (sh, n)
start:
CLS
FOR y = 1 TO 6
FOR x = 1 TO 4
a = x + y * 4 - 4
IF n >= a THEN PUT (x * 30 - 30, y * 30 - 30), p%(0, sh), PSET
IF n < a THEN PUT (x * 30 - 30, y * 30 - 30), p%(0, 0), PSET
IF a = 1 THEN LINE (x * 30 - 30, y * 30 - 30)-(x * 30 - 1, y * 30 - 1), 15, B
NEXT x
NEXT y
DO
a$ = INKEY$
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN df = df - 1
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN df = df + 1
IF df < 1 THEN df = 4
IF df > 4 THEN df = 1
PUT (240, 0), p%(0, shp.f1.typ), PSET
PUT (240, 32), p%(0, shp.f2.typ), PSET
PUT (240, 64), p%(0, shp.f3.typ), PSET
ship shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
IF df < 4 THEN LINE (240, df * 32 - 32)-(267, df * 32 - 3), 15, B
IF df = 4 THEN LINE (150, 160)-(299, 189), 15, B
IF a$ = " " OR a$ = CHR$(13) THEN
IF df = 1 AND shp.f1.typ = 0 THEN a$ = ""
IF df = 2 AND shp.f2.typ = 0 THEN a$ = ""
IF df = 3 AND shp.f3.typ = 0 THEN a$ = ""
END IF
LOOP WHILE a$ <> " " AND a$ <> CHR$(13)
IF df = 4 THEN
ship shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
FOR y% = 1 TO 30
FOR x% = 1 TO 60
PSET (61 - x%, y%), POINT(150 + x% * 150 \ 60, 159 + y%)
NEXT x%
NEXT y%
GET (1, 1)-(60, 30), us%
LINE (1, 1)-(10, 10), 0, BF
FOR a = 1 TO 5
CIRCLE (5, 5), a, 15 * RND
NEXT a
GET (1, 1)-(10, 10), bv%(0, 0)
END IF
f = rumble(sh, df)
IF f = 1 AND shp.crew > 0 THEN GOTO start
fight = f
END FUNCTION

FUNCTION find (lbl$)
t = 0
FOR a = 1 TO length
IF t$(a) = "%L " + lbl$ THEN t = a: a = length
NEXT a
IF t = 0 THEN PRINT "Label not found ("; lbl$; ")": BEEP:
find = t
END FUNCTION

SUB fPRINT (a$, l)
LOCATE l + 14, 1
PRINT LEFT$(a$ + "                                          ", 39)
END SUB

SUB frame (t)
CLS
LINE (0, 96)-(319, 103), 7, BF: LINE (0, 96)-(319, 96), 15: LINE (0, 103)-(319, 103), 8
LINE (130, 0)-(137, 96), 7, BF: LINE (130, 0)-(130, 96), 15: LINE (137, 0)-(137, 96), 8
LINE (240, 0)-(247, 96), 7, BF: LINE (240, 0)-(240, 96), 15: LINE (247, 0)-(247, 96), 8
LINE (180, 0)-(180, 96), 7: LINE (138, 31)-(240, 31), 7: LINE (138, 63)-(240, 63), 7
LINE (179, 0)-(179, 95), 15: LINE (137, 30)-(239, 30), 15: LINE (137, 62)-(239, 62), 15
LINE (247, 12)-(319, 15), 7, BF: LINE (247, 12)-(319, 12), 15: LINE (247, 15)-(319, 15), 8
LINE (247, 64)-(319, 71), 7, BF: LINE (247, 64)-(319, 64), 15: LINE (247, 71)-(319, 71), 8
IF t = 1 THEN LINE (0, 144)-(319, 151), 7, BF: LINE (0, 144)-(319, 144), 15: LINE (0, 151)-(319, 151), 8
IF t = 2 THEN
LINE (130, 103)-(137, 199), 7, BF: LINE (130, 103)-(130, 199), 15: LINE (137, 103)-(137, 199), 8
LINE (137, 144)-(319, 151), 7, BF: LINE (137, 144)-(319, 144), 15: LINE (137, 151)-(319, 151), 8
LINE (137, 129)-(319, 129), 7: LINE (137, 128)-(319, 128), 15
ship shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
systemdat me.systm, me.plant
DangerBar 70
Starmap me.x, me.y, me.a
END IF
pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
status Shpspace, shp.cr, shp.fuel
END SUB

SUB fuelup (am)
IF shp.cr - am * 2 >= 0 THEN
ofuel = shp.fuel
n = maxfuel
shp.fuel = shp.fuel + am
IF shp.fuel < 0 THEN shp.fuel = 0
IF shp.fuel > n THEN shp.fuel = n
shp.cr = shp.cr + (ofuel - shp.fuel) * 2
END IF
status Shpspace, shp.cr, shp.fuel
END SUB

SUB give (IT$)
FOR a = 1 TO 15
IF Item$(a) = "" THEN Item$(a) = IT$: a = 101
NEXT a
CALL compress
END SUB

SUB Gship (n)
s = 0
IF shp.f1.typ = 0 THEN s = 1
IF shp.f2.typ = 0 THEN s = 2
IF shp.f3.typ = 0 THEN s = 3
IF s = 0 THEN s = INT(3 * RND + 1)
IF s = 1 THEN shp.f1.typ = n: shp.f1.crew = crew(n)
IF s = 2 THEN shp.f2.typ = n: shp.f2.crew = crew(n)
IF s = 3 THEN shp.f3.typ = n: shp.f3.crew = crew(n)
pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
END SUB

FUNCTION have (IT$)
h = 0
FOR a = 30 TO 1 STEP -1
IF MID$(IT$, a, 1) = " " THEN IT$ = LEFT$(IT$, a - 1)
NEXT a
FOR a = 1 TO 15
IF Item$(a) = IT$ THEN h = 1: a = 101
NEXT a
have = h
END FUNCTION

SUB Land (sys, pl)
p = 0
IF pl = 1 THEN p = syst(sys).p1
IF pl = 2 THEN p = syst(sys).p2
IF pl = 3 THEN p = syst(sys).p3
IF pl = 4 THEN p = syst(sys).p4
IF pl = 5 THEN p = syst(sys).p5
IF pl = 6 THEN p = syst(sys).p6
tmp = plant(p).temp
ran = plant(p).rain
qak = plant(p).quake
min = plant(p).min
lif = plant(p).life
t = min
IF t > Shpspace THEN t = Shpspace
plant(p).min = plant(p).min - t
mm = shp.min
FOR g = 0 TO t STEP 5
shp.min = mm + g
status Shpspace, shp.cr, shp.fuel
SOUND 100 + a * 10, .1: SOUND 200 + a * 5, .1: SOUND 37 + ABS(3000 - a * 100), .1
NEXT g
END SUB

SUB load (FILE$)
OPEN FILE$ + ".SAV" FOR INPUT AS #1
INPUT #1, me.x, me.y, me.systm, me.plant
INPUT #1, shp.fuel, shp.min, shp.cr
INPUT #1, shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
INPUT #1, shp.f1.typ, shp.f1.crew
INPUT #1, shp.f2.typ, shp.f2.crew
INPUT #1, shp.f3.typ, shp.f3.crew
FOR a = 1 TO SolarN
INPUT #1, syst(a).nam
INPUT #1, syst(a).col, syst(a).typ, syst(a).num
INPUT #1, syst(a).p1, syst(a).p2, syst(a).p3, syst(a).p4, syst(a).p5, syst(a).p6
INPUT #1, syst(a).x, syst(a).y
NEXT a
FOR a = 1 TO maxpln
INPUT #1, plant(a).temp, plant(a).rain, plant(a).quake
INPUT #1, plant(a).min, plant(a).life
NEXT a
FOR a = 1 TO 15
INPUT #1, Item$(a)
NEXT a
FOR a = 1 TO 99
INPUT #1, place(a)
NEXT a
CLOSE #1
frame 2
END SUB

FUNCTION maxfuel
n = 0
IF shp.p1 = 1 THEN n = n + 50
IF shp.p2 = 1 THEN n = n + 50
IF shp.p3 = 1 THEN n = n + 50
IF shp.p4 = 1 THEN n = n + 50
IF shp.p5 = 1 THEN n = n + 50
IF shp.p6 = 1 THEN n = n + 50
IF shp.p7 = 1 THEN n = n + 50
IF shp.p8 = 1 THEN n = n + 50
IF shp.p1 = 6 THEN n = n + 150
IF shp.p2 = 6 THEN n = n + 150
IF shp.p3 = 6 THEN n = n + 150
IF shp.p4 = 6 THEN n = n + 150
IF shp.p5 = 6 THEN n = n + 150
IF shp.p6 = 6 THEN n = n + 150
IF shp.p7 = 6 THEN n = n + 150
IF shp.p8 = 6 THEN n = n + 150
maxfuel = n
END FUNCTION

SUB Menu (Men, g)
SOUND 100, .1: SOUND 400, .1: SOUND 100, 0
IF Men = 1 THEN
LOCATE 1, 32: COLOR 15: PRINT "MAIN MENU"
COLOR 7
LOCATE 3, 32: PRINT " Starmap "
IF g = -1 THEN me.a = 240: Move Men, g, me.a
LOCATE 4, 32: PRINT "         "
LOCATE 5, 32: PRINT " Cargo   "
IF g = -3 THEN Men = 4: g = 1
LOCATE 6, 32: PRINT " Game    "
IF g = -4 THEN Men = 5: g = 1
LOCATE 7, 32: PRINT " Help    "
IF g = -5 THEN Men = 17: g = 1
LOCATE 8, 32: PRINT "         "
END IF
IF Men = 2 THEN
LOCATE 1, 32: COLOR 15: PRINT "Starmap  "
COLOR 15
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = Master: g = 1
COLOR 11
ox = me.x: oy = me.y
LOCATE 4, 32: PRINT " Up      "
IF g = -2 THEN me.y = me.y - 3: Starmap me.x, me.y, me.a: shp.fuel = shp.fuel - 1
LOCATE 5, 32: PRINT " Down    "
IF g = -3 THEN me.y = me.y + 3: Starmap me.x, me.y, me.a: shp.fuel = shp.fuel - 1
LOCATE 6, 32: PRINT " Left    "
IF g = -4 THEN me.x = me.x - 3: Starmap me.x, me.y, me.a: shp.fuel = shp.fuel - 1
LOCATE 7, 32: PRINT " Right   "
IF g = -5 THEN me.x = me.x + 3: Starmap me.x, me.y, me.a: shp.fuel = shp.fuel - 1
COLOR 12
LOCATE 8, 32: PRINT " Enter   "
IF g = -6 THEN Enter me.x, me.y: IF me.systm > 0 THEN Men = 3: g = 1 ELSE IF me.systm = -1 THEN me.systm = 0: Men = 6: g = 1
IF shp.fuel < 0 THEN shp.fuel = 0: me.x = ox: me.y = oy
COLOR 10
LOCATE 14, 19: PRINT "x"; me.x; "y"; me.y; "   "
END IF
IF Men = 3 THEN
LOCATE 1, 32: COLOR 15: PRINT "System   "
COLOR 15
LOCATE 3, 32: PRINT " Leave   "
IF g = -1 THEN Men = Master: g = 1: systemdat 0, 0
COLOR 10
LOCATE 4, 32: PRINT " Land    "
IF g = -2 THEN CALL Land(me.systm, me.plant)
LOCATE 5, 32: PRINT " Scan    "
IF g = -3 THEN scanpln me.systm, me.plant
COLOR 9
LOCATE 6, 32: PRINT " P Planet"
IF g = -4 THEN me.plant = ABS(me.plant - 1): systemdat me.systm, me.plant
LOCATE 7, 32: PRINT " N Planet"
IF g = -5 THEN me.plant = ABS(me.plant + 1): systemdat me.systm, me.plant
LOCATE 8, 32: PRINT "         "
END IF
IF Men = 4 THEN
LOCATE 1, 32: COLOR 15: PRINT "CARGO    "
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = Master: g = 1
LOCATE 4, 32: PRINT LEFT$(" " + Item$(1) + "       ", 9)
LOCATE 5, 32: PRINT LEFT$(" " + Item$(2) + "       ", 9)
LOCATE 6, 32: PRINT LEFT$(" " + Item$(3) + "       ", 9)
LOCATE 7, 32: PRINT LEFT$(" " + Item$(4) + "       ", 9)
LOCATE 8, 32: PRINT LEFT$(" " + Item$(5) + "       ", 9)
END IF
IF Men = 5 THEN
LOCATE 1, 32: COLOR 15: PRINT "GAME     "
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = Master: g = 1
LOCATE 4, 32: PRINT " Load    "
IF g = -2 THEN Men = 18: g = 1
LOCATE 5, 32: PRINT " Save    "
IF g = -3 THEN Men = 19: g = 1
LOCATE 6, 32: PRINT " Quit    "
IF g = -4 THEN STOP
LOCATE 7, 32: PRINT "         "
LOCATE 8, 32: PRINT "         "
END IF
IF Men = 6 THEN
LOCATE 1, 32: COLOR 15: PRINT "Stardock "
COLOR 7
LOCATE 3, 32: PRINT " Leave   "
IF g = -1 THEN Men = Master: g = 1: me.systm = 0: systemdat 0, 1
LOCATE 4, 32: PRINT " Add Part"
IF g = -2 THEN Men = 8: g = 1
LOCATE 5, 32: PRINT " Sub Part"
IF g = -3 THEN Men = 9: g = 1
LOCATE 6, 32: PRINT " Add Fuel"
IF g = -4 THEN fuelup 5
LOCATE 7, 32: PRINT " Sub Fuel"
IF g = -5 THEN fuelup -5
LOCATE 8, 32: PRINT " Sell Res"
IF g = -6 THEN
FOR j = shp.cr TO shp.cr + shp.min / 1.5 STEP 10
status Shpspace, j, shp.fuel
SOUND 1000, .1: SOUND 37, .1: SOUND 37 + ABS(j), .1
NEXT j
shp.cr = shp.cr + shp.min / 1.5: shp.min = 0
END IF
END IF
IF Men = 7 THEN
IF Fdn < 1 THEN Fdn = 1
IF Fdn > 3 THEN Fdn = 3
LOCATE 1, 32: COLOR 15: PRINT "Friend#"; STR$(Fdn)' *************
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = Master: g = 1
LOCATE 4, 32: PRINT " - Type  "
IF g = -2 THEN CALL addFriend(Curtype - 1): pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
LOCATE 5, 32: PRINT " + Type  "
IF g = -3 THEN CALL addFriend(Curtype + 1): pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
LOCATE 6, 32: PRINT " Add Crew"
IF g = -4 THEN ACrew 1: pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
LOCATE 7, 32: PRINT " Sub Crew"
IF g = -5 THEN ACrew -1: pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
LOCATE 8, 32: PRINT " Select# "
IF g = -6 THEN Men = 14: g = 1

END IF
IF Men = 8 THEN
LOCATE 1, 32: COLOR 15: PRINT "Add Part "' *************
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = 6: g = 1
LOCATE 4, 32: PRINT " Gas Tank"
IF g = -2 THEN add 1, 100
LOCATE 5, 32: PRINT " Lazer   "
IF g = -3 THEN add 3, 250
LOCATE 6, 32: PRINT " Storage "
IF g = -4 THEN add 2, 300
LOCATE 7, 32: PRINT " Thruster"
IF g = -5 THEN add 4, 100
LOCATE 8, 32: PRINT " More    "
IF g = -6 THEN Men = 10: g = 1
END IF
IF Men = 9 THEN
LOCATE 1, 32: COLOR 15: PRINT "Sell Part"' *************
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = 6: g = 1
LOCATE 4, 32: PRINT " Gas Tank"
IF g = -2 THEN subt 1, 100
LOCATE 5, 32: PRINT " Lazer   "
IF g = -3 THEN subt 3, 250
LOCATE 6, 32: PRINT " Storage "
IF g = -4 THEN subt 2, 300
LOCATE 7, 32: PRINT " Thruster"
IF g = -5 THEN subt 4, 100
LOCATE 8, 32: PRINT " More    "
IF g = -6 THEN Men = 11: g = 1
END IF
IF Men = 10 THEN
LOCATE 1, 32: COLOR 15: PRINT "Add Part "' *************
COLOR 7
LOCATE 3, 32: PRINT " Prev    "
IF g = -1 THEN Men = 8: g = 6
LOCATE 4, 32: PRINT " Turn Jet"
IF g = -2 THEN add 5, 100
LOCATE 5, 32: PRINT " Hi Fuel"
IF g = -3 THEN add 6, 350
LOCATE 6, 32: PRINT " Plasma A"
IF g = -4 THEN add 7, 500
LOCATE 7, 32: PRINT " Plasma B"
IF g = -5 THEN add 8, 750
LOCATE 8, 32: PRINT " More    "
IF g = -6 THEN Men = 12: g = 1
END IF
IF Men = 11 THEN
LOCATE 1, 32: COLOR 15: PRINT "Sell Part"' *************
COLOR 7
LOCATE 3, 32: PRINT " Prev    "
IF g = -1 THEN Men = 9: g = 1
LOCATE 4, 32: PRINT " Turn Jet"
IF g = -2 THEN subt 5, 100
LOCATE 5, 32: PRINT " Hi Fuel"
IF g = -3 THEN subt 6, 350
LOCATE 6, 32: PRINT " Plasma A"
IF g = -4 THEN subt 7, 500
LOCATE 7, 32: PRINT " Plasma B"
IF g = -5 THEN subt 8, 750
LOCATE 8, 32: PRINT " More    "
IF g = -6 THEN Men = 13: g = 1
END IF
IF Men = 12 THEN
LOCATE 1, 32: COLOR 15: PRINT "Add Item "' *************
COLOR 7
LOCATE 3, 32: PRINT " Prev    "
IF g = -1 THEN Men = 10: g = 6
LOCATE 4, 32: PRINT " Dynamo  "
IF g = -2 THEN add 9, 150
LOCATE 5, 32: PRINT " Furnace "
IF g = -3 THEN add 10, 300
LOCATE 6, 32: PRINT " Bomber  "
IF g = -4 THEN add 11, 1000
LOCATE 7, 32: PRINT " Goto Top"
IF g = -5 THEN Men = 8: g = 1
LOCATE 8, 32: PRINT " Return  "
IF g = -6 THEN Men = 6: g = 1
END IF
IF Men = 13 THEN
LOCATE 1, 32: COLOR 15: PRINT "Sell Item"' *************
COLOR 7
LOCATE 3, 32: PRINT " Prev    "
IF g = -1 THEN Men = 11: g = 6
LOCATE 4, 32: PRINT " Dynamo  "
IF g = -2 THEN subt 9, 150
LOCATE 5, 32: PRINT " Furnace "
IF g = -3 THEN subt 10, 300
LOCATE 6, 32: PRINT " Bomber  "
IF g = -4 THEN subt 11, 1000
LOCATE 7, 32: PRINT " Goto Top"
IF g = -5 THEN Men = 9: g = 1
LOCATE 8, 32: PRINT " Return  "
IF g = -6 THEN Men = 6: g = 1
END IF
IF Men = 14 THEN
LOCATE 1, 32: COLOR 15: PRINT "Friend#"; STR$(Fdn)' *************
COLOR 7
LOCATE 3, 32: PRINT " Done    "
IF g = -1 THEN Men = 7: g = 1
LOCATE 4, 32: PRINT " Friend 1"
IF g = -2 THEN Fdn = 1: Men = 7: g = 1
LOCATE 5, 32: PRINT " Friend 2"
IF g = -3 THEN Fdn = 2: Men = 7: g = 1
LOCATE 6, 32: PRINT " Friend 3"
IF g = -4 THEN Fdn = 3: Men = 7: g = 1
LOCATE 7, 32: PRINT "         "
LOCATE 8, 32: PRINT "         "
END IF
IF Men = 15 THEN
LOCATE 1, 32: COLOR 15: PRINT "Select 1 "
COLOR 7
LOCATE 3, 32: PRINT " Done    "
IF g = -1 THEN Men = 7: g = 1
LOCATE 4, 32: PRINT sn$(1)
IF g = -2 THEN addFriend 1: Men = 7: g = 1
LOCATE 5, 32: PRINT sn$(2)
IF g = -2 THEN addFriend 2: Men = 7: g = 1
LOCATE 6, 32: PRINT sn$(3)
IF g = -2 THEN addFriend 3: Men = 7: g = 1
LOCATE 7, 32: PRINT sn$(0)
IF g = -2 THEN addFriend 0: Men = 7: g = 1
LOCATE 8, 32: PRINT sn$(0)
IF g = -2 THEN addFriend 0: Men = 7: g = 1
END IF
IF Men = 17 THEN
LOCATE 1, 32: COLOR 15: PRINT "Help Menu"
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = Master: g = 1
LOCATE 4, 32: PRINT " Menuhelp"
IF g = -2 THEN talk "MenuHelp"
LOCATE 5, 32: PRINT " Fighting"
IF g = -3 THEN talk "FightHelp"
LOCATE 6, 32: PRINT " Starmap "
IF g = -4 THEN talk "MapHelp"
LOCATE 7, 32: PRINT " Starbase"
IF g = -5 THEN talk "BaseHelp"
LOCATE 8, 32: PRINT " Talking "
IF g = -6 THEN talk "TalkHelp"
END IF
IF Men = 18 THEN
LOCATE 1, 32: COLOR 15: PRINT "Load Game"
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = 5: g = 1
LOCATE 4, 32: PRINT " Slot 1  "
IF g = -2 THEN load "Slot1"
LOCATE 5, 32: PRINT " Slot 2  "
IF g = -3 THEN load "Slot2"
LOCATE 6, 32: PRINT " Slot 3  "
IF g = -4 THEN load "Slot3"
LOCATE 7, 32: PRINT " Slot 4  "
IF g = -5 THEN load "Slot4"
LOCATE 8, 32: PRINT " Slot 5  "
IF g = -6 THEN load "Slot5"
END IF
IF Men = 19 THEN
LOCATE 1, 32: COLOR 15: PRINT "Save Game"
COLOR 7
LOCATE 3, 32: PRINT " Return  "
IF g = -1 THEN Men = 5: g = 1
LOCATE 4, 32: PRINT " Slot 1  "
IF g = -2 THEN save "Slot1"
LOCATE 5, 32: PRINT " Slot 2  "
IF g = -3 THEN save "Slot2"
LOCATE 6, 32: PRINT " Slot 3  "
IF g = -4 THEN save "Slot3"
LOCATE 7, 32: PRINT " Slot 4  "
IF g = -5 THEN save "Slot4"
LOCATE 8, 32: PRINT " Slot 5  "
IF g = -6 THEN save "Slot5"
END IF

IF g > 0 THEN COLOR 14 ELSE COLOR 9
LOCATE 2 + ABS(g), 32: PRINT "¯"
COLOR 7
END SUB

SUB Move (Men, g, an)
PLAY "mb l32 aaaa"
PLAY ON
zft = TIMER + 15 * RND
DO
DO: LOOP WHILE TIMER - zme < .02
zme = TIMER

IF TIMER - zft > 15 THEN attack INT(14 * RND + 1), INT(1 + 2 * RND): frame 2: zft = TIMER + 15 * RND: IF have("WarpPod") = 1 THEN shp.fuel = shp.fuel + 150: IF shp.fuel > maxfuel THEN shp.fuel = maxfuel
a$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
ox = me.x: oy = me.y
t = 0
IF a$ = CHR$(0) + "H" OR a$ = "8" THEN t = speed: shp.fuel = shp.fuel - (1 + speed / 2)
IF a$ = CHR$(0) + "K" OR a$ = "4" THEN an = an + turn * 10 + 5: shp.fuel = shp.fuel - 1 * RND
IF a$ = CHR$(0) + "M" OR a$ = "6" THEN an = an - turn * 10 - 5: shp.fuel = shp.fuel + 1 * RND
tx = -SIN(an * 6.28 / 360) * (2 + t * 3) * 100
ty = -COS(an * 6.28 / 360) * (2 + t * 3) * 100
me.mx = ((me.mx / 100 * 5 + tx / 100 * t) / (6 + t)) * 100
me.my = ((me.my / 100 * 5 + ty / 100 * t) / (6 + t)) * 100
me.x = me.x + me.mx / 15
me.y = me.y + me.my / 15
IF me.x < 0 THEN me.x = 0
IF me.y < 0 THEN me.y = 0
IF me.y > 5000 THEN me.y = 5000
IF me.x > 5000 THEN me.x = 5000
IF a$ = " " OR a$ = CHR$(13) THEN Enter me.x, me.y: IF me.systm <> 0 THEN IF me.systm > 0 THEN Men = 3: g = 1 ELSE IF me.systm = -1 THEN me.systm = 0: Men = 6: g = 1
IF shp.fuel < 0 THEN shp.fuel = -1: me.x = ox: me.y = oy
IF INT(me.x / 10) <> INT(ox / 10) OR INT(me.y / 10) <> INT(oy / 10) OR a$ <> "" THEN
Starmap me.x, me.y, an
COLOR 10
LOCATE 14, 19: PRINT "x"; me.x; "y"; me.y; "   "
status Shpspace, shp.cr, shp.fuel
END IF
LOOP WHILE a$ <> "s" AND s$ <> "S" AND g <> 1
PLAY STOP
a$ = ""
END SUB

FUNCTION nam$ (a)
a$ = CHR$(65 + 25 * RND)
FOR t = 2 TO a STEP 2
n = INT(5 * RND + 1)
IF n = 1 THEN a$ = a$ + "a"
IF n = 2 THEN a$ = a$ + "e"
IF n = 3 THEN a$ = a$ + "i"
IF n = 4 THEN a$ = a$ + "o"
IF n = 5 THEN a$ = a$ + "u"
NEXT t
a$ = a$ + CHR$(97 + 25 * RND)
nam$ = a$
END FUNCTION

SUB PAUSE
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
fPRINT "", 0
fPRINT "", 1
fPRINT "", 2
fPRINT "", 3
fPRINT "", 4
END SUB

SUB pic (p)
IF p = 11 THEN GOTO skipp
IF p = 1 THEN LINE (0, 0)-(129, 95), 0, BF ELSE LINE (0, 0)-(129, 95), 8, BF
LINE (20, 20)-(109, 20), 12
LINE (20, 20)-(0, 75), 12
LINE (109, 20)-(129, 75), 12
LINE (20, 20)-(20, 0), 12
LINE (109, 20)-(109, 0), 12
IF p = 10 THEN
FOR a = 1 TO 30 STEP 5
CIRCLE (65, 80 - a), a, 15
CIRCLE (66, 80 - a), a, 7
CIRCLE (66, 81 - a), a, 8
CIRCLE (65 - a / 2, 40), a / 2, 15
CIRCLE (66 - a / 2, 40), a / 2, 9
CIRCLE (66 - a / 2, 41), a / 2, 1
CIRCLE (65 + a / 2, 40), a / 2, 15
CIRCLE (66 + a / 2, 40), a / 2, 9
CIRCLE (66 + a / 2, 41), a / 2, 1
NEXT a
END IF
IF p = 3 THEN
FOR a = 1 TO 360 STEP 10
u = 30 + 15 * RND
DRAW "bm65,50ta=" + VARPTR$(a) + "c14u=" + VARPTR$(u)
DRAW "bm65,51ta=" + VARPTR$(a) + "c4u=" + VARPTR$(u)
NEXT a
FOR a = 1 TO 3.14 * 4
B = COS(a / 4) * 5
c = SIN(a / 4) * 10
CIRCLE (36 + B * 1.5, 40 + B * 1.5), c * 1.5 + 2, 7
CIRCLE (35 + B * 1.5, 41 + B * 1.5), c * 1.5 + 2, 7
CIRCLE (35 + B * 1.5, 40 + B * 1.5), c * 1.5 + 2, 15
CIRCLE (36 + B * 1.5, 41 + B * 1.5), c * 1.5 + 2, 8
CIRCLE (96 + B * 1.5, 40 + B * 1.5), c * 1.5 + 2, 7
CIRCLE (95 + B * 1.5, 41 + B * 1.5), c * 1.5 + 2, 7
CIRCLE (95 + B * 1.5, 40 + B * 1.5), c * 1.5 + 2, 15
CIRCLE (96 + B * 1.5, 41 + B * 1.5), c * 1.5 + 2, 8
NEXT a
c = 1
END IF
IF p = 8 THEN
FOR a = 1 TO 50 STEP 5
CIRCLE (66, 30 + a), 15, 7
CIRCLE (65, 31 + a), 15, 7
CIRCLE (65, 30 + a), 15, 15
CIRCLE (66, 31 + a), 15, 8
NEXT a
FOR a = 0 TO 8
CIRCLE (65, 30), a, 1
CIRCLE (67, 30), a, 9
CIRCLE (67, 32), a, 13
CIRCLE (65, 32), a, 5
CIRCLE (65, 60), a, 4, , , 1 / 2
CIRCLE (67, 60), a, 12, , , 1 / 2
CIRCLE (67, 62), a, 13, , , 1 / 2
CIRCLE (65, 62), a, 5, , , 1 / 2
NEXT a
c = 1
END IF
IF p = 1 OR p = 2 THEN
    LINE (35, 55)-(95, 85), 7, BF: LINE (35, 55)-(95, 85), 1, B
    LINE (45, 50)-(85, 85), 7, BF: LINE (45, 50)-(85, 85), 1, B
    LINE (65, 50)-(65, 85), 1
    CIRCLE (65, 35), 20, 15, , , 3 / 2: PAINT (65, 35), 7, 15: CIRCLE (65, 35), 20, 8, , , 3 / 2
    CIRCLE (60, 32), 3, 15, , , 1 / 2: CIRCLE (70, 32), 3, 15, , , 1 / 2
    CIRCLE (60, 32), 1, 9, , , 1 / 2: CIRCLE (70, 32), 1, 9, , , 1 / 2
    CIRCLE (65, 45), 3, 12, , , 1 / 2: CIRCLE (65, 44), 1, 4, , , 2 / 3
    IF p = 1 THEN FOR a = 1 TO 180: PSET (129 * RND, 95 * RND), 15: NEXT a
    c = 1
END IF
IF p = 6 THEN
    LINE (48, 30)-(82, 70), 4, BF
    LINE (48, 30)-(82, 70), 9, B
    CIRCLE (65, 64), 25, 15
    PAINT (65, 64), 6, 15
    CIRCLE (65, 64), 25, 9
    FOR a = 1 TO 360 STEP 360 / 9
    c = 10 + 10 * RND
    DRAW "bm65,64ta=" + VARPTR$(a) + "c15u=" + VARPTR$(c)
    NEXT a
    c = 15: LINE (30, 24)-(90, 18), c: LINE (30, 24)-(31, 35), c: LINE (90, 18)-(91, 34), c: LINE (31, 35)-(67, 45), c: LINE (67, 45)-(91, 35), c
    PAINT (65, 25), 6, 15
    c = 9: LINE (30, 24)-(90, 18), c: LINE (30, 24)-(31, 35), c: LINE (90, 18)-(91, 34), c: LINE (31, 35)-(67, 45), c: LINE (67, 45)-(91, 35), c
    CIRCLE (43, 29), 3, 15, , , 1 / 2
    CIRCLE (77, 27), 3, 15, , , 1 / 2
    c = 1
END IF

IF c = 1 THEN
LINE (0, 75)-(129, 95), 7, BF
LINE (0, 75)-(129, 95), 15, B
FOR a = 1 TO 13
CIRCLE (a * 10 - 3, 80), 1, 8
CIRCLE (a * 10 - 8, 90), 1, 8
CIRCLE (a * 10 - 3, 80), 0, 15
CIRCLE (a * 10 - 8, 90), 0, 15
NEXT a
END IF
skipp:
IF p = 11 THEN drawsys me.systm, me.plant
END SUB

FUNCTION power
p = 0
IF shp.p1 = 3 THEN p = p + 1
IF shp.p2 = 3 THEN p = p + 1
IF shp.p3 = 3 THEN p = p + 1
IF shp.p4 = 3 THEN p = p + 1
IF shp.p5 = 3 THEN p = p + 1
IF shp.p6 = 3 THEN p = p + 1
IF shp.p7 = 3 THEN p = p + 1
IF shp.p8 = 3 THEN p = p + 1
IF shp.p1 = 7 THEN p = p + 2
IF shp.p2 = 7 THEN p = p + 2
IF shp.p3 = 7 THEN p = p + 2
IF shp.p4 = 7 THEN p = p + 2
IF shp.p5 = 7 THEN p = p + 2
IF shp.p6 = 7 THEN p = p + 2
IF shp.p7 = 7 THEN p = p + 2
IF shp.p8 = 7 THEN p = p + 2
IF shp.p1 = 8 THEN p = p + 3
IF shp.p2 = 8 THEN p = p + 3
IF shp.p3 = 8 THEN p = p + 3
IF shp.p4 = 8 THEN p = p + 3
IF shp.p5 = 8 THEN p = p + 3
IF shp.p6 = 8 THEN p = p + 3
IF shp.p7 = 8 THEN p = p + 3
IF shp.p8 = 8 THEN p = p + 3
IF shp.p1 = 11 THEN p = p + 5
IF shp.p2 = 11 THEN p = p + 5
IF shp.p3 = 11 THEN p = p + 5
IF shp.p4 = 11 THEN p = p + 5
IF shp.p5 = 11 THEN p = p + 5
IF shp.p6 = 11 THEN p = p + 5
IF shp.p7 = 11 THEN p = p + 5
IF shp.p8 = 11 THEN p = p + 5
power = p
END FUNCTION

SUB pship (sh1, sh2, sh3, c1, c2, c3)
IF sh1 < 0 THEN sh1 = 0 ELSE IF sh1 > shpn THEN sh1 = shpn
IF sh2 < 0 THEN sh2 = 0 ELSE IF sh2 > shpn THEN sh2 = shpn
IF sh3 < 0 THEN sh3 = 0 ELSE IF sh3 > shpn THEN sh3 = shpn

PUT (140, 0), p%(0, sh1), PSET
PUT (140, 32), p%(0, sh2), PSET
PUT (140, 64), p%(0, sh3), PSET
COLOR 15
LOCATE 1, 24: PRINT sn$(sh1)
LOCATE 5, 24: PRINT sn$(sh2)
LOCATE 9, 24: PRINT sn$(sh3)
COLOR 10
LOCATE 2, 24: PRINT "Crew"; STR$(c1)
LOCATE 6, 24: PRINT "Crew"; STR$(c2)
LOCATE 10, 24: PRINT "Crew"; STR$(c3)
FOR a = 1 TO 3: FOR B = 1 TO 14
IF a + B * 3 - 3 <= c1 THEN c = 13 ELSE c = 0
CIRCLE (B * 4 + 180, a * 4 + 15), 1, c
PSET (B * 4 + 180, a * 4 + 15), c * 2
NEXT B: NEXT a
FOR a = 1 TO 3: FOR B = 1 TO 14
IF a + B * 3 - 3 <= c2 THEN c = 13 ELSE c = 0
CIRCLE (B * 4 + 180, a * 4 + 15 + 32), 1, c
PSET (B * 4 + 180, a * 4 + 15 + 32), c * 2
NEXT B: NEXT a
FOR a = 1 TO 3: FOR B = 1 TO 14
IF a + B * 3 - 3 <= c3 THEN c = 13 ELSE c = 0
CIRCLE (B * 4 + 180, a * 4 + 15 + 64), 1, c
PSET (B * 4 + 180, a * 4 + 15 + 64), c * 2
NEXT B: NEXT a
END SUB

FUNCTION question (cur)
ql = VAL(MID$(t$(cur), 4, 1))
DO
a$ = INKEY$
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN s = s - 1
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN s = s + 1
IF s < 1 THEN s = ql
IF s > ql THEN s = 1
FOR g = 1 TO 4
IF g <> s THEN COLOR 7
IF g = s THEN COLOR 15
IF g <= ql THEN fPRINT MID$(t$(cur + g), 4, 30), g + 5
IF g > ql THEN fPRINT "", g + 5
NEXT g
question = s
LOOP WHILE a$ <> CHR$(13)
fPRINT "", 0: fPRINT "", 1: fPRINT "", 2: fPRINT "", 3: fPRINT "", 4: fPRINT "", 6: fPRINT "", 7: fPRINT "", 8: fPRINT "", 9
END FUNCTION

FUNCTION rumble (typ1, defen)
CLS
cr = 1
IF defen = 1 THEN typ2 = shp.f1.typ: hp2 = shp.f1.crew
IF defen = 2 THEN typ2 = shp.f2.typ: hp2 = shp.f2.crew
IF defen = 3 THEN typ2 = shp.f3.typ: hp2 = shp.f3.crew
IF defen = 4 THEN typ2 = 0: hp2 = shp.crew
hp1 = crew(typ1)
x1 = 10: x2 = 10
y1 = 500
y2 = 150
bx1 = 400: bx2 = -10
DO
LOCATE 1, 1: PRINT "Attacker"; hp1
LOCATE 1, 25: PRINT "Defender"; hp2
ox1 = x1: oy1 = y1: ox2 = x2: oy2 = y2
obx1 = bx1: oby1 = by1
obx2 = bx2: oby2 = by2
x1 = SIN(TIMER * 2) * 30 + SIN(TIMER / 2.3) * 30 + 60
x2 = 289 - COS(TIMER * 2.5) * 30 - COS(TIMER / 1.5) * 30 - 60
IF bx1 > x2 AND (RND > .98 OR (y1 + 15 > y2 AND y1 + 15 < y2 + 30)) THEN
zst = TIMER
bx1 = x1 + 35
by1 = y1 + 15
END IF
IF ((bx2 > x1 + 40 AND bx2 > x1) AND (by2 - 30 < y1 + 15 AND by2 + 30 > y1 + 15)) AND SIN(TIMER) > 0 THEN
IF y1 + 15 < by2 THEN y1 = y1 - 3 ELSE y1 = y1 + 3
ELSE
IF y1 < y2 THEN y1 = y1 + 3 ELSE y1 = y1 - 3
END IF
ooa$ = oa$
oa$ = a$
a$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
IF a$ = "8" OR a$ = CHR$(0) + "H" OR oa$ = "8" OR oa$ = CHR$(0) + "H" OR ooa$ = "8" OR ooa$ = CHR$(0) + "H" THEN y2 = y2 - 5
IF a$ = "2" OR a$ = CHR$(0) + "P" OR oa$ = "2" OR oa$ = CHR$(0) + "P" OR ooa$ = "2" OR ooa$ = CHR$(0) + "P" THEN y2 = y2 + 5
IF (a$ = "+" OR a$ = " " OR a$ = CHR$(13)) THEN
bx2 = x2 - 5: by2 = y2 + 15
END IF
IF y1 < 0 THEN y1 = 0
IF y2 < 0 THEN y2 = 0
IF y1 > 169 THEN y1 = 169
IF y2 > 169 THEN y2 = 169
LINE (ox1, oy1)-(ox1 + 29, oy1 + 29), 0, BF
PUT (x1, y1), p%(0, typ1), PSET
LINE (ox2 - 30, oy2)-(ox2 + 29, oy2 + 29), 0, BF
IF defen < 4 THEN PUT (x2, y2), v%(0, typ2), PSET ELSE PUT (x2 - 30, y2), us%, PSET
DO: LOOP WHILE TIMER - zme < .1
zme = TIMER
IF bx1 < 320 THEN bx1 = bx1 + 20: SOUND bx1 + 100, .1
IF bx2 > 0 THEN bx2 = bx2 - 20: SOUND bx2 + 100, .1
LINE (obx1 - 5, oby1 - 5)-(obx1 + 5, oby1 + 5), 0, BF
IF bx1 < 314 AND by1 < 189 THEN PUT (bx1 - 5, by1 - 5), bp%(0, typ1), XOR
LINE (obx2 - 5, oby2 - 5)-(obx2 + 5, oby2 + 5), 0, BF
IF bx2 > 5 THEN PUT (bx2 - 5, by2 - 5), bv%(0, typ2), XOR
IF POINT(bx1 + 5, by1 - 5) > 0 AND bx1 > x2 THEN hp2 = hp2 - (1 + SQR(typ1)): bx1 = 400: blowup bx1, by1, 13
IF POINT(bx1 + 5, by1 + 5) > 0 AND bx1 > x2 THEN hp2 = hp2 - (1 + SQR(typ1)): bx1 = 400: blowup bx1, by1, 13
IF defen = 4 THEN pp = power ELSE pp = 0
IF POINT(bx2 - 5, by2 - 5) > 0 AND bx2 < x1 + 30 THEN hp1 = hp1 - (1 + SQR(typ2)) - pp: bx2 = -20: blowup bx2, by2, 13
IF POINT(bx2 - 5, by2 + 5) > 0 AND bx2 < x1 + 30 THEN hp1 = hp1 - (1 + SQR(typ2)) - pp: bx2 = -20: blowup bx2, by2, 13
LOOP UNTIL hp1 <= 0 OR hp2 <= 0
IF defen = 1 THEN shp.f1.crew = hp2
IF defen = 2 THEN shp.f2.crew = hp2
IF defen = 3 THEN shp.f3.crew = hp2
IF defen = 4 THEN shp.crew = hp2
IF hp1 <= 0 THEN
FOR a = 1 TO 15
blowup x1 + 30 * RND, y1 + 30 * RND, 10 + 10 * RND
NEXT a
END IF
IF hp2 <= 0 THEN
FOR a = 1 TO 15
blowup x2 + 30 * RND, y2 + 30 * RND, 10 + 10 * RND
NEXT a
IF defen = 1 THEN shp.f1.typ = 0: shp.f1.crew = 0
IF defen = 2 THEN shp.f2.typ = 0: shp.f2.crew = 0
IF defen = 3 THEN shp.f3.typ = 0: shp.f3.crew = 0
r = 1
END IF
rumble = r
END FUNCTION

SUB save (FILE$)
OPEN FILE$ + ".SAV" FOR OUTPUT AS #1
WRITE #1, me.x, me.y, me.systm, me.plant
WRITE #1, shp.fuel, shp.min, shp.cr
WRITE #1, shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
WRITE #1, shp.f1.typ, shp.f1.crew
WRITE #1, shp.f2.typ, shp.f2.crew
WRITE #1, shp.f3.typ, shp.f3.crew
FOR a = 1 TO SolarN
PRINT #1, syst(a).nam
WRITE #1, syst(a).col, syst(a).typ, syst(a).num
WRITE #1, syst(a).p1, syst(a).p2, syst(a).p3, syst(a).p4, syst(a).p5, syst(a).p6
WRITE #1, syst(a).x, syst(a).y
NEXT a
FOR a = 1 TO maxpln
SOUND 100, .1: SOUND 200, .5: SOUND 100, 0
WRITE #1, plant(a).temp, plant(a).rain, plant(a).quake
WRITE #1, plant(a).min, plant(a).life
NEXT a
FOR a = 1 TO 15
WRITE #1, Item$(a)
NEXT a
FOR a = 1 TO 99
WRITE #1, place(a)
NEXT a
CLOSE #1
END SUB

SUB scanpln (sol, plt)
IF plt = 1 THEN pl = syst(sol).p1
IF plt = 2 THEN pl = syst(sol).p2
IF plt = 3 THEN pl = syst(sol).p3
IF plt = 4 THEN pl = syst(sol).p4
IF plt = 5 THEN pl = syst(sol).p5
IF plt = 6 THEN pl = syst(sol).p6
LINE (0, 104)-(129, 199), 6, BF
tmp = plant(pl).temp
ran = plant(pl).rain
qak = plant(pl).quake
min = plant(pl).min
lif = plant(pl).life
FOR a = 1 TO min / 5
x = 120 * RND + 4
y = 85 * RND + 108
PSET (x, y), 15
PSET (x + 1, y), 7
PSET (x, y + 1), 7
PSET (x + 1, y + 1), 8
SOUND 100 + x + y, .1
NEXT a
FOR a = 1 TO lif
x = 120 * RND + 4
y = 85 * RND + 108
FOR B = 1 TO 3
CIRCLE (x, y), B, 10
CIRCLE (x + 1, y), B, 2
SOUND 100 + B * 100 + a * 10, .1
NEXT B
NEXT a
END SUB

SUB ship (p1, p2, p3, p4, p5, p6, p7, p8)
PUT (150, 160), pt%(0, p1), PSET
PUT (165, 160), pt%(0, p2), PSET
PUT (180, 160), pt%(0, p3), PSET
PUT (195, 160), pt%(0, p4), PSET
PUT (210, 160), pt%(0, p5), PSET
PUT (225, 160), pt%(0, p6), PSET
PUT (240, 160), pt%(0, p7), PSET
PUT (255, 160), pt%(0, p8), PSET
PUT (270, 160), tip%, PSET
END SUB

FUNCTION Shpspace
s = 0
IF shp.p1 = 2 THEN s = s + 700
IF shp.p2 = 2 THEN s = s + 700
IF shp.p3 = 2 THEN s = s + 700
IF shp.p4 = 2 THEN s = s + 700
IF shp.p5 = 2 THEN s = s + 700
IF shp.p6 = 2 THEN s = s + 700
IF shp.p7 = 2 THEN s = s + 700
IF shp.p8 = 2 THEN s = s + 700
Shpspace = s - shp.min
END FUNCTION

FUNCTION speed
s = 1
IF shp.p1 = 4 THEN s = s + 1
IF shp.p2 = 4 THEN s = s + 1
IF shp.p3 = 4 THEN s = s + 1
IF shp.p4 = 4 THEN s = s + 1
IF shp.p5 = 4 THEN s = s + 1
IF shp.p6 = 4 THEN s = s + 1
IF shp.p7 = 4 THEN s = s + 1
IF shp.p8 = 4 THEN s = s + 1
speed = s
END FUNCTION

SUB Starmap (x, y, an)
an = an MOD 360
IF x < 0 THEN x = 0
IF y < 0 THEN y = 0
IF x > 5000 THEN x = 5000
IF y > 5000 THEN y = 5000
LINE (0, 104)-(129, 199), 0, BF
DRAW "bm65,150ta=" + VARPTR$(an) + "c9d3u6c10f3l6e3"
sx = 250 - x / 10 + 65
sy = 250 - y / 10 + 150
IF sx >= 3 AND sx <= 126 AND sy >= 115 AND sy <= 196 THEN
LINE (sx - 3, sy - 3)-(sx + 3, sy + 3), 7, BF
LINE (sx, sy)-(sx, sy - 6), 7
LINE (sx - 3, sy - 3)-(sx + 3, sy + 3), 4, B
CIRCLE (sx, sy - 6), 1 + RND, 12
PSET (sx - 1, sy - 1), 9
PSET (sx + 1, sy - 1), 9
PSET (sx, sy + 1), 9
END IF
FOR a = 1 TO SolarN
sx = 65 + syst(a).x - x / 10
sy = 150 + syst(a).y - y / 10
IF sx >= 3 AND sx <= 126 AND sy >= 107 AND sy <= 196 THEN
FOR g = syst(a).typ / 2 TO syst(a).typ
CIRCLE (sx + 1, sy), g, 15
CIRCLE (sx, sy), g, syst(a).col + 8
NEXT g
END IF
NEXT a
LINE (129 - (x / 10 MOD 130), 104)-(129 - (x / 10 MOD 130), 199), 7
LINE (129 - ((x / 10 + 65) MOD 130), 104)-(129 - ((x / 10 + 65) MOD 130), 199), 7
LINE (0, 199 - (y / 10 MOD 95))-(129, 199 - (y / 10 MOD 95)), 7
LINE (0, 199 - ((y / 10 + 46) MOD 95))-(129, 199 - ((y / 10 + 46) MOD 95)), 7
END SUB

SUB Stars
FOR a = 1 TO 100
x = 120 * RND: y = 93 * RND
PSET (x, y), 15
x = 120 * RND: y = 93 * RND
PSET (x + 1, y), 7
x = 120 * RND: y = 93 * RND
PSET (x, y + 1), 7
x = 120 * RND: y = 93 * RND
PSET (x + 1, y + 1), 8
SOUND 1000 - a * 5, .1
NEXT a
END SUB

SUB status (sp, cr, fuel)
LOCATE 10, 32: COLOR 11: PRINT "Space"; LEFT$(STR$(sp \ 10) + "   ", 4)
LOCATE 11, 32: COLOR 10: PRINT "$"; STR$(cr); " "
LOCATE 12, 32: COLOR 15: PRINT "Fuel:"
LINE (288, 88)-(319, 88), 15
LINE (288, 95)-(319, 95), 8
LINE (288 + fuel / 10 + 1, 89)-(319, 94), 0, BF
LINE (288, 89)-(288 + fuel / 10, 94), 7, BF
END SUB

SUB subt (part, cost)
n = 0
IF shp.p1 = part THEN n = 1
IF shp.p2 = part THEN n = 2
IF shp.p3 = part THEN n = 3
IF shp.p4 = part THEN n = 4
IF shp.p5 = part THEN n = 5
IF shp.p6 = part THEN n = 6
IF shp.p7 = part THEN n = 7
IF shp.p8 = part THEN n = 8
IF n = 1 THEN shp.p1 = 0
IF n = 2 THEN shp.p2 = 0
IF n = 3 THEN shp.p3 = 0
IF n = 4 THEN shp.p4 = 0
IF n = 5 THEN shp.p5 = 0
IF n = 6 THEN shp.p6 = 0
IF n = 7 THEN shp.p7 = 0
IF n = 8 THEN shp.p8 = 0
IF n > 0 THEN shp.cr = shp.cr + cost
IF n > 0 THEN ship shp.p1, shp.p2, shp.p3, shp.p4, shp.p5, shp.p6, shp.p7, shp.p8
status Shpspace, shp.cr, shp.fuel
IF shp.fuel > maxfuel THEN shp.fuel = maxfuel
END SUB

SUB systemdat (sys, pl)
IF sys = 0 AND pl = 0 THEN LINE (140, 103)-(319, 127), 0, BF
IF sys < 1 THEN GOTO skip
IF sys > SolarN THEN sys = SolarN
IF pl > syst(sys).num THEN pl = syst(sys).num
IF pl < 1 THEN pl = 1
IF pl = 1 THEN p = syst(sys).p1
IF pl = 2 THEN p = syst(sys).p2
IF pl = 3 THEN p = syst(sys).p3
IF pl = 4 THEN p = syst(sys).p4
IF pl = 5 THEN p = syst(sys).p5
IF pl = 6 THEN p = syst(sys).p6
COLOR 15
LOCATE 14, 19: PRINT col$(syst(sys).col); " "; typ$(syst(sys).typ); "       "
COLOR 10
LOCATE 15, 19: PRINT syst(sys).nam; " "; r$(pl); "     "
LOCATE 16, 19: COLOR 12: PRINT "Temp"; plant(p).temp; : COLOR 9: PRINT "Weather"; plant(p).rain; " "
skip:
drawsys sys, pl
END SUB

SUB take (IT$)
FOR a = 1 TO 15
IF Item$(a) = IT$ THEN Item$(a) = "": a = 101
NEXT a
CALL compress
END SUB

SUB talk (lbl$)
frame 1
cur = find(lbl$)
DO
IF l <= length THEN
    c$ = LEFT$(t$(cur), 2)
    IF LEFT$(t$(cur), 1) = "%" THEN
        IF c$ = "%G" THEN cur = find(MID$(t$(cur), 4))
        IF c$ = "%D" THEN pic VAL(MID$(t$(cur), 4))
        IF c$ = "%A" THEN attack VAL(MID$(t$(cur), 4, 2)), VAL(MID$(t$(cur), 7, 2)): frame 1
        IF c$ = "%P" THEN t = 6
        IF c$ = "%Q" THEN cur = find(MID$(t$(cur + question(cur)), 34)): t = 0
        IF c$ = "%F" THEN IF place(VAL(MID$(t$(cur), 4, 2))) = 0 THEN place(VAL(MID$(t$(cur), 4, 2))) = 1: cur = find(MID$(t$(cur), 7))
        IF c$ = "%g" THEN give MID$(t$(cur), 4)
        IF c$ = "%t" THEN take MID$(t$(cur), 4)
        IF c$ = "%I" THEN IF have(MID$(t$(cur), 4, 30)) = 1 THEN cur = find(MID$(t$(cur), 34))
        IF c$ = "%M" THEN IF shp.cr >= VAL(MID$(t$(cur), 4, 20)) THEN cur = find(MID$(t$(cur), 34))
        IF c$ = "%p" THEN shp.cr = shp.cr + VAL(MID$(t$(cur), 4)): status Shpspace, shp.cr, shp.fuel
        IF c$ = "%c" THEN shp.cr = shp.cr - VAL(MID$(t$(cur), 4)): status Shpspace, shp.cr, shp.fuel
        IF c$ = "%T" THEN n = VAL(MID$(t$(cur), 4)): COLOR 9: fPRINT ((syst(n).nam) + STR$(syst(n).x * 10) + STR$(syst(n).y * 10)), t: t = t + 1
        IF c$ = "%S" THEN Gship (VAL(MID$(t$(cur), 4)))
        IF c$ = "%s" THEN Tship (VAL(MID$(t$(cur), 4)))
    ELSE
        COLOR 9: fPRINT t$(cur), t: t = t + 1
    END IF
    IF t >= 5 THEN t = 0: CALL PAUSE
    cur = cur + 1
END IF
LOOP WHILE c$ <> "%E" AND cur <= length
frame 2
END SUB

SUB Tship (n)
IF n = 1 THEN t = shp.f1.typ: shp.f1.typ = 0: shp.f1.crew = 0
IF n = 2 THEN t = shp.f2.typ: shp.f2.typ = 0: shp.f2.crew = 0
IF n = 3 THEN t = shp.f3.typ: shp.f3.typ = 0: shp.f3.crew = 0
IF t = 1 THEN shp.cr = shp.cr + 900
IF t = 2 THEN shp.cr = shp.cr + 900
IF t = 3 THEN shp.cr = shp.cr + 900
IF t = 4 THEN shp.cr = shp.cr + 900
IF t = 5 THEN shp.cr = shp.cr + 950
IF t = 6 THEN shp.cr = shp.cr + 950
IF t = 7 THEN shp.cr = shp.cr + 950
IF t = 8 THEN shp.cr = shp.cr + 950
IF t = 9 THEN shp.cr = shp.cr + 950
IF t = 10 THEN shp.cr = shp.cr + 1000
IF t = 11 THEN shp.cr = shp.cr + 1200
IF t = 12 THEN shp.cr = shp.cr + 1300
IF t = 13 THEN shp.cr = shp.cr + 1400
IF t = 14 THEN shp.cr = shp.cr + 3000
pship shp.f1.typ, shp.f2.typ, shp.f3.typ, shp.f1.crew, shp.f2.crew, shp.f3.crew
status Shpspace, shp.cr, shp.fuel
END SUB

FUNCTION turn
t = 1
IF shp.p1 = 5 THEN t = t + 1
IF shp.p2 = 5 THEN t = t + 1
IF shp.p3 = 5 THEN t = t + 1
IF shp.p4 = 5 THEN t = t + 1
IF shp.p5 = 5 THEN t = t + 1
IF shp.p6 = 5 THEN t = t + 1
IF shp.p7 = 5 THEN t = t + 1
IF shp.p8 = 5 THEN t = t + 1
turn = t
END FUNCTION

