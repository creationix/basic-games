'
'
'           ±±±    ±±  ±±      ±±  ±±  ±±  ±±±±±±±  ±±±±±±±
'           ±±±±   ±±  ±±      ±±  ±± ±±   ±±       ±±    ±±
'           ±± ±±  ±±  ±±      ±±  ±±±±    ±±       ±±    ±±
'           ±±  ±± ±±  ±±      ±±  ±± ±±   ±±±±±    ±±±±±±±
'           ±±   ±±±±   ±±    ±±   ±±  ±±  ±±       ±±    ±±
'           ±±    ±±±    ±±±±±±    ±±  ±±  ±±±±±±±  ±±    ±±
'
'                           By Tim Caswell
'
'                              Controls
'
'        W   `   - Set Bomb      I   / - Set Bomb     8    + - Set bomb
'        |                       |                    |           
'      A-*-D                   J-*-L                4-*-6            
'       /|\                     /|\                  /|\
'      Z S C                   < K >                1 2 3
'
'
DECLARE SUB Odraw (x%, y%)
DECLARE SUB Getpic (pn%)
DECLARE SUB Smoker (x%, y%)
DECLARE SUB Fall (x%)
DECLARE SUB FallN (x%)
DECLARE SUB Mega (x%, y%, pn%)
DECLARE SUB Setbomb (x%, y%, ty%)
DECLARE SUB Opset (x%, y%, t%)
DECLARE SUB Blowup (x%, y%, s%)
DECLARE SUB setfire (x%, y%, s%)
DECLARE SUB Oput (x%, y%, t%)
DECLARE FUNCTION IfBomb% (x%, y%)
DECLARE FUNCTION Treas% ()
DECLARE FUNCTION Death% (x%, y%)

TYPE rupt
    x AS INTEGER
    y AS INTEGER
    s AS INTEGER
END TYPE

TYPE bomber
    x AS INTEGER
    y AS INTEGER
    s AS INTEGER
    t AS INTEGER
END TYPE

DEFINT A-Y
DIM SHARED p%(30 * 15, 21), slug(10) AS bomber
DIM SHARED l(22, 17), s%(30 * 15, 7), m%(30 * 15, 9, 3)
DIM SHARED ext(50) AS rupt, smok(30) AS rupt, bomb(12) AS bomber
DIM SHARED x(3), y(3), fp(10)
DIM SHARED ch(3), bm(3), nuke(3), live(10)
DIM a$(3), nk(3), j(3), an(3), di(3)

RANDOMIZE (TIMER)

SCREEN 1
WINDOW SCREEN (0, 0)-(640, 480)
OPEN "nuker.dat" FOR INPUT AS #1
GET (1, 1)-(30, 30), p%(0, 0)
Getpic 21
FOR n = 1 TO 21
GET (n * 30 - 30, 1)-(n * 30 - 1, 30), p%(0, n)
NEXT n
Getpic 7
FOR n = 1 TO 7
GET (n * 30 - 30, 1)-(n * 30 - 1, 30), s%(0, n)
NEXT n
FOR t = 1 TO 3
Getpic 9
FOR n = 1 TO 9
GET (n * 30 - 30, 1)-(n * 30 - 1, 30), m%(0, n, t)
NEXT n
NEXT t
CLS
DO
FOR x = 1 TO 21
FOR y = 1 TO 16
Oput x, y, 0
NEXT y
NEXT x
FOR x = 1 TO 21
l(x, 17) = 1
NEXT x
p = CINT(RND)
FOR a = 1 TO 100 * (1 - p)
x = INT(21 * RND) + 1
y = INT(15 * RND) + 2
Oput x, y, 1
NEXT a
FOR a = 1 TO 30 * p
x = INT(21 * RND) + 1
y = INT(16 * RND) + 1
d = INT(3 * RND + 1)
r = 9 * RND + 6
IF RND > .5 THEN t = -1 ELSE t = 1
FOR b = 1 TO r
IF d = 1 THEN bx = x - b * t: by = y: Oput bx, by - 1, 0
IF d = 2 THEN bx = x - b * t: by = y - b * t: Oput bx, by - 1, 0: Oput bx, by - 2, 0
IF d = 3 THEN bx = x - b * t: by = y + b * t: Oput bx, by - 1, 0: Oput bx, by - 2, 0
Oput bx, by, 1
NEXT b
NEXT a
FOR y = 1 TO 16
Oput 2, y, 4
Oput 20, y, 4
NEXT y
SOUND 100, 0
FOR y = 1 TO 16
FOR x = 1 TO 21
sc = 0
IF l(x, y - 1) = 1 THEN sc = sc + 1
IF l(x, y - 1) = 2 THEN sc = sc + 1
IF l(x, y - 1) = 3 THEN sc = sc + 1
IF l(x, y + 1) = 1 THEN sc = sc + 1
IF l(x - 1, y) = 1 THEN sc = sc + 1
IF l(x + 1, y) = 1 THEN sc = sc + 1
IF l(x - 1, y) = 10 THEN sc = sc + 1
IF l(x + 1, y) = 10 THEN sc = sc + 1
IF l(x, y) <> 0 THEN sc = 0
IF sc > 2 THEN Oput x, y, 10
IF y > 1 THEN IF l(x, y) = 0 AND l(x - 1, y) = 1 AND l(x, y - 2) = 0 AND l(x, y - 1) = 0 AND l(x, y + 1) = 0 THEN Oput x, y, 12
IF l(x - 1, y) = 12 AND l(x, y) = 0 THEN Oput x, y, 12
IF l(x, y) = 0 AND l(x + 1, y) = 1 AND l(x, y - 1) = 0 AND l(x - 1, y) = 0 THEN Oput x, y, 3
IF l(x, y) = 0 AND l(x - 1, y) = 1 AND l(x, y - 1) = 0 AND l(x + 1, y) = 0 THEN Oput x, y, 2
NEXT x
NEXT y
FOR a = 1 TO 15 * RND + 4
DO
x = INT(21 * RND) + 1
y = INT(17 * RND) + 1
LOOP WHILE l(x, y) <> 1 OR l(x, y - 1) <> 0
h = INT(6 * RND) + 1
FOR b = 1 TO h
Oput x, y - b, 8
IF y - b - 1 > 0 THEN IF l(x, y - b - 1) <> 0 THEN Oput x, y - b, 7
IF y - b - 1 > 0 THEN IF l(x, y - b - 1) <> 0 THEN SWAP b, h
NEXT b
IF b - 1 = h THEN Oput x, y - b, 7
NEXT a
FOR a = 1 TO 10 * RND + 4
DO
x = INT(21 * RND) + 1
y = INT(17 * RND) + 1
LOOP WHILE l(x, y) <> 1 OR l(x, y - 1) <> 0
h = INT(9 * RND) + 4
FOR b = 1 TO h
Oput x, y - b, 4
IF y - b - 1 > 0 THEN IF l(x, y - b - 1) <> 0 THEN g = b: b = h: h = g
NEXT b
NEXT a
FOR y = 1 TO 16
FOR x = 1 TO 21
IF l(x, y) = 2 THEN IF l(x - 1, y) <> 1 OR l(x, y + 1) <> 1 THEN Oput x, y, 0
IF l(x, y) = 3 THEN IF l(x + 1, y) <> 1 OR l(x, y + 1) <> 1 THEN Oput x, y, 0
sc = 0
dd = l(x, y - 1)
IF dd = 1 OR dd = 2 OR dd = 3 OR dd = 10 OR dd = 8 THEN sc = sc + 1
dd = l(x, y + 1)
IF dd = 1 OR dd = 2 OR dd = 3 OR dd = 10 THEN sc = sc + 1
dd = l(x - 1, y)
IF dd = 1 OR dd = 2 OR dd = 3 OR dd = 10 OR dd = 12 THEN sc = sc + 1
dd = l(x + 1, y)
IF dd = 1 OR dd = 2 OR dd = 3 OR dd = 10 OR dd = 12 THEN sc = sc + 1
IF sc = 0 AND l(x, y) = 1 THEN Oput x, y, 0
IF l(x, y) = 7 AND l(x, y + 1) <> 8 THEN Oput x, y, 0
IF l(x, y) = 8 AND l(x, y - 1) <> 8 AND l(x, y - 1) <> 7 THEN Oput x, y, 0
IF l(x, y) = 4 AND l(x, y - 1) <> 4 AND l(x, y + 1) <> 4 THEN Oput x, y, 0
IF l(x, y) = 12 THEN IF l(x - 1, y) = 0 OR l(x + 1, y) = 0 THEN Oput x, y, 0
IF l(x, y) = 0 AND l(x + 1, y) = 1 AND l(x, y - 1) = 0 AND l(x - 1, y) = 0 THEN Oput x, y, 3
IF l(x, y) = 0 AND l(x - 1, y) = 1 AND l(x, y - 1) = 0 AND l(x + 1, y) = 0 THEN Oput x, y, 2
IF x = 1 AND l(x, y) = 3 THEN Oput x, y, 0
IF x = 21 AND l(x, y) = 2 THEN Oput x, y, 0
NEXT x
NEXT y
CLS
FOR x = 1 TO 21
FOR y = 1 TO 16
PUT (x * 30 - 30, y * 30 - 30), p%(0, l(x, y)), PSET
NEXT y
NEXT x
FOR a = 1 TO 3
x(a) = 0: y(a) = 0
NEXT a
FOR a = 1 TO 3
DO
x = INT(21 * RND) + 1
y = INT(16 * RND) + 1
LOOP WHILE l(x, y) <> 0 OR l(x, y + 1) = 0 OR Death(x, y) > 10
x(a) = x: y(a) = y
PUT (x(a) * 30 - 30, y(a) * 30 - 30), m%(0, 1, a)
NEXT a
FOR a = 1 TO 10
DO
x = INT(21 * RND) + 1
y = INT(16 * RND) + 1
LOOP WHILE l(x, y) <> 0 OR l(x, y + 1) = 0 OR Death(x, y) > 0
PUT (x * 30 - 30, y * 30 - 30), s%(0, 2)
slug(a).x = x
slug(a).y = y
slug(a).s = 5
NEXT a
FOR a = 1 TO 3
live(a) = 1: di(a) = 1
NEXT a
FOR a = 1 TO 50: ext(a).s = 0: NEXT a
FOR a = 1 TO 30: smok(a).s = 0: NEXT a
FOR a = 1 TO 12: bomb(a).s = 0: NEXT a
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
DO
FOR a = 0 TO 3: a$(a) = "": NEXT a
DO: LOOP WHILE TIMER - zme < .1
zme = TIMER
DO
a$ = UCASE$(INKEY$)
IF a$ = "~" THEN a$(0) = "~"
IF a$(1) = "" THEN
IF a$ = "8" OR a$ = CHR$(0) + "H" THEN a$(1) = "^"
IF a$ = "4" OR a$ = CHR$(0) + "K" THEN a$(1) = "<"
IF a$ = "6" OR a$ = CHR$(0) + "M" THEN a$(1) = ">"
IF a$ = "1" OR a$ = CHR$(0) + "O" THEN a$(1) = "("
IF a$ = "3" OR a$ = CHR$(0) + "Q" THEN a$(1) = ")"
IF a$ = "2" OR a$ = CHR$(0) + "P" THEN a$(1) = "v"
IF a$ = "+" THEN a$(1) = "*"
END IF
IF a$(2) = "" THEN
IF a$ = "W" THEN a$(2) = "^"
IF a$ = "A" THEN a$(2) = "<"
IF a$ = "D" THEN a$(2) = ">"
IF a$ = "Z" THEN a$(2) = "("
IF a$ = "C" THEN a$(2) = ")"
IF a$ = "S" THEN a$(2) = "v"
IF a$ = "`" THEN a$(2) = "*"
END IF
IF a$(3) = "" THEN
IF a$ = "I" THEN a$(3) = "^"
IF a$ = "J" THEN a$(3) = "<"
IF a$ = "L" THEN a$(3) = ">"
IF a$ = "," THEN a$(3) = "("
IF a$ = "." THEN a$(3) = ")"
IF a$ = "K" THEN a$(3) = "v"
IF a$ = "/" THEN a$(3) = "*"
END IF
LOOP WHILE a$ <> ""
FOR a = 1 TO 3
IF live(a) = 0 THEN a$(a) = ""
NEXT a
DO: LOOP WHILE INKEY$ <> ""
FOR a = 1 TO 30
IF smok(a).s > 0 THEN
x = smok(a).x
y = smok(a).y
s = smok(a).s
s = s - 1
IF x > 0 AND y > 0 AND x < 22 AND y < 17 THEN PUT (x * 30 - 30, y * 30 - 30), p%(0, l(x, y)), PSET
y = y - 1
IF s > 0 THEN
sx = 10 * RND: sy = 10 * RND
PSET (x * 30 - 10 - sx, y * 30 - 10 - sy), 15
PSET (x * 30 - 9 - sx, y * 30 - 10 - sy), 7
PSET (x * 30 - 10 - sx, y * 30 - 9 - sy), 7
PSET (x * 30 - 9 - sx, y * 30 - 9 - sy), 8
END IF
smok(a).y = y
smok(a).s = s
END IF
IF ext(a).s > 0 THEN
x = ext(a).x
y = ext(a).y
s = ext(a).s
sx = 10 * RND + x * 30 - 30: sy = 10 * RND + y * 30 - 30
LINE (sx, sy)-(sx + 10, sy + 10), 14, B
LINE (sx + 3, sy + 3)-(sx + 6, sy + 6), 12, B
s = s - 1
ded = Death(x, y)
IF ded > 0 THEN
    IF s + 1 > 4 AND ded < 11 THEN slug(ded).s = 10
    IF s + 1 > 3 AND ded > 10 THEN live(ded - 10) = 0: Blowup x(ded - 10), y(ded - 10), 10: Blowup x(ded - 10), y(ded - 10), 10
END IF
IF x > 0 AND y > 0 AND x < 22 AND y < 17 THEN
IF l(x, y) > 0 THEN
IF l(x, y) = 1 AND s + 1 >= 5 THEN Opset x, y, 10: Fall x: s = 0
IF l(x, y) = 2 AND s + 1 >= 3 THEN Opset x, y, 5: s = 0
IF l(x, y) = 3 AND s + 1 >= 3 THEN Opset x, y, 6: s = 0
IF l(x, y) = 4 AND s + 1 >= 3 THEN Opset x, y, 0: Fall x: s = 0
IF l(x, y) = 5 AND s + 1 >= 5 THEN Opset x, y, 0: Fall x: s = 0
IF l(x, y) = 6 AND s + 1 >= 5 THEN Opset x, y, 0: Fall x: s = 0
IF l(x, y) = 7 AND s + 1 >= 2 THEN Opset x, y, 9: s = 0
IF l(x, y) = 8 AND s + 1 >= 3 THEN Opset x, y, 0: Fall x: s = 0
IF l(x, y) = 9 AND s + 1 >= 5 THEN Opset x, y, 0: Fall x: s = 0
IF l(x, y) = 10 AND s + 1 >= 2 THEN Opset x, y, 11: Fall x: s = 0
IF l(x, y) = 11 AND s + 1 <= 3 AND s > 0 THEN Opset x, y, Treas: Fall x: s = 0
IF l(x, y) = 12 AND s + 1 >= 1 THEN Opset x, y, 0: Fall x: s = 0
IF s = 0 THEN SOUND 100, .1: SOUND 200, .1: SOUND 400, .1: SOUND 300, .1: SOUND 100, 0
END IF
END IF
s = 0
ext(a).s = s
IF s = 0 THEN Odraw x, y: Smoker x, y
END IF
NEXT a
FOR a = 1 TO 10
IF fp(a) > 0 THEN
FallN fp(a)
END IF
NEXT a
FOR a = 1 TO 10
    s = slug(a).s
    IF s <> 0 THEN
    x = slug(a).x
    y = slug(a).y
    ox = x: oy = y
    IF s < 6 THEN
    IF s = 3 OR s = 4 THEN
    lv = l(x, y)
    lr = l(x + 1, y + 1)
    ll = l(x - 1, y + 1)
    IF lv <> 4 THEN IF RND > .5 THEN s = 4 ELSE IF RND > .5 THEN s = 1 ELSE s = 2
    IF l(x, y + 1) <> 4 THEN IF RND > .5 THEN s = 1 ELSE s = 2
    IF l(x, y - 1) <> 4 THEN IF RND > .5 THEN s = 1 ELSE s = 2
    IF (lr = 1 OR lr = 10) AND (l(x + 1, y) = 0 OR l(x + 1, y) = 9 OR l(x + 1, y) > 12) AND RND > .5 THEN s = 1
    IF (ll = 1 OR ll = 10) AND (l(x - 1, y) = 0 OR l(x - 1, y) = 9 OR l(x - 1, y) > 12) AND RND > .5 THEN s = 2
    END IF
    IF s = 1 THEN
        lf = l(x + 1, y + 1)
        ld = l(x, y + 1)
        lr = l(x + 1, y)
        IF ld <> 2 THEN
            IF lf = 0 AND RND > .6 THEN s = 2
            IF (lf = 9 OR lf = 11 OR lf > 12) AND RND > .5 THEN s = 2
        END IF
        IF lr = 1 OR lr = 2 OR lr = 8 OR lr = 7 OR lr = 10 THEN s = 2
        IF ld = 2 THEN IF (l(x + 1, y + 2) = 0 OR l(x + 1, y + 2) = 9 OR l(x + 1, y + 2) = 11) AND RND > .3 THEN s = 2
        IF (lr = 10 OR ld = 10) AND RND > .9 THEN s = 10: 'Salted
        ELSE
        IF s = 2 THEN
            lf = l(x - 1, y + 1)
            ld = l(x, y + 1)
            lr = l(x - 1, y)
            IF ld <> 2 THEN
                IF lf = 0 AND RND > .6 THEN s = 2
                IF (lf = 9 OR lf = 11 OR lf > 12) AND RND > .5 THEN s = 1
            END IF
            IF lr = 1 OR lr = 3 OR lr = 8 OR lr = 7 OR lr = 10 THEN s = 1
            IF ld = 2 THEN IF (l(x - 1, y + 2) = 0 OR l(x - 1, y + 2) = 9 OR l(x - 1, y + 2) = 11) AND RND > .3 THEN s = 1
            IF (lr = 10 OR ld = 10) AND RND > .9 THEN s = 10: 'Salted
        END IF
    END IF
    IF s = 5 THEN
    ld = l(x, y + 1)
    IF ld = 1 OR ld = 7 OR ld = 8 OR ld = 10 OR ld = 12 OR ld = 2 OR ld = 3 THEN s = 1 + RND
    IF ld = 4 THEN s = 4
    END IF
    IF IfBomb(x + 1, y) > 0 THEN s = 2
    IF IfBomb(x - 1, y) > 0 THEN s = 1
    IF IfBomb(x + 1, y - 1) > 0 THEN s = 2
    IF IfBomb(x - 1, y - 1) > 0 THEN s = 1
    IF IfBomb(x + 2, y) > 0 THEN s = 2
    IF IfBomb(x - 2, y) > 0 THEN s = 1
    IF IfBomb(x, y) > 0 THEN s = INT(4 * RND + 1)
    IF IfBomb(x, y + 1) > 0 THEN s = 1 + RND
    ld = l(x, y + 1)
    IF (ld = 0 OR ld = 9 OR ld = 11 OR ld > 12) THEN s = 5
    IF l(x, y) = 4 AND s <> 3 AND s <> 4 AND RND > .7 THEN s = 3 + RND
    IF s = 5 OR s = 4 THEN y = y + 1
    IF s = 1 THEN x = x + 1
    IF s = 2 THEN x = x - 1
    IF s = 3 THEN y = y - 1
    lv = l(x, y)
    IF lv = 1 OR lv = 7 OR lv = 8 OR lv = 10 THEN x = ox: y = oy
    IF lv = 2 THEN IF ox > x THEN y = y - 1 ELSE x = ox: y = oy
    IF lv = 3 THEN IF ox < x THEN y = y - 1 ELSE x = ox: y = oy
    ded = Death(x, y)
    IF ded > 0 AND ded <> a THEN x = ox: y = oy: s = INT(5 * RND + 1)
    IF x < 1 THEN x = 1: s = 1
    IF x > 21 THEN x = 21: s = 2
    IF y < 1 THEN y = 1: s = 4
    IF y > 16 THEN y = 16: s = 3
    END IF
    IF s = 9 THEN Blowup x, y, 8: s = 0
    IF s = 8 THEN s = 9
    IF s = 7 THEN s = 8
    IF s = 6 THEN s = 7
    IF s = 10 THEN s = 6
    slug(a).t = (slug(a).t + 1) MOD 4
    b = slug(a).t
    IF b = 0 THEN b = 2
    Opset ox, oy, l(ox, oy)
    IF s <> 0 AND s < 6 THEN PUT (x * 30 - 30, y * 30 - 30), s%(0, b)
    IF s > 5 THEN PUT (x * 30 - 30, y * 30 - 30), s%(0, s - 2)
    IF (Death(x, y - 1) > 10 OR Death(x, y + 1) > 10 OR Death(x + 1, y) > 10 OR Death(x - 1, y) > 10) AND RND > .01 THEN Setbomb x, y, 3
    slug(a).x = x
    slug(a).y = y
        slug(a).s = s
        END IF
    NEXT a
FOR a = 1 TO 12
IF bomb(a).s > 0 THEN
s = bomb(a).s
x = bomb(a).x
y = bomb(a).y
t = bomb(a).t
s = s - 1
oy = y
IF s > 5 THEN y = y - 1
IF s < 5 THEN y = y + 1
IF y < 1 THEN y = 1
IF y > 16 THEN y = 16
lv = l(x, y)
IF lv > 0 AND lv < 9 THEN y = oy
IF lv = 10 THEN y = oy
IF lv = 12 THEN Blowup x, y, 0: y = oy
Opset x, oy, l(x, oy)
IF s > 0 THEN PUT (x * 30 - 30, y * 30 - 30), p%(0, 10 + (s MOD 2) + (t MOD 4) * 3), PSET
IF s = 0 THEN Blowup x, y, t + 2
bomb(a).s = s
bomb(a).y = y
END IF
NEXT a
FOR a = 1 TO 3
x = x(a)
y = y(a)
j = j(a)
s = 0
ox = x: oy = y
IF (l(x, y + 1) > 0 AND l(x, y + 1) < 9) OR (l(x, y + 1) > 9 AND l(x, y + 1) < 11) OR l(x, y + 1) = 12 THEN s = 1
IF a$ = "" THEN
IF a$(a) = "^" THEN IF s = 1 THEN j = 3
IF a$(a) = "<" THEN x = x - 1: di(a) = 2
IF a$(a) = ">" THEN x = x + 1: di(a) = 3
IF a$(a) = "(" THEN Blowup x - 1, y, 1: di(a) = 2
IF a$(a) = ")" THEN Blowup x + 1, y, 1: di(a) = 3
IF a$(a) = "v" THEN y = y + 1
IF a$(a) = "*" THEN Mega x, y, a
END IF
IF y > 16 THEN y = 16
IF j > 0 THEN j = j - 1: y = y - 1
IF s = 0 AND j = 0 AND a$(a) <> "v" THEN y = y + 1
lv = l(x, y)
IF l(x, y + 1) = 12 AND oy < y THEN Blowup x, y + 1, 0
IF lv = 2 THEN IF ox > x THEN y = y - 1 ELSE IF oy < y THEN x = x + 1 ELSE x = ox: y = oy: IF l(x, y + 1) = 0 AND j(a) = 0 THEN y = y + 1
IF lv = 3 THEN IF ox < x THEN y = y - 1 ELSE IF oy < y THEN x = x - 1 ELSE x = ox: y = oy: IF l(x, y + 1) = 0 AND j(a) = 0 THEN y = y + 1
IF lv = 15 THEN Opset x, y, 0: Fall x: ch(a) = ch(a) + 8: SOUND 1000, .1: SOUND 300, .2
IF lv = 18 THEN Opset x, y, 0: Fall x: bm(a) = bm(a) + 4: SOUND 900, .1: SOUND 400, .2
IF lv = 21 THEN Opset x, y, 0: Fall x: nuke(a) = nuke(a) + 2: SOUND 800, .1: SOUND 500, .1: SOUND 100, .1
IF lv = 1 OR lv = 7 OR lv = 8 OR lv = 10 THEN x = ox: y = oy: IF l(x, y + 1) = 0 AND j(a) = 0 THEN y = y + 1
IF lv = 12 AND oy < y THEN x = ox: y = oy: IF l(x, y + 1) = 0 AND j(a) = 0 THEN y = y + 1
IF x < 1 THEN x = 1
IF x > 21 THEN x = 21
IF y < 1 THEN y = 1
IF y > 16 THEN y = 16
IF live(a) > 0 THEN
Opset ox, oy, l(ox, oy)
Opset x, y, l(x, y)
IF x <> ox OR y <> oy THEN an(a) = (an(a) + 1) MOD 4
b = an(a)
IF b = 0 THEN b = 2
IF y <> oy THEN di(a) = 1
IF x < ox THEN di(a) = 2 ELSE IF x > ox THEN di(a) = 3
IF x = ox AND y = oy AND l(x, y) <> 4 AND di(a) = 1 THEN di(a) = 2 + RND
PUT (x * 30 - 30, y * 30 - 30), m%(0, di(a) * 3 - 3 + b, a)
END IF
j(a) = j
x(a) = x
y(a) = y
NEXT a
lv = 0
FOR a = 1 TO 3
IF live(a) > 0 THEN lv = lv + 1
NEXT a
sl = 0
FOR a = 1 TO 10
IF slug(a).s > 1 THEN sl = sl + 1
NEXT a
IF lv = 0 OR sl = 0 THEN ddth = ddth + 1
LOOP WHILE ddth < 35
ddth = 0
FOR a = 1 TO 3
IF live(a) = 0 THEN ch(a) = 0: bm(a) = 0: nuke(a) = 0
NEXT a
LOOP

SUB Blowup (x, y, s)
setfire x, y, s + 1
setfire x - 1, y, s
setfire x + 1, y, s
setfire x, y - 1, s
setfire x, y + 1, s
setfire x - 1, y - 1, s - 1
setfire x - 1, y + 1, s - 1
setfire x + 1, y - 1, s - 1
setfire x + 1, y + 1, s - 1
setfire x - 2, y, s - 2
setfire x + 2, y, s - 2
setfire x, y - 2, s - 2
setfire x, y + 2, s - 2
setfire x + 2, y - 1, s - 3
setfire x + 2, y + 1, s - 3
setfire x - 2, y - 1, s - 3
setfire x - 2, y + 1, s - 3
setfire x + 1, y + 1, s - 3
setfire x - 1, y + 1, s - 3
setfire x + 1, y - 1, s - 3
setfire x - 1, y - 1, s - 3
setfire x + 3, y, s - 4
setfire x - 3, y, s - 4
setfire x, y + 3, s - 4
setfire x, y - 3, s - 4
END SUB

FUNCTION Death (x, y)
dd = 0
FOR a = 1 TO 10
IF slug(a).x = x AND slug(a).y = y AND slug(a).s > 0 AND slug(a).s < 6 THEN dd = a
NEXT a
FOR a = 1 TO 3
IF x(a) = x AND y(a) = y AND live(a) > 0 THEN dd = a + 10
NEXT a
Death = dd
END FUNCTION

SUB Fall (x)
t = 0
FOR a = 1 TO 10
IF fp(a) = 0 THEN t = a: a = 10
NEXT a
fp(t) = x
END SUB

SUB FallN (x)
t = 0
yb = 0
yt = 17
FOR y = 15 TO 1 STEP -1
ld = l(x, y + 1)
IF ld = 0 OR ld = 9 OR ld = 11 THEN
l = l(x, y)
IF l > 0 THEN
IF l = 4 THEN t = 1: Oput x, y, 0: Oput x, y + 1, 4: l = 0
IF l = 7 THEN t = 1: Oput x, y, 0: Oput x, y + 1, 7: l = 0
IF l = 8 THEN t = 1: Oput x, y, 0: Oput x, y + 1, 8: l = 0
IF l = 9 THEN t = 1: Oput x, y, 0: Oput x, y + 1, 9: l = 0
IF l = 11 THEN t = 1: Oput x, y, 0: Oput x, y + 1, 11: l = 0
IF l = 0 THEN
IF y < yt THEN yt = y
IF y > yb THEN yb = y
END IF
END IF
END IF
NEXT y
FOR y = yt TO yb + 1
Odraw x, y
NEXT y
IF t = 0 THEN x = 0
END SUB

SUB Getpic (pn)
FOR x = 0 TO pn * 30 - 1 STEP 2
INPUT #1, a$, a$
FOR y = 1 TO 30 STEP 2
c = ASC(MID$(a$, y, 1)) - 100
IF c > 7 THEN c = c - 8
IF c = 1 OR c = 2 OR c = 3 THEN c = 1
IF c = 4 OR c = 5 OR c = 6 THEN c = 2
PSET (x, y), c
NEXT y
NEXT x
END SUB

FUNCTION IfBomb (x, y)
  t = 0
  FOR a = 1 TO 6
    IF bomb(a).x = x AND bomb(a).y = y AND bomb(a).s > 0 THEN t = a
  NEXT a
  IfBomb = t
END FUNCTION

SUB Mega (x, y, pn)
bt = 0
IF ch(pn) > 0 THEN bt = 1
IF bm(pn) > 0 THEN bt = 2
IF nuke(pn) > 0 THEN bt = 11
IF bt > 0 THEN
Setbomb x, y, bt
IF bt = 1 THEN ch(pn) = ch(pn) - 1
IF bt = 1 THEN bm(pn) = bm(pn) - 1
IF bt = 1 THEN nuke(pn) = nuke(pn) - 1
END IF
END SUB

SUB Odraw (x, y)
IF x >= 1 AND y >= 1 AND x <= 21 AND y <= 16 THEN
lv = l(x, y)
PUT (x * 30 - 30, y * 30 - 30), p%(0, lv), PSET
END IF
END SUB

SUB Opset (x, y, lv)
IF x >= 1 AND y >= 1 AND x <= 21 AND y <= 16 THEN
l(x, y) = lv
PUT (x * 30 - 30, y * 30 - 30), p%(0, lv), PSET
END IF
END SUB

SUB Oput (x, y, lv)
IF x >= 1 AND y >= 1 AND x <= 21 AND y <= 16 THEN
l(x, y) = lv
END IF
END SUB

SUB Setbomb (x, y, t)
s = 0
FOR a = 1 TO 12
IF bomb(a).s <= 0 THEN s = a: a = 12
NEXT a
bomb(s).x = x
bomb(s).y = y
bomb(s).s = 8
bomb(s).t = (t MOD 4)
END SUB

SUB setfire (x, y, s)
t = 0
FOR a = 1 TO 50
IF ext(a).s <= 0 THEN t = a: a = 50
NEXT a
ext(t).x = x
ext(t).y = y
ext(t).s = s
END SUB

SUB Smoker (x, y)
t = 0
'FOR a = 1 TO 30
'IF smok(a).s <= 0 THEN t = a: a = 30
'NEXT a
'IF RND > .3 THEN t = 0
'smok(t).x = x
'smok(t).y = y
'smok(t).s = 6
END SUB

FUNCTION Treas
n = INT(3 * RND + 1)
IF n = 1 THEN t = 21
IF n = 2 THEN t = 18
IF n = 3 THEN t = 15
IF RND > .9 THEN t = 0
Treas = t
END FUNCTION

