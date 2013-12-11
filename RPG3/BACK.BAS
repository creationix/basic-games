DECLARE SUB anim ()
DECLARE SUB jump (x%, y%, n%)
DEFINT A-Z

SCREEN 13
anim

'DEF SEG = &HA000
'BLOAD "grass.pic", 0


FOR a = 0 TO 3
LINE (a, 150 + a)-(319 - a, 199 - a), a * 4 + 3, B
NEXT a
FOR a = 0 TO 319
FOR B = 0 TO 149
PSET (a, B), 80 + 15 * RND
NEXT B
NEXT a



DEF SEG = &HA000
BSAVE "DIRT.pic", 0, 64000
DO
anim
LOOP

SUB anim
STATIC G AS INTEGER
G = (G + 1) MOD 63
OUT &H3C8, 1
FOR a = 1 TO 15
    OUT &H3C9, a * 2 + 31 + G
    OUT &H3C9, a * 2 + 31 + G
    OUT &H3C9, a * 2 + 31 + G
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
    OUT &H3C9, 63
    OUT &H3C9, 63
    OUT &H3C9, a * 4 + G
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, a * 4 + G
    OUT &H3C9, 63
    OUT &H3C9, a * 4 + G
NEXT a
FOR a = 0 TO 15
    OUT &H3C9, (a + G \ 4) MOD 16
    OUT &H3C9, (a + G \ 4) MOD 16
    OUT &H3C9, (a + G \ 4) MOD 16
NEXT a

END SUB

