DECLARE SUB explosion (x%, y%)
DECLARE SUB shoot (x1%, y1%, x2%, y2%)
DECLARE SUB fight (hx%, hy%)
DECLARE FUNCTION costof% (pl%, shp%)
DECLARE SUB see (pl%, st%)
DECLARE SUB look (pl%, sh%, Stars%)
DECLARE SUB make (typ%, x%, y%, p%)
DECLARE SUB slist (plyr%, l%)
DECLARE SUB newdate (en%, rd%, players%, money%, Stars%)
DECLARE SUB main (en%, rn%, players%, Stars%)
DECLARE SUB custom (ply%, slot%)
DECLARE SUB mouseHide ()
DECLARE SUB mousestatus (lb%, rb%, xmouse%, ymouse%)
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB mouseShow ()
'
'
'     ±€€€€€€   ±€€€€€€±   ±€∞     ±   ±€€€€€±   ±€€€€€€€±   ±     ±
'     €±   ±€   €±         €±€∞    €     ±€±     €± ±€± ±€   €     €
'         ±€∞   €          € ±€∞   €      €          €       €±   ±€
'        ±€∞    €€€€€±     €  ±€∞  €      €          €       €€€€€€€
'       ±€∞     €          €   ±€∞ €      €          €       €±   ±€
'      ±€∞      €          €    ±€∞€      €          €       €     €
'     ±€∞  ±€   €±         €     ±€€     ±€±         €       €     €
'     €€€€€€±   ±€€€€€€±   ±      ±€   ±€€€€€±       ±       ±     ±
'
'
'                       By Tim Caswell
'
DECLARE SUB update (wp%, sh%, en%, sz%, p%, name$, money%)
DECLARE SUB center (a$, r%)
DECLARE SUB loadback (a$)
DECLARE SUB load ()
DECLARE SUB mainmenu ()
DECLARE SUB newgame ()
DECLARE SUB savegame ()
DECLARE SUB loadgame ()
DECLARE SUB map (Stars%, x%, y%)
DECLARE SUB star (x%, y%, s%)
DECLARE SUB flag (x%, y%, c%)
DECLARE SUB credits ()



DEFINT A-Z

TYPE WEAPON
   nam AS STRING * 12
   cost AS INTEGER
   size AS INTEGER
   min AS INTEGER
   max AS INTEGER
   typ AS STRING * 1
END TYPE
TYPE NORM
   nam AS STRING * 10
   cost AS INTEGER
   size AS INTEGER
   power AS INTEGER
   elec AS INTEGER
   typ AS STRING * 1
END TYPE
TYPE ship
   nam AS STRING * 10
   cost AS INTEGER
   size AS INTEGER
   crew AS INTEGER
   ab1 AS STRING * 1
   ab2 AS STRING * 1
END TYPE
TYPE custom
   nam AS STRING * 10
   eng AS INTEGER
   shld AS INTEGER
   weap AS INTEGER
   sh AS INTEGER
   ab3 AS STRING * 1
   pic AS INTEGER
END TYPE
TYPE colony
    own AS INTEGER
    making AS INTEGER
    left AS INTEGER
    size AS INTEGER
END TYPE
TYPE ships
    x AS INTEGER
    y AS INTEGER
    hull AS INTEGER
    typ AS INTEGER
    tx AS INTEGER
    ty AS INTEGER
END TYPE

CONST plynum = 4
CONST Strnum = 100

DIM SHARED w(13) AS WEAPON, e(11) AS NORM, s(16) AS NORM, x(20), y(20), typ(20), lst(plynum)
DIM SHARED shp(6) AS ship, g(plynum, 6) AS custom, name$(20), ok$, cost, StarX(Strnum), StarY(Strnum)
DIM SHARED f%(450, 1 TO 20, 1), p%(200, 1 TO 9), mouse$, money(plynum), stx(plynum), sty(plynum)
DIM SHARED st(20) AS colony, sh(plynum, 50) AS ships, en, rn, players, Stars
RANDOMIZE TIMER
GOSUB mouse
CALL load
CALL mainmenu






END
mouse:
RESTORE
mouse$ = SPACE$(57)
FOR I% = 1 TO 57
  READ a$
  h$ = CHR$(VAL("&H" + a$))
  MID$(mouse$, I%, 1) = h$
NEXT I%




CLS
MS% = MouseInit%
IF NOT MS% THEN
  PRINT "Mouse not found": LET AMOUSE$ = "NO":
  PRINT "This Game Won't Run Without Mouse"
  END
END IF
LET AMOUSE$ = "YES"
CALL mouseShow
RETURN

DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00

SUB center (a$, r)
LOCATE r, 20 - LEN(a$) \ 2: PRINT a$
END SUB

FUNCTION costof (pl, shp)
en = g(pl, shp).eng: sh = g(pl, shp).shld
wp = g(pl, shp).weap: sz = g(pl, shp).sh
cs = w(wp + 1).cost + s(sh + 1).cost + e(en + 1).cost + shp(sz + 1).cost
IF shp = 0 THEN cs = 0
costof = cs
END FUNCTION

SUB credits
SCREEN 7
CALL mouseHide
DO: mousestatus l, r, x, y: LOOP WHILE r OR l

CLS
DIM sx(4)
s = INT(20 * RND) + 1
d = CINT(RND)
IF d = 0 THEN x = 0 ELSE x = 289
y = 169 * RND
sp = 2
ox = x: oy = y
DO
center "ZENITH", 6
center "By", 9
center "Tim Caswell", 10
PUT (x, y), f%(0, s, d), PSET
IF d = 0 THEN LINE (ox, oy)-(x - 1, oy + 29), 0, BF
IF d = 1 THEN LINE (ox + 29, oy)-(x + 30, oy + 29), 0, BF
ox = x: oy = y
IF d = 0 THEN x = x + sp ELSE x = x - sp
mousestatus l, r, gx, gy
IF x < 0 OR x > 289 THEN
LINE (ox, y)-(ox + 29, y + 29), 0, BF
s = INT(20 * RND) + 1: d = CINT(RND): y = 169 * RND: sp = 2 + 3 * RND
IF d = 0 THEN x = 0 ELSE x = 289
END IF
LOOP WHILE INKEY$ = "" AND (NOT l) AND (NOT r)
CALL mouseShow
END SUB

SUB custom (ply, slot)
loadback "custom.pic"
name$ = g(ply, slot).nam
en = (g(ply, slot).eng): sh = (g(ply, slot).shld)
wp = (g(ply, slot).weap): sz = (g(ply, slot).sh)
ab3 = ASC(g(ply, slot).ab3): p = g(ply, slot).pic

IF name$ = "" THEN name$ = "New"
update wp, sh, en, sz, p, name$, money(ply)
LINE (11, 11)-(42, 42), ply + 8, B
done = 0
DO:
mousestatus l, r, x, y

IF r OR l OR INKEY$ = CHR$(13) THEN
    IF l OR INKEY$ = CHR$(13) THEN ad = -1 ELSE ad = 1
    sy = y \ 8
    IF sy = 23 AND x < 100 THEN IF ok$ = "OK" THEN done = -1 ELSE SOUND 1000, 1: SOUND 2000, 1: SOUND 300, 1
    IF sy = 23 AND x > 100 AND x < 200 THEN wp = 0: sh = 0: en = 0: sz = 2: p = INT(4 * RND): name$ = "New"
    IF sy = 7 THEN
    COLOR 15
    CALL mouseHide
    LOCATE 8, 8: PRINT ":                      "
    LOCATE 8, 8: INPUT n$
    IF n$ <> "" THEN name$ = n$
    CALL mouseShow
    END IF
    IF x < 50 AND y < 50 THEN p = (p + ad) MOD 4: IF p < 0 THEN p = 3
    IF sy = 11 THEN wp = (wp + ad) MOD 13: IF wp < 0 THEN wp = 12
    IF sy = 13 THEN sh = (sh + ad) MOD 16: IF sh < 0 THEN sh = 15
    IF sy = 15 THEN en = (en + ad) MOD 11: IF en < 0 THEN en = 10
    IF sy = 17 THEN sz = (sz + ad) MOD 5: IF sz < 0 THEN sz = 4
    update wp, sh, en, sz, p, name$, money(ply)
    IF sy = 23 AND x > 200 THEN done = -1: ok$ = "NO"
    DO: mousestatus l, r, x, y: LOOP WHILE r OR l
END IF
LOOP WHILE NOT done
IF ok$ = "OK" THEN
    cd = 0
    FOR a = 1 TO 50
        IF sh(ply, a).typ = slot THEN ok$ = "NO": cd = cd + 1
    NEXT a
    FOR a = 1 TO Stars
        IF st(a).making = slot THEN ok$ = "NO": cd = cd + 1
    NEXT a

    IF ok$ = "NO" THEN
        LOCATE 12, 14: COLOR 15: PRINT "Are you sure?"
        LOCATE 13, 14: COLOR 15: PRINT "This will destroy"; cd; "ships!"
        ok$ = ""
        DO
            a$ = UCASE$(INKEY$)
            IF a$ = "Y" THEN ok$ = "OK"
            IF a$ = "N" THEN ok$ = "NO"
        LOOP WHILE ok$ = ""
        IF ok$ = "OK" THEN
            FOR a = 1 TO 50
                IF sh(ply, a).typ = slot THEN
                    sh(ply, a).typ = 0
                    FOR s = 1 TO 30
                    SOUND 37 + s * 10 * RND, .1
                    NEXT s
                END IF
            NEXT a
            FOR a = 1 TO Stars
                IF st(a).making = slot THEN st(a).making = 0
            NEXT a

        END IF
    END IF
    IF ok$ = "OK" THEN
        'money(ply) = money(ply) - cost
        SOUND 1100, .5: g(ply, slot).nam = name$
        SOUND 1200, .5: g(ply, slot).eng = (en)
        SOUND 2300, .5: g(ply, slot).shld = (sh)
        SOUND 1300, .5: g(ply, slot).weap = (wp)
        SOUND 2000, .5: g(ply, slot).sh = (sz)
        SOUND 1200, .5: g(ply, slot).ab3 = " "
        SOUND 1500, .5: g(ply, slot).pic = p
    END IF
END IF
END SUB

SUB explosion (x, y)
FOR a = 1 TO 10
sx = 20 * RND - 10
sy = 20 * RND - 10
s = 5 + 20 * RND
FOR b = 0 TO s
CIRCLE (x + sx, y + sy), b, 4 + CINT(RND * 2) * 8
SOUND 37 + b * 5 * RND, .1
NEXT b
FOR b = 0 TO s
CIRCLE (x + sx, y + sy), b, 0
SOUND 37 + (s - b) * 5 * RND, .1
NEXT b
NEXT a
END SUB

SUB fight (hx, hy)
'loadback "fight.pic"
CLS
mouseHide
c = 0
MaxS = 10
Maxb = 40
DIM num(MaxS), o(MaxS), Fx(MaxS)
DIM Fy(MaxS), hull(MaxS), kin(MaxS)
DIM Fwp(MaxS), Fsh(MaxS), Fen(MaxS)
DIM pict(MaxS), live(MaxS), t(MaxS)
DIM wpt(MaxS) AS STRING * 1
DIM bx(Maxb), by(Maxb), btx(Maxb), bty(Maxb), bt(Maxb), bd(Maxb)
DIM team(plynum)

FOR p = 1 TO plynum
    FOR a = 1 TO 50
        IF sh(p, a).typ > 0 AND sh(p, a).x = hx AND sh(p, a).y = hy THEN c = c + 1: num(c) = a: o(c) = p: SOUND 100, .1: SOUND 200, .2: SOUND 300, .3
    NEXT a
NEXT p

FOR a = 1 TO c
    b = INT(c * RND + 1)
    SWAP num(a), num(b)
    SWAP o(a), o(b)
NEXT a
FOR a = 1 TO c
    Fx(a) = INT(220 * RND)
    Fy(a) = INT(90 * RND)
    hull(a) = sh(o(a), num(a)).hull
    kin(a) = sh(o(a), num(a)).typ
    Fwp(a) = g(o(a), kin(a)).weap + 1
    Fen(a) = g(o(a), kin(a)).eng + 1
    Fsh(a) = g(o(a), kin(a)).shld + 1
    pict(a) = g(o(a), kin(a)).pic
    wpt(a) = w(Fwp(a)).typ
    t(a) = 30 * RND
    IF hx > 0 THEN live(a) = -1
NEXT a
done = 0
DO
l = 0
FOR s = 1 TO c
sx = 30: sy = 55
    IF live(s) THEN
    l = l + 1
FOR a = 1 TO 7
t = INT(c * RND + 1)
IF o(t) <> o(s) AND live(t) <> 0 THEN a = 7
NEXT a
'       **************************--FOCUS--****************
IF o(s) = 1 THEN tsx = 16: tsy = 16
IF o(s) = 2 THEN tsx = 16: tsy = 32
IF o(s) = 3 THEN tsx = 180: tsy = 16
IF o(s) = 4 THEN tsx = 180: tsy = 32
LINE (tsx, tsy)-(100 + tsx, tsy + 6), 0, BF
LINE (tsx, tsy)-(tsx + hull(s), tsy + 6), 15, BF
IF Fx(t) > Fx(s) THEN f = 0 ELSE IF Fx(t) < Fx(s) THEN f = 1
LINE (sx + Fx(s), sy + Fy(s))-(sx + Fx(s) + 32, sy + Fy(s) + 32), 0, BF
t(s) = (t(s) + 1) MOD 30
IF Fx(s) < Fx(t) THEN mx = 1 ELSE mx = -1
IF Fy(s) < Fy(t) THEN my = 1 ELSE my = -1
IF ABS(Fx(s) - Fx(t)) + ABS(Fy(s) - Fy(t)) < 70 THEN
    mx = -mx: my = -my
ELSE
    IF t(s) < 15 THEN mx = -mx
    IF t(s) < 7 OR t(s) > 23 THEN my = -my
END IF
Fx(s) = Fx(s) + 3 * mx
Fy(s) = Fy(s) + 3 * my
IF Fx(s) < 0 THEN Fx(s) = 0 ELSE IF Fx(s) > 220 THEN Fx(s) = 220
IF Fy(s) < 0 THEN Fy(s) = 0 ELSE IF Fy(s) > 90 THEN Fy(s) = 90
a = g(o(s), kin(s)).sh * 4 + pict(s) + 1
PUT (sx + Fx(s), sy + Fy(s)), f%(0, a, f), PSET
'LINE (sx + Fx(s), sy + Fy(s))-(sx + Fx(s) + 32, sy + Fy(s) + 32), o(s) + 8, B
'       ************************--END FOCUS--**************

IF o(t) <> o(s) AND sh(o(t), num(t)).typ > 0 AND RND > .75 THEN
    d = w(Fwp(s)).min + (w(Fwp(s)).max - w(Fwp(s)).min) * RND
    bb = 0
    FOR a = 1 TO Maxb
        IF bt(a) <= 0 THEN bb = a: a = Maxb
    NEXT a
    bx(bb) = Fx(s) + 16: by(bb) = Fy(s) + 16
    btx(bb) = Fx(t) + 16: bty(bb) = Fy(t) + 16
    bd(bb) = d: bt(bb) = ASC(wpt(s)) - 64
    SOUND 37, .1: SOUND 200, .1: SOUND 400, .2: SOUND 200, .2: SOUND 37, .3
END IF
FOR a = 1 TO Maxb
    IF bt(a) > 0 THEN
        sp = 20 - bt(a): ex = bt(a) ^ 2
        ox = bx(a): oy = by(a)
        FOR t = 1 TO sp
            IF bx(a) > btx(a) THEN bx(a) = bx(a) - 1
            IF bx(a) < btx(a) THEN bx(a) = bx(a) + 1
            IF by(a) > bty(a) THEN by(a) = by(a) - 1
            IF by(a) < bty(a) THEN by(a) = by(a) + 1
        NEXT t
        PSET (ox + sx, oy + sy), 0
        PSET (bx(a) + sx, by(a) + sy), 15 - bt(a)
        IF bx(a) = btx(a) AND by(a) = bty(a) THEN
            sz = bt(a) * 2
            FOR t = 0 TO 3
                FOR b = t TO sz STEP 4
                    CIRCLE (bx(a) + sx, by(a) + sy), b, 4 + CINT(RND) * 8
                NEXT b
            NEXT t
            FOR t = 1 TO c
                IF ABS(Fx(t) + 16 - bx(a)) + ABS(Fy(t) + 16 - by(a)) < bt(a) * 10 THEN
                    d = bd(a) - s(Fsh(t)).power * RND
                    d = d * (100 / shp(g(o(t), kin(t)).sh + 1).crew)
                    IF d > 0 THEN
                        hull(t) = hull(t) - d
                        t(t) = 30 * RND
                    END IF
                END IF
            NEXT t
            FOR t = 0 TO 3
                FOR b = t TO sz STEP 4
                    CIRCLE (bx(a) + sx, by(a) + sy), b, 0
                NEXT b
            NEXT t
            bt(a) = 0
        END IF
    END IF
NEXT a

IF hull(s) < 0 THEN live(s) = 0: explosion sx + Fx(s) + 16, sy + Fy(s) + 16
    

'          *****************--Check to see if winner--********
        FOR a = 1 TO plynum
            team(a) = 0
        NEXT a
        FOR a = 1 TO c
            IF live(a) THEN team(o(a)) = team(o(a)) + 1
        NEXT a
        teams = 0
        FOR a = 1 TO plynum
            IF team(a) > 0 THEN teams = teams + 1
        NEXT a
        IF teams <= 1 THEN done = 1
'         ******************--End Check--*********************

    END IF
NEXT s
IF l = 0 THEN done = 1
LOOP WHILE done = 0
FOR a = 1 TO c
    sh(o(a), num(a)).hull = hull(a)
    IF live(a) = 0 THEN sh(o(a), num(a)).x = 0: sh(o(a), num(a)).y = 0: sh(o(a), num(a)).typ = 0
NEXT a

mouseShow
END SUB

SUB flag (x, y, c)
a$ = "u4u2r3d2l3e2"
PSET (x + 2, y + 2), 0: DRAW a$
PSET (x + 1, y + 1), c: DRAW a$
PSET (x, y), c + 8: DRAW a$
END SUB

SUB getbutton
DO
mousestatus lb%, rb%, xmouse%, ymouse%
IF lb% = -1 THEN EXIT DO
LOOP UNTIL INKEY$ <> ""
hotmail:
mousestatus lb%, rb%, xmouse%, ymouse%
IF lb% = -1 THEN GOTO hotmail
END SUB

SUB intro
CLS
fight 1, 1
END SUB

SUB load
DEF SEG = VARSEG(f%(0, 1, 0))
BLOAD "..\zenith\Ships.pic", 0
DEF SEG = VARSEG(p%(0, 1))
BLOAD "..\zenith\planets.pic", 0
OPEN "..\zenith\Ships.dat" FOR INPUT AS #1
FOR a = 1 TO 13
    INPUT #1, w(a).nam, w(a).cost, w(a).size, w(a).min, w(a).max, w(a).typ
NEXT a
FOR a = 1 TO 11
    INPUT #1, e(a).nam, e(a).cost, e(a).size, e(a).power, e(a).elec, e(a).typ
NEXT a
FOR a = 1 TO 16
    INPUT #1, s(a).nam, s(a).cost, s(a).size, s(a).power, s(a).elec, s(a).typ
NEXT a
FOR a = 1 TO 5
    INPUT #1, shp(a).nam, shp(a).cost, shp(a).size, shp(a).crew, shp(a).ab1, shp(a).ab2
NEXT a
FOR a = 1 TO 6
    INPUT #1, g(1, a).nam, g(1, a).eng, g(1, a).shld, g(1, a).weap, g(1, a).sh, g(1, a).ab3
    FOR b = 2 TO plynum
        g(b, a).nam = g(1, a).nam: g(b, a).eng = g(1, a).eng
        g(b, a).shld = g(1, a).shld: g(b, a).weap = g(1, a).weap
        g(b, a).sh = g(1, a).sh: g(b, a).ab3 = g(1, a).ab3
    NEXT b
    FOR b = 1 TO plynum
        g(b, a).pic = b
    NEXT b
NEXT a
CLOSE #1
END SUB

SUB loadback (a$)
DIM b%(32000)
SCREEN 7
PALETTE 7, 9
PALETTE 8, 1
DEF SEG = VARSEG(b%(0))
BLOAD "..\zenith\" + a$, 0
CALL mouseHide
PALETTE 7, 7
PALETTE 8, 8
PUT (0, 0), b%, PSET
CALL mouseShow
END SUB

SUB loadgame
loadback "game.pic"
LOCATE 9, 2: COLOR 14: PRINT " Load Game"
DO:
mousestatus l, r, x, y
IF l OR r OR INKEY$ = CHR$(13) THEN
sy = y \ 8 + 1
IF sy = 24 THEN f$ = "SLOT6.SAV": SV = -1
IF sy = 21 THEN f$ = "SLOT5.SAV": SV = -1
IF sy = 18 THEN f$ = "SLOT4.SAV": SV = -1
IF sy = 15 THEN f$ = "SLOT3.SAV": SV = -1
IF sy = 12 THEN f$ = "SLOT2.SAV": SV = -1
IF sy = 9 THEN f$ = "SLOT1.SAV": SV = -1
IF SV THEN
    done = -1
    OPEN "..\zenith\" + f$ FOR INPUT AS #1
    INPUT #1, en, rn, players, Stars
    FOR b = 1 TO players
        INPUT #1, money(b), stx(b), sty(b), lst(b)
        FOR a = 1 TO 50
            INPUT #1, sh(b, a).typ, sh(b, a).hull, sh(b, a).x, sh(b, a).y, sh(b, a).tx, sh(b, a).ty
        NEXT a
        FOR a = 1 TO 6
            INPUT #1, g(b, a).nam, g(b, a).eng, g(b, a).shld, g(b, a).weap, g(b, a).sh, g(b, a).ab3, g(b, a).pic
        NEXT a
    NEXT b
    FOR a = 1 TO Stars
        INPUT #1, st(a).own, st(a).making, st(a).left, st(a).size, x(a), y(a), typ(a)
    NEXT a
    FOR a = 1 TO Strnum
        INPUT #1, StarX(a), StarY(a)
    NEXT a
    CLOSE #1
END IF
IF sy = 24 AND x > 220 THEN done = -1
END IF
LOOP WHILE NOT done
END SUB

SUB look (pl, sh, Stars)
loadback "ship.pic"
Fx = sh(pl, sh).x - 5: Fy = sh(pl, sh).y - 5
typ = sh(pl, sh).typ
IF typ = 0 THEN GOTO skip
PUT (185, 10), f%(0, g(pl, typ).sh * 4 + g(pl, typ).pic + 1, 1), PSET
LOCATE 8, 29: COLOR 9: PRINT pl
LOCATE 11, 28: COLOR 9: PRINT g(pl, sh(pl, sh).typ).nam
LOCATE 14, 28: COLOR 9: PRINT sh(pl, sh).hull
map Stars, Fx, Fy
IF sh(pl, sh).tx > 0 THEN
    sx = sh(pl, sh).tx - Fx: IF sx < 1 THEN sx = 1 ELSE IF sx > 8 THEN sx = 8
    sy = sh(pl, sh).ty - Fy: IF sy < 1 THEN sy = 1 ELSE IF sy > 8 THEN sy = 8
    star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 5: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 4: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 3: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 2
    LINE (95, 95)-(8 + sx * 20 - 10, 8 + sy * 20 - 10), 0: LINE (95, 95)-(8 + sx * 20 - 10, 8 + sy * 20 - 10), 15, , 200
    LOCATE 18, 24: COLOR 15: PRINT sh(pl, sh).tx; sh(pl, sh).ty; "   "
END IF
done = 0
DO:
mousestatus l, r, x, y
mousestatus l, r, x, y
IF l OR r THEN
    sx = x \ 8 + 1: sy = y \ 8 + 1
    IF sy = 24 AND sx > 1 AND sx < 10 THEN done = -1: sh(pl, sh).tx = 0: sh(pl, sh).ty = 0: sx = 2: sy = 2
    IF sx > 1 AND sy > 1 AND sx < 22 AND sy < 22 THEN
        IF NOT done THEN
            sh(pl, sh).tx = (x - 8) \ 20 + Fx + 1
            sh(pl, sh).ty = (y - 8) \ 20 + Fy + 1
            IF sh(pl, sh).tx < 1 THEN sh(pl, sh).tx = 1
            IF sh(pl, sh).ty < 1 THEN sh(pl, sh).ty = 1
            IF sh(pl, sh).tx > 50 THEN sh(pl, sh).tx = 50
            IF sh(pl, sh).ty > 50 THEN sh(pl, sh).ty = 50
        END IF
        done = 0
whereto:   
        map Stars, Fx, Fy
        IF sh(pl, sh).tx > 0 THEN
        CALL mouseHide
            sx = sh(pl, sh).tx - Fx: IF sx < 1 THEN sx = 1 ELSE IF sx > 8 THEN sx = 8
            sy = sh(pl, sh).ty - Fy: IF sy < 1 THEN sy = 1 ELSE IF sy > 8 THEN sy = 8
            star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 5: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 4: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 3: star 8 + sx * 20 - 10, 8 + sy * 20 - 10, 2
            LINE (95, 95)-(8 + sx * 20 - 10, 8 + sy * 20 - 10), 0: LINE (95, 95)-(8 + sx * 20 - 10, 8 + sy * 20 - 10), 15, , 200
            LOCATE 18, 24: COLOR 15: PRINT sh(pl, sh).tx; sh(pl, sh).ty; "   "
            CALL mouseShow
        END IF
    END IF
    IF sx > 29 AND sx < 40 AND sy = 24 THEN done = -1
    IF sx >= 16 AND sx <= 26 AND sy = 24 THEN LOCATE 18, 24: COLOR 12: INPUT sh(pl, sh).tx, sh(pl, sh).ty: sx = 0: GOTO whereto
    DO: mousestatus l, r, x, y: LOOP WHILE r
END IF
LOOP WHILE NOT done
skip:

END SUB

SUB main (en, rn, players, Stars)
DO
plyr = (plyr MOD players) + 1
FOR a = 1 TO Stars
    IF st(a).own = plyr THEN
        IF st(a).making > 0 THEN st(a).left = st(a).left - st(a).size * 2
        IF st(a).making > 0 AND st(a).left <= 0 THEN make st(a).making, x(a), y(a), st(a).own: st(a).making = 0
        IF st(a).size < 500 THEN st(a).size = st(a).size + 1 + st(a).size / 10
        money(plyr) = money(plyr) + st(a).size / 3 + 30
        IF st(a).left < 0 THEN st(a).left = 0
    END IF
NEXT a
Fx = stx(plyr): Fy = sty(plyr): lst = lst(plyr)
loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
done = 0
DO
mousestatus l, r, x, y
sy = y \ 8 + 1: sx = x \ 8 + 1
IF l OR r OR INKEY$ = CHR$(13) THEN
IF sy = 2 AND sx >= 23 AND sx <= 27 THEN custom plyr, 1: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 3 AND sx >= 23 AND sx <= 27 THEN custom plyr, 2: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 4 AND sx >= 23 AND sx <= 27 THEN custom plyr, 3: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 5 AND sx >= 23 AND sx <= 27 THEN custom plyr, 4: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 6 AND sx >= 23 AND sx <= 27 THEN custom plyr, 5: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 7 AND sx >= 23 AND sx <= 27 THEN custom plyr, 6: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 2 AND sx >= 29 AND sx <= 39 THEN over = -1
IF sy = 4 AND sx >= 29 AND sx <= 39 THEN CALL loadgame: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 6 AND sx >= 29 AND sx <= 39 THEN CALL savegame: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
IF sy = 8 AND sx >= 29 AND sx <= 39 THEN SYSTEM
IF sy = 10 AND sx >= 29 AND sx <= 39 THEN done = -1
IF sx > 23 AND sx < 40 AND sy >= 18 AND sy <= 24 THEN
        ship = (sy + lst) MOD 50 + 1
        IF sh(plyr, ship).typ > 0 THEN
            IF l THEN look plyr, ship, Stars: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
            IF r THEN Fx = sh(plyr, ship).x - 5: Fy = sh(plyr, ship).y - 5: map Stars, Fx, Fy
        END IF
END IF
mv = 0
IF sy = 18 AND sx = 23 THEN mv = -1: lst = lst - 1: IF lst < 0 THEN lst = 49
IF sy = 24 AND sx = 23 THEN mv = -1: lst = (lst + 1) MOD 50
IF mv THEN slist plyr, lst
mv = 0
IF x > 185 AND x < 200 AND y > 73 AND y < 88 THEN mv = -1: cur = (cur MOD Stars) + 1
IF x > 185 AND x < 200 AND y > 100 AND y < 115 THEN mv = -1: cur = cur - 1: IF cur < 1 THEN cur = Stars
IF mv THEN Fx = x(cur) - 4: Fy = y(cur) - 4: map Stars, Fx, Fy
rdr = 0
IF x > 258 AND x < 273 AND y > 90 AND y < 105 THEN Fy = Fy - 1: rdr = -1
IF x > 258 AND x < 273 AND y > 110 AND y < 125 THEN Fy = Fy + 1: rdr = -1
IF x > 235 AND x < 250 AND y > 100 AND y < 115 THEN Fx = Fx - 1: rdr = -1
IF x > 285 AND x < 300 AND y > 100 AND y < 115 THEN Fx = Fx + 1: rdr = -1
IF rdr THEN map Stars, Fx, Fy
DO: mousestatus l, r, x, y: LOOP WHILE r
END IF
message$ = "              "
IF x > 8 AND y > 8 AND x < 168 AND y < 168 THEN
    sx = (x - 8) \ 20 + 1 + Fx
    sy = (y - 8) \ 20 + 1 + Fy
    pl = 0
    FOR a = 1 TO Stars
        IF x(a) = sx AND y(a) = sy THEN pl = a
    NEXT a
    IF pl > 0 THEN
        COLOR 8 + st(pl).own
        IF st(pl).own = 0 THEN COLOR 7
        IF typ(pl) = 1 THEN message$ = "Life world   "
        IF typ(pl) = 2 THEN message$ = "Mineral world"
        IF typ(pl) = 3 THEN message$ = "Ringed Planet"
        IF typ(pl) = 4 THEN message$ = "Ice Planet   "
        IF typ(pl) = 5 THEN message$ = "Gas Giant    "
        mousestatus l, r, x, y
        IF l THEN IF st(pl).own = plyr OR en = 1 THEN see plyr, pl: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
    ELSE
    pl = 0
    FOR a = 1 TO 50
        IF sh(plyr, a).x = sx AND sh(plyr, a).y = sy THEN pl = a
    NEXT a
        IF pl > 0 THEN
            COLOR 8 + plyr
            message$ = "Ship         "
            mousestatus l, r, x, y
            IF l THEN look plyr, pl, Stars: loadback "Normal.pic": map Stars, Fx, Fy: slist plyr, lst
        ELSE
        IF r OR l THEN Fx = sx - 4: Fy = sy - 4: map Stars, Fx, Fy
        END IF
    END IF
END IF
LOCATE 23, 2
IF LEFT$(message$, 1) = " " AND x < 166 AND y < 166 THEN PRINT sx; sy; "     " ELSE PRINT message$
LOOP WHILE NOT done AND NOT over
stx(plyr) = Fx
sty(plyr) = Fy
lst(plyr) = lst
over = 0
FOR a = 1 TO 50
    IF sh(plyr, a).typ > 0 THEN
        IF sh(plyr, a).tx > 0 THEN
            t = sh(plyr, a).typ
            sp = g(plyr, t).eng + 3 - g(plyr, t).sh
            IF sp < 1 THEN sp = 1
            SOUND 600, 1
            FOR m = 1 TO sp
                SOUND 37, .1
                IF sh(plyr, a).tx < sh(plyr, a).x THEN sh(plyr, a).x = sh(plyr, a).x - 1
                IF sh(plyr, a).tx > sh(plyr, a).x THEN sh(plyr, a).x = sh(plyr, a).x + 1
                IF sh(plyr, a).ty < sh(plyr, a).y THEN sh(plyr, a).y = sh(plyr, a).y - 1
                IF sh(plyr, a).ty > sh(plyr, a).y THEN sh(plyr, a).y = sh(plyr, a).y + 1
            NEXT m
            IF sh(plyr, a).tx = sh(plyr, a).x AND sh(plyr, a).ty = sh(plyr, a).y THEN sh(plyr, a).tx = 0: sh(plyr, a).ty = 0
        END IF
    END IF
    IF sh(plyr, a).typ > 0 THEN
        FOR b = 1 TO Stars
            IF x(b) = sh(plyr, a).x AND y(b) = sh(plyr, a).y THEN st(b).own = plyr
        NEXT b
        sh(plyr, a).hull = sh(plyr, a).hull + 10: IF sh(plyr, a).hull > 100 THEN sh(plyr, a).hull = 100
    END IF
NEXT a
FOR a = 1 TO 50
    IF sh(plyr, a).typ > 0 THEN
        FOR pp = 1 TO players
                IF pp <> plyr THEN
                        FOR z = 1 TO 50
                                IF sh(pp, z).typ > 0 AND sh(plyr, a).x = sh(pp, z).x AND sh(plyr, a).y = sh(pp, z).y THEN fight sh(pp, z).x, sh(pp, z).y
                        NEXT z
                END IF
        NEXT pp
    END IF
NEXT a
LOOP WHILE NOT done
END SUB

SUB mainmenu
loadback "main.pic"
CALL mouseShow
DO:
mousestatus l, r, x, y
IF l OR r OR INKEY$ = CHR$(13) THEN
    sy = y \ 8
    IF x > 100 AND x < 220 THEN
        IF sy = 8 THEN CALL newgame: loadback "main.pic"
        IF sy = 11 THEN CALL loadgame: loadback "main.pic"
        IF sy = 14 THEN CALL savegame: loadback "main.pic"
        IF sy = 17 AND players >= 1 THEN main en, rn, players, Stars: loadback "main.pic"
        IF sy = 20 THEN CALL credits: loadback "main.pic"
        IF sy = 23 THEN SYSTEM
    END IF
END IF

LOOP
END SUB

SUB make (typ, x, y, p)
sh = 0
FOR a = 1 TO 50
IF sh(p, a).typ = 0 THEN sh = a: a = 50
NEXT a
sh(p, sh).typ = typ
sh(p, sh).x = x
sh(p, sh).y = y
sh(p, sh).hull = 100
END SUB

SUB map (Stars, x, y)
CALL mouseHide
LINE (8, 8)-(167, 167), 0, BF
FOR a = 1 TO plynum
    FOR b = 1 TO 50
        IF sh(a, b).typ > 0 THEN
            sx = sh(a, b).x - x: sy = sh(a, b).y - y
            IF sx > 0 AND sy > 0 AND sx < 9 AND sy < 9 THEN PUT (8 + sx * 20 - 20, 8 + sy * 20 - 20), p%(0, a + 5), PSET
        END IF
    NEXT b
NEXT a
FOR yy = 1 TO 8
FOR xx = 1 TO 8
sx = xx + x: sy = yy + y
IF sx < 1 OR sy < 1 OR sx > 100 OR sy > 100 THEN LINE (xx * 20 - 12, yy * 20 - 12)-(xx * 20 + 8, yy * 20 + 8), 14
NEXT xx
NEXT yy
FOR a = 1 TO Stars
sx = x(a) - x: sy = y(a) - y
IF sx > 0 AND sy > 0 AND sx < 9 AND sy < 9 THEN PUT (8 + sx * 20 - 20, 8 + sy * 20 - 20), p%(0, typ(a)), PSET: IF st(a).own > 0 THEN flag 8 + sx * 20 - 12, 8 + sy * 20 - 14, st(a).own
NEXT a
FOR a = 1 TO Strnum
sx = StarX(a) - x: sy = StarY(a) - y
IF sx > 0 AND sy > 0 AND sx < 9 AND sy < 9 THEN star 8 + sx * 20 - 15 + a / 20, 8 + sy * 20 - 15 + a / 20, a / Strnum * 4 + 1
NEXT a
CALL mouseShow
END SUB

SUB MouseDriver (AX%, bx%, CX%, DX%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(AX%, bx%, CX%, DX%, mouse%)
END SUB

SUB mouseHide
 AX% = 2
 MouseDriver AX%, 0, 0, 0

END SUB

FUNCTION MouseInit%
  AX% = 0
  MouseDriver AX%, 0, 0, 0
  MouseInit% = AX%

END FUNCTION

SUB Mouseput
  AX% = 4
  CX% = x%
  DX% = y%
  MouseDriver AX%, 0, CX%, DX%

END SUB

SUB mouseShow
  AX% = 1
  MouseDriver AX%, 0, 0, 0

END SUB

SUB mousestatus (lb%, rb%, xmouse%, ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  lb% = ((bx% AND 1) <> 0)
  rb% = ((bx% AND 2) <> 0)
  xmouse% = CX% \ 2
  ymouse% = DX%
END SUB

SUB newdate (en, rd, players, money, Stars)
CALL mouseHide
LOCATE 10, 22: COLOR 12: PRINT Stars
LOCATE 12, 19: COLOR 12: PRINT USING "$####"; money
LOCATE 14, 22: COLOR 12: PRINT players
IF rd = 0 THEN COLOR 0 ELSE COLOR 12
LOCATE 18, 27: PRINT "€"
IF rd = 1 THEN COLOR 0 ELSE COLOR 12
LOCATE 18, 35: PRINT "€"
IF en = 0 THEN COLOR 0 ELSE COLOR 12
LOCATE 20, 27: PRINT "€"
IF en = 1 THEN COLOR 0 ELSE COLOR 12
LOCATE 20, 35: PRINT "€"
CALL mouseShow
END SUB

SUB newgame
loadback "Newgame.pic"
done = 0
ok$ = "OK"
en = 0: rn = 1: players = 2: money = 500: Stars = 15
newdate en, rn, players, money, Stars
DO
mousestatus l, r, x, y
IF l OR r OR INKEY$ = CHR$(13) THEN
IF r THEN ad = 1 ELSE ad = -1
    sy = y \ 8 + 1
    IF sy = 20 THEN en = 1 - en
    IF sy = 18 THEN rn = 1 - rn
    IF sy = 14 THEN players = (players MOD 4) + ad: IF players < 1 THEN players = 4
    IF sy = 12 THEN money = (money + 100 * ad) MOD 2000: IF money < 0 THEN money = 2000
    IF sy = 10 THEN Stars = (Stars MOD 20) + ad: IF Stars < 1 THEN Stars = 20
    IF sy = 24 AND x < 100 THEN IF ok$ = "OK" THEN done = -1 ELSE SOUND 1000, 1: SOUND 2000, 1: SOUND 300, 1
    IF sy = 24 AND x > 100 AND x < 200 THEN wp = 0: sh = 0: en = 0: sz = 2: p = INT(4 * RND): name$ = "New"
    IF sy = 24 AND x > 200 THEN done = -1: ok$ = "NO"
    newdate en, rn, players, money, Stars
    DO: mousestatus l, r, x, y: LOOP WHILE r OR l
END IF
LOOP WHILE NOT done
PALETTE 7, 12
PALETTE 8, 4
IF ok$ = "OK" THEN
    FOR a = 1 TO Strnum
        StarX(a) = INT(50 * RND + 1)
        StarY(a) = INT(50 * RND + 1)
    NEXT a
    FOR a = 1 TO Stars
        x(a) = INT(50 * RND + 1)
        y(a) = INT(50 * RND + 1)
        typ(a) = INT(5 * RND + 1)
        st(a).own = a: IF a > players THEN st(a).own = 0
        st(a).making = 0: IF a <= players THEN st(a).making = 5
        st(a).left = 0
        st(a).size = 20 + 20 * RND: IF a <= players THEN st(a).size = 60
    NEXT a
    FOR a = 1 TO players
        FOR b = 1 TO 50
            sh(a, b).typ = 0
            sh(a, b).hull = 0
        NEXT b
        money(a) = money
        stx(a) = x(a) - 3
        sty(a) = y(a) - 3
        lst(a) = 32
    NEXT a
    main en, rn, players, Stars
END IF
END SUB

SUB savegame
loadback "game.pic"
LOCATE 9, 2: COLOR 14: PRINT " Save Game"
done = 0
DO:
mousestatus l, r, x, y
IF l OR r OR INKEY$ = CHR$(13) THEN
sy = y \ 8 + 1
IF sy = 24 THEN f$ = "SLOT6.SAV": SV = -1
IF sy = 21 THEN f$ = "SLOT5.SAV": SV = -1
IF sy = 18 THEN f$ = "SLOT4.SAV": SV = -1
IF sy = 15 THEN f$ = "SLOT3.SAV": SV = -1
IF sy = 12 THEN f$ = "SLOT2.SAV": SV = -1
IF sy = 9 THEN f$ = "SLOT1.SAV": SV = -1
IF SV THEN
    done = -1
    OPEN "..\zenith\" + f$ FOR OUTPUT AS #1
    WRITE #1, en, rn, players, Stars
    FOR b = 1 TO players
        WRITE #1, money(b), stx(b), sty(b), lst(b)
        FOR a = 1 TO 50
            WRITE #1, sh(b, a).typ, sh(b, a).hull, sh(b, a).x, sh(b, a).y, sh(b, a).tx, sh(b, a).ty
        NEXT a
        FOR a = 1 TO 6
            WRITE #1, g(b, a).nam, g(b, a).eng, g(b, a).shld, g(b, a).weap, g(b, a).sh, g(b, a).ab3, g(b, a).pic
        NEXT a
    NEXT b
    FOR a = 1 TO Stars
        WRITE #1, st(a).own, st(a).making, st(a).left, st(a).size, x(a), y(a), typ(a)
    NEXT a
    FOR a = 1 TO Strnum
        WRITE #1, StarX(a), StarY(a)
    NEXT a
    CLOSE #1
END IF
IF sy = 24 AND x > 220 THEN done = -1
END IF
LOOP WHILE NOT done
END SUB

SUB see (pl, st)
DIM lit(1 TO 8)
start:
loadback "planet.pic"
CALL mouseHide
PUT (9 + 5, 9 + 5), p%(0, typ(st)), PSET
IF st(st).own > 0 THEN flag 8 + 1 * 20 - 12 + 5, 8 + 1 * 20 - 14 + 5, pl
LOCATE 8, 8: COLOR st(st).own + 8: PRINT st(st).own
LOCATE 11, 8: COLOR 10
IF typ(st) = 1 THEN PRINT "Life world   "
IF typ(st) = 2 THEN PRINT "Mineral world"
IF typ(st) = 3 THEN PRINT "Ringed Planet"
IF typ(st) = 4 THEN PRINT "Ice Planet   "
IF typ(st) = 5 THEN PRINT "Gas Giant    "
LOCATE 14, 12: COLOR 12
IF st(st).making = 0 THEN PRINT "Nothing"
IF st(st).making > 0 THEN PRINT g(pl, st(st).making).nam
LOCATE 17, 7: COLOR 12: PRINT st(st).left; "/"; costof(pl, st(st).making); "        "
d = 0
FOR a = 1 TO 8
DO
d = d + 1:
ok = 0: IF d <= 50 THEN IF sh(pl, d).typ > 0 AND sh(pl, d).x = x(st) AND sh(pl, d).y = y(st) THEN ok = -1
IF d > 50 THEN ok = -1
LOOP WHILE NOT ok
IF d <= 50 THEN typ = sh(pl, d).typ: PUT (a * 30 + 19, 9), f(0, g(pl, typ).sh * 4 + g(pl, typ).pic + 1, 1), PSET
lit(a) = d
NEXT a
CALL mouseShow
done = 0
DO
mousestatus l, r, x, y
IF l OR r THEN
sx = x \ 8 + 1
sy = y \ 8 + 1
IF x > 49 AND y > 8 AND x < 310 AND y < 39 THEN shp = (x - 49) \ 30 + 1: IF lit(shp) > 0 AND lit(shp) <= 50 THEN look pl, lit(shp), 20: GOTO start
IF sy = 14 AND st(st).making = 0 THEN
    PALETTE 8, 2
    PALETTE 7, 10
    mv = 0
    DO: a$ = INKEY$
        IF a$ = "1" THEN shp = 1: mv = -1
        IF a$ = "2" THEN shp = 2: mv = -1
        IF a$ = "3" THEN shp = 3: mv = -1
        IF a$ = "4" THEN shp = 4: mv = -1
        IF a$ = "5" THEN shp = 5: mv = -1
        IF a$ = "6" THEN shp = 6: mv = -1
        IF shp > 0 THEN IF costof(pl, shp) > money(pl) THEN shp = 0: SOUND 100, .1: SOUND 1000, .1: SOUND 10000, .1
    LOOP WHILE NOT mv
    st(st).making = shp
    st(st).left = costof(pl, shp)
    CALL mouseHide
    LOCATE 14, 12: COLOR 12
    IF st(st).making = 0 THEN PRINT "Nothing"
    IF st(st).making > 0 THEN PRINT g(pl, st(st).making).nam
    LOCATE 17, 7: COLOR 12: PRINT st(st).left; "/"; costof(pl, st(st).making); "        "
    CALL mouseShow
    PALETTE 8, 8
    PALETTE 7, 7
END IF
IF sx < 13 AND sy = 24 THEN
    st(st).making = 0: st(st).left = 0
    LOCATE 14, 12: COLOR 12
    IF st(st).making = 0 THEN PRINT "Nothing"
    IF st(st).making > 0 THEN PRINT g(pl, st(st).making).nam
    LOCATE 17, 7: COLOR 12: PRINT st(st).left; "/"; costof(pl, st(st).making); "        "
END IF
IF sx > 29 AND sy = 24 THEN done = -1
END IF
LOOP WHILE NOT done
IF st(st).left = costof(pl, st(st).making) THEN money(pl) = money(pl) - costof(pl, st(st).making): st(st).left = st(st).left - 1
END SUB

SUB shoot (x1, y1, x2, y2)
d = SQR((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
a = 0
x = (x2 * (a / d) + x1 * ((d - a) / d))
y = (y2 * (a / d) + y1 * ((d - a) / d))
FOR a = 0 TO d STEP 4
ox = x: oy = y
x = (x2 * (a / d) + x1 * ((d - a) / d))
y = (y2 * (a / d) + y1 * ((d - a) / d))
FOR sx = -1 TO 1
FOR sy = -1 TO 1
PSET (ox + sx, oy + sy), 0
PSET (x + sx, y + sy), 12 + 3 * RND
NEXT sy
NEXT sx
SOUND 37 + 540 * RND, .1
NEXT a
SOUND 0, 0
END SUB

SUB slist (plyr, l)
CALL mouseHide
FOR a = 18 TO 24
LOCATE a, 24
c = (a + l) MOD 50 + 1
COLOR plyr
IF sh(plyr, c).tx = 0 THEN COLOR plyr + 8
PRINT LEFT$(g(plyr, sh(plyr, c).typ).nam + "                 ", 15);
NEXT a
LOCATE 24, 2: COLOR 15: PRINT "Vault"; money(plyr);
CALL mouseShow
END SUB

SUB star (x, y, s)
PSET (x - 1, y), 11: PSET (x + 1, y), 11: PSET (x, y + 1), 11: PSET (x, y - 1), 11
PSET (x - 1, y - 1), 9: PSET (x - 1, y + 1), 9: PSET (x + 1, y - 1), 9: PSET (x + 1, y + 1), 9
PSET (x - s, y - s), 8: PSET (x - s, y + s), 8: PSET (x + s, y + s), 8: PSET (x + s, y - s), 8
PSET (x - s, y), 7: PSET (x + s, y), 7: PSET (x, y - s), 7: PSET (x, y + s), 7
PSET (x, y), 15
END SUB

SUB update (wp, sh, en, sz, p, name$, money)
g = (p + 1) + sz * 4
CALL mouseHide
PUT (12, 12), f%(0, g, 0), PSET
cost = 0: sp = 0
COLOR 12
LOCATE 8, 8: PRINT ": ";
COLOR 15: IF name$ = "New" THEN COLOR 13
PRINT name$; "                 "
COLOR 11
LOCATE 12, 4: PRINT LEFT$(w(wp + 1).nam, 12)
LOCATE 12, 16: PRINT w(wp + 1).cost: cost = cost + w(wp + 1).cost
LOCATE 12, 24: PRINT w(wp + 1).size: sp = sp - w(wp + 1).size
LOCATE 12, 31: PRINT w(wp + 1).min; "-"; w(wp + 1).max
LOCATE 14, 4: PRINT LEFT$(s(sh + 1).nam, 12)
LOCATE 14, 16: PRINT s(sh + 1).cost: cost = cost + s(sh + 1).cost
LOCATE 14, 24: PRINT s(sh + 1).size: sp = sp - s(sh + 1).size
LOCATE 14, 34: PRINT s(sh + 1).power
LOCATE 16, 4: PRINT LEFT$(e(en + 1).nam, 12)
LOCATE 16, 16: PRINT e(en + 1).cost: cost = cost + e(en + 1).cost
LOCATE 16, 24: PRINT e(en + 1).size: sp = sp - e(en + 1).size
LOCATE 16, 34: PRINT e(en + 1).power
LOCATE 18, 4: PRINT LEFT$(shp(sz + 1).nam, 12)
LOCATE 18, 16: PRINT shp(sz + 1).cost: cost = cost + shp(sz + 1).cost
LOCATE 18, 24: PRINT shp(sz + 1).size: sp = sp + shp(sz + 1).size
LOCATE 18, 34: PRINT shp(sz + 1).crew
COLOR 11: 'IF cost > money THEN COLOR 13
LOCATE 20, 16: PRINT cost
COLOR 11: IF sp < 0 THEN COLOR 13
LOCATE 20, 24: PRINT sp
elec = e(en + 1).elec - s(sh + 1).elec
COLOR 11: IF cost > money THEN COLOR 13
LOCATE 22, 16: PRINT money
COLOR 11: IF elec <= 5 THEN COLOR 13
LOCATE 22, 34: PRINT elec; " "
IF sp < 0 OR elec < 0 OR name$ = "New" THEN ok$ = "NO": COLOR 13 ELSE ok$ = "OK": COLOR 10
LOCATE 20, 34: PRINT ok$
CALL mouseShow
END SUB

