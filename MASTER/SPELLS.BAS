DECLARE SUB summon (g%, b%)
DECLARE SUB save ()
DECLARE SUB viewall ()
DECLARE SUB update (g%)
DEFINT A-Z
TYPE spell
    title AS STRING * 20
    cs AS INTEGER
    ab AS INTEGER
    nm AS INTEGER
END TYPE

DIM SHARED s(60) AS spell
DIM SHARED cr$(48), mon(48, 10, 10)
DIM SHARED abil$(30), t(48, 8)
abil$(0) = "                "
abil$(1) = "Boat            "
abil$(2) = "Armor piercing  "
abil$(3) = "Air Walking     "
abil$(4) = "Fireball Spell  "
abil$(5) = "Magic Immunuty  "
abil$(6) = "Giant Strength  "
abil$(7) = "Fire Immunity   "
abil$(8) = "Second Life     "
abil$(9) = "Quick Move      "
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
SCREEN 0
WIDTH 80
CLS
OPEN "spells.dat" FOR INPUT AS #1
FOR a = 1 TO 60
INPUT #1, s(a).title
INPUT #1, s(a).cs, s(a).ab, s(a).nm
NEXT a
CLOSE #1
OPEN "creature.dat" FOR INPUT AS #1
FOR a = 1 TO 48
LOCATE 1, 1
PRINT "Loading creature #"; a
FOR y = 1 TO 10
INPUT #1, a$
NEXT y
FOR b = 1 TO 8
INPUT #1, c
NEXT b
INPUT #1, cr$(a)
FOR b = 1 TO 11
INPUT #1, c
IF b < 9 THEN t(a, b) = c
NEXT b
NEXT a
CLOSE #1
CLS
g = 1
update g
DO
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "s" THEN CALL save
IF a$ = "," THEN g = g - 1: IF g < 1 THEN g = 60
IF a$ = "." THEN g = g + 1: IF g > 60 THEN g = 1
IF a$ = "m" THEN INPUT "Mana use"; s(g).cs
IF a$ = "n" THEN INPUT "Spell name"; s(g).title
IF a$ = "v" THEN CALL viewall
IF a$ = " " THEN
PRINT "1 Enchantment"
PRINT "2 Summon"
PRINT "3 Heal"
PRINT "4 Fire Damage"
PRINT "5 Magic damage"
PRINT "6 Charm"
PRINT "7 Disenchant:"
PRINT "8"
PRINT "9"
PRINT "10"
INPUT "What type of spell? "; s(g).ab
IF s(g).ab = 1 THEN PRINT "Enchantment number? ";
IF s(g).ab = 2 THEN PRINT "Summen number? ";
IF s(g).ab > 2 THEN PRINT "Power? ";
INPUT s(g).nm
IF s(g).ab = 2 THEN summon g, s(g).nm
IF s(g).ab = 1 THEN s(g).title = abil$(s(g).nm)
END IF
update g
LOOP

SUB save
OPEN "spells.dat" FOR OUTPUT AS #1
FOR a = 1 TO 60
PRINT #1, s(a).title
WRITE #1, s(a).cs, s(a).ab, s(a).nm
NEXT a
CLOSE #1
END SUB

SUB summon (g, b)
s(g).title = cr$(s(g).nm)
t = t(b, 8) * 1
t = t + t(b, 3) * 1
t = t + t(b, 1) * 1
t = t + t(b, 2) * 1
t = t + t(b, 4) * 1
t = t + t(b, 5) * 1
t = t + t(b, 6) * 1
t = t + t(b, 7) * 1
s(g).cs = t
END SUB

SUB update (g)
CLS
COLOR 15
PRINT "Spell number"; g
PRINT "Spell name: "; s(g).title
COLOR 9
PRINT
PRINT "Mana use"; s(g).cs
PRINT
COLOR 12
t = s(g).ab
b = s(g).nm
IF t = 0 THEN PRINT "No magic done"
IF t = 1 THEN PRINT "Enchant with "; abil$(b)
IF t = 2 THEN PRINT "Summon a "; cr$(b)
IF t = 3 THEN PRINT "Heal for"; b; "points"
IF t = 4 THEN PRINT "Fire burn with"; b
IF t = 5 THEN PRINT "Magic damage of"; b
IF t = 6 THEN PRINT "Charm level"; b
IF t = 7 THEN PRINT "Disenchant level"; b
END SUB

SUB viewall
SCREEN 12
WIDTH 80, 60
FOR a = 1 TO 60
COLOR 15
LOCATE a, 1
PRINT a;
COLOR 7
PRINT s(a).title,
PRINT "Use"; s(a).cs,
t = s(a).ab
b = s(a).nm
IF t = 0 THEN PRINT "No magic done";
IF t = 1 THEN PRINT "Enchant with "; abil$(b);
IF t = 2 THEN PRINT "Summon a "; cr$(b);
IF t = 3 THEN PRINT "Heal for"; b; points;
IF t = 4 THEN PRINT "Fire burn with"; b;
IF t = 5 THEN PRINT "Magic damage of"; b;
IF t = 6 THEN PRINT "Charm level"; b;
IF t = 7 THEN PRINT "Disenchant level"; b;
NEXT a
DO: LOOP WHILE INKEY$ = ""
SCREEN 0
WIDTH 80
END SUB

