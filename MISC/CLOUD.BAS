DECLARE FUNCTION conx! (x%, y%, z!)
DECLARE FUNCTION cony! (x%, y%, z!)
RANDOMIZE TIMER
'DEFINT A-Z
SCREEN 13
OUT &H3C8, 1
FOR a = 1 TO 63
OUT &H3C9, a
OUT &H3C9, a
OUT &H3C9, 31 + a / 2
NEXT a

CONST sz = 33
WINDOW (-sz * .1, -sz * .1)-(sz * 1.1, sz * 1.1)

HT = 2
DIM a(-sz * .5 TO sz * 1.5, -sz * .5 TO sz * 1.5)
a(1, 1) = 33
a(sz, 1) = 33
a(sz, sz) = 33
a(1, sz) = 33
LENGTH = sz - 1
WHILE LENGTH > 0
FOR sx% = 1 TO sz - 1 STEP LENGTH
FOR sy% = 1 TO sz - 1 STEP LENGTH
UP = (2 * RND - 1) / HT * LENGTH * 7
a(sx% + LENGTH / 2, sy% + LENGTH / 2) = (a(sx%, sy%) + a(sx%, sy% + LENGTH) + a(sx% + LENGTH, sy%) + a(sx% + LENGTH, sy% + LENGTH)) / 4 + UP
a(sx% + LENGTH / 2, sy%) = (a(sx%, sy%) + a(sx% + LENGTH / 2, sy% + LENGTH / 2) + a(sx% + LENGTH, sy%) + a(sx% + LENGTH / 2, sy% - LENGTH / 2)) / 4 + UP
a(sx%, sy% + LENGTH / 2) = (a(sx%, sy%) + a(sx% + LENGTH / 2, sy% + LENGTH / 2) + a(sx%, sy% + LENGTH) + a(sx% - LENGTH / 2, sy% + LENGTH / 2)) / 4 + UP
a(sx% + LENGTH / 2, sy% + LENGTH) = (a(sx%, sy% + LENGTH) + a(sx% + LENGTH / 2, sy% + LENGTH / 2) + a(sx% + LENGTH, sy% + LENGTH) + a(sx% + LENGTH / 2, sy% + LENGTH * 1.5)) / 4 + UP
a(sx% + LENGTH, sy% + LENGTH / 2) = (a(sx% + LENGTH, sy%) + a(sx% + LENGTH / 2, sy% + LENGTH / 2) + a(sx% + LENGTH, sy% + LENGTH) + a(sx% + LENGTH * 1.5, sy% + LENGTH / 2)) / 4 + UP
IF a(sx%, sy%) < 0 THEN a(sx%, sy%) = 0 ELSE IF a(sx%, sy%) > 63 THEN a(sx%, sy%) = 63
PSET (sx%, sy% + a(sx%, sy%) \ 5), 63
NEXT sy%
NEXT sx%
LENGTH = INT(LENGTH / 2)
WEND
FOR sy% = 1 TO sz
FOR sx% = 1 TO sz
IF a(sx%, sy%) < 0 THEN a(sx%, sy%) = 0
IF a(sx%, sy%) > 63 THEN a(sx%, sy%) = 63
LINE (sx% - .5, sy% - .5)-(sx% + .5, sy% + .5), a(sx%, sy%), BF
NEXT sx%
NEXT sy%

