DECLARE SUB font (txt$)
DIM SHARED t$(128)
OPEN "font2.fon" FOR INPUT AS #1
FOR a = 0 TO 127
INPUT #1, t$(a)
NEXT a
CLOSE #1
SCREEN 12

minl = 33
maxl = 127
curl = minl
DO
IF a$ = "." THEN curl = curl + 1
IF a$ = "," THEN curl = curl - 1
IF a$ = "+" THEN t$(curl) = ""
IF a$ = CHR$(8) AND LEN(t$(curl)) > 0 THEN t$(curl) = LEFT$(t$(curl), LEN(t$(curl)) - 1)
IF a$ = "8" THEN t$(curl) = t$(curl) + "u"
IF a$ = "4" THEN t$(curl) = t$(curl) + "l"
IF a$ = "6" THEN t$(curl) = t$(curl) + "r"
IF a$ = "2" THEN t$(curl) = t$(curl) + "d"
IF a$ = "9" THEN t$(curl) = t$(curl) + "e"
IF a$ = "3" THEN t$(curl) = t$(curl) + "f"
IF a$ = "7" THEN t$(curl) = t$(curl) + "h"
IF a$ = "1" THEN t$(curl) = t$(curl) + "g"
IF a$ = "-" THEN t$(curl) = t$(curl) + "B"
IF a$ = " " THEN LOCATE 10: INPUT t$(curl): LOCATE 10: PRINT "            "
IF a$ = "S" THEN
OPEN "font2.fon" FOR OUTPUT AS #1
FOR a = 0 TO 127
PRINT #1, t$(a)
NEXT a
CLOSE #1
END IF
IF curl > maxl THEN curl = maxl
IF curl < minl THEN curl = minl
LOCATE 1, 1: PRINT "'"; CHR$(curl); "'"
LOCATE 2, 1: PRINT "("; t$(curl); ")                   "
LOCATE 3, 1: PRINT "   "
LOCATE 4, 1: PRINT "   "
LOCATE 4, 2
font CHR$(curl)
DO
a$ = INKEY$
LOOP WHILE a$ = ""
LOOP

DEFINT A-Z
SUB font (txt$)
c = 15
x = POS(0)
y = CSRLIN
DRAW "S12"
FOR r = 1 TO LEN(txt$)
PSET (x * 8 - 8, y * 16 - 4), 0: DRAW "c=" + VARPTR$(c) + t$(ASC(MID$(txt$, r, 1)))
'IF (x + r * 13 - 6) > 640 THEN EXIT FOR
NEXT r
DRAW "c12u0"
END SUB

