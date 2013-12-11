DEFINT A-Z
DIM map(121, 121)
DIM f$(26), n$(26), x(26), y(26)
f$(1) = "CITY_A.UTX": n$(1) = "SimBa¤o"
f$(2) = "CITY_B.UTX": n$(2) = "Capetown"
f$(3) = "CITY_C.UTX": n$(3) = "C-c"
f$(4) = "CITY_D.UTX": n$(4) = "C-d"
f$(5) = "CITY_E.UTX": n$(5) = "Farout Post"
f$(6) = "CITY_F.UTX": n$(6) = "Hermit's House"
f$(7) = "CITY_G.UTX": n$(7) = "Moasis"
f$(8) = "CITY_H.UTX": n$(8) = "C-h"
f$(9) = "CITY_I.UTX": n$(9) = "C-i"
f$(10) = "CITY_J.UTX": n$(10) = "C-j"
f$(11) = "CITY_K.UTX": n$(11) = "Stone Haven"
f$(12) = "CITY_L.UTX": n$(12) = "C-l"
f$(13) = "CITY_M.UTX": n$(13) = "Ferudda"
f$(14) = "CITY_N.UTX": n$(14) = "Cliffport"
f$(15) = "CITY_O.UTX": n$(15) = "C-o"
f$(16) = "CITY_P.UTX": n$(16) = "Marino"
f$(17) = "CITY_Q.UTX": n$(17) = "Fort Pine"
f$(18) = "CITY_R.UTX": n$(18) = "Mountainview"
f$(19) = "CITY_S.UTX": n$(19) = "C-s"
f$(20) = "CITY_T.UTX": n$(20) = "C-t"
f$(21) = "CITY_U.UTX": n$(21) = "Your Home"
f$(22) = "CITY_V.UTX": n$(22) = "C-v"
f$(23) = "CITY_W.UTX": n$(23) = "C-w"
f$(24) = "CITY_X.UTX": n$(24) = "Ant¡ba¤o"
f$(25) = "CITY_Y.UTX": n$(25) = "C-y"
f$(26) = "CITY_Z.UTX": n$(26) = "C-z"

SCREEN 12
FOR y = 1 TO 3 * 5
FOR x = 1 TO 3
READ c
PSET (x, y), c
NEXT x
NEXT y
DIM a1%(9), a2%(9), a3%(9), a4%(9), a5%(9)
GET (1, 1)-(3, 3), a1%
GET (1, 4)-(3, 6), a2%
GET (1, 7)-(3, 9), a3%
GET (1, 10)-(3, 12), a4%
GET (1, 13)-(3, 15), a5%
DEF SEG = VARSEG(map(0, 0))
BLOAD "light.map", 0
CLS
'
DATA 01,09,01
DATA 01,01,09
DATA 09,01,09
'
DATA 02,10,15
DATA 02,15,06
DATA 15,02,10
'
DATA 06,07,02
DATA 10,06,02
DATA 07,02,06
'
DATA 14,06,06
DATA 14,14,14
DATA 06,14,06
'
DATA 07,07,06
DATA 04,06,04
DATA 07,06,07
GOSUB drawmap
x = 10: y = 10
FOR a = 1 TO 26
LOCATE a + 1, 61: IF x(a) > 0 THEN PRINT "*" ELSE PRINT " "
LOCATE a + 1, 62: PRINT LEFT$(n$(a) + SPACE$(18), 18);
NEXT a
DO
ox = x: oy = y
a$ = INKEY$
IF a$ <> "" THEN
IF a$ = "s" THEN GOSUB save
IF a$ = "q" THEN GOSUB save: STOP
IF a$ = "8" THEN y = y - 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "2" THEN y = y + 1
IF a$ = "l" THEN x = x + 5
IF a$ = "j" THEN x = x - 5
IF a$ = "i" THEN y = y - 5
IF a$ = "k" THEN y = y + 5
IF x < 1 THEN x = 120
IF x > 120 THEN x = 1
IF y < 1 THEN y = 120
IF y > 120 THEN y = 1
IF a$ = "z" THEN map(x, y) = 0
IF a$ = "x" THEN map(x, y) = 1
IF a$ = "c" THEN map(x, y) = 2
IF a$ = "v" THEN map(x, y) = 3
IF a$ = "b" THEN map(x, y) = 4
IF a$ = "h" THEN
  GOSUB putcity
  map(x, y) = -cty
  FOR a = 1 TO 26
    LOCATE a + 1, 61: IF x(a) > 0 THEN PRINT "*" ELSE PRINT " "
    LOCATE a + 1, 62: PRINT LEFT$(n$(a) + SPACE$(18), 18);
  NEXT a
END IF

LOCATE 1, 62: PRINT "x"; x; "y"; y
END IF
IF x <> ox OR y <> oy OR a$ <> "" THEN
l = map(ox, oy)
IF l < 0 THEN LINE (ox * 4 - 3, oy * 4 - 3)-(ox * 4 - 1, oy * 4 - 1), 0, BF
IF l = 0 THEN PUT (ox * 4 - 3, oy * 4 - 3), a1%, PSET: GOTO l
IF l = 1 THEN PUT (ox * 4 - 3, oy * 4 - 3), a2%, PSET: GOTO l
IF l = 2 THEN PUT (ox * 4 - 3, oy * 4 - 3), a3%, PSET: GOTO l
IF l = 3 THEN PUT (ox * 4 - 3, oy * 4 - 3), a4%, PSET: GOTO l
IF l = 4 THEN PUT (ox * 4 - 3, oy * 4 - 3), a5%, PSET
LOCATE 1, 62: PRINT SPACE$(18);
END IF
l = map(x, y)
IF l < 0 THEN LOCATE 1, 62: PRINT LEFT$(n$(-l) + SPACE$(18), 18);
CIRCLE (x * 4 - 2, y * 4 - 2), 1, 15 * RND
l:
LOOP
save:
DEF SEG = VARSEG(map(0, 0))
BSAVE "light.map", 0, VARPTR(map(121, 121))
RETURN
OPEN "ultima.map" FOR OUTPUT AS #1
FOR y = 1 TO 120
a$ = ""
FOR x = 1 TO 120
a$ = a$ + CHR$(map(x, y) + 100)
NEXT x
PRINT #1, a$
NEXT y
CLOSE #1
RETURN
drawmap:
CLS
FOR x = 1 TO 120
FOR y = 1 TO 120
l = map(x, y)
IF l < 0 THEN LINE (x * 4 - 3, y * 4 - 3)-(x * 4 - 1, y * 4 - 1), 0, BF: x(-l) = x: y(-l) = y
IF l = 0 THEN PUT (x * 4 - 3, y * 4 - 3), a1%, PSET: GOTO j
IF l = 1 THEN PUT (x * 4 - 3, y * 4 - 3), a2%, PSET: GOTO j
IF l = 2 THEN PUT (x * 4 - 3, y * 4 - 3), a3%, PSET: GOTO j
IF l = 3 THEN PUT (x * 4 - 3, y * 4 - 3), a4%, PSET: GOTO j
IF l = 4 THEN PUT (x * 4 - 3, y * 4 - 3), a5%, PSET
j:
'IF x / 15 = INT(x / 15) THEN LINE (x * 4, y * 4 - 4)-(x * 4, y * 4), 15
'IF y / 15 = INT(y / 15) THEN LINE (x * 4 - 4, y * 4)-(x * 4, y * 4), 15
NEXT y
NEXT x
RETURN

putcity:
BEEP:
DO
a$ = INKEY$
IF a$ = "-" OR a$ = "8" THEN cty = cty - 1
IF a$ = "+" OR a$ = "2" THEN cty = cty + 1
IF cty < 1 THEN cty = 26
IF cty > 26 THEN cty = 1
LOCATE 1, 62: PRINT LEFT$(n$(cty) + SPACE$(18), 18);
IF a$ = " " AND x(cty) > 0 THEN a$ = "": BEEP
LOOP WHILE a$ <> " "
x(cty) = x: y(cty) = y
RETURN

