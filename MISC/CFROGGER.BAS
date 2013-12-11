DECLARE FUNCTION done% ()
DECLARE SUB odraw (x%, y%)
DEFINT A-Y
RANDOMIZE (TIMER)
SCREEN 1
COLOR , 0
CONST du = 15 * 15
DIM SHARED s%(du, 8), l(22, 14), fx, fy, f%(du), m%(du), lvl
FOR n = 1 TO 8
FOR y = 1 TO 15
FOR x = 1 TO 15
READ c
IF c = 2 THEN c = 1
IF c = 3 THEN c = 1
IF c = 4 THEN c = 2
IF c = 5 THEN c = 2
IF c = 6 THEN c = 3
IF c = 8 THEN c = 0
IF x > 1 AND y > 1 THEN
IF c > 0 AND c <> 8 AND POINT(x, y - 1) = 0 THEN c = 3
IF c > 0 AND c <> 8 AND POINT(x - 1, y) = 0 THEN c = 3
END IF
PSET (x, y), c
NEXT x
NEXT y
GET (1, 1)-(15, 15), s%(0, n)
NEXT n
FOR y = 1 TO 15
FOR x = 1 TO 15
READ c
c = c MOD 4
IF c > 0 AND c <> 8 AND POINT(x, y - 1) = 0 THEN c = 3
IF c > 0 AND c <> 8 AND POINT(x - 1, y) = 0 THEN c = 3
PSET (x, y), c
NEXT x
NEXT y
GET (1, 1)-(15, 15), f%
FOR y = 1 TO 15
FOR x = 15 TO 1 STEP -1
c = POINT(x, y)
IF c = 0 THEN PSET (x, y), 15 ELSE PSET (x, y), 0
NEXT x
NEXT y
GET (1, 1)-(15, 15), m%
CLS
FOR x = 1 TO 21
FOR y = 1 TO 13
l = 2
IF y > 7 THEN l = 1
IF y = 13 THEN l = 3
IF y = 1 THEN l = 7: IF (x MOD 6) <> 2 THEN l = 3
l(x, y) = l
odraw x, y
NEXT y
NEXT x
gy = 2: hy = 8
DO
mv = 0
gy = gy + 1
IF gy > 4 THEN gy = 2
sy = gy
IF sy MOD 2 = 1 THEN
IF fy = sy THEN mv = 1: fx = fx + 1
FOR sx = 20 TO 1 STEP -1
l(sx + 1, sy) = l(sx, sy): odraw sx + 1, sy
NEXT sx
l(1, sy) = 2 + CINT(RND - lvl / 20 + .4) * 2
odraw 1, sy
ELSE
IF fy = sy THEN mv = 2: fx = fx - 1
FOR sx = 2 TO 21
l(sx - 1, sy) = l(sx, sy): odraw sx - 1, sy
NEXT sx
l(21, sy) = 2 + CINT(RND - lvl / 20 + .4) * 2
odraw 21, sy
END IF
sy = gy + 3
IF sy MOD 2 = 1 THEN
IF fy = sy THEN mv = 1: fx = fx + 1
FOR sx = 20 TO 1 STEP -1
l(sx + 1, sy) = l(sx, sy): odraw sx + 1, sy
NEXT sx
l(1, sy) = 2 + CINT(RND - lvl / 20 + .4) * 2
odraw 1, sy
 ELSE
IF fy = sy THEN mv = 2: fx = fx - 1
FOR sx = 2 TO 21
l(sx - 1, sy) = l(sx, sy): odraw sx - 1, sy: IF x = sx - 1 AND y = sy THEN PUT (x * 15 - 14, y * 15 - 14), m%, AND: PUT (x * 15 - 14, y * 15 - 14), f%
NEXT sx
l(21, sy) = 2 + CINT(RND - lvl / 20 + .4) * 2
odraw 21, sy
END IF
FOR sy = 8 TO 12
IF sy MOD 2 = 0 THEN
IF RND > .5 THEN
FOR sx = 20 TO 1 STEP -1
l(sx + 1, sy) = l(sx, sy): odraw sx + 1, sy
NEXT sx
l(1, sy) = 1 + CINT(RND - .4 + lvl / 30) * 4
odraw 1, sy
END IF
ELSE
FOR sx = 2 TO 21
l(sx - 1, sy) = l(sx, sy): odraw sx - 1, sy: IF x = sx - 1 AND y = sy THEN PUT (x * 15 - 14, y * 15 - 14), m%, AND: PUT (x * 15 - 14, y * 15 - 14), f%
NEXT sx
l(21, sy) = 1 + CINT(RND - .4 + lvl / 30) * 5
odraw 21, sy
END IF
NEXT sy
a$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
ox = fx: oy = fy
IF a$ = "8" THEN fy = fy - 1
IF a$ = "2" THEN fy = fy + 1
IF a$ = "4" AND mv <> 2 THEN fx = fx - 1
IF a$ = "6" AND mv <> 1 THEN fx = fx + 1
IF fx < 1 OR fx > 21 THEN FOR a = 1 TO 30: SOUND 100, .1: SOUND 300, .1: SOUND 1000, .1: NEXT a: fx = 10: fy = 13
IF fy < 1 THEN y = 1
IF fy > 13 THEN y = 13
lv = l(fx, fy)
ol = l(ox, oy)
IF lv = 2 THEN fx = 10: fy = 13: FOR a = 1 TO 30: SOUND 300 - a * 5, .1: SOUND 37 + (a MOD 3) * 100, .1: NEXT a
IF lv = 5 OR lv = 6 OR lv = 8 THEN fx = 10: fy = 13: FOR a = 1 TO 30: SOUND 37 + a * 5 * RND, .05: SOUND 37 + a * 3, .15: NEXT a
IF ol = 5 OR ol = 6 OR ol = 8 THEN fx = 10: fy = 13: FOR a = 1 TO 30: SOUND 37 + a * 5 * RND, .05: SOUND 37 + a * 3, .15: NEXT a
IF lv = 7 THEN x = fx: y = fy: fx = 10: fy = 13: l(x, y) = 8: odraw x, y: odraw ox, oy: FOR a = 1 TO 50: SOUND 100 + a * 5, .1: SOUND 200 + a * 3, .1: SOUND 37 + a * 10, .1: NEXT a: odraw fx, fy: IF done = 1 THEN lvl = lvl + 1
IF oy <> fy OR a$ = "4" OR a$ = "6" THEN FOR a = 1 TO 10: SOUND 100 + a * 5, .1: NEXT a
IF fx <> ox OR fy <> oy THEN odraw ox, oy
odraw fx, fy
LOOP
'
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,6,0,6,0,6,0,6,0,8,8,8,8,8
DATA 8,8,0,6,0,6,0,6,0,6,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
'
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,0
DATA 1,1,1,1,1,1,1,1,1,0,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,0,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,0,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,0,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,0,1,1,1,1,1,1,1,0,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,0,1,0
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
'
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,0,2
DATA 2,0,2,0,2,2,2,2,2,2,2,2,2,2,0
DATA 2,2,0,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,0,2,0,2,2,2,2,2,0,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,0,2,0,2,2,2,2
DATA 2,2,2,2,2,2,2,0,2,0,2,0,2,2,2
DATA 2,2,2,2,2,2,2,2,0,2,0,2,2,2,2
DATA 2,2,2,0,2,0,2,2,2,0,2,2,2,2,2
DATA 2,2,2,2,0,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,0,2,0,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,0,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,0,2,0,2,2,2
DATA 2,2,2,0,2,2,2,2,2,2,0,2,2,2,2
DATA 2,2,0,2,0,2,2,2,2,2,2,2,2,2,0
DATA 2,2,2,0,2,2,2,2,2,2,2,2,2,0,2
'
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,1,1,1,0,1,1,0,0,0,0,1,1,1,1
DATA 0,1,1,0,6,0,1,1,6,6,6,0,0,0,1
DATA 6,0,0,6,6,6,0,0,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,6,6,6,6,6,6,6,6,6,6,6
DATA 6,6,6,6,8,8,8,8,6,6,8,6,6,6,6
DATA 8,8,6,8,1,1,1,8,6,8,1,8,8,6,6
DATA 8,1,8,1,1,1,1,1,8,1,1,1,1,8,8
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
'
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,0,0,0,0,0,0,0,0,0,0,0,0,8,8
DATA 0,6,4,4,4,4,4,4,4,4,4,4,0,0,0
DATA 6,0,4,5,4,4,5,5,4,5,5,4,4,4,0
DATA 0,6,4,5,5,5,5,5,5,5,5,5,4,4,0
DATA 6,0,4,5,5,5,5,5,5,5,5,5,4,4,0
DATA 0,6,4,5,5,5,5,5,5,5,5,5,4,4,0
DATA 6,0,4,5,4,4,5,5,4,5,5,4,4,4,0
DATA 0,6,4,4,4,4,4,4,4,4,4,4,0,8,8
DATA 8,0,0,0,0,0,0,0,0,0,0,0,0,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
'
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8
DATA 8,8,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,0,0,0,0,8,8,8,8,0,3,3,3,3,3
DATA 0,3,3,3,3,0,8,8,8,0,3,3,3,3,3
DATA 0,3,3,3,3,0,0,0,0,0,3,3,3,3,3
DATA 8,0,5,5,0,0,5,5,5,0,0,5,5,5,0
DATA 8,0,5,5,5,5,5,5,5,5,5,5,5,5,0
DATA 8,0,5,5,5,5,5,5,5,5,5,5,5,5,0
DATA 8,0,5,5,5,5,5,5,5,5,5,5,5,5,0
DATA 8,0,5,5,0,0,5,5,5,0,0,5,5,5,0
DATA 0,3,3,3,3,0,0,0,0,0,3,3,3,3,3
DATA 0,3,3,3,3,0,8,8,8,0,3,3,3,3,3
DATA 8,0,0,0,0,8,8,8,8,0,3,3,3,3,3
DATA 8,8,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,8,8,8,8,8,8,8,8,8,8,8,8,8

DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,0,0,2,6,6,0,0,2,2,2,2
DATA 2,2,2,0,0,0,0,0,6,6,0,0,2,2,2
DATA 2,2,2,0,0,0,0,0,6,6,0,0,0,2,2
DATA 2,2,0,0,0,0,0,0,0,6,6,6,0,2,2
DATA 2,2,0,0,0,0,0,0,0,0,6,6,6,6,2
DATA 2,2,0,0,0,0,0,0,0,0,0,0,6,6,6
DATA 2,0,0,0,0,0,0,0,0,0,0,0,0,0,6
DATA 2,0,0,0,0,0,0,0,0,0,0,0,0,0,2
DATA 2,0,0,0,0,0,0,0,0,0,0,0,0,2,2
DATA 2,2,0,0,0,0,0,0,0,0,0,0,0,2,2
DATA 2,2,0,0,0,0,0,0,0,0,0,0,0,2,2
DATA 2,2,0,0,0,0,0,0,0,0,0,0,2,2,2

DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
DATA 2,2,2,2,0,0,2,0,0,0,0,2,2,2,2
DATA 2,2,2,0,0,0,0,0,0,0,0,0,2,2,2
DATA 2,2,2,0,0,2,2,0,2,2,0,0,0,2,2
DATA 2,2,0,0,2,4,4,2,4,4,2,0,0,2,2
DATA 2,2,0,0,2,4,2,2,2,4,2,0,0,2,2
DATA 2,2,0,0,0,2,2,2,2,2,0,0,0,2,2
DATA 2,0,0,0,2,2,2,2,2,2,2,0,0,2,2
DATA 2,0,0,0,2,2,2,2,2,2,2,0,0,0,2
DATA 2,0,0,0,0,2,2,2,2,2,0,0,0,2,2
DATA 2,2,0,0,2,2,2,2,2,2,2,0,0,2,2
DATA 2,2,0,0,2,0,0,2,0,0,2,0,0,2,2
DATA 2,2,0,2,2,2,0,0,0,2,2,2,0,2,2

DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 2,0,0,2,8,0,0,0,0,0,0,2,0,0,2
DATA 0,2,2,0,0,0,2,2,2,0,0,0,2,2,8
DATA 0,2,2,2,0,2,4,2,4,2,0,2,2,2,8
DATA 0,0,2,2,2,4,4,2,4,4,2,2,2,8,0
DATA 0,0,0,2,2,2,2,2,2,2,2,2,8,0,0
DATA 0,0,0,2,2,2,2,2,2,2,2,2,8,0,0
DATA 0,0,0,0,2,2,2,2,2,2,2,0,0,0,0
DATA 0,0,2,2,8,2,2,2,2,2,8,2,2,8,0
DATA 0,0,2,2,2,8,2,2,2,8,2,2,2,0,0
DATA 0,2,2,2,2,2,8,8,0,2,2,2,2,2,8
DATA 0,0,2,2,2,8,0,0,0,0,2,2,2,0,0
DATA 0,2,2,2,8,0,0,0,0,0,0,2,2,2,8
DATA 0,2,2,2,8,0,0,0,0,0,0,2,2,2,8
DATA 2,0,2,0,2,8,0,0,0,8,2,0,2,0,2

FUNCTION done
d = 1
FOR x = 1 TO 21
IF l(x, 1) = 7 THEN d = 0
NEXT x
IF d = 1 THEN
FOR x = 1 TO 21
IF l(x, 1) = 8 THEN l(x, 1) = 7: odraw x, 1
NEXT x
END IF
done = d
END FUNCTION

SUB odraw (x, y)
IF NOT (x < 1 OR y < 1 OR x > 21 OR y > 13) THEN PUT (x * 15 - 14, y * 15 - 14), s%(0, l(x, y)), PSET: IF x = fx AND y = fy THEN PUT (x * 15 - 14, y * 15 - 14), m%, AND: PUT (x * 15 - 14, y * 15 - 14), f%
END SUB

