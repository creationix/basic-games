DECLARE SUB frac (x!, y!, l!)
DECLARE SUB dfrac (x!, y!, l!)
DECLARE FUNCTION wrap! (n!)
DIM x AS INTEGER
DIM y AS INTEGER
'DEFINT A-Z
'CLEAR , , 5000
SCREEN 13
CONST sz = 33
FOR a = 0 TO 15
'PALETTE a, a * 4
NEXT a
DIM SHARED l(sz, sz), been(sz, sz)

l(1, 1) = 5
l(sz, 1) = 5
l(sz, sz) = 5
l(1, sz) = 5
WINDOW (-sz * .1, -sz * .1)-(sz * 1.1, sz * 1.1)
frac sz \ 2 + 1, sz \ 2 + 1, sz \ 2
frac sz \ 2 + 1, sz \ 2 + 1, sz \ 4

FOR y = 1 TO sz
FOR x = 1 TO sz
LINE (x - .5, y - .5)-(x + .5, y + .5), l(x, y), BF
NEXT x
NEXT y


'DEFINT A-Z
SUB dfrac (x, y, l)
ln = l
IF x < 1 OR y < 1 OR x > sz OR y > sz THEN EXIT SUB
IF been(x, y) <> 0 THEN EXIT SUB
l(x, y) = (l(x, wrap(y - ln)) + l(x, wrap(y + ln)) + l(wrap(x + ln), y) + l(wrap(x - ln), y)) / 4
LINE (x, y)-(x, wrap(y + ln))
LINE (x, y)-(x, wrap(y - ln))
LINE (x, y)-(wrap(x + ln), y)
LINE (x, y)-(wrap(x - ln), y)
CIRCLE (x, y), .1
been(x, y) = 1
frac x + ln \ 2, y - ln \ 2, ln
frac x + ln \ 2, y + ln \ 2, ln
frac x - ln \ 2, y - ln \ 2, ln
frac x - ln \ 2, y + ln \ 2, ln
END SUB

'DEFINT A-Z
SUB frac (x, y, l)
ln = l
IF x < 1 OR y < 1 OR x > sz OR y > sz THEN EXIT SUB
IF been(x, y) <> 0 THEN EXIT SUB
l(x, y) = (l(wrap(x - ln), wrap(y - ln)) + l(wrap(x - ln), wrap(y + ln)) + l(wrap(x + ln), wrap(y + ln)) + l(wrap(x + ln), wrap(y - ln))) / 4 + 1
LINE (x, y)-(wrap(x - ln), wrap(y + ln)), 10
LINE (x, y)-(wrap(x - ln), wrap(y - ln)), 10
LINE (x, y)-(wrap(x + ln), wrap(y + ln)), 10
LINE (x, y)-(wrap(x + ln), wrap(y - ln)), 10
CIRCLE (x, y), .1
been(x, y) = 1
dfrac x + ln, y, ln
dfrac x - ln, y, ln
dfrac x, y + ln, ln
dfrac x, y - ln, ln
END SUB

FUNCTION wrap (n)
WHILE n < 1 OR n > sz
IF n < 1 THEN n = n + sz - 1
IF n > sz THEN n = n - sz + 1
SOUND 47, .1
WEND
wrap = n
END FUNCTION

