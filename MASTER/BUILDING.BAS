DECLARE SUB copy (a%, b%)
DECLARE SUB viewall ()
DECLARE SUB update (f%)
DECLARE SUB save ()
DECLARE SUB edit (f%)
DEFINT A-Z
TYPE building
    title AS STRING * 20
    nb AS STRING * 1
    cs AS STRING * 1
    gd AS STRING * 1
    ag AS STRING * 1
    am AS STRING * 1
    af AS STRING * 1
    ac AS STRING * 1
    ar AS STRING * 1
END TYPE

DIM SHARED c(25) AS building
DIM SHARED pic(25, 20, 20)
DIM SHARED cr$(48), mon(48, 10, 10)
SCREEN 0
WIDTH 80
CLS
OPEN "creature.dat" FOR INPUT AS #1
FOR a = 1 TO 48
LOCATE 1, 1
PRINT "Loading creature #"; a
FOR y = 1 TO 10
INPUT #1, a$
FOR x = 1 TO 10
mon(a, x, y) = ASC(MID$(a$, x, 1)) - 100
NEXT x
NEXT y
FOR b = 1 TO 8
INPUT #1, c
NEXT b
INPUT #1, cr$(a)
FOR b = 1 TO 11
INPUT #1, c
NEXT b
NEXT a
CLOSE #1
CLS
OPEN "city.dat" FOR INPUT AS #1
FOR a = 1 TO 25
LOCATE 1, 1: PRINT "Loading building #"; a
FOR y = 1 TO 20
INPUT #1, a$
FOR x = 1 TO 20
pic(a, x, y) = ASC(MID$(a$, x, 1)) - 100
NEXT x
NEXT y
INPUT #1, c(a).title
INPUT #1, c: c(a).nb = CHR$(c)
INPUT #1, c: c(a).cs = CHR$(c)
INPUT #1, c: c(a).gd = CHR$(c)
INPUT #1, c: c(a).ag = CHR$(c)
INPUT #1, c: c(a).am = CHR$(c)
INPUT #1, c: c(a).af = CHR$(c)
INPUT #1, c: c(a).ac = CHR$(c)
INPUT #1, c: c(a).ar = CHR$(c)
NEXT a

CLOSE #1

h = 1
update h
DO
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "," THEN h = h - 1: IF h < 1 THEN h = 25
IF a$ = "." THEN h = h + 1: IF h > 25 THEN h = 1
IF a$ = "s" THEN CALL save
LOCATE 13, 1: COLOR 15
IF a$ = "c" THEN INPUT "copy pic to what page"; c: copy h, c
IF a$ = "n" THEN INPUT "name:"; c(h).title
IF a$ = "1" THEN INPUT "Need what (0-auto)"; c: c(h).nb = CHR$(c)
IF a$ = "2" THEN INPUT "Cost "; c: c(h).cs = CHR$(c)
IF a$ = "3" THEN INPUT "Gold upkeep "; c: c(h).gd = CHR$(c)
IF a$ = "4" THEN INPUT "Gold income "; c: c(h).ag = CHR$(c)
IF a$ = "5" THEN INPUT "Mana Income "; c: c(h).am = CHR$(c)
IF a$ = "6" THEN INPUT "Food income "; c: c(h).af = CHR$(c)
IF a$ = "7" THEN INPUT "Growth rate"; c: c(h).ar = CHR$(c)
IF a$ = "8" THEN INPUT "Allow monster"; c: c(h).ac = CHR$(c)
IF a$ = "l" THEN
INPUT "name:"; c(h).title
INPUT "Need what (0-auto)"; c: c(h).nb = CHR$(c)
INPUT "Cost "; c: c(h).cs = CHR$(c)
INPUT "Gold upkeep "; c: c(h).gd = CHR$(c)
INPUT "Gold income "; c: c(h).ag = CHR$(c)
INPUT "Mana Income "; c: c(h).am = CHR$(c)
INPUT "Food income "; c: c(h).af = CHR$(c)
INPUT "Growth rate"; c: c(h).ar = CHR$(c)
INPUT "Allow monster"; c: c(h).ac = CHR$(c)
END IF
IF a$ = "e" THEN edit h
IF a$ = "v" THEN CALL viewall
update h
LOOP

SUB copy (a, b)
FOR y = 1 TO 20
FOR x = 1 TO 20
pic(b, x, y) = pic(a, x, y)
NEXT x
NEXT y
END SUB

SUB edit (G)
x = 20: y = 20
DO
ox = x: oy = y
a$ = INKEY$
IF a$ = "8" THEN y = y - 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "2" THEN y = y + 1
IF a$ = "z" THEN pic(G, x, y) = 0
IF a$ = "x" THEN pic(G, x, y) = 1
IF a$ = "c" THEN pic(G, x, y) = 2
IF a$ = "v" THEN pic(G, x, y) = 3
IF a$ = "b" THEN pic(G, x, y) = 4
IF a$ = "n" THEN pic(G, x, y) = 5
IF a$ = "m" THEN pic(G, x, y) = 6
IF a$ = "," THEN pic(G, x, y) = 7
IF a$ = "a" THEN pic(G, x, y) = 8
IF a$ = "s" THEN pic(G, x, y) = 9
IF a$ = "d" THEN pic(G, x, y) = 10
IF a$ = "f" THEN pic(G, x, y) = 11
IF a$ = "g" THEN pic(G, x, y) = 12
IF a$ = "h" THEN pic(G, x, y) = 13
IF a$ = "j" THEN pic(G, x, y) = 14
IF a$ = "k" THEN pic(G, x, y) = 15
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
IF x > 20 THEN x = 20
IF y > 20 THEN y = 20
IF ox <> x OR oy <> y THEN LOCATE oy + 1, ox * 2 + 30: COLOR pic(G, ox, oy): PRINT "лл"
LOCATE y + 1, x * 2 + 30: COLOR pic(G, x, y), 8 * RND: PRINT "ББ"
LOOP WHILE a$ <> "e"
LOCATE y + 1, x * 2 + 30: COLOR pic(G, x, y), 0: PRINT "лл"
SCREEN 13
FOR y = 1 TO 20
FOR x = 1 TO 20
PSET (100 + x, 100 + y), pic(G, x, y)
NEXT x
NEXT y
DO: LOOP WHILE INKEY$ = ""
SCREEN 0: WIDTH 80: COLOR 15, 0
END SUB

SUB save
OPEN "city.dat" FOR OUTPUT AS #1
FOR a = 1 TO 25
FOR y = 1 TO 20
a$ = ""
FOR x = 1 TO 20
a$ = a$ + CHR$(pic(a, x, y) + 100)
NEXT x
PRINT #1, a$
NEXT y
PRINT #1, c(a).title
PRINT #1, ASC(c(a).nb)
PRINT #1, ASC(c(a).cs)
PRINT #1, ASC(c(a).gd)
PRINT #1, ASC(c(a).ag)
PRINT #1, ASC(c(a).am)
PRINT #1, ASC(c(a).af)
PRINT #1, ASC(c(a).ac)
PRINT #1, ASC(c(a).ar)
NEXT a
CLOSE #1
END SUB

SUB update (f)
CLS
COLOR 15
PRINT "Building #"; f
PRINT "N Name: "; c(f).title
COLOR 10
PRINT
IF c(f).nb > CHR$(0) THEN PRINT "1 Need a "; c(ASC(c(f).nb)).title ELSE PRINT "1 Auto enable"
PRINT "2 Cost"; ASC(c(f).cs)
PRINT "3 Gold upkeep"; ASC(c(f).gd)
PRINT "4 Adds"; ASC(c(f).ag); "to gold income"
PRINT "5 Adds"; ASC(c(f).am); "to mana pool"
PRINT "6 Adds"; ASC(c(f).af); "to food production"
PRINT "7 Adds"; ASC(c(f).ar); "to city growth rate"
PRINT "8 Allows "; cr$(ASC(c(f).ac))
FOR y = 0 TO 21
FOR x = 0 TO 21
LOCATE y + 1, x * 2 + 30
IF x = 0 OR y = 0 OR x = 21 OR y = 21 THEN COLOR 15 ELSE COLOR pic(f, x, y)
PRINT "лл"
NEXT x
NEXT y
END SUB

SUB viewall
SCREEN 7
FOR a = 1 TO 4
FOR b = 1 TO 6
G = a * 6 - 6 + b
COLOR 15
LOCATE b * 4 - 3, a * 10 - 6: PRINT LEFT$(c(G).title, 7)
LOCATE b * 4 - 2, a * 10 - 6: PRINT MID$(c(G).title, 8, 7)
IF c(G).title > "                    " THEN
sx = a * 80 - 78: sy = b * 32 - 30
FOR y = 1 TO 10
FOR x = 1 TO 10
PSET (x + sx + 22, y + sy + 17), mon(ASC(c(G).ac), x, y)
NEXT x
NEXT y
FOR y = 1 TO 20
FOR x = 1 TO 20
PSET (x + sx, y + sy), pic(G, x, y)
NEXT x
NEXT y
END IF
NEXT b
NEXT a
DO: LOOP WHILE INKEY$ = ""
SCREEN 0
WIDTH 80
END SUB

