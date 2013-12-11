DEFINT A-Z
DECLARE SUB anim (hp%)
DECLARE SUB loadpal (filename$)
DECLARE SUB savePal (filename$)
RANDOMIZE TIMER
SCREEN 13
DIM m(-1 TO 32, -1 TO 32)
loadpal "game.pal"


filename$ = "Lars.chr"
name$ = "Lars"
hp = 30    'Hit points
at = 5     'Random attacking
df = 5      'random points taken off
sp = 5      '{1 - 10}
Weapon$ = "crossbow": wp = 3
Armor$ = "Small Shield": ar = 3
' Program start here
FOR y = 1 TO 30
FOR x = 1 TO 30
READ a
IF a = 7 THEN c = 5
IF a = 1 THEN c = 4
IF a = 2 THEN c = 31 + 16
IF a = 3 THEN c = 31
IF a = 4 THEN c = 31 + 16 + 16 + 16
IF a = 5 THEN c = 31 + 16 + 16
IF a = 6 THEN c = 6
IF a = 0 THEN c = INT(3 * RND) + 1
PSET (x, y), c

NEXT x
NEXT y
FOR y = 1 TO 30
    FOR x = 1 TO 30
        IF POINT(x, y) = 6 THEN
            px = 0
            c = 16 * RND
            FOR s = 0 TO 6
                px = px + 2 * RND - 1
                c = (c + 1) MOD 16
                PSET (x + px, y - s), 95 - c
            NEXT s
        END IF
    NEXT x
NEXT y

FOR y = 1 TO 30
    FOR x = 1 TO 30
        m(x, y) = POINT(x, y)
    NEXT x
NEXT y
FOR s = 1 TO 10
FOR y = 1 TO 30
FOR x = 1 TO 30
c = m(x, y)
IF m(x, y) >= 16 AND m(x, y) < 80 THEN
IF (x + y) MOD 2 = 0 THEN
    up = m(x, y - 1) MOD 16
    dn = m(x, y + 2) MOD 16
    rt = m(x + 2, y) MOD 16
    lt = m(x - 1, y) MOD 16
ELSE
    up = m(x, y - 2) MOD 16
    dn = m(x, y + 1) MOD 16
    rt = m(x + 1, y) MOD 16
    lt = m(x - 2, y) MOD 16
END IF
pt = m(x, y) MOD 16
av = (up + dn + lt + rt) / 4
c = m(x, y) \ 16
c = av + c * 16
END IF
PSET (x, y), c
NEXT x
NEXT y
FOR y = 1 TO 30
FOR x = 1 TO 30
m(x, y) = POINT(x, y)
NEXT x
NEXT y
NEXT s
GOSUB save
DO:
hp = (hp + 1) MOD 64
anim hp
 LOOP WHILE INKEY$ <> " "
END
save:
OPEN filename$ FOR OUTPUT AS #1
PRINT #1, name$
FOR y = 1 TO 30
a$ = ""
FOR x = 1 TO 30
a$ = a$ + CHR$(POINT(x, y) + 128)
LINE (x * 5 + 30, y * 5 + 30)-(x * 5 + 34, y * 5 + 34), POINT(x, y), BF
NEXT x
PRINT #1, a$
NEXT y
WRITE #1, hp, at, df, sp
WRITE #1, Weapon$, wp
WRITE #1, Armor$, ar
PRINT


CLOSE #1
RETURN


pic:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0
DATA 0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0
DATA 0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0
DATA 0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,3,7,7,7,3,3,3,3,3,3,3,3,3,7,7,7,3,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,3,2,2,2,3,3,3,3,3,3,3,3,3,2,2,2,3,3,3,3,3,3,3,0,0
DATA 0,0,3,3,3,7,2,2,2,7,3,3,3,3,3,3,3,7,2,2,2,7,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,7,2,2,2,7,3,3,3,3,3,3,3,7,2,2,2,7,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,7,2,2,2,7,3,3,3,3,3,3,3,7,2,2,2,7,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,3,7,7,7,3,3,2,3,2,3,2,3,3,7,7,7,3,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,3,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,3,3,3,3,3,3,0,0,0
DATA 0,0,3,3,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,3,3,3,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,3,2,3,2,3,2,3,2,3,2,3,5,5,5,3,2,3,2,3,2,3,2,3,2,3,0,0,0
DATA 0,0,0,3,3,2,3,2,3,2,3,2,5,5,5,5,5,2,3,2,3,2,3,2,3,3,3,0,0,0
DATA 0,0,0,3,3,2,3,2,3,2,3,2,5,2,5,2,5,2,3,2,3,2,3,2,3,3,0,0,0,0
DATA 0,0,0,0,3,3,3,2,3,2,3,2,3,2,5,2,3,2,3,2,3,2,3,2,3,0,0,0,0,0
DATA 0,0,0,0,0,3,3,2,7,2,3,2,3,2,3,2,3,2,7,2,3,2,3,3,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,3,3,2,3,2,3,2,3,2,3,2,3,2,3,2,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,3,0,3,0,3,0,3,0,0,0,0,0,0,0,0,0,0,0,0

SUB anim (hp%)
OUT &H3C8, 1
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(hp - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((hp + 20) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((hp + 40) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, ABS(((hp) MOD 64) * 2 - 63): OUT &H3C9, 0
OUT &H3C8, 80
FOR a = 0 TO 15         '80-95 Fire shades
OUT &H3C9, 32 + ((hp + a * 4) MOD 64 \ 2)
OUT &H3C9, ((hp + a * 4) MOD 64) * ((hp + a * 4) MOD 64) \ 64
OUT &H3C9, 0
NEXT a
END SUB

DEFSNG A-Z
SUB loadpal (filename$)
DIM pal(767)  AS STRING * 1
DEF SEG = VARSEG(pal(1))
BLOAD filename$, 0
DEF SEG
OUT &H3C8, 0
FOR a% = 3 TO 767
    OUT &H3C9, ASC(pal(a%))
NEXT a%
END SUB

SUB savePal (filename$)
DIM pal(767) AS STRING * 1
OUT &H3C8, 0
FOR a% = 0 TO 767
    pal(a%) = CHR$(INP(&H3C9))
NEXT a%
DEF SEG = VARSEG(pal(0))
BSAVE filename$, 0, 768
DEF SEG
END SUB

