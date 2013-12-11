DECLARE SUB font (X%, Y%, txt$, PT%, C%)
DECLARE SUB INIT ()
DECLARE SUB LEVEL (P%(), l%())
DECLARE SUB PAL (R%, g%, B%)
DEFINT A-Z
DIM l(17, 13)
DIM P(16800)
DIM SHARED T$(127)  'The Cool Font!

CALL INIT
DEF SEG = VARSEG(P(16800))
BLOAD "BANANA.PIC", 0
READ NAME$
FOR Y = 1 TO 12
FOR X = 1 TO 16
READ l(X, Y)
NEXT X
NEXT Y
CALL LEVEL(P(), l())
font 24, 24, "BANANA WORLD", 16, 0
font 22, 22, "BANANA WORLD", 16, 1
font 20, 20, "BANANA WORLD", 16, 2
font 18, 18, "BANANA WORLD", 16, 3
font 16, 16, "BANANA WORLD", 16, 4
font 14, 14, "BANANA WORLD", 16, 5
font 12, 12, "BANANA WORLD", 16, 6
font 10, 10, "BANANA WORLD", 16, 7
DO: LOOP WHILE INKEY$ = ""
LEVEL1:
DATA TEST
DATA 9,0,0,0,0,0,0,0,7,0,0,0,20,0,0,0
DATA 0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0
DATA 4,5,4,4,4,1,2,2,2,1,0,20,0,0,0,0
DATA 5,6,5,4,4,1,2,2,2,1,0,0,0,0,0,0
DATA 4,5,19,4,4,1,0,0,11,1,0,0,15,0,0,0
DATA 4,5,4,4,4,1,0,0,0,1,0,0,0,0,0,0
DATA 4,1,1,1,1,1,10,0,0,1,0,0,0,0,0,9
DATA 4,1,3,3,0,1,1,8,8,1,1,1,1,1,1,1
DATA 19,1,3,3,0,0,0,0,0,0,14,0,0,0,0,0
DATA 4,1,3,3,0,12,0,0,0,0,0,0,15,0,0,0
DATA 4,1,3,3,0,0,12,0,0,0,0,0,0,0,0,0
DATA 1,1,1,1,0,0,0,0,13,13,13,13,13,0,0,0

SUB font (X, Y, txt$, PT, C)
sz = PT * 4: SP = PT * 3 + 2
DRAW "S=" + VARPTR$(sz)
FOR R = 1 TO LEN(txt$)
l = ASC(MID$(txt$, R, 1))
cb = POINT(X + R * SP - SP, Y + SP)
sh = 2
F = PT \ 4 - 1
IF PT < 3 THEN sh = 1
PSET (X - F - 1 + R * SP - SP, Y + SP - F - 1), cb: DRAW "c0" + T$(l)
PSET (X - F - 1 + R * SP - SP, Y + SP + F + 1), cb: DRAW "c0" + T$(l)
PSET (X + F + 1 + R * SP - SP, Y + SP - F - 1), cb: DRAW "c0" + T$(l)
PSET (X + F + 1 + R * SP - SP, Y + SP + F + 1), cb: DRAW "c0" + T$(l)
IF (X + R * 13 - 6) > 640 THEN EXIT FOR
NEXT R
FOR R = 1 TO LEN(txt$)
l = ASC(MID$(txt$, R, 1))
cb = POINT(X + R * SP - SP, Y + SP)
FOR A = -F TO F
FOR B = -F TO F
PSET (A + X + R * SP - SP, B + Y + SP), cb: DRAW "c=" + VARPTR$(C) + T$(l)
NEXT B
NEXT A
IF (X + R * 13 - 6) > 640 THEN EXIT FOR
NEXT R
END SUB

SUB INIT
SCREEN 12
OPEN "font1.fon" FOR INPUT AS #1
FOR A = 0 TO 127
INPUT #1, T$(A)
NEXT A
CLOSE #1
OUT &H3C8, 0
FOR A = 0 TO 7
OUT &H3C9, SQR(A) * 23
OUT &H3C9, SQR(A) * 23
OUT &H3C9, SQR(A) * 23
NEXT A
CALL PAL(63, 63, 0)   'L YELLOW     8
CALL PAL(30, 30, 0)   'D YELLOW     9
CALL PAL(0, 10, 63)   'WATER        10
CALL PAL(0, 20, 53)   'WATER        11
CALL PAL(53, 25, 10)  'BROWN        12
CALL PAL(0, 63, 0)    'GREEN        13
CALL PAL(0, 33, 0)    'GREEN        14
CALL PAL(43, 10, 0)    'RED        15
END SUB

SUB LEVEL (P(), l())
FOR X = 1 TO 16
FOR Y = 1 TO 12
n = l(X, Y) * 800
PUT (X * 40 - 40, Y * 40 - 40), P(n), PSET
NEXT Y
NEXT X
END SUB

SUB PAL (R, g, B)
OUT &H3C9, R
OUT &H3C9, g
OUT &H3C9, B
END SUB

