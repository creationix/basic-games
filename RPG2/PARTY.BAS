TYPE character
    CharName AS STRING * 30
    HitPoints AS INTEGER
    Magic AS INTEGER
    Attack AS INTEGER
    Defense AS INTEGER
    Expierence AS LONG
    Picture AS INTEGER
    Status AS INTEGER   '   0 Normal
                        '   1 Sleeping
                        '   2 Stunned
                        '   3 Bezerk
                        '   4 Chaos!
    Level AS INTEGER
END TYPE
TYPE item
    number AS INTEGER
    id AS INTEGER
END TYPE

DIM party(6) AS character
DIM inventory(100) AS item
DIM skills(6, 300) AS STRING * 1
CLS
PRINT "This program uses";
PRINT (LEN(party(0)) * 6) + (LEN(inventory(0)) * 100) + (LEN(skills(0, 0)) * 6 * 300);
PRINT "bytes of memory"
                        

party(1).CharName = "Terren Whiselir"
party(1).HitPoints = 100
party(1).Magic = 0
party(1).Level = 1
party(1).Attack = 10
party(1).Defense = 10

party(2).CharName = "Krysten"
party(2).HitPoints = 90
party(2).Magic = 30
party(2).Level = 1
party(2).Attack = 7
party(2).Defense = 7

party(3).CharName = "Julien"
party(3).HitPoints = 120
party(3).Magic = 0
party(3).Level = 2
party(3).Attack = 11
party(3).Defense = 11

party(4).CharName = "Sephinite"
party(4).HitPoints = 350
party(4).Magic = 90
party(4).Level = 6
party(4).Attack = 25
party(4).Defense = 30

party(5).CharName = "Tovi"
party(5).HitPoints = 160
party(5).Magic = 10
party(5).Level = 4
party(5).Attack = 12
party(5).Defense = 12

party(6).CharName = "Feltspar"
party(6).HitPoints = 150
party(6).Magic = 150
party(6).Level = 4
party(6).Attack = 7
party(6).Defense = 15

current = 1

FOR a = 1 TO 6
    party(a).Expierence = INT(1.8 ^ party(a).Level * 4) * 100 - 400
NEXT a


DO
CLS
COLOR 7
PRINT "Name:"; party(current).CharName
COLOR 15
PRINT "-------------------------------------------------------------"
COLOR 9
PRINT "HitPoints:"; party(current).HitPoints
PRINT "Magic:"; party(current).Magic
PRINT "Attack:"; party(current).Attack
PRINT "Defense:"; party(current).Defense
PRINT "Expierence"; party(current).Expierence
PRINT "Level:"; party(current).Level

DO
a$ = INKEY$
LOOP WHILE a$ = ""
IF a$ = "+" THEN current = current + 1
IF a$ = "-" THEN current = current - 1
IF current > 6 THEN current = 1
IF current < 1 THEN current = 6
LOOP WHILE a$ <> CHR$(13)

OPEN "party.dat" FOR OUTPUT AS #1
FOR a = 1 TO 6
PRINT #1, party(a).CharName
PRINT #1, party(a).HitPoints
PRINT #1, party(a).Magic
PRINT #1, party(a).Attack
PRINT #1, party(a).Defense
PRINT #1, party(a).Expierence
PRINT #1, party(a).Picture
PRINT #1, party(a).Status
PRINT #1, party(a).Level
a$ = ""
FOR b = 1 TO 300
a$ = a$ + skills(a, b)
NEXT b
WRITE #1, a$
NEXT a
FOR a = 1 TO 100
    PRINT #1, inventory(a).number
    PRINT #1, inventory(a).id
NEXT a


