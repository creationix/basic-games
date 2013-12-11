DECLARE SUB colorchange (c%)
DECLARE SUB shot (x%, y%, p%(), l%(), mode%)
'Fowler V.0
'By Tim Caswell
'8/24/98
'6:08 PM
'Picture size 32*24
'1 block
'2 slide \
'3 slide /
'4 coin
'5 fish icon
'6 angel icon
'7 dude icon
'8 water
'9 lava
'10 slime
'11 - squid
'12 - blob
'13 - fireball
'14 - fire1
'15 - fire2
'16
'17
'18 fish
'19 angel
'20 dude

DEFINT A-Z
CONST MaxMon = 20

DIM SHARED r(15), g(15), b(15)
DIM monx(MaxMon), mony(MaxMon), mont(MaxMon), monj(MaxMon)
DIM l(25, 201), z AS STRING * 1
DIM p(384 * 2, 20)
RANDOMIZE TIMER
DIM SHARED iSin(20)
FOR a = 0 TO 20
	iSin(a) = SIN(a / 10 * 3.141) * 8
NEXT a
r(1) = 10: g(1) = 10: b(1) = 31
r(2) = 10: g(2) = 31: b(2) = 10
r(3) = 10: g(3) = 21: b(3) = 41
r(4) = 31: g(4) = 10: b(4) = 10
r(5) = 31: g(5) = 10: b(5) = 31
r(6) = 31: g(6) = 31: b(6) = 10
r(7) = 40: g(7) = 40: b(7) = 40
r(8) = 20: g(8) = 20: b(8) = 20
r(9) = 10: g(9) = 10: b(9) = 53
r(10) = 10: g(10) = 53: b(10) = 10
r(11) = 10: g(11) = 53: b(11) = 53
r(12) = 53: g(12) = 10: b(12) = 10
r(13) = 53: g(13) = 10: b(13) = 53
r(14) = 53: g(14) = 53: b(14) = 10
r(15) = 53: g(15) = 53: b(15) = 53
SCREEN 13

DEF SEG = VARSEG(p(0, 0))
BLOAD "fowler.pic", 0

DEF SEG = VARSEG(l(0, 0))
BLOAD "fowler.l01", 0

FOR a = 1 TO MaxMon
	DO
		x = INT(24 * RND) + 1
		y = INT(200 * RND) + 1
	LOOP WHILE l(x, y) <> 0 AND l(x, y) <> 8
	monx(a) = x
	mony(a) = y
	IF l(x, y) = 8 THEN mont(a) = 11
	IF l(x, y) = 0 THEN mont(a) = 12
NEXT a
x = 7: y = 3
mode = 20
DO
FOR a = 1 TO MaxMon
	h = iSin((TIMER * 4 + a) MOD 10) / 8
	IF h = 0 THEN h = -1
	mx = monx(a): ox = mx
	my = mony(a): oy = my
	t = mont(a)
	IF t > 0 AND ABS(mx - x) < 10 AND ABS(my - y) < 10 THEN
		mj = monj(a)
		IF t = 11 THEN
			l(ox, oy) = 8
			IF RND > .2 THEN IF my > y THEN my = my - h ELSE IF my < y THEN my = my + h
			IF RND > .2 THEN IF mx > x THEN mx = mx + h ELSE IF mx < x THEN mx = mx - h
			IF l(mx, my) <> 8 THEN mx = ox: my = oy
		END IF
		IF t = 12 THEN
			l(ox, oy) = 0
			IF mj > 0 THEN my = my - 1: mj = mj - 1 ELSE IF l(mx, my + 1) = 0 THEN my = my + 1
			IF RND > .6 THEN IF mx > x THEN mx = mx - h ELSE IF mx < x THEN mx = mx + h
			IF RND > .9 AND l(x, y + 1) > 0 THEN mj = 3 + RND * 2
			IF l(mx, my) <> 0 THEN mx = ox: my = oy
		END IF
		IF mx < 1 THEN mx = 1 ELSE IF mx > 24 THEN mx = 24
		IF my < 1 THEN my = 1 ELSE IF my > 200 THEN my = 200
		l = l(mx, my)
		IF l = 1 THEN mx = ox: my = oy
		IF l = 2 THEN IF ox > mx THEN my = my - 1 ELSE mx = ox: my = oy
		IF l = 3 THEN IF ox < mx THEN my = my - 1 ELSE mx = ox: my = oy
		IF t = 12 AND l(mx, my) <> 0 THEN mx = ox: my = oy
		IF l = 10 THEN IF RND > .5 THEN mx = ox ELSE my = oy
		monx(a) = mx
		mony(a) = my
		mont(a) = t
		monj(a) = mj
		l(mx, my) = t
	END IF
NEXT a
shot x, y, p(), l(), mode
a$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
ox = x: oy = y
l = l(x, y + 1)
IF l = 1 OR l = 2 OR l = 3 THEN s = 1 ELSE s = 0
IF l = 8 AND RND > .3 THEN s = 1
IF a$ = "8" THEN
	IF mode = 18 THEN IF l(x, y) = 8 THEN y = y - 1
	IF mode = 19 THEN y = y - 1
	IF mode = 20 THEN IF s = 1 THEN j = 3
END IF
'IF a$ = "!" THEN mode = 18
'IF a$ = "@" THEN mode = 19
'IF a$ = "#" THEN mode = 20
IF a$ = "2" THEN y = y + 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF mode = 18 AND s = 1 AND l(x, y) <> 8 THEN j = 2 * RND
IF mode > 18 AND l(x, y) = 8 THEN y = y - 1
IF j > 0 THEN j = j - 1: y = y - 1 ELSE IF s = 0 AND mode <> 19 THEN y = y + 1
IF y < oy THEN y = oy - 1 ELSE IF y > oy THEN y = oy + 1
l = l(x, y)
IF l = 0 THEN bak = 0
IF l = 8 THEN bak = 8
IF l = 1 THEN x = ox: y = oy
IF l = 2 THEN IF ox > x THEN y = y - 1 ELSE x = ox: y = oy
IF l = 3 THEN IF ox < x THEN y = y - 1 ELSE x = ox: y = oy
IF l = 4 THEN l(x, y) = bak: SOUND 1000, .1
IF l = 5 THEN l(x, y) = mode - 13: mode = 18
IF l = 6 THEN l(x, y) = mode - 13: mode = 19
IF l = 7 THEN l(x, y) = mode - 13: mode = 20
IF l = 10 THEN IF RND > .5 THEN x = ox ELSE y = oy
LOOP WHILE a$ <> "5"

SUB colorchange (c)
t = INT((TIMER * 10) MOD 11)
OUT &H3C8, c
OUT &H3C9, r(c) + iSin((t + c + 1) MOD 10)
OUT &H3C9, g(c) + iSin((t + c + 6) MOD 10)
OUT &H3C9, b(c) + iSin((t + c + 13) MOD 10)
END SUB

SUB shot (x, y, p(), l(), mode)
FOR sx = 1 TO 10
FOR sy = 1 TO 8
lx = sx - 5 + x: ly = sy - 4 + y
IF lx < 0 OR ly < 0 OR lx > 25 OR ly > 201 THEN l = 9 ELSE l = l(lx, ly)
PUT (sx * 32 - 32, sy * 24 - 24), p(0, l), PSET
IF sx = 5 AND sy = 4 THEN PUT (sx * 32 - 32, sy * 24 - 24), p(0, mode)
NEXT sy
NEXT sx
colorchange 1
colorchange 9
colorchange 3
colorchange 4
colorchange 12
colorchange 14
END SUB

