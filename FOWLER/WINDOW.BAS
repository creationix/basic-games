DECLARE FUNCTION popup$ (x1%, y1%, PR$, tx$)
DECLARE SUB openbox (x%, y%, w%, h%)
DECLARE SUB closebox (x%, y%, w%, h%)
 


DEFINT A-Z
SCREEN 7
FOR a = 1 TO 1000
CIRCLE (320 * RND, 480 * RND), 10 * RND, 15 * RND
NEXT a
'      *--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--*--
p3$ = "%s I11I22I33I44Gs %1 R01E  %2 R02E  %3 R03E  %4 R04B  E"
sp$ = "%1 I 2G1 %2 "
ps$ = "P  "

a$ = popup$(1, 1, sp$, "Hello\Welcome to\Q-Window\(press space)\")
DO
B$ = popup$(12 * RND + 1, 12 * RND + 1, p3$, "Choose\1-One\2-Two\3-Exit\4-Beep\")
IF B$ = "01" THEN t$ = "You choose One\"
IF B$ = "02" THEN t$ = "You choose Two\"
IF B$ = "03" THEN t$ = "Bye!\"
IF B$ = "04" THEN t$ = "beep!\"
a$ = popup$(INT(12 * RND) + 1, INT(12 + RND) + 1, "P  ", t$)
LOOP WHILE B$ <> "03"

SUB closebox (x, y, w, h)
x1 = x * 8 - 8: y1 = y * 8 - 8
x2 = (x + w) * 8 - 8: y2 = (y + h) * 8 - 8
IF w > h THEN t = h ELSE t = w
FOR a = 0 TO t * 4
LINE (x1 + 6 + a, y1 + 6 + a)-(x2 - 6 - a, y2 - 6 - a), 0, BF
LINE (x1 + 5 + a, y1 + 5 + a)-(x2 - 5 - a, y2 - 5 - a), 8, B
LINE (x1 + 4 + a, y1 + 4 + a)-(x2 - 4 - a, y2 - 4 - a), 7, B
LINE (x1 + 3 + a, y1 + 3 + a)-(x2 - 3 - a, y2 - 3 - a), 15, B
LINE (x1 + 2 + a, y1 + 2 + a)-(x2 - 2 - a, y2 - 2 - a), 7, B
LINE (x1 + 1 + a, y1 + 1 + a)-(x2 - 1 - a, y2 - 1 - a), 8, B
LINE (x1 + 0 + a, y1 + 0 + a)-(x2 - 0 - a, y2 - 0 - a), 0, B
NEXT a
END SUB

SUB openbox (x, y, w, h)
x1 = x * 8 - 8: y1 = y * 8 - 8
x2 = (x + w) * 8 - 8: y2 = (y + h) * 8 - 8
IF w > h THEN t = h ELSE t = w
FOR a = t * 4 TO 0 STEP -1
LINE (x1 + 6 + a, y1 + 6 + a)-(x2 - 6 - a, y2 - 6 - a), 0, BF
LINE (x1 + 5 + a, y1 + 5 + a)-(x2 - 5 - a, y2 - 5 - a), 8, B
LINE (x1 + 4 + a, y1 + 4 + a)-(x2 - 4 - a, y2 - 4 - a), 8, B
LINE (x1 + 3 + a, y1 + 3 + a)-(x2 - 3 - a, y2 - 3 - a), 7, B
LINE (x1 + 2 + a, y1 + 2 + a)-(x2 - 2 - a, y2 - 2 - a), 15, B
LINE (x1 + 1 + a, y1 + 1 + a)-(x2 - 1 - a, y2 - 1 - a), 7, B
LINE (x1 + 0 + a, y1 + 0 + a)-(x2 - 0 - a, y2 - 0 - a), 8, B
NEXT a
END SUB

FUNCTION popup$ (x1, y1, PR$, tx$)
w = 2: h = 2
mw = w
FOR a = 1 TO LEN(tx$)
    g$ = MID$(tx$, a, 1)
    IF g$ <> "\" THEN
        w = w + 1
    ELSE
        h = h + 1
        IF w > mw THEN mw = w
        w = 2
    END IF
NEXT a
w = mw

DIM bak%(w * h * 32)
GET (x1 * 8 - 8, y1 * 8 - 8)-((x1 + w) * 8 - 1, (y1 + h) * 8 - 1), bak%

openbox x1, y1, w, h

COLOR 15
L = 0
P = 0
t = LEN(tx$)
DO
P = P + 1
g$ = MID$(tx$, P, 1)
IF g$ <> "\" THEN t$ = t$ + g$ ELSE L = L + 1: LOCATE y1 + L, x1 + w \ 2 - LEN(t$) / 2: PRINT t$: t$ = ""
LOOP WHILE P < t

res$ = ""
L = LEN(PR$)
P = 1
WORKING = -1
DO
t$ = INKEY$
IF t$ <> "" THEN k$ = t$
g$ = MID$(PR$, P, 3)
C$ = LEFT$(g$, 1)
IF C$ = "B" THEN BEEP
IF C$ = "P" THEN SLEEP
IF C$ = "I" THEN IF k$ = MID$(g$, 2, 1) THEN P = INSTR(PR$, "%" + RIGHT$(g$, 1)): k$ = ""
IF C$ = "G" THEN P = INSTR(PR$, "%" + MID$(g$, 2, 1))
IF C$ = "E" THEN WORKING = 0
IF C$ = "R" THEN ret$ = RIGHT$(g$, 2)
P = P + 3
IF P > L THEN WORKING = 0
LOOP WHILE WORKING
closebox x1, y1, w, h
PUT (x1 * 8 - 8, y1 * 8 - 8), bak%, PSET
popup$ = ret$
END FUNCTION

SUB winbox (x, y, w, h)
x1 = x * 8 - 8: y1 = y * 8 - 8
x2 = (x + w) * 8 - 8: y2 = (y + h) * 8 - 8
LINE (x1 + 6, y1 + 6)-(x2 - 6, y2 - 6), 0, BF
LINE (x1 + 5, y1 + 5)-(x2 - 5, y2 - 5), 8, B
LINE (x1 + 4, y1 + 4)-(x2 - 4, y2 - 4), 8, B
LINE (x1 + 3, y1 + 3)-(x2 - 3, y2 - 3), 7, B
LINE (x1 + 2, y1 + 2)-(x2 - 2, y2 - 2), 15, B
LINE (x1 + 1, y1 + 1)-(x2 - 1, y2 - 1), 7, B
LINE (x1 + 0, y1 + 0)-(x2 - 0, y2 - 0), 8, B

END SUB

