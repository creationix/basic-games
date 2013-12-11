DECLARE SUB jump (x%, y%, n%, C%)

DEFINT A-Z


DIM Skill$(300)
OPEN "skills.lst" FOR INPUT AS #1
FOR a = 1 TO 300
INPUT #1, Skill$(a)

NEXT a
CLOSE #1

x1 = 200: y1 = 100: x2 = 60: y2 = 100
SCREEN 13
OUT &H3C8, 0
FOR a = 0 TO 15
    OUT &H3C9, a * 2 + 31
    OUT &H3C9, a * 2 + 31
    OUT &H3C9, a * 2 + 31
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, 63
    OUT &H3C9, a * 4
    OUT &H3C9, 0
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, a * 4
    OUT &H3C9, a * 4
    OUT &H3C9, 63
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, 63
    OUT &H3C9, 63
    OUT &H3C9, a * 4
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, a * 4
    OUT &H3C9, 63
    OUT &H3C9, a * 4
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, 0
    OUT &H3C9, a * 4
    OUT &H3C9, 0
NEXT a
PALETTE 0, 0
DIM shake(30 * 60)
DIM fire%(400, 5)
DIM fire2%(400, 5)
FOR n = 1 TO 5
    FOR b = 1 TO n * 40 + 10
    PSET (10 + n * 6 * RND - n * 3, 10 + n * 6 * RND - n * 3), 16 + 16 * RND
    NEXT b
    FOR x = 1 TO 20
    FOR y = 1 TO 20
    IF POINT(x, y) = 0 THEN PSET (x + 20, y), 255
    NEXT y
    NEXT x
    GET (1, 1)-(20, 20), fire%(0, n)
    GET (21, 1)-(40, 20), fire2%(0, n)
    LINE (0, 0)-(55, 30), 0, BF
NEXT n
DO
DEF SEG = &HA000
BLOAD "DIRT.PIC", 0

CIRCLE (x1, y1), 10
CIRCLE (x2, y2), 10
CIRCLE (x2 - 2, y2 - 2), 2
CIRCLE (x2 + 2, y2 - 2), 2
INPUT "test Which"; s
PRINT Skill$(s)
SELECT CASE s
CASE 1 'fire1
    FOR a = 1 TO 16
        x = x2 + 20 * RND - 10
        y = y2 + 20 * RND - 10
        C = 15 * RND
        FOR b = 1 TO 16
        C = (C + 1) MOD 16
        x = x + 2 * RND - 1
        PSET (x, y - b), 31 - C
        SOUND 37 + b * 4 * RND, .1
        NEXT b
    NEXT a
    anim = 100
    hurt = 50
CASE 2 'fire2
    FOR a = 1 TO 26
        x = x2 + 30 * RND - 15
        y = y2 + 30 * RND - 15
        C = 15 * RND
        FOR b = 1 TO 20
        C = (C + 1) MOD 16
        x = x + 2 * RND - 1
        PSET (x, y - b), 31 - C
        SOUND 37 + b * 4 * RND, .1
        NEXT b
    NEXT a
    anim = 150
    hurt = 80

CASE 3 'fire3
    FOR a = 1 TO 50
        x = x2 + 30 * RND - 15
        y = y2 + 30 * RND - 15
        C = 15 * RND
        FOR b = 1 TO 25
        C = (C + 1) MOD 16
        x = x + 2 * RND - 1
        PSET (x, y - b), 31 - C
        SOUND 37 + b * 4 * RND, .1
        NEXT b
    NEXT a
    anim = 200
    hurt = 120
CASE 4 'fire4
    FOR a = 1 TO 30
        x = x2 + 30 * RND - 15
        y = y2 + 30 * RND - 15
        C = 15 * RND
        FOR b = 1 TO 50
        C = (C + 1) MOD 16
        x = x + 4 * RND - 2
        PSET (x, y - b), 31 - C
        SOUND 37 + b * 4 * RND, .1
        NEXT b
    NEXT a
    anim = 300
    hurt = 200
CASE 5 'fire5
    FOR s = 1 TO 3
        FOR n = 1 TO 35
            x = x2 + 50 * RND - 35
            y = y2 + 50 * RND - 35
            IF x > 0 THEN PUT (x, y), fire2%(0, s), AND: PUT (x, y), fire%(0, s), XOR
            x = x + 10
            C = 15 * RND
            FOR b = 1 TO 16
                C = (C + 1) MOD 16
                x = x + 2 * RND - 1
                PSET (x, y - b), 31 - C
                SOUND 37 + b * 4 * RND, .1
            NEXT b
        NEXT n
    NEXT s
    anim = 400
    hurt = 340
CASE 6: 'fire6
    FOR s = 2 TO 4
        FOR n = 1 TO 40
            x = x2 + 50 * RND - 35
            y = y2 + 50 * RND - 35
            IF x > 0 THEN PUT (x, y), fire2%(0, s), AND: PUT (x, y), fire%(0, s), XOR
            x = x + 10
            C = 15 * RND
            FOR b = 1 TO 16
                C = (C + 1) MOD 16
                x = x + 2 * RND - 1
                PSET (x, y - b), 31 - C
                SOUND 37 + b * 4 * RND, .1
            NEXT b
        NEXT n
    NEXT s
    anim = 400
    hurt = 500
CASE 7: 'fire7
    FOR s = 3 TO 5
        FOR n = 1 TO 30
            x = x2 + 50 * RND - 35
            y = y2 + 50 * RND - 35
            IF x > 0 THEN PUT (x, y), fire2%(0, s), AND: PUT (x, y), fire%(0, s), XOR
            x = x + 10
            C = 15 * RND
            FOR b = 1 TO 16
                C = (C + 1) MOD 16
                x = x + 2 * RND - 1
                PSET (x, y - b), 31 - C
                SOUND 37 + b * 4 * RND, .1
            NEXT b
        NEXT n
    NEXT s
    anim = 400
    hurt = 1200
CASE 8 'ice1
    FOR a = 1 TO 70
        PSET (x2 + 20 * RND - 10, y2 + 20 * RND - 10), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
    NEXT a
    anim = 100
    hurt = 50

CASE 9 'ice2
    FOR a = 1 TO 140
        PSET (x2 + 30 * RND - 15, y2 + 30 * RND - 15), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
    NEXT a
    anim = 150
    hurt = 80

CASE 10 'ice3
    FOR a = 1 TO 200
        PSET (x2 + 40 * RND - 20, y2 + 40 * RND - 20), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
    NEXT a
    anim = 200
    hurt = 120
CASE 11 'ice4
    FOR a = 1 TO 250
        PSET (x2 + 40 * RND - 20, y2 + 60 * RND - 40), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
    NEXT a
    anim = 300
    hurt = 200
CASE 12 'ice5
FOR a = 1 TO 16
    PSET (x2, y2), a + 31
    FOR b = 1 TO a
        PSET (x2 + a * 2 * RND - a, y2 + a * 2 * RND - a), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
        PSET (x2 - b, y2), b + 31: PSET (x2 + b, y2), b + 31
        PSET (x2, y2 - b), b + 31: PSET (x2, y2 + b), b + 31
        PSET (x2 - b, y2 - b), b + 31: PSET (x2 + b, y2 - b), b + 31
        PSET (x2 - b, y2 + b), b + 31: PSET (x2 + b, y2 + b), b + 31
        PSET (x2 - b * 2, y2 - b), b + 31: PSET (x2 + b * 2, y2 - b), b + 31
        PSET (x2 - b * 2, y2 + b), b + 31: PSET (x2 + b * 2, y2 + b), b + 31
        PSET (x2 - b, y2 - b * 2), b + 31: PSET (x2 + b, y2 - b * 2), b + 31
        PSET (x2 - b, y2 + b * 2), b + 31: PSET (x2 + b, y2 + b * 2), b + 31
        PSET (x2 - b * 3, y2 - b), b + 31: PSET (x2 + b * 3, y2 - b), b + 31
        PSET (x2 - b * 3, y2 + b), b + 31: PSET (x2 + b * 3, y2 + b), b + 31
        PSET (x2 - b, y2 - b * 3), b + 31: PSET (x2 + b, y2 - b * 3), b + 31
        PSET (x2 - b, y2 + b * 3), b + 31: PSET (x2 + b, y2 + b * 3), b + 31
    NEXT b
    anim = 300
    hurt = 340

NEXT a
CASE 13 'ice6
FOR a = 1 TO 16
    PSET (x2, y2), a + 31
    FOR b = 1 TO a * 2
        PSET (x2 + a * 2 * RND - a, y2 + a * 2 * RND - a), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
        C = b \ 2
        PSET (x2 - b, y2), C + 31: PSET (x2 + b, y2), C + 31
        PSET (x2, y2 - b), C + 31: PSET (x2, y2 + b), C + 31
        PSET (x2 - b, y2 - b), C + 31: PSET (x2 + b, y2 - b), C + 31
        PSET (x2 - b, y2 + b), C + 31: PSET (x2 + b, y2 + b), C + 31
        PSET (x2 - b * 2, y2 - b), C + 31: PSET (x2 + b * 2, y2 - b), C + 31
        PSET (x2 - b * 2, y2 + b), C + 31: PSET (x2 + b * 2, y2 + b), C + 31
        PSET (x2 - b, y2 - b * 2), C + 31: PSET (x2 + b, y2 - b * 2), C + 31
        PSET (x2 - b, y2 + b * 2), C + 31: PSET (x2 + b, y2 + b * 2), C + 31
        PSET (x2 - b * 3, y2 - b), C + 31: PSET (x2 + b * 3, y2 - b), C + 31
        PSET (x2 - b * 3, y2 + b), C + 31: PSET (x2 + b * 3, y2 + b), C + 31
        PSET (x2 - b, y2 - b * 3), C + 31: PSET (x2 + b, y2 - b * 3), C + 31
        PSET (x2 - b, y2 + b * 3), C + 31: PSET (x2 + b, y2 + b * 3), C + 31
    NEXT b
NEXT a
    anim = 300
    hurt = 500

CASE 14 'ice7
FOR a = 1 TO 16
    PSET (x2, y2), a + 31
    FOR b = 1 TO a * 2
        PSET (x2 + a * 6 * RND - a * 3, y2 + a * 6 * RND - a * 3), 16 * RND + 32
        PSET (x2 + a * 6 * RND - a * 3, y2 + a * 6 * RND - a * 3), 16 * RND + 32
        PSET (x2 + a * 6 * RND - a * 3, y2 + a * 6 * RND - a * 3), 16 * RND + 32
        PSET (x2 + a * 6 * RND - a * 3, y2 + a * 6 * RND - a * 3), 16 * RND + 32
        IF a MOD 3 = 0 THEN SOUND 1000 + 2000 * RND, .4: SOUND 2000 + 200 * RND, .3
        C = b \ 2
        PSET (x2 - b, y2), C + 31: PSET (x2 + b, y2), C + 31
        PSET (x2, y2 - b), C + 31: PSET (x2, y2 + b), C + 31
        PSET (x2 - b, y2 - b), C + 31: PSET (x2 + b, y2 - b), C + 31
        PSET (x2 - b, y2 + b), C + 31: PSET (x2 + b, y2 + b), C + 31
        PSET (x2 - b * 2, y2 - b), C + 31: PSET (x2 + b * 2, y2 - b), C + 31
        PSET (x2 - b * 2, y2 + b), C + 31: PSET (x2 + b * 2, y2 + b), C + 31
        PSET (x2 - b, y2 - b * 2), C + 31: PSET (x2 + b, y2 - b * 2), C + 31
        PSET (x2 - b, y2 + b * 2), C + 31: PSET (x2 + b, y2 + b * 2), C + 31
        PSET (x2 - b * 3, y2 - b), C + 31: PSET (x2 + b * 3, y2 - b), C + 31
        PSET (x2 - b * 3, y2 + b), C + 31: PSET (x2 + b * 3, y2 + b), C + 31
        PSET (x2 - b, y2 - b * 3), C + 31: PSET (x2 + b, y2 - b * 3), C + 31
        PSET (x2 - b, y2 + b * 3), C + 31: PSET (x2 + b, y2 + b * 3), C + 31
    NEXT b
NEXT a
    anim = 300
    hurt = 1300

CASE 15 'bolt 1
y = 0
FOR a = 1 TO 2
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 60
    hurt = 60

CASE 16 'bolt 2
y = 0
FOR a = 1 TO 4
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 110
    hurt = 90

CASE 17 'bolt 3
y = 0
FOR a = 1 TO 6
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 160
hurt = 170
CASE 18 'bolt 4
y = 0
FOR a = 1 TO 8
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 200
    hurt = 300
CASE 19 'bolt 5
y = 0
FOR a = 1 TO 10
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 200
hurt = 400
CASE 20 'bolt 6
y = 0
FOR a = 1 TO 12
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 222
hurt = 500
CASE 21 'bolt 7
y = 0
FOR a = 1 TO 14
    x = x2 + 80 * RND - 40
    FOR C = 1 TO 20
    SOUND 37 + C * 20 * RND, .1
    NEXT C
    C = 16 * RND
    FOR b = 1 TO y2 + 40 * RND - 30
        x = x + 4 * RND - 2
        PSET (x, y + b), 48 + (b + C) MOD 16
        PSET (x + 1, y + b), 48 + (b + C + 1) MOD 16
        PSET (x - 1, y + b), 48 + (b + C + 2) MOD 16
        PSET (x, y + b + 1), 48 + (b + C + 3) MOD 16
        PSET (x, y + b - 1), 48 + (b + C + 4) MOD 16
    NEXT b
    FOR C = 30 TO 1 STEP -2
    SOUND 37 + C * 20 * RND, .1
    NEXT C

NEXT a
anim = 320
hurt = 800
CASE 22 'quake1
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR a = 1 TO 100
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
    ox = x: oy = y
    x = x2 - 15 + (a \ 4) * RND - a \ 8
    y = y2 - 45 + (a \ 8) * RND - a \ 16
    LINE (ox, oy)-(ox + 30, oy + 60), 0, BF
    IF x > 0 THEN PUT (x, y), shake, PSET
NEXT a
anim = 0
hurt = 200
CASE 23 'quake2
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR a = 1 TO 150
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
    ox = x: oy = y
    x = x2 - 15 + (a \ 4) * RND - a \ 8
    y = y2 - 45 + (a \ 8) * RND - a \ 16
    LINE (ox, oy)-(ox + 30, oy + 60), 0, BF
    IF x > 0 THEN PUT (x, y), shake, PSET
NEXT a
anim = 0
hurt = 450
CASE 24 'quake3
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR a = 1 TO 200
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
    ox = x: oy = y
    x = x2 - 15 + (a \ 4) * RND - a \ 8
    y = y2 - 45 + (a \ 8) * RND - a \ 16
    LINE (ox, oy)-(ox + 30, oy + 60), 0, BF
    IF x > 0 THEN PUT (x, y), shake, PSET
NEXT a
hurt = 700
anim = 0
CASE 25 'quake4
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR a = 1 TO 300
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
    ox = x: oy = y
    x = x2 - 15 + (a \ 4) * RND - a \ 8
    y = y2 - 45 + (a \ 8) * RND - a \ 16
    LINE (ox, oy)-(ox + 30, oy + 60), 0, BF
    IF x > 0 THEN PUT (x, y), shake, PSET
NEXT a
anim = 0
hurt = 1000
CASE 26 'cure1
FOR a = 1 TO 360 * 5 STEP 15
    PSET (x1, y1), a MOD 16 + 63
    v = a MOD 360
    u = a \ 80
    DRAW "ta=" + VARPTR$(v) + "bu=" + VARPTR$(u) + "l1"
    SOUND 2000 + a, .1
NEXT a
anim = 120
hurt = -30
CASE 27 'cure2
FOR a = 1 TO 360 * 9 STEP 15
    PSET (x1, y1), a MOD 16 + 63
    v = a MOD 360
    u = a \ 80
    DRAW "ta=" + VARPTR$(v) + "bu=" + VARPTR$(u) + "l1"
    SOUND 2000 + a, .1
NEXT a
anim = 120
hurt = -100

CASE 28 'cure3
FOR a = 1 TO 360 * 13 STEP 15
    PSET (x1, y1), a MOD 16 + 63
    v = a MOD 360
    u = a \ 80
    DRAW "ta=" + VARPTR$(v) + "bu=" + VARPTR$(u) + "l1"
    SOUND 2000 + a, .1
NEXT a
anim = 120
hurt = -260

CASE 29 'cure4
FOR a = 1 TO 360 * 13 STEP 15
    PSET (x1, y1), a MOD 16 + 63
    v = a MOD 360
    u = a \ 80
    DRAW "ta=" + VARPTR$(v) + "bu=" + VARPTR$(u) + "l1"
    SOUND 2000 + a, .1
NEXT a
anim = 120
hurt = -600

CASE 30 'heal
    FOR a = 10 TO 1 STEP -1
        FOR z = x1 - a TO x1 + a
            SOUND 1000 + a * 100, .1: SOUND 0, .1
            LINE (z, 0)-(z, y1), a + 65
        NEXT z
    NEXT a
anim = 120
hurt = 0
CASE 31
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR m = 1 TO 9
x = 160 * RND + 20
FOR y = 0 TO y2 STEP 4
LINE (x, y - 1)-(x + 20, y + 19), 0, BF
x = x - 3 * RND + 1
IF x > 0 THEN PUT (x, y), fire%(0, 5), PSET
    a = m * 14
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
NEXT y
FOR a = 1 TO 40
CIRCLE (x, y), a, 16 + a MOD 16
NEXT a
NEXT m
anim = 400
hurt = 6000

CASE 32 'white meteo
GET (x2 - 15, y2 - 45)-(x2 + 15, y2 + 15), shake
FOR m = 1 TO 9
x = 160 * RND + 20
FOR y = 0 TO y2 STEP 4
LINE (x, y - 1)-(x + 20, y + 19), 15, BF
x = x - 3 * RND + 1
IF x > 0 THEN PUT (x, y), fire%(0, 5), PRESET
    a = m * 14
    FOR C = 1 TO 5
    PSET (x2 + (a \ 2) * RND - a \ 4, y2 + (a \ 2) * RND - a \ 4), 6
    NEXT C
    SOUND 37 + 100 * RND, .1
NEXT y
FOR a = 1 TO 40
CIRCLE (x, y), a, a MOD 16
NEXT a
NEXT m
anim = 400
hurt = 9999
CASE 36
    FOR a = 1 TO 15
        LINE (x1, y1 + a - 8)-(x2, y2 + a - 8), a
    NEXT a
    FOR a = 0 TO 63
    SOUND 1000 + a * 100, .1
    SOUND 2000 + a * 70, .1
    SOUND 0, .1
    OUT &H3C8, 0
    OUT &H3C9, a
    OUT &H3C9, a
    OUT &H3C9, a
    NEXT a
    FOR a = 63 TO 0 STEP -1
    SOUND 1000 + a * 100, .1
    SOUND 2000 + a * 70, .1
    SOUND 0, .1
    OUT &H3C8, 0
    OUT &H3C9, a
    OUT &H3C9, a
    OUT &H3C9, a
    NEXT a
    anim = 0
    hurt = 800

END SELECT
IF hurt > 0 THEN jump x2, y2 - 40, hurt, 63
IF hurt < 0 THEN jump x1, y1 - 40, -hurt, 63 * 256

FOR h = 1 TO anim
G = (G + 1) MOD 63
OUT &H3C8, 1
FOR a = 1 TO 15
    OUT &H3C9, (a * 2 + G) MOD 32 + 31
    OUT &H3C9, (a * 2 + G) MOD 32 + 31
    OUT &H3C9, (a * 2 + G) MOD 32 + 31
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, 63
    OUT &H3C9, a * 4 + G
    OUT &H3C9, 0
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, a * 4 + G
    OUT &H3C9, a * 4 + G
    OUT &H3C9, 63
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, 32 + a * 2 + G
    OUT &H3C9, 32 + a * 2 + G
    OUT &H3C9, (a * 2 + G)
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, a * 4 + G
    OUT &H3C9, 63
    OUT &H3C9, a * 4 + G
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, (a + G \ 4) MOD 13
    OUT &H3C9, (a + G \ 4) MOD 13
    OUT &H3C9, (a + G \ 4) MOD 10
NEXT a

IF INKEY$ <> "" THEN EXIT FOR
NEXT h
anim = 30
hurt = 0
PALETTE 0, 0
LOOP

SUB jump (x, y, n, C)
DIM nm(400)
PALETTE 255, 0
COLOR 255
LINE (0, 0)-(60, 10), 0, BF
LOCATE 1, 1: PRINT n
GET (0, 0)-(40, 8), nm
LINE (0, 0)-(40, 8), 0, BF
PALETTE 255, C
FOR n = 1 TO 3
FOR a = 1 TO 5
LINE (x, y - a - 1)-(x + 40, y - a + 10), 0, BF
PUT (x, y - a), nm, PSET
SOUND 0, .3
NEXT a
FOR a = 6 TO 0 STEP -1
LINE (x, y - a - 1)-(x + 40, y - a + 10), 0, BF
PUT (x, y - a), nm, PSET
SOUND 0, .3
NEXT a
NEXT n
END SUB

SUB sLINE (x1, y1, x2, y2, C)
x3 = (x1 + x2) / 2 + 20 * RND - 10
y3 = (y1 + y2) / 2 + 20 * RND - 10
LINE (x1, y1)-(x3, y3), C
LINE (x2, y2)-(x3, y3), C
END SUB

