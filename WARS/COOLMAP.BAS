DEFINT A-Z
DIM p(24, 3), MP(24, 24)

SCREEN 12
FOR a = 1 TO 1000
S = 3 * RND
X = 640 * RND
Y = 400 * RND
PSET (X, Y), 15
PSET (X - 1, Y), 11
PSET (X + 1, Y), 11
PSET (X, Y - 1), 11
PSET (X, Y + 1), 11
PSET (X - 1, Y - 1), 9
PSET (X - 1, Y + 1), 9
PSET (X + 1, Y - 1), 9
PSET (X + 1, Y + 1), 9
PSET (X - S, Y), 3
PSET (X + S, Y), 3
PSET (X, Y - S), 3
PSET (X, Y + S), 3
PSET (X - S, Y - S), 1
PSET (X - S, Y + S), 1
PSET (X + S, Y - S), 1
PSET (X + S, Y + S), 1
NEXT a
OPEN "wars.dat" FOR INPUT AS #1
'N$(0) = "NONE       "
FOR a = 1 TO 20
INPUT #1, N$
NEXT a
FOR a = 1 TO 20
INPUT #1, N$
NEXT a
FOR a = 1 TO 24
INPUT #1, p(a, 1), p(a, 2)
FOR b = 1 TO 20
CIRCLE (p(a, 1), p(a, 2)), b, 11
CIRCLE (p(a, 1) + 1, p(a, 2)), b, 3
NEXT b

NEXT a
FOR a = 1 TO 20
INPUT #1, N, N, N, N
NEXT a
FOR a = 1 TO 24
    INPUT #1, p(a, 3)
NEXT a
FOR a = 1 TO 24
    FOR b = 1 TO 24
    INPUT #1, MP(a, b)
    NEXT b
NEXT a
FOR a = 1 TO 24
    FOR b = 1 TO 24
        IF (MP(a, b) <> 0 OR MP(b, a) <> 0) THEN
            FOR C = 1 TO 24
                IF (MP(C, a) <> 0 OR MP(a, C) <> 0) THEN
		    CALL TLINE (((p(a, 1) + p(b, 1)) \ 2), ((p(a, 2) + p(b, 2)) \ 2), ((p(a, 1) + p(C, 1)) \ 2), ((p(a, 2) + p(C, 2)) \ 2), 1)
                END IF
            NEXT C
	    CALL TLINE (((p(a, 1) * 2 + p(b, 1)) \ 3), ((p(a, 2) * 2 + p(b, 2)) \ 3), p(a, 1), p(a, 2), 3)
        END IF
    NEXT b
NEXT a
FOR a = 1 TO 24
FOR b = 1 TO 24
IF MP(a, b) THEN CALL TLINE (p(a, 1), p(a, 2), p(b, 1), p(b, 2), 2)
NEXT b
NEXT a
FOR a = 1 TO 24
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) + 24, p(a, 2), 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) - 24, p(a, 2), 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1), p(a, 2) + 24, 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1), p(a, 2) - 24, 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) + 19, p(a, 2) + 19, 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) + 19, p(a, 2) - 19, 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) - 19, p(a, 2) + 19, 4)
CALL TLINE (p(a, 1), p(a, 2), p(a, 1) - 19, p(a, 2) - 19, 4)
NEXT a
SCREEN , , 0
CLOSE #1

DIM tmp%(32000)
DEF SEG = VARSEG(tmp%(0))
GET (0, 0)-(319, 199), tmp%: BSAVE "map00.gfx", 0, 32000
GET (320, 0)-(639, 199), tmp%: BSAVE "map01.gfx", 0, 32000
GET (0, 200)-(319, 399), tmp%: BSAVE "map02.gfx", 0, 32000
GET (320, 200)-(639, 399), tmp%: BSAVE "map03.gfx", 0, 32000
DEF SEG

FUNCTION DISTANCE (X1, Y1, X2, Y2)
DISTANCE = SQR((X1 - X2) ^ 2) + SQR((Y1 - Y2) ^ 2)
END FUNCTION

SUB TLINE (X1, Y1, X2, Y2, C)
FOR Y = 2 TO -2 STEP -1
FOR X = 2 TO -2 STEP -1
LINE (X1 + X + 1, Y1 + Y + 1)-(X2 + X + 1, Y2 + Y + 1), C
LINE (X1 + X, Y1 + Y)-(X2 + X, Y2 + Y), C + 8
NEXT X
NEXT Y
END SUB

