DECLARE SUB message (a$)
DECLARE SUB card (ca%)
DECLARE SUB cPRINT (a$)
DECLARE FUNCTION cor% (m$)


DEFINT A-Z
DIM SHARED n$(100), t$(100), m$(100), d$(100, 4)
WIDTH 80

OPEN "deck.dat" FOR INPUT AS #1
DO
cd = cd + 1
INPUT #1, n$(cd), t$(cd), m$(cd)
FOR a = 1 TO 4
LINE INPUT #1, d$(cd, a)
NEXT a
done:
LOOP WHILE NOT EOF(1)
CLOSE #1
CLS
DO
FOR a = 1 TO cd
y = ((a - 1) MOD 4) * 4 + 1
x = ((a - 1) \ 4) * 11 + 1
LOCATE y, x
card a
NEXT a
LOOP

SUB card (ca)
t! = TIMER
IF ca < 1 THEN message "Card to low error!": EXIT SUB
c = cor(m$(ca))
IF t$(ca) = "LAND" THEN c = cor(d$(ca, 1))
COLOR c
x = POS(0)
SOUND 100, .3
y = CSRLIN
FOR a = 0 TO 8
LOCATE y + a, x: PRINT SPACE$(32)
NEXT a
LOCATE y, x: PRINT "ษออออออออออออออออออออออออออออออป"
LOCATE y + 1, x: PRINT "บ"; : COLOR 15: PRINT n$(ca); : COLOR c: PRINT "บ"
a$ = t$(ca) + SPACE$(30)
MID$(a$, 25) = m$(ca)
a$ = LEFT$(a$, 30)
LOCATE y + 2, x: PRINT "บ"; : cPRINT (a$): COLOR c: PRINT "บ"
LOCATE y + 3, x: PRINT "ฬออออออออออออออออออออออออออออออน"
FOR a = 1 TO 4
LOCATE y + 3 + a, x: PRINT "บ"; : cPRINT d$(ca, a): COLOR c: PRINT "บ"
NEXT a
LOCATE y + 8, x: PRINT "ศออออออออออออออออออออออออออออออผ"
SOUND 0, 0
LOCATE 1, 1: PRINT INT((TIMER - t!) * 1000)
END SUB

FUNCTION cor (m$)
c = 7
FOR a = 1 TO LEN(m$)
f$ = MID$(m$, a, 1)
IF f$ = "" THEN IF c = 7 THEN c = 15 ELSE c = 14
IF f$ = "" THEN IF c = 7 THEN c = 10 ELSE c = 14
IF f$ = "" THEN IF c = 7 THEN c = 12 ELSE c = 14
IF f$ = "" THEN IF c = 7 THEN c = 7 ELSE c = 14
IF f$ = "ญ" THEN IF c = 7 THEN c = 9 ELSE c = 14
NEXT a
cor = c
END FUNCTION

SUB cPRINT (a$)
FOR a = 1 TO LEN(a$)
f$ = MID$(a$, a, 1)
c = 7
IF LCASE$(f$) <> f$ THEN c = 15
IF (UCASE$(f$) < "A" OR UCASE$(f$) > "Z") AND f$ <> " " THEN
  SELECT CASE f$
    CASE "(": c = 14
    CASE ")": c = 14
    CASE "@": c = 5
    CASE "": c = 15
    CASE "": c = 10
    CASE "": c = 12
    CASE "": c = 7
    CASE "ญ": c = 9
  END SELECT
END IF
COLOR c: PRINT f$;
NEXT a

END SUB

SUB message (a$)
a$ = " " + a$ + " "
l = LEN(a$)
COLOR 15
LOCATE 10, 40 - l / 2: PRINT "ฺ"; STRING$(l, 196); "ฟ"
LOCATE 11, 40 - l / 2: PRINT "ณ"; : COLOR 12: PRINT a$; : COLOR 15: PRINT "ณ"
LOCATE 12, 40 - l / 2: PRINT "ภ"; STRING$(l, 196); "ู"
FOR a = 1 TO 20
SOUND 37 + a * 10, .1
SOUND 37 + a * 30, .1
NEXT a
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
COLOR 7:
LOCATE 10, 40 - l / 2: PRINT "ฺ"; STRING$(l, 196); "ฟ"
LOCATE 11, 40 - l / 2: PRINT "ณ"; a$; "ณ"
LOCATE 12, 40 - l / 2: PRINT "ภ"; STRING$(l, 196); "ู"
FOR a = 1 TO 2000: NEXT a
COLOR 8:
LOCATE 10, 40 - l / 2: PRINT "ฺ"; STRING$(l, 196); "ฟ"
LOCATE 11, 40 - l / 2: PRINT "ณ"; a$; "ณ"
LOCATE 12, 40 - l / 2: PRINT "ภ"; STRING$(l, 196); "ู"
FOR a = 1 TO 2000: NEXT a
COLOR 0:
LOCATE 10, 40 - l / 2: PRINT "ฺ"; STRING$(l, 196); "ฟ"
LOCATE 11, 40 - l / 2: PRINT "ณ"; a$; "ณ"
LOCATE 12, 40 - l / 2: PRINT "ภ"; STRING$(l, 196); "ู"
END SUB

