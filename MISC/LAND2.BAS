DEFSNG A-Z
DIM a AS INTEGER
DIM q AS INTEGER
DIM lg AS INTEGER
DIM g AS INTEGER
DIM z AS INTEGER
DIM Y AS INTEGER
RANDOMIZE TIMER
DIM m(350) AS INTEGER
SCREEN 13
OUT &H3C8, 0
FOR a = 0 TO 63
OUT &H3C9, a
OUT &H3C9, a / 4
OUT &H3C9, 63 - a
NEXT a
FOR a = 0 TO 63
OUT &H3C9, 63 - a \ 2
OUT &H3C9, 63 - a \ 2
OUT &H3C9, 63
NEXT a

FOR a = 1 TO 320

m(a) = SIN(a / 20) * 40 + 120
NEXT a
FOR Y = 1 TO 200
LINE (0, Y)-(320, Y), Y / 320 * 63
NEXT Y
FOR z = 1 TO 5
FOR lg = 1 TO 4
l = 320 / (2 ^ lg)
FOR g = 1 TO 319 STEP (l + 1)
my = 30 * RND - 15
FOR q = 1 TO l
IF q < l / 2 THEN s = q ELSE s = (l - q)
m(g + q) = m(g + q) + my * s / 20
NEXT q
NEXT g
NEXT lg
FOR a = 1 TO 320
LINE (a, 262 - m(a) + z * 30)-(a, 200), 127
FOR Y = 0 TO 63
PSET (a, 200 - m(a) + z * 30 + Y), Y + 64
NEXT Y
NEXT a
NEXT z
DEF SEG = &HA000
BSAVE "SNOW.PIC", 0, 64000

