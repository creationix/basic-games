DEFINT A-Z
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
DIM skill$(300)
OPEN "skills.lst" FOR INPUT AS #1
FOR a = 1 TO 300
INPUT #1, skill$(a)
NEXT a
CLS

CLOSE #1
OPEN "party.dat" FOR INPUT AS #1
FOR a = 1 TO 6
INPUT #1, party(a).CharName
INPUT #1, party(a).HitPoints
INPUT #1, party(a).Magic
INPUT #1, party(a).Attack
INPUT #1, party(a).Defense
INPUT #1, party(a).Expierence
INPUT #1, party(a).Picture
INPUT #1, party(a).Status
INPUT #1, party(a).Level

INPUT #1, a$
FOR b = 1 TO 300
c$ = MID$(a$, b, 1)
IF c$ = CHR$(0) THEN c$ = "N"
skills(a, b) = c$
NEXT b

NEXT a
FOR a = 1 TO 100
    INPUT #1, inventory(a).number
    INPUT #1, inventory(a).id
NEXT a
CLOSE #1

current = 1

DO
CLS
COLOR 7: IF ch = 0 THEN COLOR 15
PRINT "Name:"; party(current).CharName
COLOR 9
PRINT "-------------------------------------------------------------"
COLOR 9
COLOR 7: IF ch = 1 THEN COLOR 15
PRINT "HitPoints:"; party(current).HitPoints
COLOR 7: IF ch = 2 THEN COLOR 15
PRINT "Magic:"; party(current).Magic
COLOR 7: IF ch = 3 THEN COLOR 15
PRINT "Attack:"; party(current).Attack
COLOR 7: IF ch = 4 THEN COLOR 15
PRINT "Defense:"; party(current).Defense
COLOR 7: IF ch = 5 THEN COLOR 15
PRINT "Expierence"; party(current).Expierence
COLOR 7: IF ch = 6 THEN COLOR 15
PRINT "Level:"; party(current).Level
COLOR 7: IF ch = 7 THEN COLOR 15
PRINT "Skills"
FOR b = 1 TO 300
IF skills(current, b) = "Y" THEN PRINT skill$(b); "  ";
NEXT b
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "L" THEN
CLS
FOR a = 1 TO 300
PRINT skill$(a); " ";
NEXT a
DO: LOOP WHILE INKEY$ = ""
END IF
IF a$ = "+" THEN current = current + 1
IF a$ = "-" THEN current = current - 1
IF a$ = "8" THEN ch = ch - 1
IF a$ = "2" THEN ch = ch + 1
IF ch < 0 THEN ch = 0

IF a$ = " " THEN
    LOCATE 20, 1
    SELECT CASE ch
    CASE 0
        INPUT "Enter name: "; t$:
        IF t$ <> "" THEN party(current).CharName = t$
    CASE 1
        INPUT "Enter hitpoints: ", t
        IF t > 0 THEN party(current).HitPoints = t
    CASE 2
        INPUT "Enter Magic: ", t
        IF t > 0 THEN party(current).Magic = t
    CASE 3
        INPUT "Enter Attack: ", t
        IF t > 0 THEN party(current).Attack = t
    CASE 4
        INPUT "Enter Defense: ", t
        IF t > 0 THEN party(current).Defense = t
    CASE 5
        INPUT "Enter Expierence: ", t
        IF t > 0 THEN party(current).Expierence = t

    CASE 6
        INPUT "Enter level: ", t
        IF t > 0 THEN party(current).Level = t
    CASE 7
        INPUT "Enter Skill number to toggle: ", t
         IF t < 1 OR t > 300 THEN t = 0
        IF skills(current, t) <> "Y" THEN
            skills(current, t) = "Y"
        ELSE
            skills(current, t) = "N"
        END IF
    END SELECT
    LOCATE 20, 1: PRINT "                                                  "
END IF

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
CLOSE #1

