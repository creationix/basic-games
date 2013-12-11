DECLARE SUB anim (hp%)
DEFINT A-Z
DECLARE SUB loadPal (filename$)
DECLARE SUB savePal (filename$)
SCREEN 13
FOR A = 0 TO 255                  'LINE (a, 0)-(a, 100), a
LINE (0, A)-(320, A), A
NEXT A
OUT &H3C8, 1
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 40   '1 glowing blue 1
OUT &H3C9, 0: OUT &H3C9, 10: OUT &H3C9, 30   '2 glowing blue 2
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 62   '3 glowing blue 3
OUT &H3C9, 0: OUT &H3C9, 50: OUT &H3C9, 0    '4 erie green
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '5
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '6
OUT &H3C9, 32: OUT &H3C9, 32: OUT &H3C9, 32   '7
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '8
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '9
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '10
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '11
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0    '12
OUT &H3C9, 50: OUT &H3C9, 25: OUT &H3C9, 0  '13 orange
OUT &H3C9, 40: OUT &H3C9, 40: OUT &H3C9, 20 '14 brown
OUT &H3C9, 63: OUT &H3C9, 63: OUT &H3C9, 63 '15 White
FOR A = 0 TO 15         '16-31 blue shades
OUT &H3C9, A * A * .2
OUT &H3C9, A * A * .2
OUT &H3C9, 16 + A * 3
NEXT A
FOR A = 0 TO 15         '32-47 red shades
OUT &H3C9, 16 + A * 3
OUT &H3C9, A * A * .2
OUT &H3C9, A * A * .2
NEXT A
FOR A = 0 TO 15         '48-63 green shades
OUT &H3C9, A * A * .2
OUT &H3C9, 16 + A * 3
OUT &H3C9, A * A * .2
NEXT A
FOR A = 0 TO 15         '64-79 gray shades
OUT &H3C9, A * 4
OUT &H3C9, A * 4
OUT &H3C9, A * 4
NEXT A
FOR A = 0 TO 15         '80-95 Fire shades
OUT &H3C9, 32 + ((A * 4) MOD 64 \ 2)
OUT &H3C9, ((A * 4) MOD 64) * ((A * 4) MOD 64) \ 64
OUT &H3C9, 0
NEXT A
FOR A = 0 TO 15         '96-127 Browns
OUT &H3C9, A * 4
OUT &H3C9, A * 2.3
OUT &H3C9, 0
NEXT A

DIM p(383)
OUT &H3C8, 0
FOR A = 0 TO 383
p(A) = INP(&H3C9)
NEXT A
OUT &H3C8, 128
FOR A = 0 TO 383
OUT &H3C9, p(A) / 1.5
NEXT A
savePal "game.pal"

'DO: LOOP WHILE INKEY$ = ""
CLS

LINE (48, 0)-(48, 140), 47
LINE (47, 0)-(47, 140), 44
LINE (46, 0)-(46, 140), 41
LINE (45, 0)-(45, 140), 38

LINE (271, 0)-(271, 140), 47
LINE (272, 0)-(272, 140), 44
LINE (273, 0)-(273, 140), 41
LINE (274, 0)-(274, 140), 38

FOR A = 0 TO 15
LINE (0, 141 + A)-(319, 141 + A), 31 - A
NEXT A
FOR Y = 0 TO 140
FOR X = 0 TO 44

C = (X + Y + (X MOD 5)) MOD 16 + 96
PSET (X, Y), C
PSET (319 - X, Y), C
NEXT X
C = (Y / 10 + RND * 2) + 32 + 16
LINE (49, Y)-(270, 140 - Y), C
LINE (49 + Y, Y)-(270 - Y, Y), C
LINE (49 + Y, 140 - Y)-(270 - Y, 140 - Y), C
NEXT Y
DEF SEG = &HA000
BSAVE "frame.pic", 0, 64000

DO: LOOP WHILE INKEY$ = ""

GOTO animate
CLS

title$ = "Shadow Falls"
sx = 160 - (LEN(title$) * 3 * 8) \ 2
COLOR 5

PRINT title$
FOR Y = 7 TO 0 STEP -1
FOR X = 0 TO LEN(title$) * 8 - 1
IF POINT(X, Y) > 0 THEN
FOR zx = -2 TO 1
FOR zy = -3 TO 3
PSET (sx + X * 3 + zx, 90 + Y * 6 + zy), INT(3 * RND) + 1
NEXT zy
NEXT zx
C = INT(16 * RND)
px = 8 * RND - 4
FOR sy = 0 TO 10 + 25 * RND
px = px + 4 * RND - 2
PSET (sx + X * 3 + px, 85 + Y * 6 - sy), 95 - ((C + sy) MOD 16)
NEXT sy
END IF
NEXT X
IF INKEY$ <> "" THEN Y = -1
NEXT Y
DEF SEG = &HA000
BSAVE "title.pic", 0, 64000
animate:
DO
hp = (hp + 1) MOD 64
anim hp
LOOP WHILE INKEY$ = ""

SUB anim (hp%)
OUT &H3C8, 1
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(hp - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((hp + 20) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((hp + 40) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, ABS(((hp) MOD 64) * 2 - 63): OUT &H3C9, 0
OUT &H3C8, 80
FOR A = 0 TO 15         '80-95 Fire shades
OUT &H3C9, 32 + ((hp + A * 4) MOD 64 \ 2)
OUT &H3C9, ((hp + A * 4) MOD 64) * ((hp + A * 4) MOD 64) \ 64
OUT &H3C9, 0
NEXT A

OUT &H3C8, 129
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ((ABS(hp - 32) + 31) MOD 64) \ 2
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ((ABS(((hp + 20) MOD 64) - 32) + 31) MOD 64) \ 2
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ((ABS(((hp + 40) MOD 64) - 32) + 31) MOD 64) \ 2
OUT &H3C9, 0: OUT &H3C9, ((ABS(((hp) MOD 64) * 2 - 63)) MOD 64) \ 2: OUT &H3C9, 0
OUT &H3C8, 80 + 128
FOR A = 0 TO 15         '80-95 Fire shades
OUT &H3C9, ((32 + ((hp + A * 4) MOD 64 \ 2)) MOD 64) \ 2
OUT &H3C9, ((((hp + A * 4) MOD 64) * ((hp + A * 4) MOD 64) \ 64) MOD 64) \ 2
OUT &H3C9, 0
NEXT A
PALETTE 128, 0
PALETTE 0, 0

END SUB

DEFSNG A-Z
SUB loadPal (filename$)
DIM pal(767)  AS STRING * 1
DEF SEG = VARSEG(pal(1))
BLOAD filename$, 0
DEF SEG
OUT &H3C8, 0
FOR A% = 3 TO 767
    OUT &H3C9, ASC(pal(A%))
NEXT A%
END SUB

SUB savePal (filename$)
DIM pal(767) AS STRING * 1
OUT &H3C8, 0
FOR A% = 0 TO 767
    pal(A%) = CHR$(INP(&H3C9))
NEXT A%
DEF SEG = VARSEG(pal(0))
BSAVE filename$, 0, 768
DEF SEG
END SUB

