DECLARE SUB viewall ()
DECLARE SUB copy (a%, b%)
DECLARE FUNCTION free% (g%)
DECLARE SUB save ()
DECLARE SUB edit (g%)
DEFINT A-Z
DECLARE SUB update (g)
SCREEN 0
WIDTH 80
CLS
TYPE creature
    title AS STRING * 20
    mr AS STRING * 1
    at AS STRING * 1
    rg AS STRING * 1
    mv AS STRING * 1
    hp AS STRING * 1
    mp AS STRING * 1
    ar AS STRING * 1
    tm AS STRING * 1
    th AS STRING * 1
    tv AS STRING * 1
    mt AS STRING * 1
    gd AS STRING * 1
    fd AS STRING * 1
    md AS STRING * 1
    ex AS STRING * 1
END TYPE

DIM SHARED c(48) AS creature
DIM SHARED ab(48, 8)
DIM SHARED pic(48, 10, 10)
DIM SHARED abil$(30)
abil$(0) = "                "
abil$(1) = "Boat            "
abil$(2) = "Armor piercing  "
abil$(3) = "Air Walking     "
abil$(4) = "Fireball Spell  "
abil$(5) = "Magic Immunuty  "
abil$(6) = "Giant Strength  "
abil$(7) = "Fire Immunity   "
abil$(8) = "Second Life     "
abil$(9) = "Negate first hit"
abil$(10) = "Weapon immunity "
abil$(11) = "Drain power     "
abil$(12) = "Undead          "
abil$(13) = "Elderich Weapon "
abil$(14) = "Double Hit Short"
abil$(15) = "Two hit Ranged  "
abil$(16) = "Flame Blade     "
abil$(17) = "Speed +1        "
abil$(18) = "Accuracy        "
abil$(19) = "Legendary       "
abil$(20) = "Wand of Power   "
abil$(21) = "Construction    "
abil$(22) = "Healer          "
abil$(23) = "Lucky           "
abil$(24) = "Divine Favor    "
abil$(25) = "Fast Learn      "
abil$(26) = "Invisibility    "
abil$(27) = "Soul Rush       "
abil$(28) = "Explosion       "
abil$(29) = "Large Shield    "
abil$(30) = "Magic Missile   "
OPEN "creature.dat" FOR INPUT AS #1
FOR a = 1 TO 48
LOCATE 1, 1: PRINT "Loading #"; a
FOR y = 1 TO 10
INPUT #1, a$
FOR x = 1 TO 10
pic(a, x, y) = ASC(MID$(a$, x, 1)) - 100
NEXT x
NEXT y
FOR b = 1 TO 8
INPUT #1, ab(a, b)
NEXT b
INPUT #1, c(a).title
INPUT #1, g: c(a).at = CHR$(g)
INPUT #1, g: c(a).rg = CHR$(g)
INPUT #1, g: c(a).mv = CHR$(g)
INPUT #1, g: c(a).hp = CHR$(g)
INPUT #1, g: c(a).mp = CHR$(g)
INPUT #1, g: c(a).ar = CHR$(g)
INPUT #1, g: c(a).mr = CHR$(g)
INPUT #1, g: c(a).mt = CHR$(g)
INPUT #1, g: c(a).gd = CHR$(g)
INPUT #1, g: c(a).fd = CHR$(g)
INPUT #1, g: c(a).md = CHR$(g)
NEXT a
CLOSE #1
h = 1
update h
DO
a$ = INKEY$
IF a$ = " " THEN
DO
LOCATE 14, 1: COLOR 15: INPUT "Change Which"; c
LOOP WHILE c < 0 OR c > 12
IF c = 1 THEN INPUT "Name:"; c(h).title
IF c = 2 THEN INPUT "Moving type 0-land 1-water 2-air"; a: c(h).mt = CHR$(a)
IF c = 3 THEN INPUT "Attack power"; a: c(h).at = CHR$(a)
IF c = 4 THEN INPUT "Ranged attack"; a: c(h).rg = CHR$(a)
IF c = 5 THEN INPUT "Move points"; a: c(h).mv = CHR$(a)
IF c = 6 THEN INPUT "Hitpoints"; a: c(h).hp = CHR$(a)
IF c = 7 THEN INPUT "Magic points"; a: c(h).mp = CHR$(a)
IF c = 8 THEN INPUT "Armor"; a: c(h).ar = CHR$(a)
IF c = 9 THEN INPUT "Magic resistance"; a: c(h).mr = CHR$(a)
IF c = 10 THEN INPUT "Gold upkeep:"; a: c(h).gd = CHR$(a)
IF c = 11 THEN INPUT "Food upkeep:"; a: c(h).fd = CHR$(a)
IF c = 12 THEN INPUT "Mana upkeep"; a: c(h).md = CHR$(a)
update h
END IF
IF a$ = "." THEN h = h MOD 48 + 1: update h
IF a$ = "," THEN h = h - 1: IF h < 1 THEN h = 48: update h ELSE update h
IF a$ = "s" THEN CALL save
IF a$ = "e" THEN edit h
IF a$ = "a" THEN g = free(h): IF g > 0 THEN LOCATE 14, 1: COLOR 15: INPUT "Give what ability"; ab(h, g): update h
IF a$ = "t" THEN LOCATE 14, 1: COLOR 15: INPUT "Take what ability (1-8)"; t: ab(h, t) = 0: update h
IF a$ = "c" THEN LOCATE 14, 1: COLOR 15: INPUT "copy to what page"; t: copy h, t: update h
IF a$ = "v" THEN CALL viewall: update h
IF a$ = "l" THEN
INPUT a: c(h).fd = CHR$(a)
INPUT a: c(h).gd = CHR$(a)
INPUT a: c(h).md = CHR$(a)
INPUT a: c(h).mt = CHR$(a)
INPUT a: c(h).mv = CHR$(a)
INPUT a: c(h).at = CHR$(a)
INPUT a: c(h).rg = CHR$(a)
INPUT a: c(h).hp = CHR$(a)
INPUT a: c(h).mp = CHR$(a)
INPUT a: c(h).ar = CHR$(a)
INPUT a: c(h).mr = CHR$(a)
update h
END IF
LOOP WHILE a$ <> "q"

SUB copy (a, b)
FOR y = 1 TO 10
FOR x = 1 TO 10
pic(b, x, y) = pic(a, x, y)
NEXT x
NEXT y
FOR s = 1 TO 8
ab(b, s) = ab(a, s)
NEXT s
c(b).title = c(a).title
c(b).at = c(a).at
c(b).rg = c(a).rg
c(b).mv = c(a).mv
c(b).hp = c(a).hp
c(b).mp = c(a).mp
c(b).ar = c(a).ar
c(b).mr = c(a).mr
c(b).mt = c(a).mt
c(b).gd = c(a).gd
c(b).fd = c(a).fd
c(b).md = c(a).md
END SUB

SUB edit (g)
x = 5: y = 5
DO
ox = x: oy = y
a$ = INKEY$
IF a$ = "8" THEN y = y - 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "2" THEN y = y + 1
IF a$ = "z" THEN pic(g, x, y) = 0
IF a$ = "x" THEN pic(g, x, y) = 1
IF a$ = "c" THEN pic(g, x, y) = 2
IF a$ = "v" THEN pic(g, x, y) = 3
IF a$ = "b" THEN pic(g, x, y) = 4
IF a$ = "n" THEN pic(g, x, y) = 5
IF a$ = "m" THEN pic(g, x, y) = 6
IF a$ = "," THEN pic(g, x, y) = 7
IF a$ = "a" THEN pic(g, x, y) = 8
IF a$ = "s" THEN pic(g, x, y) = 9
IF a$ = "d" THEN pic(g, x, y) = 10
IF a$ = "f" THEN pic(g, x, y) = 11
IF a$ = "g" THEN pic(g, x, y) = 12
IF a$ = "h" THEN pic(g, x, y) = 13
IF a$ = "j" THEN pic(g, x, y) = 14
IF a$ = "k" THEN pic(g, x, y) = 15
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
IF x > 10 THEN x = 10
IF y > 10 THEN y = 10
IF ox <> x OR oy <> y THEN LOCATE oy + 2, ox * 2 + 40: COLOR pic(g, ox, oy): PRINT "лл"
LOCATE y + 2, x * 2 + 40: COLOR pic(g, x, y), 8 * RND: PRINT "ББ"
LOOP WHILE a$ <> "e"
LOCATE y + 2, x * 2 + 40: COLOR pic(g, x, y), 0: PRINT "лл"
SCREEN 13
FOR y = 1 TO 10
FOR x = 1 TO 10
'LINE (100 + x * 2, 100 + y * 2)-(100 + x * 2 - 1, 100 + y * 2 - 1), pic(g, x, y), B
PSET (100 + x, 100 + y), pic(g, x, y)
NEXT x
NEXT y
DO: LOOP WHILE INKEY$ = ""
SCREEN 0: WIDTH 80: COLOR 15, 0: update g
END SUB

FUNCTION free (g)
f = 0
FOR a = 1 TO 8
IF ab(g, a) = 0 THEN f = a: a = 8
NEXT a
free = f
END FUNCTION

SUB save
OPEN "creature.dat" FOR OUTPUT AS #1
FOR a = 1 TO 48
FOR y = 1 TO 10
a$ = ""
FOR x = 1 TO 10
a$ = a$ + CHR$(pic(a, x, y) + 100)
NEXT x
PRINT #1, a$
NEXT y
FOR b = 1 TO 8
PRINT #1, ab(a, b)
NEXT b
PRINT #1, c(a).title
PRINT #1, ASC(c(a).at)
PRINT #1, ASC(c(a).rg)
PRINT #1, ASC(c(a).mv)
PRINT #1, ASC(c(a).hp)
PRINT #1, ASC(c(a).mp)
PRINT #1, ASC(c(a).ar)
PRINT #1, ASC(c(a).mr)
PRINT #1, ASC(c(a).mt)
PRINT #1, ASC(c(a).gd)
PRINT #1, ASC(c(a).fd)
PRINT #1, ASC(c(a).md)
NEXT a
CLOSE #1
END SUB

SUB update (g)
CLS
FOR y = 0 TO 11
LOCATE y + 2, 40
FOR x = 0 TO 11
IF x = 0 OR y = 0 OR x = 11 OR y = 11 THEN COLOR 7 ELSE COLOR pic(g, x, y)
PRINT "лл";
NEXT x
NEXT y
LOCATE 1, 1
COLOR 15
PRINT "Creature #"; g
PRINT "1 Name: "; c(g).title
PRINT "2 Moving type ";
a = ASC(c(g).mt)
IF a = 0 THEN PRINT "Land "
IF a = 1 THEN PRINT "Water "
IF a < 0 OR a > 1 THEN PRINT "Flying"
COLOR 9
PRINT "3 Attack power     "; ASC(c(g).at)
PRINT "4 Ranged Attack    "; ASC(c(g).rg)
PRINT "5 Movement         "; ASC(c(g).mv)
PRINT "6 Hit Points       "; ASC(c(g).hp)
PRINT "7 Magic Points     "; ASC(c(g).mp)
PRINT "8 Armor            "; ASC(c(g).ar)
PRINT "9 Magic Resistance "; ASC(c(g).mr)
COLOR 10
PRINT "10 Gold upkeep"; ASC(c(g).gd)
PRINT "11 Food Upkeep"; ASC(c(g).fd)
PRINT "12 Mana upkeep"; ASC(c(g).md)
PRINT
COLOR 15
PRINT "Special abilities"
COLOR 7
FOR a = 1 TO 8
PRINT a; abil$(ab(g, a))
NEXT a
END SUB

SUB viewall
SCREEN 7
CLS
FOR a = 1 TO 4
FOR b = 1 TO 12
LOCATE b * 2 - 1, a * 10 - 7
PRINT LEFT$(c(a * 12 - 12 + b).title, 8);
LOCATE b * 2, a * 10 - 7
PRINT MID$(c(a * 12 - 12 + b).title, 9, 8);
FOR y = 1 TO 10
sx = a * 80 - 77: sy = b * 16 - 8
FOR x = 1 TO 10
sx = a * 80 - 77 + x: sy = b * 16 - 8 + y
PSET (sx, sy - 10), pic(a * 12 - 12 + b, x, y)
NEXT x
NEXT y
NEXT b
NEXT a
DO: LOOP WHILE INKEY$ = ""
SCREEN 0
WIDTH 80
END SUB

