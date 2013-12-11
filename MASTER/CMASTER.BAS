'
'        ±±±     ±±±    ±±±±     ±±±±±±   ±±±±±±±±  ±±±±±±±  ±±±±±±
'        ±±±±   ±±±±   ±±  ±±   ±±           ±±     ±±       ±±   ±±
'        ±± ±± ±± ±±   ±±±±±±   ±±±±±±±±     ±±     ±±±±±    ±±±±±±
'        ±±  ±±±  ±±  ±±    ±±        ±±     ±±     ±±       ±±   ±±
'        ±±   ±   ±±  ±±    ±±   ±±±±±±      ±±     ±±±±±±±  ±±   ±±
'
'                           By Tim Caswell
'   Game Strategies:
'
' - To have more power you will need to gain more cities.
' - To use the cities, put buildings that help prodiction.
' - Only use production hurting buildings if they are needed.
' - Watch your food. If it runs out your troops will starve.
' - Also watch gold. If unpaid, troops leave your armies.
' - When all troops are gone, no gold will cause buildings to
'     fall apart because of lack of matinence.
' - The green cities are nuetral and can be taken with no resistance.
' - It is good to look at a citie before attacking to see if
'     you stand a chance against it.
' - Boats and flying ships help you in transporting slow armies.
' - If troops are transported than they are not tired and can
'     still move.
' - The nodes will usually give you a intermediate prize for taking it.
' - If it will cause great deaths on your side, then do not attack it.
' - Casting spells in a fight will help you, but it uses your mana pool.
' - Don't try to charm a large creature, it has to much resistance.
' - Don't try to charm a small creature, they won't be worth having.
' - When a undead creature kills another it will usually become a skeleton.
' - These skeletons do not have this ability themselves.
' - If you take all of an enemy's cities and guard them the enemy can't
'     produce and their armies will starve.
' - TigerSharks are great fighters, but can't Go on land.
' - Making large armies of cheap troops is fine at first, but cost more
'     upkeep than a few highly enhanced troops.
' - When making buildings you can go in debt, but to train troops you
'     need the gold right then.
' -
' -
' -
' -
' -
' -
' -
' -
DECLARE FUNCTION nearcity% (x%, y%, player%)
DECLARE SUB denchant (unit%, abu%)
DECLARE SUB magic (x%, y%, brn%)
DECLARE SUB cast ()
DECLARE FUNCTION owrap% (a%)
DECLARE FUNCTION wrap% (a%)
DECLARE FUNCTION haveit% (unit%, ab%)
DECLARE SUB seemap (player%)
DECLARE SUB look (x%, y%, player%)
DECLARE FUNCTION menu% ()
DECLARE FUNCTION unitat% (x%, y%)
DECLARE FUNCTION findtarget% (hh%)
DECLARE FUNCTION free% (x%, y%)
DECLARE FUNCTION highest% (x%, y%)
DECLARE FUNCTION isboat% (x%, y%, p%)
DECLARE FUNCTION isplane% (x%, y%)
DECLARE FUNCTION expier% (c%)
DECLARE FUNCTION canbuild% (cty%, per%)
DECLARE FUNCTION canmake% (cty%, bld%)
DECLARE FUNCTION newname$ ()
DECLARE FUNCTION cityat% (x%, y%)
DECLARE SUB save ()
DECLARE SUB newgame ()
DECLARE SUB load ()
DECLARE SUB ttrain (x%, y%, B%, p%)
DECLARE SUB password (player%)
DECLARE SUB seeit (x%, y%, d%, player%)
DECLARE SUB compress ()
DECLARE SUB burn (dfn%, att%)
DECLARE SUB hurt (x%, y%, att%)
DECLARE SUB froy (x%, y%)
DECLARE SUB fight (fx%, fy%)
DECLARE SUB Move (rx%, ry%, tx%, ty%, player%)
DECLARE SUB drow (sx%, sy%, lx%, ly%, player%)
DECLARE SUB train (c%, B%, pl%)
DECLARE SUB build (c%, B%, player%)
DECLARE SUB info (player%)
DECLARE SUB init ()
DECLARE SUB ecity (gx%, gy%, player%)
DECLARE SUB turn (player%)
DECLARE SUB mapit (rx%, ry%, player%)
DECLARE SUB place (h%)
DECLARE SUB fill (h%)
DECLARE SUB blank ()
DECLARE SUB spells (x%, y%, player%)
DECLARE SUB fire (x%, y%, att%, brn%)
DEFINT A-Z
RANDOMIZE (TIMER)
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

TYPE spell
    title AS STRING * 15
    cs AS INTEGER
    ab AS INTEGER
    nm AS INTEGER
END TYPE

TYPE person
    di AS STRING * 1
    fa AS STRING * 1
    x AS STRING * 1
    y AS STRING * 1
    hp AS STRING * 1
    mp AS STRING * 1
    mv AS STRING * 1
    ow AS STRING * 1
    ex AS STRING * 1
    typ AS STRING * 1
END TYPE
TYPE player
    title AS STRING * 15
    mn AS INTEGER
    gd AS INTEGER
    fd AS INTEGER
    tg AS INTEGER
    tm AS INTEGER
END TYPE

DIM mana(3), gold(3), food(3)
DIM SHARED s(60) AS spell, maxc, inf(200) AS STRING * 1, sav$(9)
DIM SHARED bl(25) AS building, h(5), target(200), vx(5), vy(5)
DIM SHARED crt(48) AS creature, lvl(14, 14), ttt, ctynum, mstnum, plynum, ndenum
DIM SHARED M%(1600), pop(35), cx(35), cy(35), see(5, 50) AS STRING * 50
DIM SHARED mon%(50, 48), ab(48, 8), cit%(200, 25)
DIM SHARED abil$(30), lnd%(113, 15), vw(51, 51)
DIM SHARED city(35, 20), cty(35) AS STRING * 15
DIM SHARED map(51, 51), abit(200, 8), worth(48)
DIM SHARED unit(200) AS person, movelist(200), fav
DIM SHARED ply(5) AS player, spell(5) AS STRING * 60
fav = INT(6 * RND + 1)
FOR a = 1 TO 3
FOR y = 1 TO 50
see(a, y) = STRING$(50, "N")
NEXT y
NEXT a
FOR a = 1 TO 48: worth(a) = a: NEXT a
FOR a = 40 TO 44: worth(a) = a + 20: NEXT a
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
unit(0).x = CHR$(7)
unit(0).y = CHR$(7)
CALL init
SCREEN 1
GET (1, 1)-(20, 20), cit%(0, 0)
CLS
CIRCLE (5, 5), 4, 15
CIRCLE (5, 5), 3, 12
CIRCLE (5, 5), 2, 13
CIRCLE (6, 5), 4, 15
CIRCLE (6, 5), 3, 12
CIRCLE (6, 5), 2, 13
GET (1, 1)-(10, 10), mon%(0, 0)
CLS
OPEN "spells.dat" FOR INPUT AS #1
FOR a = 1 TO 60
INPUT #1, s(a).title
INPUT #1, s(a).cs, s(a).ab, s(a).nm
NEXT a
CLOSE #1
OPEN "city.dat" FOR INPUT AS #1
FOR a = 1 TO 25
LOCATE 4, 1: PRINT "Loading building #"; a
FOR y = 1 TO 20
INPUT #1, a$
FOR x = 1 TO 20
c = ASC(MID$(a$, x, 1)) - 100
IF c = 7 THEN c = c * ((x + y) MOD 2)
c = c MOD 8
IF c = 1 OR c = 2 OR c = 3 THEN c = 1
IF c = 4 OR c = 5 OR c = 6 THEN c = 2
PSET (x, y), c
NEXT x
NEXT y
GET (1, 1)-(20, 20), cit%(0, a)
INPUT #1, bl(a).title
INPUT #1, c: bl(a).nb = CHR$(c)
INPUT #1, c: bl(a).cs = CHR$(c)
INPUT #1, c: bl(a).gd = CHR$(c)
INPUT #1, c: bl(a).ag = CHR$(c)
INPUT #1, c: bl(a).am = CHR$(c)
INPUT #1, c: bl(a).af = CHR$(c)
INPUT #1, c: bl(a).ac = CHR$(c)
INPUT #1, c: bl(a).ar = CHR$(c)
NEXT a

CLOSE #1

OPEN "creature.dat" FOR INPUT AS #1
FOR a = 1 TO 48
LOCATE 3, 1: PRINT "Loading #"; a
FOR y = 1 TO 10
INPUT #1, a$
FOR x = 1 TO 10
c = ASC(MID$(a$, x, 1)) - 100
IF c = 7 AND (x MOD 3) AND (y MOD 3) THEN c = 0
c = c MOD 8
IF c = 1 OR c = 2 OR c = 3 THEN c = 1
IF c = 4 OR c = 5 OR c = 6 THEN c = 2
PSET (x, y), c
NEXT x
NEXT y
GET (1, 1)-(10, 10), mon%(0, a)
FOR B = 1 TO 8
INPUT #1, ab(a, B)
NEXT B
INPUT #1, crt(a).title
INPUT #1, g: crt(a).at = CHR$(g)
INPUT #1, g: crt(a).rg = CHR$(g)
INPUT #1, g: crt(a).mv = CHR$(g)
INPUT #1, g: crt(a).hp = CHR$(g)
INPUT #1, g: crt(a).mp = CHR$(g)
INPUT #1, g: crt(a).ar = CHR$(g)
INPUT #1, g: crt(a).mr = CHR$(g)
INPUT #1, g: crt(a).mt = CHR$(g)
INPUT #1, g: crt(a).gd = CHR$(g)
INPUT #1, g: crt(a).fd = CHR$(g + 1)
INPUT #1, g: crt(a).md = CHR$(g)
NEXT a
CLOSE #1
skip:
OPEN "land.dat" FOR INPUT AS #1
FOR n = 1 TO 15
FOR y = 1 TO 15
INPUT #1, a$
FOR x = 1 TO 15
c = (ASC(MID$(a$, x, 1)) - 100)
IF c < 8 AND ((x + y) MOD 2) THEN c = 0
c = c MOD 8
IF c = 1 AND RND > .5 THEN c = 0
IF c = 1 OR c = 2 OR c = 3 THEN c = 1
IF c = 4 OR c = 5 OR c = 6 THEN c = 2

PSET (x, y), c
NEXT x
NEXT y
GET (1, 1)-(15, 15), lnd%(0, n)
NEXT n
CLOSE #1
CLS
a = menu
IF a = 2 THEN GOTO start
PRINT "Generating map........"
PRINT "Grass...."
FOR y = 1 TO 50
FOR x = 1 TO 50
map(x, y) = 2
NEXT x
NEXT y
PRINT "Forest...."
FOR a = 1 TO 6
fill 4
NEXT a
PRINT "Deserts...."
FOR a = 1 TO 4
fill 3
NEXT a
PRINT "Swamps...."
FOR a = 1 TO 3
fill 6
NEXT a
PRINT "Mountains...."
FOR a = 1 TO 8
fill 5
NEXT a
PRINT "Streams...."
FOR a = 1 TO 15
x = INT(50 * RND + 1)
y = INT(50 * RND + 1)
d = INT(4 * RND + 1)
FOR B = 1 TO 70
IF d = 1 THEN x = x + 1
IF d = 2 THEN y = y + 1
IF d = 3 THEN x = x - 1
IF d = 4 THEN y = y - 1
x = wrap(x): y = wrap(y)
IF RND > .8 OR map(x, y) > 6 THEN
IF RND > .5 THEN d = d + 1 ELSE d = d - 1
map(x, y) = 9
ELSE
IF d = 1 OR d = 3 THEN map(x, y) = 7
IF d = 2 OR d = 4 THEN map(x, y) = 8
END IF
IF d > 4 THEN d = 1
IF d < 1 THEN d = 4
NEXT B
NEXT a
PRINT "Water...."
FOR a = 1 TO 10
fill 1
NEXT a
PRINT "Others......"
FOR a = 1 TO ctynum
DO
x = INT(50 * RND + 1): y = INT(50 * RND + 1)
LOOP WHILE map(x, y) <= 1 OR map(x, y) > 6
map(x, y) = 10
cx(a) = x: cy(a) = y
cty(a) = newname$
pop(a) = 3754 + 2000 * RND
IF a <= 5 THEN
city(a, 0) = a
city(a, 1) = 1
city(a, 2) = 2
city(a, 3) = 14
train a, 4, a
train a, 6, a
train a, 7, a
train a, 8, a
END IF
NEXT a
FOR B = 11 TO 15
FOR a = 1 TO ndenum
place B
NEXT a
NEXT B
FOR x = 1 TO 50
FOR y = 1 TO 50
l = map(x, y)
ll = INT(plynum + 1 + (5 - plynum) * RND)
IF l > 9 THEN
FOR t = 1 TO 7 * RND
n = INT(6 * RND + 1)
IF l = 11 THEN
IF n = 1 THEN ttrain x, y, 15, ll
IF n = 2 THEN ttrain x, y, 35, ll
IF n = 3 THEN ttrain x, y, 33, ll
IF n = 4 THEN ttrain x, y, 30, ll
IF n = 5 THEN ttrain x, y, 35, ll
IF n = 6 THEN ttrain x, y, 33, ll
END IF
IF l = 12 THEN
IF n = 1 THEN ttrain x, y, 37, ll
IF n = 2 THEN ttrain x, y, 36, ll
IF n = 3 THEN ttrain x, y, 16, ll
IF n = 4 THEN ttrain x, y, 32, ll
IF n = 5 THEN ttrain x, y, 36, ll
IF n = 6 THEN ttrain x, y, 37, ll
END IF
IF l = 13 THEN
IF n = 1 THEN ttrain x, y, 31, ll
IF n = 2 THEN ttrain x, y, 31, ll
IF n = 3 THEN ttrain x, y, 47, ll
IF n = 4 THEN ttrain x, y, 34, ll
IF n = 5 THEN ttrain x, y, 34, ll
IF n = 6 THEN ttrain x, y, 34, ll
END IF
IF l = 14 THEN
IF n = 1 THEN ttrain x, y, 17, ll
IF n = 2 THEN ttrain x, y, 18, ll
IF n = 3 THEN ttrain x, y, 19, ll
IF n = 4 THEN ttrain x, y, 20, ll
IF n = 5 THEN ttrain x, y, 21, ll
IF n = 6 THEN ttrain x, y, 22, ll
END IF
IF l = 15 THEN
IF n = 1 THEN ttrain x, y, 3, ll
IF n = 2 THEN ttrain x, y, 2, ll
IF n = 3 THEN ttrain x, y, 2, ll
IF n = 4 THEN ttrain x, y, 1, ll
IF n = 5 THEN ttrain x, y, 1, ll
IF n = 6 THEN ttrain x, y, 1, ll
END IF
NEXT t
END IF
NEXT y
NEXT x
CALL compress
FOR a = 1 TO plynum
ply(a).tg = 200
vx(a) = cx(a): vy(a) = cy(a)
NEXT a
start:
DO
GOSUB update
FOR a = 1 TO plynum
turn a
NEXT a
LINE (0, 0)-(160, 30), 0, BF
LINE (0, 0)-(160, 30), 1, B
LOCATE 2, 2: PRINT "Save game?"
ok = -1
IF TIMER > 600 THEN TIME$ = "00:00:00": ok = 0
DO
a$ = INKEY$
IF a$ = "Y" OR a$ = "y" THEN ok = 1
IF a$ = "N" OR a$ = "n" OR a$ = "E" THEN ok = -1
LOOP WHILE ok = 0
IF ok = 1 THEN CALL save
LOOP

update:
LINE (0, 0)-(160, 30), 0, BF
LINE (0, 0)-(160, 30), 1, B
LOCATE 2, 2: PRINT "Updating..."
FOR a = 1 TO plynum
    ply(a).mn = 0
    ply(a).gd = 5
    ply(a).fd = 12
NEXT a
FOR a = 1 TO maxc
    ow = ASC(unit(a).ow)
    IF ow > 0 THEN
        t = ASC(unit(a).typ)
        IF ASC(unit(a).ex) < 200 THEN unit(a).ex = CHR$(ASC(unit(a).ex) + 1)
        IF haveit(a, 25) THEN IF ASC(unit(a).ex) < 200 THEN unit(a).ex = CHR$(ASC(unit(a).ex) + 1)
        IF inf(a) = "Y" THEN inf(a) = "N": IF haveit(a, 25) THEN IF ASC(unit(a).ex) < 200 THEN unit(a).ex = CHR$(ASC(unit(a).ex) + 5)
        mv = ASC(crt(t).mv)
        IF haveit(a, 17) THEN mv = mv + 1
        FOR moving = 1 TO mv
            f = ASC(unit(a).fa)
            IF f > 0 THEN
            d = ASC(unit(a).di)
            x = ASC(unit(a).x)
            y = ASC(unit(a).y)
            mt = ASC(crt(t).mt)
            ox = x: oy = y
            IF d = 1 THEN x = x - 1: y = y + 1: f = f - 1
            IF d = 2 THEN y = y + 1: f = f - 1
            IF d = 3 THEN x = x + 1: y = y + 1: f = f - 1
            IF d = 4 THEN x = x - 1: f = f - 1
            IF d = 6 THEN x = x + 1: f = f - 1
            IF d = 7 THEN x = x - 1: y = y - 1: f = f - 1
            IF d = 8 THEN y = y - 1: f = f - 1
            IF d = 9 THEN x = x + 1: y = y - 1: f = f - 1
            x = wrap(x)
            y = wrap(y)
            l = map(x, y)
            IF ow <= 2 THEN
            boat = 0
            FOR ll = 1 TO 8
            IF abit(a, ll) = 1 THEN boat = 1
            IF abit(a, ll) = 3 THEN boat = 1
            NEXT ll
            END IF
            IF mt = 0 AND isboat(x, y, ow) = 0 AND (l = 1 OR l = 9) THEN x = ox: y = oy
            IF mt = 1 AND (l = 2 OR l = 3 OR l = 4 OR l = 5 OR l = 6 OR l > 9) THEN x = ox: y = oy
            IF boat = 1 THEN
            FOR bt = 1 TO maxc
            IF unit(bt).x = CHR$(ox) AND unit(bt).y = CHR$(oy) THEN unit(bt).x = CHR$(x): unit(bt).y = CHR$(y)
            NEXT bt
            END IF
            IF f < 0 THEN f = 0
            unit(a).fa = CHR$(f)
            unit(a).x = CHR$(x)
            unit(a).y = CHR$(y)
            IF ow <= plynum THEN seeit x, y, 2, ASC(unit(a).ow)

            IF x <> ox OR y <> oy THEN mv = mv - 1
            END IF
        NEXT moving
        unit(a).mv = CHR$(mv)
        IF ow <= plynum THEN
        ply(ow).mn = ply(ow).mn - ASC(crt(t).md)
        ply(ow).fd = ply(ow).fd - ASC(crt(t).fd) * 3
        ply(ow).gd = ply(ow).gd - ASC(crt(t).gd)
        END IF
        IF unit(a).hp < crt(t).hp THEN unit(a).hp = CHR$(ASC(unit(a).hp) + 1)
        ex = ASC(unit(a).ex): mp = ASC(crt(t).mp)
        unit(a).mp = CHR$(mp + ex \ 7)
        IF haveit(a, 19) AND ow <= plynum THEN ply(ow).gd = ply(ow).gd + 1
        IF haveit(a, 20) AND ow <= plynum THEN ply(ow).mn = ply(ow).mn + 1
    END IF
NEXT a
FOR a = 1 TO maxc
ow = ASC(unit(a).ow)
IF ow > 0 THEN
x = ASC(unit(a).x)
y = ASC(unit(a).y)
l = map(x, y)
fight x, y
lft = 0
FOR B = 1 TO maxc
IF ASC(unit(B).x) = x AND ASC(unit(B).y) = y AND ASC(unit(B).ow) > 0 THEN lft = ASC(unit(B).ow)
NEXT B
IF lft > 0 THEN
IF l = 10 THEN city(cityat(x, y), 0) = lft
END IF
END IF
NEXT a
LINE (0, 0)-(160, 30), 0, BF
LINE (0, 0)-(160, 30), 1, B
LOCATE 2, 2: PRINT "Updating..."
FOR cit = 1 TO ctynum
    mana = 2
    food = 3
    gold = 6
    grow = 120
    FOR a = 1 TO 5
    FOR B = 1 TO 4
    g = a * 4 - 4 + B
    x = city(cit, g)
    mana = mana + ASC(bl(x).am)
    food = food + ASC(bl(x).af)
    gold = gold + ASC(bl(x).ag) - ASC(bl(x).gd)
    grow = grow + ASC(bl(x).ar)
    NEXT B
    NEXT a
    gold = gold + pop(cit) / 1000
    food = food + pop(cit) / 3000
    pop(cit) = pop(cit) + grow
    IF pop(cit) > 25000 THEN pop(cit) = 25000
    ow = city(cit, 0)
    seeit cx(cit), cy(cit), 4, ow
    IF ow > 0 AND ow <= plynum THEN
    ply(ow).gd = ply(ow).gd + gold
    ply(ow).fd = ply(ow).fd + food
    ply(ow).mn = ply(ow).mn + mana
    END IF
NEXT cit
LINE (0, 0)-(160, 30), 0, BF
LINE (0, 0)-(160, 30), 1, B
LOCATE 2, 2: PRINT "Updating..."
FOR a = 1 TO plynum
ply(a).tg = ply(a).tg + ply(a).gd
ply(a).tm = ply(a).tm + ply(a).mn
tc = 0
FOR s = 1 TO maxc
IF unit(s).ow = CHR$(a) THEN tc = tc + 1
NEXT s
IF tc > 0 THEN
IF (ply(a).gd <= 0 AND ply(a).tg <= 0) OR ply(a).fd < 0 THEN
DO
r = maxc * RND
LOOP WHILE unit(r).ow <> CHR$(a)
unit(r).ow = CHR$(0): FOR s = 1 TO 40: SOUND 37 + 200 / SQR(s), .1: NEXT s
END IF
ELSE
IF ply(a).gd <= 0 AND ply(a).tg <= 0 THEN
FOR c = 1 TO ctynum
s = INT(5 * RND + 1)
IF city(c, 0) = a THEN city(c, s) = 0: FOR s = 1 TO 70: SOUND 37 + 600 / SQR(s / 2), .1: NEXT s
NEXT c
END IF
END IF
NEXT a
CLS

year = year + 1
mn = year MOD 8
IF mn = 0 OR mn = 1 THEN PRINT "Spring of";
IF mn = 2 OR mn = 3 THEN PRINT "Summer of";
IF mn = 4 OR mn = 5 THEN PRINT "Fall of";
IF mn = 6 OR mn = 7 THEN PRINT "Winter of";
PRINT 1500 + mn \ 8
PRINT "Human players"; plynum,
PRINT "Computer Players"; 5 - plynum
FOR p = 1 TO 5
PRINT
PRINT "Player"; p
PRINT "Gold"; ply(p).tg, "Mana"; ply(p).tm
g = 0
FOR a = 1 TO maxc
IF ASC(unit(a).ow) = p THEN g = g + 1
NEXT a
PRINT "Units"; g,
g = 0
FOR a = 1 TO ctynum
IF city(a, 0) = p THEN g = g + 1
NEXT a
PRINT "Cities"; g
NEXT p
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
RETURN

SUB aroa (x, y, rx, ry, d)
gx = x - rx: gy = y - ry
FOR a = -d TO d
FOR B = -d TO d
IF a + gx >= 0 AND a + gx <= 11 AND B + gy >= 0 AND B + gy <= 11 THEN
sx = rx + a: sy = ry + B
IF MID$(see(player, sy), sx, 1) = "Y" THEN
l = map(sx, sy)
PUT ((a + gx) * 15, (B + gy) * 15), lnd%(0, l), PSET
vw(sx, sy) = 0
ELSE
LINE ((a + gx) * 15, (B + gy) * 15)-((a + gx) * 15 + 14, (B + gy) * 15 + 14), 0, BF
END IF
END IF
NEXT B
NEXT a
FOR a = 1 TO maxc
sx = ASC(unit(a).x)
sy = ASC(unit(a).y)
IF vw(sx, sy) = 0 THEN tx = sx - rx: ty = sy - ry: drow tx + 5, ty + 5, sx, sy, player: vw(sx, sy) = 1
NEXT a

END SUB

SUB blank
'FOR p = 0 TO 1600
'x = (M%(p) MOD 40) * 8
'y = (M%(p) \ 40) * 5
'LINE (x, y)-(x + 7, y + 4), 0, BF
'NEXT p
CLS
END SUB

SUB build (c, B, player)
h = 0
FOR a = 1 TO 20
IF city(c, a) = B THEN h = 1: a = 20
NEXT a
IF h = 0 THEN
t = 0
FOR a = 1 TO 20
IF city(c, a) = 0 THEN t = a: a = 20
NEXT a
IF t > 0 AND player <= plynum THEN city(c, t) = B: ply(player).tg = ply(player).tg - ASC(bl(B).cs)
END IF
END SUB

SUB burn (dfn, att)
IF unit(att).ow <> unit(dfn).ow THEN
ttl = -haveit(att, 23) + haveit(dfn, 23) - haveit(att, 24) * 2 + haveit(dfn, 24) * 2
FOR aaa = 1 TO 1 - haveit(att, 15)
x = ASC(unit(dfn).x)
y = ASC(unit(dfn).y)
fx = ASC(unit(att).x)
fy = ASC(unit(att).y)
IF x > 13 THEN x = 13
IF y > 13 THEN y = 13
ds = SQR((x - fx) ^ 2 + (y - fy) ^ 2) * 3 + 1
FOR a = 0 TO ds
ohx = hx: ohy = hy
hx = (a / ds * x + (ds - a) / ds * fx) * 15 - 15
hy = (a / ds * y + (ds - a) / ds * fy) * 15 - 15
IF a > 0 THEN PUT (ohx, ohy), lnd%(0, 0), PSET
IF a < ds THEN GET (hx, hy)-(hx + 14, hy + 14), lnd%(0, 0)
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 5, 15 * RND
SOUND 100 + a * 30, .05
NEXT a
SOUND 1000, .1
hp = ASC(unit(dfn).hp)
ar = ASC(crt(ASC(unit(dfn).typ)).ar) + ASC(unit(dfn).ex) / 20 + haveit(att, 13) + haveit(att, 16) * 2 - haveit(dfn, 29)
at = ASC(crt(ASC(unit(att).typ)).rg) + 1 + ASC(unit(att).ex) / 10
dm = at * RND - ar * RND * 2
IF dm < 0 THEN dm = 0
IF RND > .5 - ttl OR haveit(att, 18) THEN
hp = hp - dm
FOR a = 1 TO 8
LINE (x * 15 - a, y * 15 - a)-(x * 15 - 16 + a, y * 15 - 16 + a), 2, B
SOUND 100 + a * 10, .1
NEXT a
END IF
IF hp <= 0 THEN IF haveit(dfn, 8) THEN denchant dfn, 8: hp = 3 ELSE inf(dfn) = "N": unit(dfn).ow = CHR$(0): FOR a = 1 TO 37: SOUND 37 + a, .05: NEXT a
IF hp < 0 THEN hp = 0
unit(dfn).hp = CHR$(hp)
FOR a = 5 TO 0 STEP -1
SOUND 37 + a * 30, .12
NEXT a
froy x, y
NEXT aaa
END IF
froy x, y
END SUB

FUNCTION canbuild (cty, per)
nd = 0
FOR a = 1 TO 20
IF ASC(bl(city(cty, a)).ac) = per THEN nd = 1
NEXT a
IF nd = 1 THEN nd = -1 ELSE nd = 0
canbuild = nd
END FUNCTION

FUNCTION canmake (cty, bld)
nd = ASC(bl(bld).nb)
FOR a = 1 TO 20
IF city(cty, a) = nd THEN nd = 0
NEXT a
FOR a = 1 TO 20
IF city(cty, a) = bld THEN nd = 1
NEXT a
IF nd = 0 THEN nd = -1 ELSE nd = 0
canmake = nd
END FUNCTION

SUB cast
player = 0
h = 0
FOR a = 1 TO 5
IF h(a) > 0 AND a <= plynum THEN player = a: h = h + 1
NEXT a
IF player = 0 THEN GOTO nocast
IF h > 1 THEN
LINE (195, 0)-(319, 199), 0, BF
LINE (195, 0)-(319, 199), 1, B
LOCATE 2, 26: PRINT "Who will cast"
B = 0
FOR a = 1 TO plynum
IF h(a) > 0 THEN B = B + 1: LOCATE 3 + B, 26: PRINT "Player"; a
NEXT a
player = 0
DO
a$ = INKEY$
IF a$ = "1" AND h(1) > 0 THEN player = 1
IF a$ = "2" AND h(2) > 0 THEN player = 2
IF a$ = "3" AND h(3) > 0 THEN player = 3
IF a$ = "4" AND h(4) > 0 THEN player = 4
IF a$ = "5" AND h(5) > 0 THEN player = 5
LOOP WHILE player = 0
END IF
LINE (195, 0)-(319, 199), 0, BF
LINE (195, 0)-(319, 199), 1, B
LOCATE 2, 26: PRINT "Player"; player
DO
FOR a = 1 TO 8
c = 1
IF a = v THEN c = 15
IF s(a).cs > ply(player).tm THEN c = c - 8
LOCATE 3 + a, 26: IF c = 15 THEN PRINT LEFT$(s(a).title, 13) ELSE PRINT "-------------"
NEXT a
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "8" THEN v = v - 1
IF a$ = "2" THEN v = v + 1
IF v < 1 THEN v = 1
IF v > 8 THEN v = 8
IF a$ = " " AND s(v).cs > ply(player).tm THEN a$ = "": SOUND 1000, .8: SOUND 500, .8
LOOP WHILE a$ <> " " AND a$ <> CHR$(27)
IF a$ = CHR$(27) THEN GOTO nocast
ply(player).tm = ply(player).tm - s(v).cs
LINE (195, 0)-(319, 199), 0, BF
LINE (195, 0)-(319, 199), 1, B
LOCATE 2, 26: PRINT "Chose a target"
x = 7: y = 7
DO
LINE (x * 15 - 15, y * 15 - 15)-(x * 15 - 1, y * 15 - 1), 2, B
DO: a$ = INKEY$: LOOP WHILE a$ = ""
ox = x: oy = y
IF a$ = "8" THEN y = y - 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "2" THEN y = y + 1
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
IF x > 13 THEN x = 13
IF y > 13 THEN y = 13
froy ox, oy
IF a$ = " " THEN IF unitat(x, y) = 0 THEN a$ = ""
LOOP WHILE a$ <> " "
froy x, y
tx = x: ty = y
ab = s(v).ab
nm = s(v).nm
tg = unitat(tx, ty)
IF ab = 4 THEN fire tx, ty, 0, nm
IF ab = 5 THEN magic tx, ty, nm
IF ab = 6 THEN
c = 0
res = ASC(crt(ASC(unit(tg).typ)).mr)
SOUND 100 + a * 10, .1: SOUND 100 + a * 15, .1
IF nm * RND > res * RND THEN SOUND 600, .1: unit(tg).ow = CHR$(player): SOUND 600, .5: SOUND 300, .6: SOUND 2000, .6
END IF
IF ab = 7 THEN
SOUND 100 + a * 10, .1: SOUND 100 + a * 15, .1
IF nm * RND > res * RND THEN SOUND 600, .1: FOR a = 1 TO 8: abit(tg, a) = 0: SOUND 37 + a * 5, .1: SOUND 300 + a * 5, .1: NEXT a
END IF
nocast:
LINE (195, 0)-(319, 199), 0, BF
LINE (195, 0)-(319, 199), 1, B
END SUB

FUNCTION cityat (x, y)
t = 0
FOR a = 1 TO ctynum
IF cx(a) = x AND cy(a) = y THEN t = a: a = ctynum
NEXT a
cityat = t
END FUNCTION

SUB compress
DO
ok = 1
FOR a = 1 TO 149
IF unit(a).ow = CHR$(0) AND unit(a + 1).ow > CHR$(0) THEN
SWAP unit(a).ow, unit(a + 1).ow
SWAP unit(a).x, unit(a + 1).x
SWAP unit(a).y, unit(a + 1).y
SWAP unit(a).typ, unit(a + 1).typ
SWAP unit(a).hp, unit(a + 1).hp
SWAP unit(a).mp, unit(a + 1).mp
SWAP unit(a).mv, unit(a + 1).mv
SWAP unit(a).ex, unit(a + 1).ex
FOR q = 1 TO 8
SWAP abit(a, q), abit(a + 1, q)
NEXT q
ok = 0
END IF
NEXT a
LOOP WHILE ok = 0
FOR a = 1 TO mstnum
IF unit(a).ow = CHR$(0) THEN maxc = a - 1: a = mstnum
NEXT a

END SUB

SUB denchant (unit, abu)
FOR a = 1 TO 8
IF abit(unit, a) = abu THEN abit(unit, a) = 0
SOUND 100 + a * 100, .1
SOUND 200 + a * 50, .1
SOUND 300 + a * 25, .1
SOUND 400 + a * 15, .1
SOUND 50 + a * 200, .1
NEXT a
END SUB

SUB drow (ax, ay, x, y, player)
lx = wrap(x): ly = wrap(y)
sx = ax
sy = ay
IF sx >= 0 AND sy >= 0 AND sx <= 10 AND sy <= 10 THEN
IF MID$(see(player, ly), lx, 1) = "Y" THEN
l = map(lx, ly)
IF l < 11 THEN h = highest(lx, ly) ELSE h = 0
PUT (sx * 15, sy * 15), lnd%(0, l), PSET
IF l = 10 THEN LINE (sx * 15, sy * 15)-(sx * 15 + 14, sy * 15 + 14), 1, B
IF h > 0 THEN PUT (sx * 15 + 2, sy * 15 + 2), mon%(0, ASC(unit(h).typ)), PSET: LINE (sx * 15 + 1, sy * 15 + 1)-(sx * 15 + 12, sy * 15 + 12), 2, B
ELSE
LINE (sx * 15, sy * 15)-(sx * 15 + 14, sy * 15 + 14), 0, BF
END IF
END IF
END SUB

SUB ecity (gx, gy, player)
enterin:
x = gx: y = gy
t = cityat(x, y)
IF t = 0 OR MID$(see(player, y), x, 1) <> "Y" THEN GOTO skip1
blank
mana = 2
food = 1
gold = 6
grow = 20
FOR a = 1 TO 5
FOR B = 1 TO 4
g = a * 4 - 4 + B
LINE (a * 21 - 21, B * 21 - 21)-(a * 21, B * 21), 2, B
x = city(t, g)
PUT (a * 21 - 20, B * 21 - 20), cit%(0, x), PSET
mana = mana + ASC(bl(x).am)
food = food + ASC(bl(x).af)
gold = gold + ASC(bl(x).ag) - ASC(bl(x).gd)
grow = grow + ASC(bl(x).ar)
NEXT B
NEXT a
B = 12
LOCATE B, 1:  PRINT "Next to build":
FOR a = 1 TO 25
IF canmake(t, a) AND B < 25 THEN B = B + 1: LOCATE B, 1: PRINT a; bl(a).title;
NEXT a
B = 9
LOCATE B, 20:  PRINT "Next to train":
FOR a = 1 TO 48
IF canbuild(t, a) AND B < 25 THEN B = B + 1: LOCATE B, 20: PRINT a; LEFT$(crt(a).title, 15);
NEXT a

gold = gold + pop(t) / 1000
food = food + pop(t) / 3000

LOCATE 1, 20: PRINT cty(t)
LOCATE 3, 20:  PRINT "Produces"; mana; "mana."
LOCATE 4, 20:  PRINT "Produces"; food; "food."
LOCATE 5, 20:  PRINT "Produces"; gold; "gold."
LOCATE 7, 20:  PRINT "Population"; pop(t)
LOCATE 8, 20:  PRINT "Rate of"; grow; "per turn"
DO
a$ = INKEY$
IF player = city(t, 0) THEN
IF a$ = "b" AND ply(player).tg > 0 THEN
LOCATE 12, 1: PRINT "                    "
LOCATE 12, 1:  INPUT "Build what"; g
IF g > 0 AND g < 26 THEN IF canmake(t, g) THEN build t, g, player: CLS : GOTO enterin
END IF
IF a$ = "t" AND ply(player).tg >= 100 THEN
LOCATE 12, 1: PRINT "                    "
LOCATE 12, 1: INPUT "Train what"; g
IF g > 0 AND g < 49 THEN IF canbuild(t, g) THEN train t, g, player: CLS : GOTO enterin
END IF
END IF
LOOP WHILE a$ <> "e" AND a$ <> CHR$(27)
blank
skip1:
END SUB

FUNCTION expier (c)
ex = 0
FOR a = 1 TO 20
IF city(c, a) = 1 THEN ex = ex + 4
IF city(c, a) = 3 THEN ex = ex + 5
IF city(c, a) = 4 THEN ex = ex + 6
IF city(c, a) = 14 THEN ex = ex + 2
IF city(c, a) = 25 THEN ex = ex + 5
NEXT a
expier = ex
END FUNCTION

SUB fight (fx, fy)
x = fx: y = fy
FOR a = 1 TO 5
h(a) = 0
NEXT a
hm = 0
FOR a = 1 TO maxc
ow = ASC(unit(a).ow)
inf(a) = "N"
IF ow > 0 AND x = ASC(unit(a).x) AND y = ASC(unit(a).y) THEN h(ow) = 1: inf(a) = "Y"
NEXT a
p = 0
FOR a = 1 TO 5
IF h(a) = 1 THEN p = p + 1: IF a <= plynum THEN hm = hm + 1
NEXT a
IF (p < 2 AND (map(fx, fy) < 11 OR hm = 0)) OR NOT (x > 0 AND y > 0 AND x < 51 AND y < 51) THEN GOTO nofight
LINE (195, 0)-(319, 199), 0, BF
LINE (195, 0)-(319, 199), 1, B
 l = map(x, y)
 FOR y = 1 TO 13
 FOR x = 1 TO 13
 IF l = 1 OR l = 9 THEN lvl(x, y) = 1
 IF l = 3 OR l = 14 THEN lvl(x, y) = 3
 IF l = 2 OR l = 10 OR l = 7 OR l = 8 THEN lvl(x, y) = 2 + CINT(RND - .4) * 2 + CINT(RND - .4) * 2
 IF l = 4 OR l = 13 THEN lvl(x, y) = 2 + CINT(RND - .3) * 2 + CINT(RND - .3) * 2: IF RND > .95 THEN lvl(x, y) = 4
 IF l = 5 OR l = 11 THEN lvl(x, y) = 2 + CINT(RND - .1) * 4: IF RND > .5 THEN lvl(x, y) = 5
 IF l = 6 OR l = 15 OR l = 12 THEN lvl(x, y) = 2 + CINT(RND + .1) * 4: IF RND > .965 THEN lvl(x, y) = 4
 IF l = 7 AND y = 7 THEN lvl(x, y) = 7
 IF l = 8 AND x = 7 THEN lvl(x, y) = 8
 IF x = 7 AND y = 7 AND l > 9 THEN lvl(x, y) = l
 NEXT x
 NEXT y
FOR a = 1 TO maxc
    IF inf(a) = "Y" THEN
    DO
    x = INT(13 * RND + 1)
    y = INT(13 * RND + 1)
    LOOP WHILE NOT free(x, y)
    unit(a).x = CHR$(x)
    unit(a).y = CHR$(y)
    END IF
NEXT a
FOR x = 1 TO 13
FOR y = 1 TO 13
l = lvl(x, y)
PUT (x * 15 - 15, y * 15 - 15), lnd%(0, l), PSET
NEXT y
NEXT x
DO
    tl = 0
    FOR a = 1 TO maxc
        IF inf(a) = "Y" THEN
            x = ASC(unit(a).x)
            y = ASC(unit(a).y)
            typ = ASC(unit(a).typ)
            mv = ASC(crt(typ).mv) * 4
            LINE (195, 0)-(319, 199), 1, B
            LOCATE 2, 26:
            PRINT LEFT$(crt(typ).title, 13)
            
            LOCATE 4, 26: PRINT "HP"; ASC(unit(a).hp); " "
            LOCATE 5, 26: PRINT "MP"; ASC(unit(a).mp); " "
            ex = ASC(unit(a).ex)
            LOCATE 7, 26: PRINT "Attack"; ASC(crt(typ).at) + 1 + ex \ 8 - haveit(a, 6)
            LOCATE 8, 26: PRINT "Ranged"; ASC(crt(typ).rg) + 1 + ex \ 10
            DO
                tt = target(a)
                IF inf(tt) <> "Y" THEN target(a) = findtarget(a): tt = target(a)
                ox = x: oy = y
                tl = tl + target(a)
                tx = ASC(unit(tt).x)
                ty = ASC(unit(tt).y)
                a$ = ""
                rg = ASC(crt(typ).rg): at = ASC(crt(typ).at)
                IF rg > 0 THEN n = INT((rg + at) * RND + 1): IF n <= rg AND target(a) > 0 THEN a$ = "*"
                IF a$ = "" THEN
                    IF tx < x AND ty < y AND unit(unitat(x - 1, y - 1)).ow <> unit(a).ow THEN a$ = "7"
                    IF tx > x AND ty < y AND unit(unitat(x + 1, y - 1)).ow <> unit(a).ow THEN a$ = "9"
                    IF tx < x AND ty > y AND unit(unitat(x - 1, y + 1)).ow <> unit(a).ow THEN a$ = "1"
                    IF tx > x AND ty > y AND unit(unitat(x + 1, y + 1)).ow <> unit(a).ow THEN a$ = "3"
                    IF a$ = "" THEN
                        IF tx < x AND unit(unitat(x - 1, y)).ow <> unit(a).ow THEN a$ = "4"
                        IF ty < y AND unit(unitat(x, y - 1)).ow <> unit(a).ow THEN a$ = "8"
                        IF tx > x AND unit(unitat(x + 1, y)).ow <> unit(a).ow THEN a$ = "6"
                        IF ty > y AND unit(unitat(x, y + 1)).ow <> unit(a).ow THEN a$ = "2"
                    END IF
                END IF
                mp = ASC(unit(a).mp)
                IF haveit(a, 28) AND mp > 0 AND ABS(tx - x) + ABS(ty - y) = 1 THEN mp = 0: fire x - 1, y, a, 9: fire x + 1, y, a, 9: fire x, y - 1, a, 9: fire x, y + 1, a, 9: fire x - 1, y - 1, a, 7: fire x + 1, y + 1, a, 7: fire x + 1, y - 1, a, 7: fire x - 1, y + 1, a, 7: a$ = "%"
                IF haveit(a, 27) AND RND > .9 THEN burn target(a), a: fire ASC(unit(tt).x), ASC(unit(tt).y), a, 6: a$ = "%": SOUND 3000, .1
                IF haveit(a, 4) AND (rg + at) * RND < 15 AND mp > 6 THEN mp = mp - 6: fire ASC(unit(tt).x), ASC(unit(tt).y), a, 15: a$ = "%"
                IF haveit(a, 30) AND (rg + at) * RND < 8 AND mp > 4 THEN mp = mp - 4: fire ASC(unit(tt).x), ASC(unit(tt).y), a, 8: a$ = "%"
                IF haveit(a, 27) AND (rg + at) * RND < 20 AND mp > 0 THEN mp = 0: FOR death = 1 TO 7: burn tt, a: NEXT death: a$ = "%"
                IF a$ = "" AND RND > .5 THEN n = INT(9 * RND + 1): a$ = CHR$(n + 48)
                unit(a).mp = CHR$(mp)
                'SOUND 0, 1.5
                IF a$ <> "" THEN
                    IF a$ = "8" THEN y = y - 1
                    IF a$ = "2" THEN y = y + 1
                    IF a$ = "4" THEN x = x - 1
                    IF a$ = "6" THEN x = x + 1
                    IF a$ = "7" THEN x = x - 1: y = y - 1
                    IF a$ = "1" THEN x = x - 1: y = y + 1
                    IF a$ = "9" THEN x = x + 1: y = y - 1
                    IF a$ = "3" THEN x = x + 1: y = y + 1
                    IF a$ = "q" THEN mv = 0
                    IF x < 1 THEN x = 1
                    IF y < 1 THEN y = 1
                    IF x > 13 THEN x = 13
                    IF y > 13 THEN y = 13
                    u = unitat(x, y)
                    IF u > 0 THEN ax = x: ay = y: x = ox: y = oy: hurt ax, ay, a: mv = 0:
                    IF a$ = "*" THEN burn target(a), a
                    unit(a).x = CHR$(x)
                    unit(a).y = CHR$(y)
                END IF
                l = lvl(x, y)
                IF l = 1 THEN mv = mv - 2
                IF l = 2 THEN mv = mv - 1
                IF l = 3 THEN mv = mv - 1
                IF l = 4 THEN mv = 0: lvl(x, y) = 2: FOR a = 1 TO 5: LINE (x * 15 - 1, y * 15 - 1)-(x * 15 - 15, y * 15 - 15), 2, BF: SOUND 100 - a * 10, .1: SOUND 1000 - a * 100, .1: NEXT a
                IF l = 5 THEN mv = mv - 4
                IF l = 6 THEN mv = mv - 2
                IF l = 7 THEN mv = mv - 3
                IF l = 8 THEN mv = mv - 3
                IF l > 8 THEN mv = mv - 2
                IF l > 10 THEN x = ox: y = oy
                IF x <> ox OR y <> oy THEN froy ox, oy: froy x, y: mv = mv - 3
                LINE (x * 15 - 14, y * 15 - 14)-(x * 15 - 3, y * 15 - 3), 2, B
            LOOP WHILE mv > 0
            froy x, y
        END IF
    NEXT a
    IF INKEY$ = "c" THEN cast
    DO: LOOP WHILE INKEY$ <> ""
    FOR v = 1 TO 5
    h(v) = 0
    NEXT v
    FOR v = 1 TO maxc
    ow = ASC(unit(v).ow)
    IF inf(v) = "Y" THEN h(ow) = 1
    NEXT v
    tl = 0
    FOR v = 1 TO 5
    tl = tl + h(v)
    NEXT v
    LOOP WHILE tl > 1
hlr = 0
FOR a = 1 TO maxc
    IF inf(a) = "Y" THEN
    IF haveit(a, 22) THEN hlr = hlr + 1
    unit(a).x = CHR$(fx)
    unit(a).y = CHR$(fy)
    unit(a).mv = CHR$(0)
    IF haveit(a, 9) THEN unit(a).mv = CHR$(1)
    winner = ASC(unit(a).ow)
    END IF
NEXT a
IF winner = 1 OR winner = 2 THEN

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
lv = map(fx, fy)
n = INT(4 * RND)
a = 10 * RND
IF lv <> 10 THEN
    LOCATE 22, 2
    PRINT "You have won the fight!"
END IF
IF lv = 10 THEN
    LOCATE 22, 2
    PRINT "You have taken a city!"
END IF
IF lv = 11 THEN
    lv = 5
    LOCATE 22, 2
    PRINT "Inside the volcano you find..."
    LOCATE 23, 2: PRINT "...";
    IF n = 0 THEN PRINT 200 + a * 15; "gold coins!": ply(winner).tg = ply(winner).tg + 200 + a * 15
    IF n = 1 THEN PRINT 40 + a * 4; "mana crystals!": ply(winner).tm = ply(winner).tm + 40 + a * 4
    IF n = 2 THEN PRINT "a friendly Hell Hound!": ttrain fx, fy, 33, winner
    IF n = 3 THEN
        PRINT "a Fireball spell!"
        unt = 0
        DO
        a = INT(maxc * RND + 1)
        IF inf(unt) = "Y" AND unit(unt).ow = CHR$(winner) AND haveit(unt, 4) = 0 THEN unt = a: a = 0
        LOOP WHILE a > 0
        t = 0
        FOR a = 1 TO 8
        IF abit(unt, a) = 0 THEN t = a: a = 8
        NEXT a
        abit(unt, t) = 4
    END IF
END IF
IF lv = 12 THEN
    lv = 6
    LOCATE 22, 2
    PRINT "Inside the node you find..."
    LOCATE 23, 2: PRINT "...";
    IF n = 0 THEN PRINT 70 + a * 14; "gold coins!": ply(winner).tg = ply(winner).tg + 70 + a * 14
    IF n = 1 THEN PRINT 60 + a * 8; "mana crystals!": ply(winner).tm = ply(winner).tm + 60 + a * 8
    IF n = 2 THEN PRINT "a friendly Genie!": ttrain fx, fy, 32, winner
    IF n = 3 THEN
        PRINT "an Accuracy spell!"
        unt = 0
        DO
        a = INT(maxc * RND + 1)
        IF inf(unt) = "Y" AND unit(unt).ow = CHR$(winner) AND haveit(unt, 18) = 0 THEN unt = a: a = 0
        LOOP WHILE a > 0
        t = 0
        FOR a = 1 TO 8
        IF abit(unt, a) = 0 THEN t = a: a = 8
        NEXT a
        abit(unt, t) = 18
    END IF
END IF
IF lv = 13 THEN
    lv = 4
    LOCATE 22, 2
    PRINT "Inside the Forest you find..."
    LOCATE 23, 2: PRINT "...";
    IF n = 0 THEN PRINT 50 + a * 8; "gold coins and"; 30 + a * 3; "mana crystals": ply(winner).tg = ply(winner).tg + 50 + a * 8: ply(winner).tm = ply(winner).tm + 30 + a * 3
    IF n = 1 THEN PRINT "an ant colony": FOR at = 1 TO 3 + a / 3: ttrain fx, fy, 34, winner: NEXT at
    IF n = 2 THEN PRINT "a friendly Earth Giant": ttrain fx, fy, 31, winner
    IF n = 3 THEN
        PRINT "a lucky charm!"
        unt = 0
        DO
        a = INT(maxc * RND + 1)
        IF inf(a) = "Y" AND unit(a).ow = CHR$(winner) AND haveit(a, 23) = 0 THEN unt = a: a = 0
        LOOP WHILE a > 0
        t = 0
        FOR a = 1 TO 8
        IF abit(unt, a) = 0 THEN t = a: a = 8
        NEXT a
        abit(unt, t) = 23
    END IF
END IF
IF lv = 14 THEN
    lv = 6
    LOCATE 22, 2
    PRINT "Inside the Ruins you find..."
    LOCATE 23, 2: PRINT "...";
    IF n = 0 THEN PRINT 60 + a * 6; "gold coins and"; 15 + a * 4; "mana crystals": ply(winner).tg = ply(winner).tg + 60 + a * 6: ply(winner).tm = ply(winner).tm + 15 + a * 4
    IF n = 1 THEN PRINT "an few skeletons": FOR at = 1 TO 3 + a / 3: ttrain fx, fy, 17, winner: NEXT at
    IF n = 2 THEN PRINT "a friendly Vampire!": ttrain fx, fy, 20, winner
    IF n = 3 THEN
        PRINT "an Amulet of Invisibility!"
        unt = 0
        DO
        a = INT(maxc * RND + 1)
        IF inf(a) = "Y" AND unit(a).ow = CHR$(winner) AND haveit(a, 26) = 0 THEN unt = a: a = 0
        LOOP WHILE a > 0
        t = 0
        FOR a = 1 TO 8
        IF abit(unt, a) = 0 THEN t = a: a = 8
        NEXT a
        abit(unt, t) = 26
    END IF
END IF
IF lv = 15 THEN
    lv = 6
    LOCATE 22, 2
    PRINT "Inside the Dragon Cave you find..."
    LOCATE 23, 2: PRINT "...";
    IF n = 0 THEN PRINT 400 + a * 13; "gold coins!": ply(winner).tg = ply(winner).tg + 400 + a * 13
    IF n = 1 THEN PRINT 50 + a * 7; "mana crystals!": ply(winner).tm = ply(winner).tm + 50 + a * 7
    IF n = 2 THEN PRINT "a baby Dragon!": ttrain fx, fy, 2, winner
    IF n = 3 THEN
        PRINT "an famous Articaft"
        FOR unt = 1 TO maxc
        IF inf(a) = "Y" AND unit(a).ow = CHR$(winner) AND haveit(a, 19) = 0 THEN
        t = 0
        FOR a = 1 TO 8
        IF abit(unt, a) = 0 THEN t = a: a = 8
        NEXT a
        abit(unt, t) = 19
        END IF
        NEXT unt
    END IF
END IF
    DO: LOOP WHILE INKEY$ <> ""
    DO: LOOP WHILE INKEY$ = ""
LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
map(fx, fy) = lv
END IF
IF hlr > 0 THEN
    FOR a = 1 TO maxc
        IF inf(a) = "Y" THEN
        hp = ASC(unit(a).hp)
        FOR B = 1 TO hlr
            hp = hp + 2 * RND: SOUND 1000, .1: SOUND 500, .1: SOUND 3000, .04
        NEXT B
        unit(a).hp = CHR$(hp)
        END IF
    NEXT a
END IF
CLS
CALL compress
nofight:
END SUB

SUB fill (h)
x = 50 * RND: y = 50 * RND
FOR g = 1 TO 150
x = x + 2 * RND - 1
y = y + 2 * RND - 1
x = wrap(x)
y = wrap(y)
map(x, y) = h
IF h = 1 THEN
map(wrap(x - 1), y) = h
map(wrap(x + 1), y) = h
map(x, wrap(y - 1)) = h
map(x, wrap(y + 1)) = h
END IF
NEXT g
END SUB

FUNCTION findtarget (hh)
a = hh
g = 0
FOR t = 1 TO maxc
g = INT(maxc * RND + 1)
IF inf(g) = "Y" AND unit(a).ow <> unit(g).ow THEN t = maxc ELSE g = 0
NEXT t
IF g = 0 THEN
FOR t = 1 TO maxc
IF inf(t) = "Y" AND unit(a).ow <> unit(t).ow THEN g = t: t = maxc
NEXT t
END IF
IF haveit(g, 26) AND RND < .9 THEN g = 0
findtarget = g
END FUNCTION

SUB fire (x, y, att, brn)
dfn = unitat(x, y)
IF unit(att).ow <> unit(dfn).ow THEN
ttl = -haveit(att, 23) + haveit(dfn, 23) - haveit(att, 24) * 2 + haveit(dfn, 24) * 2
FOR aaa = 1 TO 1 - haveit(att, 15)
fx = ASC(unit(att).x)
fy = ASC(unit(att).y)
IF x > 13 THEN x = 13
IF y > 13 THEN y = 13
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
ds = SQR((x - fx) ^ 2 + (y - fy) ^ 2) * 2 + 1
FOR a = 0 TO ds
ohx = hx: ohy = hy
hx = (a / ds * x + (ds - a) / ds * fx) * 15 - 15
hy = (a / ds * y + (ds - a) / ds * fy) * 15 - 15
IF a > 0 THEN PUT (ohx, ohy), lnd%(0, 0), PSET
IF a < ds THEN GET (hx, hy)-(hx + 14, hy + 14), lnd%(0, 0)
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 5, 12
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 4, 14
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 3, 4
SOUND 37 + a * RND, .05
SOUND 100, .05
SOUND 37 + 200 * RND, .05
NEXT a
SOUND 37, .2
hp = ASC(unit(dfn).hp)
ar = ASC(crt(ASC(unit(dfn).typ)).ar) + ASC(unit(dfn).ex) / 18 - haveit(dfn, 29)
at = brn + ASC(unit(att).ex) / 10
dm = at / 2 * RND - ar * RND + at / 2
IF haveit(dfn, 7) AND RND > .3 + ttl THEN dm = 0
IF haveit(dfn, 5) AND RND > .7 + ttl THEN dm = 0
IF dm < 0 THEN dm = 0
IF RND > .3 - ttl THEN
hp = hp - dm
FOR a = 1 TO 10
LINE (x * 15 - a, y * 15 - a)-(x * 15 - 16 + a, y * 15 - 16 + a), 2, BF
SOUND 100 - a * 5, .05
SOUND 37, .05
NEXT a
END IF
IF hp <= 0 THEN IF haveit(dfn, 8) THEN denchant dfn, 8: hp = 3 ELSE inf(dfn) = "N": unit(dfn).ow = CHR$(0): FOR a = 1 TO 37: SOUND 37 + a, .05: NEXT a
IF hp < 0 THEN hp = 0
unit(dfn).hp = CHR$(hp)
FOR a = 5 TO 0 STEP -1
SOUND 37 + a * 30, .12
NEXT a
froy x, y
NEXT aaa
END IF
END SUB

FUNCTION free (x, y)
f = -1
FOR a = 1 TO maxc
IF inf(a) = "Y" THEN IF unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN f = 0
NEXT a
IF x < 1 OR y < 1 OR x > 13 OR y > 13 THEN f = 0
free = f
END FUNCTION

SUB froy (x, y)
IF x > 0 AND y > 0 AND x <= 13 AND y <= 13 THEN
l = lvl(x, y)
IF l = 0 THEN l = 1
PUT (x * 15 - 15, y * 15 - 15), lnd%(0, l), PSET
FOR a = 1 TO maxc
IF inf(a) = "Y" THEN IF unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) AND ASC(unit(a).typ) >= 1 THEN PUT (x * 15 - 13, y * 15 - 13), mon%(0, ASC(unit(a).typ)), PSET: LINE (x * 15 - 14, y * 15 - 14)-(x * 15 - 3, y * 15 - 3), 3, B: a = maxc
NEXT a
END IF
END SUB

FUNCTION haveit (unit, ab)
t = 0
FOR a = 1 TO 8
IF abit(unit, a) = ab THEN t = -1: a = 8
NEXT a
haveit = t
END FUNCTION

FUNCTION highest (zx, zy)
x = wrap(zx): y = wrap(zy)
h = 0
w = 0
FOR a = 1 TO maxc
ww = worth(ASC(unit(a).typ))
IF ww > w THEN IF unit(a).ow > CHR$(0) AND unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN w = ww: h = a
NEXT a
highest = h
END FUNCTION

SUB hurt (x, y, att)
FOR aaa = 1 TO 1 - haveit(att, 14)
dfn = unitat(x, y)
ttl = -haveit(att, 23) + haveit(dfn, 23) - haveit(att, 24) * 2 + haveit(dfn, 24) * 2
IF unit(att).ow <> unit(dfn).ow THEN
hp = ASC(unit(dfn).hp)
ar = ASC(crt(ASC(unit(dfn).typ)).ar) + ASC(unit(dfn).ex) / 20 + haveit(att, 13) + haveit(att, 16) * 2 - haveit(dfn, 29)
at = ASC(crt(ASC(unit(att).typ)).at) + 1 + ASC(unit(att).ex) / 8 - haveit(att, 6)
dm = at * RND - ar * RND
IF haveit(att, 2) AND RND > .6 + ttl / 10 THEN dm = at * RND
IF haveit(dfn, 10) AND RND > .6 - ttl / 10 THEN dm = 0
IF dm < 0 THEN dm = 0
IF RND > .3 - ttl / 10 THEN
hp = hp - dm
IF haveit(att, 11) AND (NOT haveit(dfn, 5)) AND ASC(crt(ASC(unit(dfn).typ)).mr) * RND < 6 + ttl THEN unit(att).hp = CHR$(ASC(unit(att).hp) + dm / 3): IF unit(att).hp > crt(ASC(unit(att).typ)).hp THEN unit(att).hp = crt(ASC(unit(att).typ)).hp
FOR a = 1 TO 6
LINE (x * 15 - a, y * 15 - a)-(x * 15 - 16 + a, y * 15 - 16 + a), 3, B
SOUND 100 + a * 10, .05
SOUND 500 + a * 5, .05
NEXT a
END IF
IF hp <= 0 THEN IF haveit(dfn, 8) THEN denchant dfn, 8: hp = 3 ELSE inf(dfn) = "N": unit(dfn).ow = CHR$(0): FOR a = 1 TO 37: SOUND 37 + a, .05: NEXT a: IF haveit(att, 12) AND ASC(crt(ASC(unit(dfn).typ)).mr) * RND < 4 THEN unit(dfn).ow = unit(att).ow: unit(dfn).typ = CHR$(17): unit(dfn).hp = CHR$(1): SOUND 37, .7: SOUND 100, .4: SOUND 37, .4: inf(dfn) = "Y": FOR a = 1 TO 8: abit(dfn, a) = 0: NEXT a
IF hp < 0 THEN hp = 0
unit(dfn).hp = CHR$(hp)
SOUND 1000, .1
SOUND 300, .1
SOUND 37, .05
froy x, y
END IF
NEXT aaa
END SUB

SUB info (player)
LINE (165, 0)-(319, 164), 0, BF
LINE (165, 0)-(319, 164), 1, B

LOCATE 2, 22: PRINT "Player's"; player; "turn"

LOCATE 4, 22: PRINT "Mana"; ply(player).mn
LOCATE 5, 22: PRINT "Food"; ply(player).fd
LOCATE 6, 22: PRINT "Gold"; ply(player).gd
LOCATE 8, 22: PRINT "Magic"; ply(player).tm
LOCATE 9, 22: PRINT "Vault"; ply(player).tg
END SUB

SUB init
RANDOMIZE (TIMER)
FOR a = 1 TO 1600
M%(a) = a
NEXT a
FOR a = 1 TO 1600
SWAP M%(a), M%(1600 * RND)
NEXT a
END SUB

FUNCTION isboat (ax, ay, p)
x = wrap(ax): y = wrap(ay)
c = 0
FOR a = 1 TO maxc
IF unit(a).ow = CHR$(p) AND unit(a).ow < CHR$(3) AND unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN
FOR B = 1 TO 8
IF abit(a, B) = 1 THEN c = -1
IF abit(a, B) = 3 THEN c = -1
NEXT B
END IF
NEXT a
isboat = c
END FUNCTION

SUB load
blank
ok = 0
OPEN "list.dat" FOR INPUT AS #1
FOR a = 1 TO 9
INPUT #1, sav$(a)
NEXT a
CLOSE #1
DO

LOCATE 1, 16: PRINT "Load game"
FOR a = 1 TO 9
LOCATE a + 2, 2: PRINT a; sav$(a)
NEXT a
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "1" THEN ok = 1
IF a$ = "2" THEN ok = 2
IF a$ = "3" THEN ok = 3
IF a$ = "4" THEN ok = 4
IF a$ = "5" THEN ok = 5
IF a$ = "6" THEN ok = 6
IF a$ = "7" THEN ok = 7
IF a$ = "8" THEN ok = 8
IF a$ = "9" THEN ok = 9
IF sav$(ok) = "" THEN ok = 0
l$ = a$
LOOP WHILE ok = 0
OPEN l$ + "slot.sav" FOR INPUT AS #1
INPUT #1, plynum, ctynum, ndenum, mstnum, maxc
FOR a = 1 TO ctynum
FOR B = 0 TO 20
INPUT #1, city(a, B)
NEXT B
INPUT #1, cty(a)
INPUT #1, cx(a), cy(a), pop(a)
NEXT a
FOR a = 1 TO mstnum
INPUT #1, B: unit(a).x = CHR$(B)
INPUT #1, B: unit(a).y = CHR$(B)
INPUT #1, B: unit(a).hp = CHR$(B)
INPUT #1, B: unit(a).mp = CHR$(B)
INPUT #1, B: unit(a).ex = CHR$(B)
INPUT #1, B: unit(a).ow = CHR$(B)
INPUT #1, B: unit(a).typ = CHR$(B)
INPUT #1, B: unit(a).di = CHR$(B)
INPUT #1, B: unit(a).fa = CHR$(B)
INPUT #1, B: unit(a).mv = CHR$(B)
FOR B = 1 TO 8
INPUT #1, abit(a, B)
NEXT B
NEXT a
FOR a = 1 TO plynum
INPUT #1, ply(a).title
INPUT #1, ply(a).mn
INPUT #1, ply(a).gd
INPUT #1, ply(a).fd
INPUT #1, ply(a).tg
INPUT #1, ply(a).tm
INPUT #1, vx(a), vy(a)
FOR y = 1 TO 50
INPUT #1, a$
see(a, y) = a$
NEXT y
INPUT #1, spell(a)
NEXT a
FOR y = 1 TO 50
INPUT #1, a$
FOR x = 1 TO 50
map(x, y) = ASC(MID$(a$, x, 1)) - 48
NEXT x
NEXT y
CLOSE #1
END SUB

SUB look (x, y, player)
l = 0
IF map(x, y) > 10 THEN GOTO nolook
FOR a = 1 TO maxc
IF MID$(see(player, y), x, 1) = "Y" AND unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN l = l + 1: movelist(l) = a
NEXT a
IF l > 0 THEN
LINE (165, 0)-(319, 164), 0, BF
LINE (165, 0)-(319, 164), 1, B
v = 1
DO
unt = movelist(v)
typ = ASC(unit(unt).typ)
ex = ASC(unit(typ).ex)

LOCATE 2, 24: PRINT v; LEFT$(crt(typ).title, 13)
PUT (290, 30), mon%(0, typ), PSET

LOCATE 3, 23: PRINT "EXP"; ex

LOCATE 4, 23: PRINT "Max HP"; ASC(crt(typ).hp)
LOCATE 5, 23: PRINT "HP now"; ASC(unit(unt).hp)
LOCATE 6, 23: PRINT "Max MP"; ASC(crt(typ).mp) + ex \ 7
LOCATE 7, 23: PRINT "MP now"; ASC(unit(unt).mp)

LOCATE 8, 23: PRINT "Short"; ASC(crt(typ).at) + ex \ 8
LOCATE 9, 23: PRINT "Ranged"; ASC(crt(typ).rg) + ex \ 10

LOCATE 10, 23: PRINT "Armor"; ASC(crt(typ).ar) + ex \ 20
LOCATE 11, 23: PRINT "Move points"; ASC(unit(unt).mv)

FOR a = 1 TO 8
LOCATE 11 + a, 23: PRINT LEFT$(abil$(abit(unt, a)), 15)
NEXT a
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "x" AND unit(movelist(v)).ow = CHR$(player) THEN unit(movelist(v)).ow = CHR$(0): FOR a = 1 TO 100: SOUND a * 2 + 37, .08: NEXT a: a$ = " "
IF a$ = "6" OR a$ = "2" THEN v = v + 1
IF a$ = "8" OR a$ = "4" THEN v = v - 1
IF v < 1 THEN v = l
IF v > l THEN v = 1
LOOP WHILE a$ <> CHR$(27) AND a$ <> "e" AND a$ <> " "
LINE (165, 0)-(319, 164), 0, BF
info player
END IF
nolook:
END SUB

SUB magic (x, y, brn)
dfn = unitat(x, y)
ttl = haveit(dfn, 23) + haveit(dfn, 24) * 2
fx = 7: fy = 7
IF x > 13 THEN x = 13
IF y > 13 THEN y = 13
IF x < 1 THEN x = 1
IF y < 1 THEN y = 1
ds = SQR((x - fx) ^ 2 + (y - fy) ^ 2) * 5 + 1
FOR a = 0 TO ds
ohx = hx: ohy = hy
hx = (a / ds * x + (ds - a) / ds * fx) * 15 - 15
hy = (a / ds * y + (ds - a) / ds * fy) * 15 - 15
IF a > 0 THEN PUT (ohx, ohy), lnd%(0, 0), PSET
IF a < ds THEN GET (hx, hy)-(hx + 14, hy + 14), lnd%(0, 0)
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 5, 11
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 4, 9
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 3, 3
IF a < ds THEN CIRCLE (hx + 8, hy + 8), 2, 1
SOUND 37 + a * 3, .1
NEXT a
SOUND 37, .2
hp = ASC(unit(dfn).hp)
ar = ASC(crt(ASC(unit(dfn).typ)).ar) + ASC(unit(dfn).ex) / 18 - haveit(dfn, 29)
at = brn
dm = at / 2 * RND - ar * RND + at / 2
IF haveit(dfn, 5) AND RND > .5 + ttl THEN dm = 0
IF haveit(dfn, 20) AND RND > .5 + ttl THEN dm = 0
IF dm < 0 THEN dm = 0
IF RND > .3 - ttl THEN
hp = hp - dm
FOR a = 1 TO 10
LINE (x * 15 - a, y * 15 - a)-(x * 15 - 16 + a, y * 15 - 16 + a), 3 * RND, BF
SOUND 50 + a * 10, .05: SOUND 300, .05
NEXT a
END IF
IF hp <= 0 THEN IF haveit(dfn, 8) THEN denchant dfn, 8: hp = 3 ELSE inf(dfn) = "N": unit(dfn).ow = CHR$(0): FOR a = 1 TO 37: SOUND 37 + a, .05: NEXT a
IF hp < 0 THEN hp = 0
unit(dfn).hp = CHR$(hp)
FOR a = 5 TO 0 STEP -1
SOUND 37 + a * 30, .12
NEXT a
froy x, y
END SUB

SUB mapit (rx, ry, player)
rx = wrap(rx)
ry = wrap(ry)
FOR ty = -5 TO 5
FOR tx = -5 TO 5
sx = rx + tx: sy = ry + ty
IF MID$(see(player, wrap(sy)), wrap(sx), 1) = "Y" THEN
l = map(wrap(sx), wrap(sy))
PUT ((tx + 5) * 15, (ty + 5) * 15), lnd%(0, l), PSET
vw(wrap(sx), wrap(sy)) = 0
gx = tx + 5: gy = ty + 5
IF l = 10 THEN LINE (gx * 15, gy * 15)-(gx * 15 + 14, gy * 15 + 14), 1, B
ELSE
LINE ((tx + 5) * 15, (ty + 5) * 15)-((tx + 5) * 15 + 14, (ty + 5) * 15 + 14), 0, BF
END IF
NEXT tx
NEXT ty
FOR a = 1 TO maxc
sx = ASC(unit(a).x)
sy = ASC(unit(a).y)
IF vw(sx, sy) = 0 THEN
vw(wrap(sx), wrap(sy)) = 1
IF sx < wrap(rx + 11) AND rx > 44 THEN sx = sx + 50
IF sx > wrap(rx - 11) AND rx < 4 THEN sx = sx - 50
IF sy < wrap(ry + 11) AND ry > 44 THEN sy = sy + 50
IF sy > wrap(ry - 11) AND ry < 4 THEN sy = sy - 50
tx = sx - rx: ty = sy - ry
drow tx + 5, ty + 5, sx, sy, player
END IF
NEXT a
LINE (0, 0)-(164, 164), 1, B
END SUB

FUNCTION menu
DO

LOCATE 1, 16: PRINT "Main Menu"
LOCATE 3, 2: PRINT "1 New Game"
LOCATE 5, 2: PRINT "2 Load Game"
LOCATE 7, 2: PRINT "3 End game"
DO: a$ = INKEY$: LOOP WHILE a$ = ""
LOCATE 12, 2
IF a$ = "1" THEN CALL newgame
IF a$ = "2" THEN CALL load
IF a$ = "3" THEN SYSTEM
LOCATE 12, 2: PRINT "                              "
LOOP WHILE a$ <> "1" AND a$ <> "2"
menu = VAL(a$)
END FUNCTION

SUB Move (rx, ry, tx, ty, player)
x = wrap(tx): y = wrap(ty)
l = 0
FOR a = 1 TO maxc
IF unit(a).ow = CHR$(player) AND unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN l = l + 1: movelist(l) = a
NEXT a
IF l > 0 THEN
boat = -1
IF isboat(x, y, player) = -1 THEN

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
PRINT "Do you want to use this ship?"
DO
a$ = INKEY$
IF a$ = "y" OR a$ = "Y" OR a$ = " " THEN boat = 1
IF a$ = "n" OR a$ = "N" THEN boat = 0
LOOP WHILE boat = -1
END IF
IF boat = 1 THEN
t = 0
FOR a = 1 TO maxc
FOR B = 1 TO 8
IF unit(a).x = CHR$(tx) AND unit(a).y = CHR$(ty) AND (abit(a, B) = 1 OR abit(a, B) = 3) AND unit(a).ow > CHR$(0) THEN t = 1: movelist(t) = a
NEXT B
NEXT a
ELSE

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
PRINT "Units at this place"; l
PRINT "UP and DOWN to chose:"
PRINT "SPACE to select";
t = 1
DO
a$ = INKEY$
IF a$ = "8" THEN t = t - 1
IF a$ = "2" THEN t = t + 1
IF a$ = CHR$(27) THEN t = 0: a$ = " "
IF t < 0 THEN t = l
IF t > l THEN t = 0
LOCATE 25, 1
IF t > 0 THEN PRINT "Unit#"; t; crt(ASC(unit(movelist(t)).typ)).title;  ELSE PRINT "Cancel                       ";
PUT (300, 180), mon%(0, ASC(unit(movelist(t)).typ)), PSET
LOOP WHILE a$ <> " "
END IF
IF t > 0 THEN
ms = movelist(t)

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
PRINT "Chose direction to move"
PRINT "Use keypad";
d = 0
DO
a$ = INKEY$
IF a$ = "7" THEN d = 7
IF a$ = "8" THEN d = 8
IF a$ = "9" THEN d = 9
IF a$ = "4" THEN d = 4
IF a$ = "6" THEN d = 6
IF a$ = "1" THEN d = 1
IF a$ = "2" THEN d = 2
IF a$ = "3" THEN d = 3
LOOP WHILE d = 0

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
PRINT "Move how many spaces"
PRINT "Use numbers"
PRINT "(0-9)";
f = -1
DO
a$ = INKEY$
IF a$ = "0" THEN f = 0
IF a$ = "1" THEN f = 1
IF a$ = "2" THEN f = 2
IF a$ = "3" THEN f = 3
IF a$ = "4" THEN f = 4
IF a$ = "5" THEN f = 5
IF a$ = "6" THEN f = 6
IF a$ = "7" THEN f = 7
IF a$ = "8" THEN f = 8
IF a$ = "9" THEN f = 9
LOOP WHILE f = -1
unit(ms).di = CHR$(d)
mv = ASC(unit(ms).mv)
x = ASC(unit(ms).x)
y = ASC(unit(ms).y)
FOR a = 1 TO 9
IF mv > 0 AND f > 0 THEN
f = f - 1
ox = x: oy = y
IF d = 1 THEN y = y + 1: x = x - 1
IF d = 2 THEN y = y + 1
IF d = 3 THEN y = y + 1: x = x + 1
IF d = 4 THEN x = x - 1
IF d = 6 THEN x = x + 1
IF d = 7 THEN y = y - 1: x = x - 1
IF d = 8 THEN y = y - 1
IF d = 9 THEN y = y - 1: x = x + 1
x = wrap(x)
y = wrap(y)
seeit x, y, 2, player
lv = map(x, y)
mt = ASC(crt(ASC(unit(ms).typ)).mt)
IF haveit(ms, 21) AND (lv = 1 OR lv = 9) THEN map(x, y) = 2: unit(ms).ow = CHR$(0): FOR a = 1 TO 20: SOUND 37 + a * 3, .07: NEXT a: SOUND 37, .6
IF mt = 0 AND isboat(x, y, player) = 0 AND (lv = 1 OR lv = 9) THEN x = ox: y = oy
IF mt = 1 AND (lv = 2 OR lv = 3 OR lv = 4 OR lv = 5 OR lv = 6) THEN x = ox: y = oy
unit(ms).x = CHR$(x)
unit(ms).y = CHR$(y)
IF boat = 1 THEN
FOR bt = 1 TO maxc
IF unit(bt).x = CHR$(ox) AND unit(bt).y = CHR$(oy) THEN unit(bt).x = CHR$(x): unit(bt).y = CHR$(y)
NEXT bt
END IF
IF x <> ox OR y <> oy THEN
    mv = mv - 1
    tox = ox: toy = oy
    IF tox < wrap(rx + 11) AND rx > 44 THEN tox = tox + 50
    IF tox > wrap(rx - 11) AND rx < 4 THEN tox = tox - 50
    IF toy < wrap(ry + 11) AND ry > 44 THEN toy = toy + 50
    IF toy > wrap(ry - 11) AND ry < 4 THEN toy = toy - 50
    sx = tox - rx + 5
    sy = toy - ry + 5
    drow sx, sy, ox, oy, player
    tox = x: toy = y
    IF tox < wrap(rx + 11) AND rx > 44 THEN tox = tox + 50
    IF tox > wrap(rx - 11) AND rx < 4 THEN tox = tox - 50
    IF toy < wrap(ry + 11) AND ry > 44 THEN toy = toy + 50
    IF toy > wrap(ry - 11) AND ry < 4 THEN toy = toy - 50
    sx = tox - rx + 5
    sy = toy - ry + 5
    drow sx, sy, x, y, player
    FOR g = 1 TO 40: SOUND 100 + g, CINT(RND) / 10: NEXT g
END IF
END IF
NEXT a
unit(ms).fa = CHR$(f)
unit(ms).mv = CHR$(mv)
unit(ms).x = CHR$(wrap(x))
unit(ms).y = CHR$(wrap(y))
LINE (0, 166)-(319, 199), 0, BF
END IF
END IF
LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
END SUB

FUNCTION nearcity (x, y, player)
cs = ABS(x - cx(1)) + ABS(y - cy(1)): n = 1
FOR a = 2 TO ctynum
dx = ABS(x - cx(a))
dy = ABS(y - cy(a))
IF dx < dy THEN ds = dx ELSE ds = dy
IF ds < cs AND city(a, 0) <> player THEN n = a: cs = ds
NEXT a
IF cs > 7 THEN n = 0
nearcity = n
END FUNCTION

SUB newgame
CALL blank
plynum = INT(4 * RND) + 1
ctynum = 5 + 30 * RND
ndenum = INT(7 * RND) + 1
mstnum = 75 + ndenum * 20
IF mstnum > 200 THEN mstnum = 200
DO

LOCATE 1, 17: PRINT "New Game"
LOCATE 3, 2: PRINT "1 Players:"; plynum
LOCATE 5, 2: PRINT "2 Cities:"; ctynum
LOCATE 7, 2: PRINT "3 Nodes:"; ndenum
LOCATE 9, 2: PRINT "4 Creatures:"; mstnum
LOCATE 11, 2: PRINT "5 Done"
DO: a$ = INKEY$: LOOP WHILE a$ = ""
LOCATE 12, 2

IF a$ = "1" THEN INPUT "How many players"; plynum
IF a$ = "2" THEN INPUT "How many cities"; g: IF g > 0 THEN ctynum = g
IF a$ = "3" THEN INPUT "How many of each node"; g: IF g > 0 THEN ndenum = g
IF a$ = "4" THEN INPUT "How many total units"; g: IF g > 0 THEN mstnum = g
IF plynum < 0 THEN plynum = 0
IF plynum > 4 THEN plynum = 4
IF ctynum < 5 THEN ctynum = 5
IF ctynum > 35 THEN ctynum = 35
IF ndenum < 1 THEN ndenum = 1
IF ndenum > 7 THEN ndenum = 7
IF mstnum < 50 THEN mstnum = 50
IF mstnum > 200 THEN mstnum = 200
LOCATE 12, 2: PRINT "                              "
LOOP WHILE a$ <> "5"
END SUB

FUNCTION newname$
a$ = CHR$(65 + 25 * RND)
FOR a = 1 TO 4 + 6 * RND
r = 1 - r
IF r = 0 THEN
a$ = a$ + CHR$(97 + 25 * RND)
ELSE
n = INT(5 * RND)
IF n = 0 THEN a$ = a$ + "a"
IF n = 1 THEN a$ = a$ + "e"
IF n = 2 THEN a$ = a$ + "i"
IF n = 3 THEN a$ = a$ + "o"
IF n = 4 THEN a$ = a$ + "u"
END IF
NEXT a
newname$ = a$
END FUNCTION

FUNCTION owrap (a)
n = a
DO WHILE n < 0 OR n > 10
IF n < 0 THEN n = n + 11
IF n > 10 THEN n = n - 11
LOOP
owrap = n
END FUNCTION

SUB password (player)

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
INPUT "Enter a message"; p$
p$ = UCASE$(p$)

IF p$ = "TIGERSHARKS SWIM FAST" THEN FOR a = 1 TO 4: train player, 38, player: NEXT a: BEEP: ply(player).tg = ply(player).tg + 400
IF p$ = "I GOT A DOLLAR" THEN ply(player).tg = 1000: BEEP: info player
IF p$ = "MAGIC OF RHUEL" THEN ply(player).tm = 200: BEEP: info player
IF p$ = "I SEE ALL" THEN
FOR y = 1 TO 50
FOR x = 1 TO 50
MID$(see(player, y), x) = "Y"
NEXT x
NEXT y
BEEP
END IF
IF p$ = "LEDGEND OF ORION" THEN
FOR a = 1 TO maxc
IF unit(a).ow = CHR$(player) AND haveit(a, 19) = 0 THEN
FOR B = 1 TO 8
IF abit(a, B) = 0 THEN abit(a, B) = 19: B = 8
NEXT B
END IF
NEXT a
END IF
IF p$ = "KING AUTHUR" THEN
OTG = ply(player).tg
FOR a = 1 TO ctynum
IF city(a, 0) = player THEN build a, 14, player
NEXT a
ply(player).tg = OTG
BEEP
END IF

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
END SUB

SUB place (h)
DO
x = INT(50 * RND + 1): y = INT(50 * RND + 1)
LOOP WHILE map(x, y) <= 1 OR map(x, y) > 6
map(x, y) = h
END SUB

SUB save
OPEN "list.dat" FOR INPUT AS #1
FOR a = 1 TO 9
INPUT #1, sav$(a)
NEXT a
CLOSE #1
blank
ok = 0
DO

LOCATE 1, 16: PRINT "save game"
FOR a = 1 TO 9
LOCATE a + 2, 2: PRINT a; sav$(a)
NEXT a
DO: a$ = INKEY$: LOOP WHILE a$ = ""
IF a$ = "1" THEN ok = 1
IF a$ = "2" THEN ok = 2
IF a$ = "3" THEN ok = 3
IF a$ = "4" THEN ok = 4
IF a$ = "5" THEN ok = 5
IF a$ = "6" THEN ok = 6
IF a$ = "7" THEN ok = 7
IF a$ = "8" THEN ok = 8
IF a$ = "9" THEN ok = 9
LOOP WHILE ok = 0
l$ = a$
LOCATE ok + 2, 3: INPUT a$: IF a$ <> "" THEN sav$(ok) = a$
OPEN "list.dat" FOR OUTPUT AS #1
FOR a = 1 TO 9
WRITE #1, sav$(a)
NEXT a
CLOSE #1
OPEN l$ + "slot.sav" FOR OUTPUT AS #1
WRITE #1, plynum, ctynum, ndenum, mstnum, maxc
FOR a = 1 TO ctynum
FOR B = 0 TO 20
PRINT #1, city(a, B)
NEXT B
PRINT #1, cty(a)
PRINT #1, cx(a), cy(a), pop(a)
NEXT a
FOR a = 1 TO mstnum
PRINT #1, ASC(unit(a).x)
PRINT #1, ASC(unit(a).y)
PRINT #1, ASC(unit(a).hp)
PRINT #1, ASC(unit(a).mp)
PRINT #1, ASC(unit(a).ex)
PRINT #1, ASC(unit(a).ow)
PRINT #1, ASC(unit(a).typ)
PRINT #1, ASC(unit(a).di)
PRINT #1, ASC(unit(a).fa)
PRINT #1, ASC(unit(a).mv)
FOR B = 1 TO 8
PRINT #1, abit(a, B)
NEXT B
NEXT a
FOR a = 1 TO plynum
WRITE #1, ply(a).title
PRINT #1, ply(a).mn
PRINT #1, ply(a).gd
PRINT #1, ply(a).fd
PRINT #1, ply(a).tg
PRINT #1, ply(a).tm
PRINT #1, vx(a), vy(a)
FOR y = 1 TO 50
WRITE #1, see(a, y)
NEXT y
WRITE #1, spell(a)
NEXT a
FOR y = 1 TO 50
a$ = ""
FOR x = 1 TO 50
a$ = a$ + CHR$(map(x, y) + 48)
NEXT x
PRINT #1, a$
NEXT y
CLOSE #1
END SUB

SUB seeit (x, y, d, player)
FOR a = -d TO d
FOR B = -d TO d
sx = x + a
sy = y + B
sx = wrap(sx)
sy = wrap(sy)
IF player <= plynum THEN MID$(see(player, sy), sx) = "Y"
NEXT B
NEXT a
END SUB

SUB seemap (player)
vvx = vx(player): vvy = vy(player)
LINE (0, 0)-(164, 164), 0, BF
LINE (0, 0)-(164, 164), 1, B
FOR ty = -24 TO 25
FOR tx = -24 TO 25
x = wrap(vvx + tx)
y = wrap(vvy + ty)
IF MID$(see(player, y), x, 1) = "Y" THEN l = map(x, y) ELSE l = 0
c = l
IF l = 0 THEN
c = 0
ELSE
IF l = 10 THEN c = 2
IF l = 4 THEN c = 1
IF l = 6 THEN c = 1
IF l = 2 THEN c = 1
IF l = 5 THEN c = 2
IF l = 3 THEN c = 2
IF l = 9 THEN c = 1
IF l = 7 OR l = 8 THEN c = 1
IF l > 10 THEN c = 3
END IF
sx = tx + 25
sy = ty + 25
IF sx < 1 THEN sx = sx + 50
IF sy < 1 THEN sy = sy + 50
IF sx > 50 THEN sx = sx - 50
IF sy > 50 THEN sy = sy - 50
LINE (sx * 3, sy * 3)-(sx * 3 + 2, sy * 3 + 2), c, BF
PSET (sx * 3 + 1, sy * 3 + 1), l MOD 4
IF l > 10 THEN PSET (sx * 3 + 1, sy * 3 + 1), 15
IF l = 10 THEN PSET (sx * 3 + 1, sy * 3 + 1), 2
IF l = 10 THEN PSET (sx * 3, sy * 3), 2
IF l = 10 THEN PSET (sx * 3, sy * 3 + 2), 2
IF l = 10 THEN PSET (sx * 3 + 2, sy * 3), 2
IF l = 10 THEN PSET (sx * 3 + 2, sy * 3 + 2), 2
IF l = 4 THEN PSET (sx * 3 + 1, sy * 3 + 1), 1
IF l = 4 THEN PSET (sx * 3, sy * 3), 1
IF l = 4 THEN PSET (sx * 3, sy * 3 + 2), 1
IF l = 4 THEN PSET (sx * 3 + 2, sy * 3), 1
IF l = 4 THEN PSET (sx * 3 + 2, sy * 3 + 2), 1
IF l = 3 THEN PSET (sx * 3 + 1, sy * 3 + 1), 3
NEXT tx
NEXT ty

DO: LOOP WHILE INKEY$ = ""
END SUB

SUB spells (x, y, player)
LINE (165, 0)-(319, 164), 0, BF
LINE (165, 0)-(319, 164), 1, B
LOCATE 3, 25: PRINT "Spells"
cs = 1
DO
FOR B = -7 TO 8
LOCATE B + 11, 23
gs = cs + B
IF gs < 9 THEN gs = gs + 40
IF gs > 48 THEN gs = gs - 40
c = 1
IF s(gs).cs > ply(player).tm THEN c = c - 8
IF B = 0 THEN PRINT ">";
IF c > 0 THEN PRINT s(gs).title ELSE PRINT "---------------"
NEXT B
a$ = INKEY$
IF a$ = "3" THEN cs = cs + 16
IF a$ = "9" THEN cs = cs - 16
IF a$ = "8" THEN cs = cs - 1
IF a$ = "2" THEN cs = cs + 1
IF cs < 9 THEN cs = 48
IF cs > 48 THEN cs = 9
IF a$ = CHR$(27) THEN cs = 0: a$ = " "
LOOP WHILE a$ <> " " AND a$ <> CHR$(13)
IF s(cs).cs <= ply(player).tm AND cs > 0 THEN
ply(player).tm = ply(player).tm - s(cs).cs
ab = s(cs).ab
nm = s(cs).nm
IF ab = 1 OR ab > 2 THEN
l = 0
FOR a = 1 TO maxc
IF unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN l = l + 1: movelist(l) = a
NEXT a
IF l > 0 THEN
END IF

LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
LOCATE 22, 1
PRINT "Units at this place"; l
PRINT "Chose to cast spell "; s(cs).title
PRINT "SPACE to select";
t = 1
DO
a$ = INKEY$
IF a$ = "8" THEN t = t - 1
IF a$ = "2" THEN t = t + 1
IF t < 0 THEN t = l
IF t > l THEN t = 0
LOCATE 25, 1

IF t > 0 THEN PRINT "Unit#"; t; crt(ASC(unit(movelist(t)).typ)).title; ASC(unit(movelist(t)).hp);  ELSE PRINT "Cancel                           ";
PUT (300, 180), mon%(0, ASC(unit(movelist(t)).typ)), PSET
LOOP WHILE a$ <> " " AND a$ <> CHR$(13)
unt = movelist(t)
IF t = 0 THEN ply(player).tm = ply(player).tm + s(cs).cs: GOTO nospell
END IF
IF ab = 2 THEN
ttrain x, y, nm, player
FOR a = 1 TO 40: SOUND 100 + a * 5, .05: SOUND 400 + a * 10, .05: NEXT a
END IF
IF ab = 1 AND haveit(unt, nm) = 0 THEN
t = 0
FOR a = 1 TO 8
IF abit(unt, a) = 0 THEN t = a: a = 8
NEXT a
abit(unt, t) = nm
FOR a = 1 TO 16: SOUND 100 + a * 10, .1: SOUND 1000 - a * 50, .2: NEXT a
END IF
IF ab = 3 THEN
hp = ASC(unit(unt).hp)
hp = hp + nm / 2 + nm * RND
mp = ASC(crt(ASC(unit(unt).typ)).hp)
IF hp > mp THEN hp = mp: SOUND 1000, .5
unit(unt).hp = CHR$(hp)
FOR a = 1 TO nm
SOUND 37 + a * 5, .1
SOUND 37 + a * 9, .1
NEXT a
END IF
FOR a = 1 TO 50
SOUND 37 + a * 15, .05
SOUND 60 + a * 10, .05
SOUND 100 + a * 5, .05
COLOR , RND
NEXT a

LINE (165, 0)-(319, 164), 0, BF
FOR B = 1 TO s(cs).cs / 3 + 2
FOR a = 1 TO 15

SOUND B * 10 + a * 3 + 100, .1
NEXT a
NEXT B
COLOR , 0
END IF
nospell:
LINE (165, 0)-(319, 164), 0, BF
LINE (0, 166)-(319, 199), 0, BF
LINE (0, 166)-(319, 199), 1, B
END SUB

SUB train (c, B, pl)
x = cx(c): y = cy(c)
ttrain x, y, B, pl
unit(ttt).ex = CHR$(expier(c))
IF pl <= plynum THEN ply(pl).tg = ply(pl).tg - 100
CALL compress
END SUB

SUB ttrain (x, y, B, p)
pl = p
IF pl > 5 THEN pl = 5
t = 0
FOR a = 1 TO mstnum
IF ASC(unit(a).ow) <= 0 THEN t = a: a = mstnum: IF t > mstnum / 1.5 AND p > plynum THEN t = 0
NEXT a
IF t = 0 THEN GOTO notrain
IF t > maxc THEN maxc = t
FOR a = 1 TO 8
abit(t, a) = ab(B, a)
NEXT a
p = pl
unit(t).di = CHR$(0)
unit(t).fa = CHR$(0)
unit(t).ow = CHR$(p)
unit(t).typ = CHR$(B)
unit(t).x = CHR$(x)
unit(t).y = CHR$(y)
unit(t).hp = crt(B).hp
unit(t).mp = crt(B).mp
unit(t).mv = crt(B).mv
unit(t).ex = CHR$(0)
notrain:
ttt = t
END SUB

SUB turn (player)
FOR ll = plynum + 1 TO 5
FOR c = 1 TO ctynum
t = 0
IF city(c, 0) = 0 AND RND > .96 THEN city(c, 0) = ll: train c, 9 + CINT(RND) * 2, ll
IF city(c, 0) = ll THEN
FOR v = 1 TO 7
B = INT(25 * RND + 1)
IF canmake(c, B) THEN build c, B, ll: SOUND 1000, .4: v = 7
NEXT v
FOR v = 1 TO 7
B = INT(48 * RND + 1)
IF canbuild(c, B) THEN train c, B, ll: SOUND 37, .1: SOUND 4000, .1: SOUND 200, .1: SOUND 3000, .1: v = 7
NEXT v
END IF
NEXT c
FOR un = 1 TO mstnum
IF unit(un).ow = CHR$(3) AND unit(un).fa < CHR$(2) AND map(ASC(unit(un).x), ASC(unit(un).y)) < 11 THEN
    x = ASC(unit(un).x)
    y = ASC(unit(un).y)
    f = nearcity(x, y, ll)
    IF f AND CINT(RND) THEN
        cx = cx(f)
        cy = cy(f)
        IF x < cx THEN
            IF y < cy THEN d = 3
            IF y > cy THEN d = 1
            IF y = cy THEN d = 2
        END IF
        IF x > cx THEN
            IF y < cy THEN d = 9
            IF y > cy THEN d = 7
            IF y = cy THEN d = 8
        END IF
        IF x = cx THEN
            IF y < cy THEN d = 6
            IF y > cy THEN d = 4
            IF y = cy THEN d = 5
        END IF
    ELSE
    d = INT(9 * RND) + 1
    f = INT(13 * RND) + 1
    END IF
    unit(un).di = CHR$(d)
    unit(un).fa = CHR$(f)
END IF
NEXT un
NEXT ll
x = vx(player): y = vy(player)
rx = x: ry = y: ox = x: oy = y
sx = 5: sy = 5
mapit rx, ry, player
info player
DO
LINE (1, 167)-(318, 198), 0, BF
LINE (0, 166)-(319, 199), 1, B
a$ = INKEY$
IF a$ <> "" THEN
IF a$ = CHR$(13) THEN password player
ox = x: oy = y
osx = sx: osy = sy
IF a$ = "m" THEN seemap player: mapit rx, ry, player
IF a$ = "b" THEN IF map(x, y) = 10 THEN a$ = "": ecity x, y, player: mapit rx, ry, player: info player
IF a$ = "c" THEN IF city(cityat(x, y), 0) = player THEN spells x, y, player: info player
IF a$ = "v" THEN look x, y, player
IF a$ = " " THEN Move rx, ry, x, y, player
IF a$ = "+" THEN
DO: mn = mn + 1
IF mn > ctynum THEN mn = 1
LOOP WHILE city(mn, 0) <> player
END IF
IF a$ = "-" THEN
DO: mn = mn - 1
IF mn < 1 THEN mn = ctynum
LOOP WHILE city(mn, 0) <> player
END IF
IF a$ = "5" THEN mn = player
xr = 0: yr = 0
IF a$ = "+" OR a$ = "-" OR a$ = "5" THEN x = cx(mn): y = cy(mn): a$ = "/"
IF a$ = "/" THEN xr = x - rx: yr = y - ry: rx = x: ry = y: mapit rx, ry, player: ox = x: oy = y: sx = 5: sy = 5
IF a$ = "8" THEN y = y - 1
IF a$ = "4" THEN x = x - 1
IF a$ = "6" THEN x = x + 1
IF a$ = "2" THEN y = y + 1
IF a$ = "7" THEN x = x - 1: y = y - 1
IF a$ = "9" THEN x = x + 1: y = y - 1
IF a$ = "1" THEN x = x - 1: y = y + 1
IF a$ = "3" THEN x = x + 1: y = y + 1
sx = sx + (x - ox)
sy = sy + y - oy
IF sx < 0 THEN sx = 0: x = ox
IF sy < 0 THEN sy = 0: y = oy
IF sx > 10 THEN sx = 10: x = ox
IF sy > 10 THEN sy = 10: y = oy
x = wrap(x)
y = wrap(y)
IF ox <> x OR oy <> y THEN drow osx + xr, osy + yr, ox, oy, player
drow sx, sy, x, y, player
END IF
LINE (sx * 15, sy * 15)-(sx * 15 + 14, sy * 15 + 14), 0, B
vx(player) = x
vy(player) = y
LOOP WHILE a$ <> "E" AND a$ <> CHR$(27)
END SUB

FUNCTION unitat (ax, ay)
x = wrap(ax): y = wrap(ay)
u = 0
FOR a = 1 TO maxc
IF inf(a) = "Y" AND unit(a).x = CHR$(x) AND unit(a).y = CHR$(y) THEN u = a: a = maxc
NEXT a
unitat = u
END FUNCTION

FUNCTION wrap (a)
n = a
DO WHILE n < 1 OR n > 50
IF n < 1 THEN n = n + 50
IF n > 50 THEN n = n - 50
LOOP
wrap = n
END FUNCTION

