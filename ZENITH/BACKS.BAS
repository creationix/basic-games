DECLARE SUB tbox (sx1%, sy1%, sx2%, sy2%)
DECLARE SUB gbar (x1%, y1%, x2%, y2%)
DECLARE SUB viewbox (sx1%, sy1%, sx2%, sy2%)
DEFINT A-Z
SCREEN 7

FOR a = 1 TO 200
s = 3 * RND
X = 320 * RND
Y = 200 * RND
PSET (X - 1, Y), 11: PSET (X + 1, Y), 11: PSET (X, Y - 1), 11: PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9: PSET (X - 1, Y + 1), 9: PSET (X + 1, Y - 1), 9: PSET (X + 1, Y + 1), 9
PSET (X - s, Y - s), 8: PSET (X - s, Y + s), 8: PSET (X + s, Y - s), 8: PSET (X + s, Y + s), 8
PSET (X - s, Y), 7: PSET (X + s, Y), 7: PSET (X, Y - s), 7: PSET (X, Y + s), 7
PSET (X, Y), 15
NEXT a
tbox 2, 2, 21, 21
FOR a = 8 TO 14 STEP 3
READ a$
tbox 23, a, 39, a
COLOR 14
LOCATE a, 23: PRINT a$
NEXT a
tbox 24, 2, 27, 5
viewbox 225, 179, 317, 196
LOCATE 24, 32: COLOR 12: PRINT " Done ";
viewbox 2, 179, 100, 196
LOCATE 24, 4: COLOR 12: PRINT " Stay ";
tbox 16, 24, 26, 24
LOCATE 24, 16: COLOR 12: PRINT " Send ";
tbox 24, 18, 34, 18


DATA "Owner:"
DATA "Type:"
DATA "Hull:"



DIM p%(32000)
GET (0, 0)-(319, 199), p%
DEF SEG = VARSEG(p%(0))
BSAVE "ship.pic", 0, VARPTR(p%(32000))



END
FOR a = 1 TO 20
s = 3 * RND
X = 320 * RND
Y = 200 * RND
PSET (X - 1, Y), 11: PSET (X + 1, Y), 11: PSET (X, Y - 1), 11: PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9: PSET (X - 1, Y + 1), 9: PSET (X + 1, Y - 1), 9: PSET (X + 1, Y + 1), 9
PSET (X - s, Y - s), 8: PSET (X - s, Y + s), 8: PSET (X + s, Y - s), 8: PSET (X + s, Y + s), 8
PSET (X - s, Y), 7: PSET (X + s, Y), 7: PSET (X, Y - s), 7: PSET (X, Y + s), 7
PSET (X, Y), 15
NEXT a
tbox 2, 2, 21, 21
FOR a = 8 TO 14 STEP 3
READ a$
tbox 23, a, 39, a
COLOR 14
LOCATE a, 23: PRINT a$
NEXT a
tbox 24, 2, 27, 5
viewbox 225, 179, 317, 196
LOCATE 24, 32: COLOR 12: PRINT " Done ";
viewbox 2, 179, 100, 196
LOCATE 24, 4: COLOR 12: PRINT " Stay ";



DATA "Owner:"
DATA "Type:"
DATA "Hull:"




END
DIM C(15, 15)
viewbox 1, 1, 317, 197
tbox 2, 2, 21, 21
tbox 2, 23, 21, 24
tbox 23, 2, 27, 7
tbox 23, 9, 27, 16
tbox 23, 18, 39, 24
FOR a = 1 TO 6
COLOR 9 + a MOD 2: LOCATE a + 1, 23
PRINT "Ship"; MID$(STR$(a), 2, 1)
NEXT a
FOR a = 2 TO 10 STEP 2
tbox 29, a, 39, a
READ a$: COLOR 13
LOCATE a, 30: PRINT a$
NEXT a
tbox 29, 12, 39, 16
COLOR 15: LOCATE 18, 23: PRINT CHR$(24)
FOR a = 19 TO 23
LOCATE a, 23
PRINT "³";
NEXT a
COLOR 15: LOCATE 24, 23: PRINT CHR$(25);
FOR Y = 1 TO 15
FOR X = 1 TO 15
READ C
IF C > 8 THEN C = C - 8 ELSE IF C > 0 AND C < 8 THEN C = C + 8
PSET (258 + X, 90 + Y), C
PSET (258 + X, 125 - Y), C
PSET (234 + Y, 100 + X), C
PSET (300 - Y, 100 + X), C
NEXT X
NEXT Y
FOR Y = 1 TO 15
FOR X = 1 TO 15
READ C
IF C > 8 THEN C = C - 8 ELSE IF C > 0 AND C < 8 THEN C = C + 8
PSET (184 + X, 73 + Y), C
NEXT X
NEXT Y
FOR Y = 1 TO 15
FOR X = 1 TO 15
READ C
IF C > 8 THEN C = C - 8 ELSE IF C > 0 AND C < 8 THEN C = C + 8
PSET (184 + X, 100 + Y), C
NEXT X
NEXT Y


DATA End Turn
DATA Load Game
DATA Save Game
DATA Quit Game
DATA Main Menu
DATA 0,0,0,0,0,9,9,9,9,9,0,0,0,0,0
DATA 0,0,0,0,9,1,5,5,5,1,9,0,0,0,0
DATA 0,0,0,9,1,5,1,5,1,5,1,9,0,0,0
DATA 0,0,9,1,5,1,1,5,1,1,5,1,9,0,0
DATA 0,9,1,5,1,9,1,5,1,9,1,5,1,9,0
DATA 9,1,5,1,9,9,1,5,1,9,9,1,5,1,9
DATA 0,9,9,9,0,9,1,5,1,9,0,9,9,9,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,5,1,9,0,0,0,0,0
DATA 0,0,0,0,0,0,9,9,9,0,0,0,0,0,0

DATA 0,0,0,0,0,0,0,9,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,9,1,9,0,0,0,0,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,9,9,9,9,1,2,1,9,9,9,9,0,0
DATA 0,9,1,1,1,1,1,2,1,1,1,1,1,9,0
DATA 9,1,2,2,2,2,2,2,2,2,2,2,2,1,9
DATA 0,9,1,1,1,1,1,2,1,1,1,1,1,9,0
DATA 0,0,9,9,9,9,1,2,1,9,9,9,9,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,0,0,0,9,1,2,1,9,0,0,0,0,0
DATA 0,0,0,0,0,0,9,1,9,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,9,0,0,0,0,0,0,0

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,9,9,9,9,9,9,9,9,9,9,9,0,0
DATA 0,9,1,1,1,1,1,1,1,1,1,1,1,9,0
DATA 9,1,2,2,2,2,2,2,2,2,2,2,2,1,9
DATA 0,9,1,1,1,1,1,1,1,1,1,1,1,9,0
DATA 0,0,9,9,9,9,9,9,9,9,9,9,9,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

END
a$ = "     New Game    "
gx = LEN(a$) * 8
LOCATE 10, 1: COLOR 14: PRINT a$
FOR Y = 71 TO 80
FOR X = 0 TO gx
IF POINT(X, Y) = 0 AND (POINT(X, Y + 1) = 14 OR POINT(X + 1, Y) = 14) THEN PSET (X, Y), 1
IF POINT(X, Y) = 0 AND (POINT(X, Y - 1) = 14 OR POINT(X - 1, Y) = 14) THEN PSET (X, Y), 5
NEXT X
NEXT Y
sx! = 300 / gx
viewbox 5, 5, 314, 45
FOR Y = -4 TO 9
FOR X = 0 TO gx - 1
C = POINT(X, Y + 72)
ax = 10 + X * sx!
ay = 25 + (Y - 3) * sx!
LINE (ax, ay)-(ax + sx!, ay + sx!), C, BF
NEXT X
NEXT Y
LINE (0, 50)-(95, 200), 0, BF
FOR a = 1 TO 300
s = 3 * RND
X = 320 * RND
Y = 150 * RND + 50
PSET (X - 1, Y), 11: PSET (X + 1, Y), 11: PSET (X, Y - 1), 11: PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9: PSET (X - 1, Y + 1), 9: PSET (X + 1, Y - 1), 9: PSET (X + 1, Y + 1), 9
PSET (X - s, Y - s), 8: PSET (X - s, Y + s), 8: PSET (X + s, Y - s), 8: PSET (X + s, Y + s), 8
PSET (X - s, Y), 7: PSET (X + s, Y), 7: PSET (X, Y - s), 7: PSET (X, Y + s), 7
PSET (X, Y), 15
NEXT a


FOR a = 10 TO 20 STEP 2
viewbox 5, a * 8 - 11, 314, a * 8 + 1
READ a$
LOCATE a, 2: COLOR 10: PRINT a$
a$ = "e3d6h6d6r6u6l6d3r6"
IF a = 16 THEN a$ = ""
PSET (12, a * 8 - 5), 15: DRAW a$
PSET (13, a * 8 - 4), 8: DRAW a$
PSET (12, a * 8 - 4), 4: DRAW a$
PSET (13, a * 8 - 5), 12: DRAW a$
NEXT a

viewbox 2, 181, 100, 197
viewbox 105, 181, 200, 197
viewbox 205, 181, 317, 197
LOCATE 24, 5: COLOR 14: PRINT "Done";
LOCATE 24, 17: COLOR 14: PRINT "Reset";
LOCATE 24, 31: COLOR 14: PRINT "Cancel";



END

DATA "  Number of Planets:                  "
DATA "  Starting Money:                     "
DATA "  Number of Players:                  "
DATA "                        Yes     No    "
DATA "  Random Events                       "
DATA "  Looking at Enemies                  "


END







END
a$ = "Ship Designer"
gx = LEN(a$) * 8
LOCATE 10, 1: COLOR 7: PRINT a$
FOR Y = 71 TO 80
FOR X = 0 TO gx
IF POINT(X, Y) = 0 AND (POINT(X, Y + 1) = 7 OR POINT(X + 1, Y) = 7) THEN PSET (X, Y), 15
IF POINT(X, Y) = 0 AND (POINT(X, Y - 1) = 7 OR POINT(X - 1, Y) = 7) THEN PSET (X, Y), 8
NEXT X
NEXT Y
sx! = 260 / gx
viewbox 317, 1, 53, 49
FOR Y = -4 TO 9
FOR X = 0 TO gx - 1
C = POINT(X, Y + 72)
ax = 55 + X * sx!
ay = 25 + (Y - 3) * sx!
LINE (ax, ay)-(ax + sx!, ay + sx!), C, BF
NEXT X
NEXT Y
viewbox 2, 1, 50, 49
FOR a = 8 TO 22 STEP 2
viewbox 2, a * 8 - 11, 317, a * 8 + 1
COLOR 12
READ a$
LOCATE a, 2: PRINT a$

a$ = "u3l1d6l1u6l1d6r6u6l1d6l1u6"
IF a = 10 OR a > 18 THEN a$ = ""
PSET (12, a * 8 - 5), 15: DRAW a$
PSET (13, a * 8 - 4), 8: DRAW a$
PSET (12, a * 8 - 4), 1: DRAW a$
PSET (13, a * 8 - 5), 9: DRAW a$
NEXT a
viewbox 2, 181, 100, 197
viewbox 105, 181, 200, 197
viewbox 205, 181, 317, 197
LOCATE 24, 5: COLOR 14: PRINT "Done";
LOCATE 24, 17: COLOR 14: PRINT "Reset";
LOCATE 24, 31: COLOR 14: PRINT "Cancel";
DATA "  Name:                               "
DATA "              Cost     Size     Power "
DATA "  Weapon                              "
DATA "  Shield                              "
DATA "  Engine                              "
DATA "  Size                                "
DATA "  Total                               "
DATA "  Vault                Elec           "





a$ = "    Game Menu    "
gx = LEN(a$) * 8
LOCATE 10, 1: COLOR 8: PRINT a$
FOR Y = 71 TO 80
FOR X = 0 TO gx
IF POINT(X, Y) = 0 AND (POINT(X, Y + 1) = 8 OR POINT(X + 1, Y) = 8) THEN PSET (X, Y), 9
IF POINT(X, Y) = 0 AND (POINT(X, Y - 1) = 8 OR POINT(X - 1, Y) = 8) THEN PSET (X, Y), 12
NEXT X
NEXT Y
sx! = 300 / gx
viewbox 5, 5, 314, 45
FOR Y = -4 TO 9
FOR X = 0 TO gx - 1
C = POINT(X, Y + 72)
ax = 10 + X * sx!
ay = 25 + (Y - 3) * sx!
LINE (ax, ay)-(ax + sx!, ay + sx!), C, BF
NEXT X
NEXT Y
LINE (0, 50)-(320, 200), 0, BF
FOR a = 1 TO 300
s = 3 * RND
X = 320 * RND
Y = 150 * RND + 50
PSET (X - 1, Y), 11: PSET (X + 1, Y), 11: PSET (X, Y - 1), 11: PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9: PSET (X - 1, Y + 1), 9: PSET (X + 1, Y - 1), 9: PSET (X + 1, Y + 1), 9
PSET (X - s, Y - s), 8: PSET (X - s, Y + s), 8: PSET (X + s, Y - s), 8: PSET (X + s, Y + s), 8
PSET (X - s, Y), 7: PSET (X + s, Y), 7: PSET (X, Y - s), 7: PSET (X, Y + s), 7
PSET (X, Y), 15
NEXT a
FOR a = 1 TO 320 STEP 10
gbar a, 55, 160, 200
NEXT a
gbar 1, 55, 160, 200
FOR a = 9 TO 24 STEP 3
viewbox 100, a * 8 - 13, 220, a * 8 + 4
READ a$
LOCATE a, 16: COLOR 9: PRINT a$;
NEXT a
viewbox 5, 59, 95, 76
viewbox 225, 179, 317, 196
LOCATE 24, 32: COLOR 14: PRINT "Cancel";




DATA "  Game 1  "
DATA "  Game 2  "
DATA "  Game 3  "
DATA "  Game 4  "
DATA "  Game 5  "
DATA "  Game 6  "





tbox 2, 2, 5, 5
tbox 7, 2, 39, 5
FOR a = 8 TO 19 STEP 3
READ a$
tbox 2, a, 39, a
COLOR 14
LOCATE a, 2: PRINT a$
NEXT a
viewbox 225, 179, 317, 196
LOCATE 24, 32: COLOR 12: PRINT " Done ";
viewbox 2, 179, 100, 196
LOCATE 24, 4: COLOR 12: PRINT " Reset ";


DATA "Owner:"
DATA "Type:"
DATA "Producing:"
DATA "Left:"
DATA "Size:"

tbox 16, 1, 22, 1
tbox 3, 3, 17, 3
tbox 21, 3, 38, 3
tbox 3, 5, 17, 5
tbox 21, 5, 38, 5
tbox 4, 8, 37, 22
LOCATE 1, 16: COLOR 15: PRINT "-FIGHT-"

END


a$ = "     Zenith     "
gx = LEN(a$) * 8
LOCATE 10, 1: COLOR 9: PRINT a$
FOR Y = 71 TO 80
FOR X = 0 TO gx
IF POINT(X, Y) = 0 AND (POINT(X, Y + 1) = 9 OR POINT(X + 1, Y) = 9) THEN PSET (X, Y), 15
IF POINT(X, Y) = 0 AND (POINT(X, Y - 1) = 9 OR POINT(X - 1, Y) = 9) THEN PSET (X, Y), 1
NEXT X
NEXT Y
sx! = 300 / gx
viewbox 5, 5, 314, 45
FOR Y = -4 TO 9
FOR X = 0 TO gx - 1
C = POINT(X, Y + 72)
ax = 10 + X * sx!
ay = 25 + (Y - 3) * sx!
LINE (ax, ay)-(ax + sx!, ay + sx!), C, BF
NEXT X
NEXT Y
LINE (0, 50)-(95, 200), 0, BF
FOR a = 1 TO 300
s = 3 * RND
X = 320 * RND
Y = 150 * RND + 50
PSET (X - 1, Y), 11: PSET (X + 1, Y), 11: PSET (X, Y - 1), 11: PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9: PSET (X - 1, Y + 1), 9: PSET (X + 1, Y - 1), 9: PSET (X + 1, Y + 1), 9
PSET (X - s, Y - s), 8: PSET (X - s, Y + s), 8: PSET (X + s, Y - s), 8: PSET (X + s, Y + s), 8
PSET (X - s, Y), 7: PSET (X + s, Y), 7: PSET (X, Y - s), 7: PSET (X, Y + s), 7
PSET (X, Y), 15
NEXT a
FOR a = 9 TO 24 STEP 3
viewbox 100, a * 8 - 13, 220, a * 8 + 4
READ a$
LOCATE a, 16: COLOR 15: PRINT a$;
NEXT a


DATA " New Game "
DATA "Load Game "
DATA "Save Game "
DATA " Continue "
DATA " Credits  "
DATA "  Quit    "

SUB gbar (x1, y1, x2, y2)
FOR a = -2 TO 2
FOR b = -2 TO 2
LINE (x1 + a, y1 + b)-(x2 + a, y2 + b), 8
NEXT b
NEXT a
FOR a = -1 TO 1
FOR b = -1 TO 1
LINE (x1 + a, y1 + b)-(x2 + a, y2 + b), 7
NEXT b
NEXT a
LINE (x1, y1)-(x2, y2), 15
END SUB

SUB tbox (sx1, sy1, sx2, sy2)
x1 = sx1 * 8 - 8 - 3
y1 = sy1 * 8 - 8 - 3
x2 = sx2 * 8 + 1
y2 = sy2 * 8 + 1
LINE (x1, y1)-(x2, y2), 0, BF
gbar x1, y1, x1, y2
gbar x2, y1, x2, y2
gbar x1, y1, x2, y1
gbar x1, y2, x2, y2
END SUB

SUB viewbox (x1, y1, x2, y2)
LINE (x1, y1)-(x2, y2), 8, BF
gbar x1, y1, x1, y2
gbar x2, y1, x2, y2
gbar x1, y1, x2, y1
gbar x1, y2, x2, y2
END SUB

