TYPE SHOT
    X AS INTEGER
    Y AS INTEGER
    T AS INTEGER
    D AS INTEGER
END TYPE
TYPE MONSTER
    X AS INTEGER
    Y AS INTEGER
    T AS INTEGER
    D AS INTEGER
END TYPE
RANDOMIZE TIMER
DEFINT A-Y
JOY = 0
SP = 2000
SCREEN 9
OPEN "SORCERER.DAT" FOR INPUT AS #1
DIM C(4)
DIM m(50, 14), MS AS SHOT
DIM m$(5), SP$(5), ORDER(100)
C(1) = 11: C(2) = 12: C(3) = 13: C(4) = 14: GOSUB PALET:
DIM B1%(112), B2%(112), B3%(112), B4%(112), B5%(112), B6%(112), B7%(112), B8%(112)
DIM B9%(112), B10%(112), B11%(112), B12%(112), B13%(112), B14%(112), B15%(112), B16%(112)
DIM B17%(112), B18%(112), B19%(112), B20%(112), B21%(112), B22%(112), B23%(112)
DIM B24%(112), B25%(112), B26%(112), B27%(112), B28%(112), B29%(112), B30%(112), b43%(112), b44%(112), b45%(112), b46%(112), b47%(112)
DIM B31%(112), B32%(112), B33%(112), B34%(112), B35%(112), B36%(112), b37%(112), b38%(112), b39%(112), b40%(112), b41%(112), b42%(112)
DIM L(39, -3 TO 25), MN(20) AS MONSTER
SP$(1) = "Invisibility"
SP$(2) = "Iceball"
SP$(3) = "Magic Missile"
SP$(4) = "Ice Auroa"
SP$(5) = "Degentize"
FOR N = 1 TO 47
SX = 0
INPUT #1, A$
LINE (0, 0)-(30, 30), 0, BF
FOR AY = 1 TO 14
FOR AX = 1 TO 16
C = ASC(MID$(A$, AX + AY * 16 - 16, 1)) - 100
IF C > 0 THEN PSET (AX + SX, AY), C
NEXT AX
NEXT AY
X1 = 1 + SX: X2 = 16 + SX
IF N = 1 THEN GET (X1, 1)-(X2, 14), B1%
IF N = 2 THEN GET (X1, 1)-(X2, 14), B2%
IF N = 3 THEN GET (X1, 1)-(X2, 14), B3%
IF N = 4 THEN GET (X1, 1)-(X2, 14), B4%
IF N = 5 THEN GET (X1, 1)-(X2, 14), B5%
IF N = 6 THEN GET (X1, 1)-(X2, 14), B6%
IF N = 7 THEN GET (X1, 1)-(X2, 14), B7%
IF N = 8 THEN GET (X1, 1)-(X2, 14), B8%
IF N = 9 THEN GET (X1, 1)-(X2, 14), B9%
IF N = 10 THEN GET (X1, 1)-(X2, 14), B10%
IF N = 11 THEN GET (X1, 1)-(X2, 14), B11%
IF N = 12 THEN GET (X1, 1)-(X2, 14), B12%
IF N = 13 THEN GET (X1, 1)-(X2, 14), B13%
IF N = 14 THEN GET (X1, 1)-(X2, 14), B14%
IF N = 15 THEN GET (X1, 1)-(X2, 14), B15%
IF N = 16 THEN GET (X1, 1)-(X2, 14), B16%
IF N = 17 THEN GET (X1, 1)-(X2, 14), B17%
IF N = 18 THEN GET (X1, 1)-(X2, 14), B18%
IF N = 19 THEN GET (X1, 1)-(X2, 14), B19%
IF N = 20 THEN GET (X1, 1)-(X2, 14), B20%
IF N = 21 THEN GET (X1, 1)-(X2, 14), B21%
IF N = 22 THEN GET (X1, 1)-(X2, 14), B22%
IF N = 23 THEN GET (X1, 1)-(X2, 14), B23%
IF N = 24 THEN GET (X1, 1)-(X2, 14), B24%
IF N = 25 THEN GET (X1, 1)-(X2, 14), B25%
IF N = 26 THEN GET (X1, 1)-(X2, 14), B26%
IF N = 27 THEN GET (X1, 1)-(X2, 14), B27%
IF N = 28 THEN GET (X1, 1)-(X2, 14), B28%
IF N = 29 THEN GET (X1, 1)-(X2, 14), B29%
IF N = 30 THEN GET (X1, 1)-(X2, 14), B30%
IF N = 31 THEN GET (X1, 1)-(X2, 14), B31%
IF N = 32 THEN GET (X1, 1)-(X2, 14), B32%
IF N = 33 THEN GET (X1, 1)-(X2, 14), B33%
IF N = 34 THEN GET (X1, 1)-(X2, 14), B34%
IF N = 35 THEN GET (X1, 1)-(X2, 14), B35%
IF N = 36 THEN GET (X1, 1)-(X2, 14), B36%
IF N = 37 THEN GET (X1, 1)-(X2, 14), b37%
IF N = 38 THEN GET (X1, 1)-(X2, 14), b38%
IF N = 39 THEN GET (X1, 1)-(X2, 14), b39%
IF N = 40 THEN GET (X1, 1)-(X2, 14), b40%
IF N = 41 THEN GET (X1, 1)-(X2, 14), b41%
IF N = 42 THEN GET (X1, 1)-(X2, 14), b42%
IF N = 43 THEN GET (X1, 1)-(X2, 14), b43%
IF N = 44 THEN GET (X1, 1)-(X2, 14), b44%
IF N = 45 THEN GET (X1, 1)-(X2, 14), b45%
IF N = 46 THEN GET (X1, 1)-(X2, 14), b46%
IF N = 47 THEN GET (X1, 1)-(X2, 14), b47%
NEXT N
CLOSE #1
CLS
LEVEL = 1
DO
LOCATE 14, 20: COLOR 9: PRINT "1-Play Sorcerer"
LOCATE 16, 20: COLOR 9: PRINT "2-Edit a level"
LOCATE 18, 20: COLOR 12: PRINT "3-Exit the game"
LOCATE 20, 20: COLOR 9: PRINT "4-Test the level"
IF LEVEL < 1 THEN LEVEL = 100
IF LEVEL > 100 THEN LEVEL = 1
LOCATE 10, 23: COLOR 10: PRINT "Level"; LEVEL
DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "+" THEN LEVEL = LEVEL + 1
IF A$ = "-" THEN LEVEL = LEVEL - 1
IF A$ = "1" THEN GOSUB START: CLS : C(1) = 11: C(2) = 12: C(3) = 13: C(4) = 14: GOSUB PALET:
IF A$ = "2" THEN ED = 1: GOSUB edit: CLS : C(1) = 11: C(2) = 12: C(3) = 13: C(4) = 14: GOSUB PALET:
IF A$ = "4" THEN Lives = 20: JumpScore = 300 / 5: SC = 0: BONUS = 1600: cr = 1: GOSUB GO: CLS : C(1) = 11: C(2) = 12: C(3) = 13: C(4) = 14: GOSUB PALET:
IF A$ = "3" THEN RUN "\TIM\menu.bas"
ED = 0
LOOP
START:
FOR A = 1 TO 100
ORDER(A) = A
NEXT A
FOR A = 1 TO 99
SWAP ORDER(A), ORDER(INT(99 * RND + 1))
NEXT A
Lives = 20: JumpScore = 300 / 5: SC = 0: BONUS = 1600: cr = 1
PATH = 0
cr = 1
DO
PATH = PATH + 1
LEVEL = ORDER(PATH)
BONUS = 1600
GOSUB GO
IF Lives <= 0 THEN GOSUB THEEND: RETURN
LOOP WHILE PATH < 100 AND cr = 1
RETURN
GO:
MS.T = 0
HAVE = 0
SPELL = 0
IF Lives <= 0 THEN RETURN
GOSUB LOAD
IF STX = 0 THEN RETURN
FOR A = 1 TO 20
L(MN(A).X, MN(A).Y) = 0
NEXT A
X = STX: Y = STY
L(X, Y) = 0
LOCATE 24, 24: COLOR 7: PRINT "LEVEL:"; PATH;
LOCATE 24, 61: COLOR 15: PRINT "BONUS---------------";
LOCATE 23, 40: COLOR 12: PRINT "Extra Life"; JumpScore * 5;
LOCATE 23, 24: COLOR 14: PRINT "SCORE:"; SC * 5;
LOCATE 24, 40: COLOR 11: IF HAVE = 0 THEN COLOR 0
PRINT SP$(LSPELL);
DO: LOOP WHILE INKEY$ <> ""
j = 0
DO
BONUS = BONUS - 1
FOR A = 1 TO 10
IF Lives >= A THEN PUT (A * 16 - 8, 308), B19%, PSET ELSE LINE (A * 16 - 8, 308)-(A * 16 + 7, 321), 0, BF
IF Lives >= A + 10 THEN PUT (A * 16 - 8, 308 + 14), B19%, PSET ELSE LINE (A * 16 - 8, 308 + 14)-(A * 16 + 7, 321 + 14), 0, BF
NEXT A
LINE (639 - BONUS / 10 - 1, 308)-(479, 321), 0, BF
LINE (639 - BONUS / 10, 308)-(639, 321), 15, BF
IF X <> OX OR Y <> OY THEN LOCATE 23, 24: COLOR 14: PRINT "SCORE:"; SC * 5; : LOCATE 24, 40: COLOR 11: IF HAVE = 0 THEN COLOR 0
IF X <> OX OR Y <> OY THEN PRINT SP$(LSPELL);
IF SC >= JumpScore THEN JumpScore = JumpScore * 1.2 + 200: Lives = Lives + 1: LOCATE 23, 40: COLOR 12: PRINT "Extra Life"; JumpScore * 5;
GOSUB OTHERS: IF DD = 1 THEN GOTO GO
GOSUB MAGIC
DO: GOSUB FIRE: LOOP WHILE TIMER - zme < .04 AND zme < TIMER: DO: LOOP WHILE TIMER - zme < .05
zme = TIMER
A$ = INKEY$
DO: LOOP WHILE INKEY$ <> ""
OX = X: OY = Y
LV = L(X, Y)
LD = L(X, Y + 1)
s = 0
IF JOY = 1 THEN
JX = STICK(0) - 100
JY = STICK(1) - 100
B1 = STRIG(0)
IF JX < -20 THEN JX = -1 ELSE IF JX > 20 THEN JX = 1 ELSE JX = 0
IF JY < -20 THEN JY = -1 ELSE IF JY > 20 THEN JY = 1 ELSE JY = 0
END IF
IF LD = 1 OR LD = 4 OR LD = 5 OR LD = 6 OR LD = 8 OR LD = 26 OR LD = 27 OR LD = 28 THEN s = 1
IF LV = 8 OR LV = 9 OR LV = 26 OR LV = 27 OR LV = 28 THEN s = 2
IF A$ = "~" THEN cr = 0: RETURN
IF A$ = "q" THEN CHDIR "\TIM": RUN "MENU"
IF A$ = "8" THEN DIR = 1
IF A$ = "8" OR B1 THEN IF s = 1 THEN j = -3: A$ = INKEY$: FOR A = 1 TO SP / 4: NEXT A
IF A$ = "8" OR JY = -1 THEN IF s = 2 THEN Y = Y - 1: A$ = INKEY$: FOR A = 1 TO SP / 8: NEXT A
IF A$ = "2" OR JY = 1 THEN DIR = 3: IF s > 0 THEN Y = Y + 1
IF A$ = "4" OR JX = -1 THEN DIR = 4: X = X - 1
IF A$ = "6" OR JX = 1 THEN DIR = 2: X = X + 1
IF A$ = "+" OR B2 THEN IF HAVE > 0 THEN HAVE = HAVE - 1: GOSUB CAST
IF SPELL > 0 THEN SPELL = SPELL - 1
IF A$ = "*" THEN BONUS = 0
IF s = 0 AND j >= 0 THEN Y = Y + 1 ELSE IF j < 0 THEN j = j + 1: Y = Y - 1
IF X < 1 THEN X = 1
IF X > 38 THEN X = 38
IF Y > 21 THEN Y = 21
LV = L(X, Y)
LD = L(X, Y + 1)
GOSUB LL
IF X <> OX OR Y <> OY OR JJ = 0 THEN GOSUB UPDATE: IF X <> OX OR Y <> OY THEN JJ = 0
IF X = OX AND Y = OY AND JJ = 0 THEN JJ = 1
LV = L(X, Y)
GOSUB LL
IF BONUS <= 0 THEN GOTO EXPLOSION
IF LV = 29 THEN IF LSPELL = 1 AND SPELL > 0 THEN SPELL = SPELL - 20 ELSE GOTO POISIN
IF LV = 7 OR LV = 24 OR LV = 25 THEN IF LSPELL = 1 AND SPELL > 0 THEN SPELL = SPELL - 10 ELSE IF LSPELL = 4 AND SPELL > 0 THEN L(X, Y) = 0: SOUND 3000, .3: SOUND 1500, .3: SPELL = SPELL - 2 ELSE GOTO BURN
IF LSPELL = 4 AND SPELL > 0 AND MS.T <= 0 THEN MS.T = 1: MS.X = X: MS.Y = Y: MS.D = INT(4 * RND) + 1
IF LV = 10 THEN D = 2: GOSUB teleport
IF LV = 11 THEN D = 4: GOSUB teleport
IF LV = 12 THEN D = 3: GOSUB teleport
IF LV = 13 THEN D = 1: GOSUB teleport
IF LV = 18 AND KYE = 1 THEN
'*********************************************************
    FOR A = BONUS TO 0 STEP -30
    LINE (639 - A / 10 - 1, 308)-(479, 321), 0, BF
    LINE (639 - A / 10, 308)-(639, 321), 15, BF
    SC = SC + 1
    LOCATE 23, 24: COLOR 14: PRINT "SCORE:"; SC * 5;
    SOUND 500 + A * 10, .08: SOUND 1000 + A * 4, .08: SOUND 2000 + A, .08
    NEXT A
    KYE = 0
    RETURN
'*********************************************************
END IF
LV = L(X, Y)
GOSUB LL
LOOP

MAGIC:
IF MS.T > 0 THEN
    FOR G = 1 TO 3
        PX = MS.X: PY = MS.Y
        IF MS.D = 1 THEN MS.Y = MS.Y - 1
        IF MS.D = 2 THEN MS.X = MS.X + 1
        IF MS.D = 3 THEN MS.Y = MS.Y + 1
        IF MS.D = 4 THEN MS.X = MS.X - 1
        LL = MS.T + 45
        IF MS.X < 1 OR MS.X > 39 OR MS.Y < 1 OR MS.Y > 25 THEN MS.T = 0 ELSE IF MS.T = 1 AND (L(MS.X, MS.Y) = 24 OR L(MS.X, MS.Y) = 25 OR L(MS.X, MS.Y) = 7) THEN MS.T = 0: L(MS.X, MS.Y) = 0
        FOR A = 1 TO MST
            IF MN(A).X = MS.X AND MN(A).Y = MS.Y THEN MN(A).T = 0: MS.T = 0: GOSUB SCREAM: MN(A).X = 0: MN(A).Y = 0
        NEXT A
        GOSUB PP: IF MS.T > 0 THEN PX = MS.X: PY = MS.Y: L = LL: GOSUB PPP
    NEXT G
END IF
RETURN
CAST:
IF LSPELL = 1 THEN SPELL = 80: FOR A = 1 TO 5: SOUND 100 + A * 40, .6: SOUND 120 + A * 30, .8: NEXT A
IF LSPELL = 2 THEN IF SPELL <= 0 AND MS.T <= 0 THEN SPELL = 10: MS.X = X: MS.Y = Y: MS.T = 1: MS.D = DIR: SOUND 1000, .1: SOUND 500, .3: SOUND 100, .1
IF LSPELL = 3 THEN IF SPELL <= 0 AND MS.T <= 0 THEN SPELL = 10: MS.X = X: MS.Y = Y: MS.T = 2: MS.D = DIR: SOUND 500, .2: SOUND 200, .2: SOUND 37, .3
IF LSPELL = 4 THEN SPELL = 50: FOR A = 1 TO 10: SOUND A * 100, .1: NEXT A
IF LSPELL = 5 AND SPELL <= 0 THEN
    SPELL = 40: FOR A = 1 TO 8: PALETTE 0, 15: SOUND 1000, .1: PALETTE 0, 0: SOUND 500, .1: NEXT A
    FOR A = 1 TO MST
    IF MN(A).T > 1 AND RND > .6 THEN MN(A).T = 1: SOUND 300, .2: SOUND 600, .2
    IF MN(A).T = 1 AND RND > .7 THEN MN(A).T = 0: PX = MN(A).X: PY = MN(A).Y: L(PX, PY) = 15: GOSUB PP: SOUND 3000, .1
    NEXT A
END IF
SOUND 100, .1
RETURN
OTHERS:
DD = 0
FOR A = 1 TO MST
    IF MN(A).T > 0 THEN
        OMX = MN(A).X: OMY = MN(A).Y
        IF (MN(A).X = X AND MN(A).Y = Y) THEN IF LSPELL = 1 AND SPELL > 0 THEN SPELL = SPELL - 3 ELSE GOSUB killed: DD = 1
        IF MN(A).T < 4 OR MN(A).T = 5 THEN
            IF MN(A).T <> 5 THEN
                IF RND > .8 THEN MN(A).D = 1
                IF RND > .8 THEN MN(A).D = -1
            END IF
            IF MN(A).D = 0 THEN MN(A).D = -1 + CINT(RND) * 2
            IF L(MN(A).X + MN(A).D, MN(A).Y) = 1 THEN MN(A).D = -MN(A).D
            IF (L(MN(A).X + MN(A).D, MN(A).Y + 1) = 0 OR (L(MN(A).X + MN(A).D, MN(A).Y + 1) >= 10 AND L(MN(A).X + MN(A).D, MN(A).Y + 1) <= 24)) AND L(MN(A).X, MN(A).Y + 1) <> 6 THEN MN(A).D = 0
            IF L(MN(A).X, MN(A).Y + 1) = 2 OR L(MN(A).X, MN(A).Y + 1) = 4 THEN IF MN(A).D = 0 THEN MN(A).Y = OMY + 1: MN(A).D = 1
            IF L(MN(A).X, MN(A).Y + 1) = 3 OR L(MN(A).X, MN(A).Y + 1) = 5 THEN IF MN(A).D = 0 THEN MN(A).Y = OMY + 1: MN(A).D = -1
            MN(A).X = MN(A).X + MN(A).D
            IF MN(A).T = 2 AND RND > .96 AND L(MN(A).X, MN(A).Y) = 0 THEN L(MN(A).X, MN(A).Y) = 7
            IF MN(A).T = 3 AND RND > .5 AND NOT (LSPELL = 1 AND SPELL > 0) THEN
                IF X < MN(A).X THEN MN(A).D = -1
                IF X > MN(A).X THEN MN(A).D = 1
                IF L(MN(A).X, MN(A).Y) = 25 OR L(MN(A).X, MN(A).Y) = 26 OR L(MN(A).X, MN(A).Y) = 27 THEN IF Y > MN(A).Y THEN MN(A).Y = MN(A).Y + 1 ELSE IF Y < MN(A).Y THEN MN(A).Y = MN(A).Y - 1
            END IF
            LV = L(MN(A).X, MN(A).Y)
            LD = L(MN(A).X, MN(A).Y + 1)
            IF LD > 50 THEN LD = m(LD - 50, 1)
            IF LV = 2 OR LV = 4 OR LV = 3 OR LV = 5 OR LV = 6 THEN MN(A).Y = MN(A).Y - 1
            IF LV = 1 THEN MN(A).X = OMX: MN(A).Y = OMY
            IF LD = 30 OR LD = 0 OR LD = 7 OR LD = 29 OR (LD >= 10 AND LD <= 24) THEN MN(A).Y = OMY + 1: MN(A).D = 0
        END IF
        IF MN(A).T = 8 THEN
        MN(A).Y = MN(A).Y + 1
        IF MN(A).Y > 21 THEN MN(A).Y = 0: MN(A).X = INT(38 * RND + 2)
        END IF
        IF MN(A).T = 9 THEN
        MN(A).X = MN(A).X + 1
        IF MN(A).X > 38 THEN MN(A).X = 2: MN(A).Y = INT(23 * RND + 1)
        END IF
        IF MN(A).T = 6 THEN
        IF MN(A).D < 2 THEN MN(A).Y = MN(A).Y - 1 ELSE IF MN(A).D < 4 THEN MN(A).Y = MN(A).Y + 1
        MN(A).D = (MN(A).D + 1) MOD 5
        END IF
        IF MN(A).T = 7 THEN
        IF MN(A).D < 2 THEN MN(A).Y = MN(A).Y + 1 ELSE IF MN(A).D < 4 THEN MN(A).Y = MN(A).Y - 1
        MN(A).D = (MN(A).D + 1) MOD 5
        END IF
        IF MN(A).T = 4 THEN
            IF LSPELL = 1 AND SPELL > 0 AND RND > .4 THEN
                MN(A).D = INT(4 * RND + 1)
                IF MN(A).D = 1 THEN MN(A).X = MN(A).X - 1 ELSE IF MN(A).D = 2 THEN MN(A).X = MN(A).X + 1 ELSE IF MN(A).D = 3 THEN MN(A).Y = MN(A).Y - 1 ELSE IF MN(A).D = 4 THEN MN(A).Y = MN(A).Y + 1
            END IF
            IF RND > .6 AND NOT (LSPELL = 1 AND SPELL > 0) THEN
                IF RND > .3 AND X < MN(A).X THEN MN(A).D = 1
                IF RND > .3 AND Y < MN(A).Y THEN MN(A).D = 3
                IF RND > .3 AND X > MN(A).X THEN MN(A).D = 2
                IF RND > .3 AND Y > MN(A).Y THEN MN(A).D = 4
                IF MN(A).D = 1 THEN MN(A).X = MN(A).X - 1 ELSE IF MN(A).D = 2 THEN MN(A).X = MN(A).X + 1 ELSE IF MN(A).D = 3 THEN MN(A).Y = MN(A).Y - 1 ELSE IF MN(A).D = 4 THEN MN(A).Y = MN(A).Y + 1
            END IF
        END IF
        IF MN(A).Y < 1 THEN MN(A).Y = 1: MN(A).D = 0
        IF MN(A).Y > 23 THEN MN(A).Y = 23: MN(A).D = 0
        IF MN(A).X < 1 THEN MN(A).X = 1: MN(A).D = 0
        IF MN(A).X > 38 THEN MN(A).X = 38: MN(A).D = 0
        PX = OMX: PY = OMY: GOSUB PP
        IF MN(A).T > 0 THEN PX = MN(A).X: PY = MN(A).Y: L = MN(A).T + 36: GOSUB PPP
        IF (MN(A).X = X AND MN(A).Y = Y) THEN IF LSPELL = 1 AND SPELL > 0 THEN SPELL = SPELL - 3 ELSE GOSUB killed: DD = 1
    END IF
NEXT A
RETURN

SCREAM:
FOR SCR = 1 TO 5
SOUND 4000 + A, .1
SOUND 37 + A * 5, .1
SOUND 300 + A * 20, .1
SOUND 600 - A * 10, .1
SOUND 100 * A, .1
NEXT SCR
RETURN
FIRE:
P = INT(3 * RND) - 1
FOR PX = 1 + INT(4 * RND) TO 38 STEP 4
FOR PY = 1 + INT(4 * RND) TO 21 STEP 4
IF P = -1 THEN
IF L(PX, PY) = 7 THEN L = 7: GOSUB PPP
IF L(PX, PY) = 24 THEN L = 24: GOSUB PPP
IF L(PX, PY) = 25 THEN L = 25: GOSUB PPP
ELSE
IF L(PX, PY) = 7 THEN L = 31 + P: GOSUB PPP
IF L(PX, PY) = 24 THEN L = 33 + P: GOSUB PPP
IF L(PX, PY) = 25 THEN L = 35 + P: GOSUB PPP
END IF
NEXT PY
NEXT PX
RETURN


EXPLOSION:
BONUS = 1600
AX = PX * 16 + 8
AY = PY * 14 - 7
Lives = Lives - 1
FOR A = 10 TO 100 STEP 10
CIRCLE (AX, AY), A, 15
CIRCLE (AX, AY), A - 3, 14
CIRCLE (AX, AY), A - 6, 7
SOUND 37 + A * 2 * RND, .08: SOUND 100, 0
SOUND 370 + A * 200 * RND, .08: SOUND 100, 0
NEXT A
GOTO GO

BURN:
FOR A = 1 TO 50
AX = PX * 16 + 32 * RND - 8
AY = PY * 14 - 7 - 14 + 28 * RND
CIRCLE (AX, AY), 1, 14
CIRCLE (AX, AY), 2, 12
CIRCLE (AX, AY), 3, 4
CIRCLE (AX, AY), 4, 14
CIRCLE (AX, AY), 5, 12
CIRCLE (AX, AY), 6, 4
CIRCLE (AX + 1, AY), 1, 14
CIRCLE (AX + 1, AY), 2, 12
CIRCLE (AX + 1, AY), 3, 4
CIRCLE (AX + 1, AY), 4, 14
CIRCLE (AX + 1, AY), 5, 12
CIRCLE (AX + 1, AY), 6, 4
F = A * 3 * RND
FOR G = 1 TO 4
SOUND 37 + F + G * 5, .08
NEXT G
NEXT A
Lives = Lives - 1
GOTO GO


killed:
T = MN(A).T
FOR N = 1 TO 10
FOR F = 0 TO -30 STEP -1
IF Y * 14 - 14 + F >= 0 THEN
IF T = 1 THEN PUT (X * 16, Y * 14 - 14 + F), b37%, PSET
IF T = 2 THEN PUT (X * 16, Y * 14 - 14 + F), b38%, PSET
IF T = 3 THEN PUT (X * 16, Y * 14 - 14 + F), b39%, PSET
IF T = 4 THEN PUT (X * 16, Y * 14 - 14 + F), b40%, PSET
END IF
SOUND 250 + N * 40 + F * 8, .08

NEXT F
FOR F = -30 TO 0
IF Y * 14 - 14 + F >= 0 THEN
IF T = 1 THEN PUT (X * 16, Y * 14 - 14 + F), b37%, PSET
IF T = 2 THEN PUT (X * 16, Y * 14 - 14 + F), b38%, PSET
IF T = 3 THEN PUT (X * 16, Y * 14 - 14 + F), b39%, PSET
IF T = 4 THEN PUT (X * 16, Y * 14 - 14 + F), b40%, PSET
IF T = 5 THEN PUT (X * 16, Y * 14 - 14 + F), b41%, PSET
IF T = 6 THEN PUT (X * 16, Y * 14 - 14 + F), b42%, PSET
IF T = 7 THEN PUT (X * 16, Y * 14 - 14 + F), b43%, PSET
END IF
SOUND 250 + N * 40 + F * 8, .08
NEXT F
NEXT N
Lives = Lives - 1
RETURN

POISIN:
Lives = Lives - 1
AX = PX * 16 + 8
AY = PY * 14 - 7
FOR A = 1 TO 500
AX = AX + 4 * RND - 2
AY = AY + 4 * RND - 2
PSET (AX + 1, AY), 11
PSET (AX - 1, AY), 8
PSET (AX, AY + 1), 7
PSET (AX, AY - 2), 11
SOUND 100, .07: SOUND 200, .07: SOUND 100, 0
NEXT A
GOTO GO


MAC:

KX = X
KY = Y
X = m(s, 4)
Y = m(s, 5)
j = 5
FOR PY = Y - 1 TO Y + 1
FOR PX = X - 1 TO X + 1
j = j + 1
L(PX, PY) = m(s, j): GOSUB PP
IF m(s, j) > 36 AND m(s, j) < 50 THEN MST = MST + 1: MN(MST).X = PX: MN(MST).Y = PY: MN(MST).T = m(s, j) - 36: L(PX, PY) = 0
NEXT PX
NEXT PY
X = KX: Y = KY
RETURN
LL:
IF LV > 50 THEN s = LV - 50: GOSUB MAC: L(X, Y) = 0: FOR A = 1 TO 10: SOUND 500 + A * 10, .08: SOUND 3000 - A * 100, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 1
IF LV = 14 THEN L(X, Y) = 0: FOR A = 1 TO 10: SOUND 1000 + A * 10, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 2
IF LV = 15 THEN L(X, Y) = 0: FOR A = 5 TO 15: SOUND 1000 + A * 12, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 4
IF LV = 16 THEN L(X, Y) = 0: FOR A = 10 TO 20: SOUND 1000 + A * 14, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 8
IF LV = 17 THEN L(X, Y) = 0: FOR A = 15 TO 25: SOUND 1000 + A * 16, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 10
IF LV = 19 THEN L(X, Y) = 0: FOR A = 15 TO 25: SOUND 100 + A * 16, .08: NEXT A: KYE = 1: PX = X: PY = Y: GOSUB PP: SC = SC + 4: HAVE = HAVE + GOTT
IF LV = 30 THEN L(OX, OY) = 0: PX = OX: PY = OY: GOSUB PP: PX = OX - 1: PY = OY: GOSUB PP: PX = OX + 1: PY = OY: GOSUB PP: PX = OX: PY = OY - 1: GOSUB PP: X = STX: Y = STY: OX = X: OY = Y - 1: FOR A = 1 TO 10: SOUND 100 * A, .07: SOUND 30 * A + 300 _
, .07: NEXT A
IF LV = 1 THEN X = OX: Y = OY
IF LV = 4 THEN IF X < OX THEN Y = Y - 1 ELSE X = OX: Y = OY
IF LV = 5 THEN IF X > OX THEN Y = Y - 1 ELSE X = OX: Y = OY
IF LV = 6 THEN IF X <> OX THEN Y = Y - 1 ELSE X = OX: Y = OY
IF LV = 8 OR LV = 9 THEN IF A$ = "8" THEN Y = OY - 1: j = -3:  ELSE IF A$ = "2" THEN Y = OY + 1
IF LV = 2 THEN IF OY < Y THEN X = X + 1 ELSE X = OX: Y = OY
IF LV = 3 THEN IF OY < Y THEN X = X - 1 ELSE X = OX: Y = OY
IF OY <> Y AND OX = X THEN IF LV = 26 THEN X = X + 1 ELSE IF LV = 28 THEN X = X - 1
IF Y > OY THEN Y = OY + 1
IF Y < OY THEN Y = OY - 1
IF X < OX THEN X = OX - 1
IF X > OX THEN X = OX + 1
RETURN
teleport:
X = X: Y = Y
FOR A = 0 TO 7
LINE (X * 16 + A, Y * 14 - 14 + A)-(X * 16 + 15 - A, Y * 14 - 1 - A), 1 + CINT(RND) * 2 + CINT(RND) * 8, BF
SOUND 37 + A * 10, .08: SOUND 37 + A * 100, .08: SOUND 37 + A * 2, .08
NEXT A
PX = X: PY = Y: GOSUB PP
PX = X - 1: PY = Y: GOSUB PP
PX = X + 1: PY = Y: GOSUB PP
PX = X: PY = Y - 1: GOSUB PP
FF = -1
DO
IF D = 1 THEN Y = Y - 1
IF D = 2 THEN X = X + 1
IF D = 3 THEN Y = Y + 1
IF D = 4 THEN X = X - 1
IF Y < -1 THEN Y = -1: D = 0: FF = 1
IF L(X, Y) > 0 AND L(X, Y) < 7 AND FF = -1 THEN FF = 0
IF L(X, Y) <= 0 OR L(X, Y) >= 7 THEN IF FF = 0 THEN FF = 1
GOSUB UPDATE
GOSUB MAGIC
DO: GOSUB FIRE: LOOP WHILE TIMER - zme < .09
zme = TIMER
LV = L(X, Y)
IF LV > 50 THEN s = LV - 50: GOSUB MAC: L(X, Y) = 0: FOR A = 1 TO 10: SOUND 500 + A * 10, .08: SOUND 3000 - A * 100, .08: NEXT A: PX = X: PY = Y: GOSUB PP: SC = SC + 1
IF LV = 14 THEN L(X, Y) = 0: FOR A = 1 TO 10: SOUND 1000 + A * 10, .08: NEXT A: PX = X: PY = Y: GOSUB PP
IF LV = 15 THEN L(X, Y) = 0: FOR A = 5 TO 15: SOUND 1000 + A * 12, .08: NEXT A: PX = X: PY = Y: GOSUB PP
IF LV = 16 THEN L(X, Y) = 0: FOR A = 10 TO 20: SOUND 1000 + A * 14, .08: NEXT A: PX = X: PY = Y: GOSUB PP
IF LV = 17 THEN L(X, Y) = 0: FOR A = 15 TO 25: SOUND 1000 + A * 16, .08: NEXT A: PX = X: PY = Y: GOSUB PP
IF LV = 19 THEN L(X, Y) = 0: FOR A = 15 TO 25: SOUND 100 + A * 16, .08: NEXT A: KYE = 1: PX = X: PY = Y: GOSUB PP
IF LV = 10 THEN D = 2: GOSUB teleport
IF LV = 11 THEN D = 4: GOSUB teleport
IF LV = 12 THEN D = 3: GOSUB teleport
IF LV = 13 THEN D = 1: GOSUB teleport
OX = X: OY = Y
LOOP WHILE FF <> 1
DO: LOOP WHILE INKEY$ <> ""
j = 0
RETURN
UPDATE:
PX = OX - 1: PY = OY: GOSUB PP
PX = OX: PY = OY - 1: GOSUB PP
PX = OX: PY = OY: GOSUB PP
PX = OX + 1: PY = OY: GOSUB PP
PX = X: PY = Y
UPD:
X1 = PX * 16 + 2: Y1 = PY * 14 - 10
X2 = PX * 16 - 3: Y2 = PY * 14 - 8 + (OY - PY) * 3
X3 = PX * 16 + 14: Y3 = PY * 14 - 10
X4 = PX * 16 + 18: Y4 = PY * 14 - 8 + (OY - PY) * 3
LINE (X1, Y1)-(X2, Y2), 14
LINE (X3, Y3)-(X4, Y4), 14
LINE (PX * 16 + 4, PY * 14 - 6)-(PX * 16 + 5, PY * 14 - 1), 14, B
LINE (PX * 16 + 11, PY * 14 - 6)-(PX * 16 + 10, PY * 14 - 1), 14, B
CIRCLE (PX * 16 + 8, PY * 14 - 16), 4, 12
C = 4
IF LSPELL = 1 AND SPELL > 0 THEN C = 0
IF LSPELL = 4 AND SPELL > 0 THEN C = 11
IF LSPELL = 5 AND SPELL > 0 THEN C = INT(3 * RND) + 1
IF LSPELL = 2 AND SPELL > 0 THEN C = 12
IF LSPELL = 3 AND SPELL > 0 THEN C = 12
PAINT (PX * 16 + 8, PY * 14 - 16), C, 12
CIRCLE (PX * 16 + 8, PY * 14 - 9), 6, 12
PAINT (PX * 16 + 8, PY * 14 - 9), C, 12
CIRCLE (X2, Y2), 2, 12
CIRCLE (X4, Y4), 2, 12
LINE (OX * 16, 0)-(OX * 16 + 16, 0), 0
LINE (X * 16, 0)-(X * 16 + 16, 0), 15
RETURN
edit:
GOSUB LOAD
IF STX = 0 THEN STX = 1: GOSUB LEVEL
LL = 1
TT = 1
DO
OX = X: OY = Y
IF JOY = 1 THEN
JX = STICK(0) - 100
JY = STICK(1) - 100
B1 = STRIG(1)
B2 = STRIG(5)
IF ABS(JX) > 15 THEN ZX = ZX + JX / 80
IF ABS(JY) > 15 THEN ZY = ZY + JY / 80
X = ZX
Y = ZY
END IF
IF A$ = "q" THEN RUN "\tim\menu.bas"
IF A$ = "8" THEN Y = Y - 1
IF A$ = "4" THEN X = X - 1
IF A$ = "6" THEN X = X + 1
IF A$ = "2" THEN Y = Y + 1
IF A$ = "7" THEN Y = Y - 1: X = X - 1
IF A$ = "9" THEN Y = Y - 1: X = X + 1
IF A$ = "1" THEN Y = Y + 1: X = X - 1
IF A$ = "3" THEN Y = Y + 1: X = X + 1
IF MD = 0 THEN
IF A$ = "s" THEN GOSUB SAVE: X = OX: Y = OY
IF A$ = "l" THEN GOSUB LOAD: TT = 1
IF A$ = "c" THEN GOSUB CL
IF X < 1 THEN X = 1
IF Y < 1 THEN Y = 1
IF X > 38 THEN X = 38
IF Y > 21 THEN Y = 21
IF A$ = "P" THEN IF L(X, Y) < 50 THEN L(X, Y) = -1
IF A$ = "`" OR B1 = -1 THEN IF L(X, Y) < 50 THEN L(X, Y) = 0
IF A$ = "S" THEN GOSUB SPELLS
IF A$ = "Q" OR B2 = -1 THEN IF L(X, Y) < 50 THEN L(X, Y) = 1
IF A$ = "E" AND L(X, Y) < 50 THEN L(X, Y) = 2
IF A$ = "W" AND L(X, Y) < 50 THEN L(X, Y) = 3
IF A$ = "T" AND L(X, Y) < 50 THEN L(X, Y) = 4
IF A$ = "R" AND L(X, Y) < 50 THEN L(X, Y) = 5
IF A$ = "Y" AND L(X, Y) < 50 THEN L(X, Y) = 6
IF A$ = "U" AND L(X, Y) < 50 THEN L(X, Y) = 7
IF A$ = "I" AND L(X, Y) < 50 THEN L(X, Y) = 8
IF A$ = "O" AND L(X, Y) < 50 THEN L(X, Y) = 9
IF A$ = "A" THEN GOSUB ARCH
IF A$ = "H" THEN GOSUB LADDER
IF A$ = " " THEN L(X, Y) = LL
IF A$ = "~" THEN CLS : RETURN
IF A$ = "," THEN LL = LL - 1
IF A$ = "." THEN LL = LL + 1
IF A$ = "-" THEN LL = LL - 1
IF A$ = "+" THEN LL = LL + 1
IF A$ = "!" THEN C(1) = C(1) + 1: IF C(1) > 63 THEN C(1) = 0
IF A$ = "@" THEN C(2) = C(2) + 1: IF C(2) > 63 THEN C(2) = 0
IF A$ = "#" THEN C(3) = C(3) + 1: IF C(3) > 63 THEN C(3) = 0
IF A$ = "$" THEN C(4) = C(4) + 1: IF C(4) > 63 THEN C(4) = 0
IF A$ = "!" OR A$ = "@" OR A$ = "#" OR A$ = "$" THEN GOSUB PALET: A$ = ""
IF A$ = "m" THEN SFX = X: SFY = Y: IF L(X, Y) < 50 THEN MD = 1: KX = X: KY = Y: LL = L(X, Y): LINE (1, 348)-(638, 308), 0, BF: LOCATE 23, 28: COLOR 14: PRINT "Choose the affected area": A$ = ""
IF A$ = "M" AND L(X, Y) > 50 THEN s = L(X, Y) - 50: GOSUB TEST: A$ = ""
IF A$ = "m" AND L(X, Y) > 50 THEN SFX = X: SFY = Y: GOSUB LOOK: L = 0: A$ = "": X = SFX: Y = SFY
IF A$ = CHR$(0) + ";" AND L(X, Y) < 50 THEN L(X, Y) = 37
IF A$ = CHR$(0) + "<" AND L(X, Y) < 50 THEN L(X, Y) = 38
IF A$ = CHR$(0) + "=" AND L(X, Y) < 50 THEN L(X, Y) = 39
IF A$ = CHR$(0) + ">" AND L(X, Y) < 50 THEN L(X, Y) = 40
IF A$ = CHR$(0) + "?" AND L(X, Y) < 50 THEN L(X, Y) = 41
IF A$ = CHR$(0) + "@" AND L(X, Y) < 50 THEN L(X, Y) = 42
IF A$ = CHR$(0) + "A" AND L(X, Y) < 50 THEN L(X, Y) = 43
IF A$ = CHR$(0) + "B" AND L(X, Y) < 50 THEN L(X, Y) = 44
IF A$ = CHR$(0) + "C" AND L(X, Y) < 50 THEN L(X, Y) = 45
END IF
IF MD = 1 AND A$ = " " THEN MD = 0: TT = 1: GOSUB MACRO: X = SFX: Y = SFY
IF LL < 0 THEN LL = 30
IF LL > 30 THEN LL = 0
IF MD = 0 THEN
IF A$ = "," OR A$ = "." OR A$ = "-" OR A$ = "+" OR TT = 1 THEN
IF TT = 1 THEN LINE (1, 349)-(639, 308), 0, BF
TT = 0
LOCATE 22, 35: COLOR 15: PRINT "  Value:"; LL; " "
LOCATE 23, 40: COLOR 15: PRINT "<  >"
FOR A = -6 TO 6
PX = 20 + A * 3: PY = 24: L = LL + A
IF A = 0 THEN PY = 23
IF L < 0 THEN L = L + 31
IF L > 30 THEN L = L - 31
GOSUB PPP
NEXT A
END IF
END IF
IF OX <> X OR OY <> Y THEN PX = OX: PY = OY: GOSUB PP: ZX = X: ZY = Y
IF INT(TIMER * 8) <> INT(TIMER * 4) * 2 THEN PX = X: PY = Y: GOSUB PP
IF INT(TIMER * 8) = INT(TIMER * 4) * 2 THEN
IF MD = 0 THEN LINE (X * 16, Y * 14 - 14)-(X * 16 + 15, Y * 14 - 1), 15, BF
IF MD = 1 THEN LINE (X * 16, Y * 14 - 14)-(X * 16 + 15, Y * 14 - 1), 7, BF
IF MD = 1 THEN LINE (X * 16, Y * 14 - 14)-(X * 16 + 15, Y * 14 - 1), 15, B
END IF
A$ = INKEY$
GOSUB FIRE
LOOP
SPELLS:
HHOT:
CLS
COLOR 15
PRINT "Level"; LEVEL
PRINT "Macros"; mcn
COLOR 11
PRINT " # ", "x,y"
FOR A = 1 TO mcn
IF m(A, 2) = 0 AND m(A, 3) = 0 THEN m(A, 0) = 0
IF m(A, 0) > 0 THEN
    PRINT A, m(A, 2); m(A, 3)
END IF
NEXT A
COLOR 14
IF LSPELL < 0 THEN LSPELL = 1
PRINT "A. Current spell "; SP$(LSPELL)
IF GOTT < 1 THEN GOTT = 1
PRINT "B. Number gotten"; GOTT
PRINT "C. Done"
DO: A$ = INKEY$
IF A$ = "A" THEN COLOR 4: FOR A = 1 TO 5: PRINT A; SP$(A): NEXT A: COLOR 15: INPUT "SPELL"; LSPELL: GOTO HHOT
IF A$ = "B" THEN INPUT "NUMBER"; GOTT: GOTO HHOT
LOOP WHILE A$ <> "C"
GOTO LEVEL
TEST:
X = m(s, 4)
Y = m(s, 5)
j = 5
FOR PY = Y - 1 TO Y + 1
FOR PX = X - 1 TO X + 1
j = j + 1
L = m(s, j): GOSUB PPP
NEXT PX
NEXT PY
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
FOR PY = Y - 1 TO Y + 1
FOR PX = X - 1 TO X + 1
GOSUB PP
NEXT PX
NEXT PY
X = m(s, 2)
Y = m(s, 3)
RETURN
LOOK:
s = L(X, Y) - 50
LL = m(s, 1)
KX = m(s, 2)
KY = m(s, 3)
X = m(s, 4)
Y = m(s, 5)
L = 1
LINE (1, 348)-(638, 308), 0, BF
PX = 1: PY = 23: L = m(s, 6): GOSUB PPP
PX = 2: PY = 23: L = m(s, 7): GOSUB PPP
PX = 3: PY = 23: L = m(s, 8): GOSUB PPP
PX = 1: PY = 24: L = m(s, 9): GOSUB PPP
PX = 2: PY = 24: L = m(s, 10): GOSUB PPP
PX = 3: PY = 24: L = m(s, 11): GOSUB PPP
PX = 1: PY = 25: L = m(s, 12): GOSUB PPP
PX = 2: PY = 25: L = m(s, 13): GOSUB PPP
PX = 3: PY = 25: L = m(s, 14): GOSUB PPP
GOTO LLK
MACRO:
TT = 1
s = 0: DO: s = s + 1: LOOP WHILE m(s, 0) > 0
m(s, 0) = 1
mcn = 51: DO: mcn = mcn - 1: LOOP WHILE m(mcn, 0) = 0
L(KX, KY) = 50 + s
m(s, 0) = 1
m(s, 1) = LL
m(s, 2) = KX
m(s, 3) = KY
m(s, 4) = X
m(s, 5) = Y
j = 5
LINE (1, 348)-(638, 308), 0, BF
m(s, 6) = L(X - 1, Y - 1): PX = 1: PY = 23: L = m(s, 6): GOSUB PPP
m(s, 7) = L(X, Y - 1): PX = 2: PY = 23: L = m(s, 7): GOSUB PPP
m(s, 8) = L(X + 1, Y - 1): PX = 3: PY = 23: L = m(s, 8): GOSUB PPP
m(s, 9) = L(X - 1, Y): PX = 1: PY = 24: L = m(s, 9): GOSUB PPP
m(s, 10) = L(X, Y): PX = 2: PY = 24: L = m(s, 10): GOSUB PPP
m(s, 11) = L(X + 1, Y): PX = 3: PY = 24: L = m(s, 11): GOSUB PPP
m(s, 12) = L(X - 1, Y + 1): PX = 1: PY = 25: L = m(s, 12): GOSUB PPP
m(s, 13) = L(X, Y + 1): PX = 2: PY = 25: L = m(s, 13): GOSUB PPP
m(s, 14) = L(X + 1, Y + 1): PX = 3: PY = 25: L = m(s, 14): GOSUB PPP
LLK:
LINE ((X - 1) * 16, (Y - 1) * 14 - 14)-((X + 1) * 16 + 15, (Y + 1) * 14 - 1), 15, B
j = 10
DO
A$ = INKEY$
OKX = KX: OKY = KY: OJ = j
IF A$ = "7" THEN KX = 1: KY = 1: j = 6
IF A$ = "8" THEN KX = 2: KY = 1: j = 7
IF A$ = "9" THEN KX = 3: KY = 1: j = 8
IF A$ = "4" THEN KX = 1: KY = 2: j = 9
IF A$ = "5" THEN KX = 2: KY = 2: j = 10
IF A$ = "6" THEN KX = 3: KY = 2: j = 11
IF A$ = "1" THEN KX = 1: KY = 3: j = 12
IF A$ = "2" THEN KX = 2: KY = 3: j = 13
IF A$ = "3" THEN KX = 3: KY = 3: j = 14
IF A$ = "+" THEN m(s, j) = m(s, j) + 1: IF m(s, j) > 30 THEN m(s, j) = 0
IF A$ = "-" THEN m(s, j) = m(s, j) - 1: IF m(s, j) < 0 THEN m(s, j) = 30
IF A$ = CHR$(0) + ";" AND m(s, j) < 50 THEN m(s, j) = 37
IF A$ = CHR$(0) + "<" AND m(s, j) < 50 THEN m(s, j) = 38
IF A$ = CHR$(0) + "=" AND m(s, j) < 50 THEN m(s, j) = 39
IF A$ = CHR$(0) + ">" AND m(s, j) < 50 THEN m(s, j) = 40
IF A$ = CHR$(0) + "?" AND m(s, j) < 50 THEN m(s, j) = 41
IF A$ = CHR$(0) + "@" AND m(s, j) < 50 THEN m(s, j) = 42
IF A$ = CHR$(0) + "A" AND m(s, j) < 50 THEN m(s, j) = 43
IF A$ = CHR$(0) + "B" AND m(s, j) < 50 THEN m(s, j) = 44
IF A$ = CHR$(0) + "C" AND m(s, j) < 50 THEN m(s, j) = 45
IF A$ = "/" THEN m(s, j) = 0
IF A$ = "`" THEN FOR AA = -1 TO 1: FOR BB = -1 TO 1: PX = X + AA: PY = Y + BB: GOSUB PP: NEXT BB: NEXT AA: LINE (1, 348)-(638, 308), 0, BF: RETURN
IF A$ = "*" THEN FOR AA = -1 TO 1: FOR BB = -1 TO 1: PX = X + AA: PY = Y + BB: GOSUB PP: NEXT BB: NEXT AA: GOTO DEL
PX = OKX: PY = OKY + 22: L = m(s, OJ): GOSUB PPP
CIRCLE (KX * 16 + 8, KY * 14 + 294 + 7), 6, 14
CIRCLE (KX * 16 + 8, KY * 14 + 294 + 7), 3, 12
LOOP
DEL:
LOCATE 23, 30: COLOR 12: PRINT "Macro deleted"
SOUND 37, 1: SOUND 100, 1
DO: LOOP WHILE INKEY$ <> "": DO: LOOP WHILE INKEY$ = ""
L(KX, KY) = m(s, 1): PX = KX: PY = KY: GOSUB PP
FOR A = 0 TO 14
m(s, A) = 0
NEXT A
X = KX: Y = KY: LINE (1, 348)-(638, 308), 0, BF: RETURN
CL:
FOR PY = 1 TO 21
FOR PX = 1 TO 38
L(PX, PY) = 0: GOSUB PP
NEXT PX
NEXT PY
RETURN
LADDER:
IF X < 2 OR X > 37 THEN RETURN
L(X - 1, Y) = 26: PX = X - 1: PY = Y: GOSUB PP
L(X, Y) = 27: PX = X: GOSUB PP
L(X + 1, Y) = 28: PX = X + 1: GOSUB PP
RETURN
ARCH:
IF X < 2 OR Y > 20 OR Y > 20 THEN RETURN
L(X - 1, Y) = 21: PX = X - 1: PY = Y: GOSUB PP
L(X, Y) = 20: PX = X: GOSUB PP
L(X + 1, Y) = 22: PX = X + 1: GOSUB PP
L(X - 1, Y + 1) = 23: PX = X - 1: PY = Y + 1: GOSUB PP
L(X + 1, Y + 1) = 23: PX = X + 1: GOSUB PP
RETURN
SAVE:
GOSUB ADD
A$ = "Sorcerer.l" + ADD$
OPEN A$ FOR OUTPUT AS #1
FOR Y = 1 TO 21
A$ = ""
FOR X = 1 TO 38
A$ = A$ + CHR$(L(X, Y) + 100)
NEXT X
PRINT #1, A$
NEXT Y
FOR A = 1 TO 4
PRINT #1, C(A)
NEXT A
A = LSPELL * 10 + GOTT
PRINT #1, A, mcn
FOR A = 1 TO mcn
A$ = ""
FOR B = 0 TO 14
A$ = A$ + CHR$(m(A, B) + 100)
NEXT B
PRINT #1, A$
NEXT A
CLOSE #1
RETURN
LOAD:
GOSUB ADD
A$ = "Sorcerer.l" + ADD$
FOR A = 1 TO 20
    MN(A).X = 0: MN(A).Y = 0: MN(A).T = 0: MN(A).D = 0
NEXT A
MST = 0
FOR A = 1 TO 50
FOR B = 0 TO 10
m(A, B) = 0
NEXT B
NEXT A
OPEN A$ FOR INPUT AS #1
STX = 0: STY = 0
FOR Y = 1 TO 21
INPUT #1, A$
FOR X = 1 TO 38
L(X, Y) = ASC(MID$(A$, X, 1)) - 100
IF L(X, Y) = -1 THEN STX = X: STY = Y
IF L(X, Y) > 36 AND L(X, Y) < 50 THEN MST = MST + 1: MN(MST).X = X: MN(MST).Y = Y: MN(MST).T = L(X, Y) - 36
NEXT X
NEXT Y
FOR A = 1 TO 4
INPUT #1, C(A)
NEXT A
INPUT #1, A, mcn
GOTT = A MOD 10
LSPELL = A \ 10
FOR A = 1 TO mcn
INPUT #1, A$
FOR B = 1 TO 15
m(A, B - 1) = ASC(MID$(A$, B, 1)) - 100
NEXT B
NEXT A
CLOSE #1
GOTO LEVEL
LEVEL:
IF STX = 0 THEN RETURN
GOSUB PALET
CLS
FOR PY = 1 TO 21
FOR PX = 1 TO 38
GOSUB PP
NEXT PX
NEXT PY
FOR PX = 0 TO 39: L(PX, PY) = 1: GOSUB PP: NEXT PX
PY = 22
RETURN
PP:
IF PX < 0 OR PY < 1 OR PX > 39 OR PY > 25 THEN RETURN
L = L(PX, PY)
PPP:
IF PX < 0 OR PY < 1 OR PX > 39 OR PY > 25 THEN RETURN
SX = PX * 16: SY = PY * 14 - 14
ON L + 1 GOSUB B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23, B24, B25, B26, B27, B28, B29, B30, B31, B32, B33, B34, B35, B36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47
IF L = -1 THEN GOSUB B0: OX = PX: OY = PY: P = 1: GOSUB UPD
IF L >= 50 THEN ON m(L - 50, 1) + 1 GOSUB B0, B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15, B16, B17, B18, B19, B20, B21, B22, B23, B24, B25, B26, B27, B28, B29, B30, B30, B31, B32, B33, B34, B35, B36, b37, b38, b39, b40, b41,  _
b42, b43, b44, b45, b46, b47
IF L >= 50 AND ED = 1 THEN LINE (SX, SY)-(SX + 15, SY + 13), 15, B
RETURN
B0: LINE (SX, SY)-(SX + 15, SY + 13), 0, BF: RETURN
B1: PUT (SX, SY), B1%, PSET: RETURN
B2: PUT (SX, SY), B2%, PSET: RETURN
B3: PUT (SX, SY), B3%, PSET: RETURN
B4: PUT (SX, SY), B4%, PSET: RETURN
B5: PUT (SX, SY), B5%, PSET: RETURN
B6: PUT (SX, SY), B6%, PSET: RETURN
B7: PUT (SX, SY), B7%, PSET: RETURN
B8: PUT (SX, SY), B8%, PSET: RETURN
B9: PUT (SX, SY), B9%, PSET: RETURN
B10: PUT (SX, SY), B10%, PSET: RETURN
B11: PUT (SX, SY), B11%, PSET: RETURN
B12: PUT (SX, SY), B12%, PSET: RETURN
B13: PUT (SX, SY), B13%, PSET: RETURN
B14: PUT (SX, SY), B14%, PSET: RETURN
B15: PUT (SX, SY), B15%, PSET: RETURN
B16: PUT (SX, SY), B16%, PSET: RETURN
B17: PUT (SX, SY), B17%, PSET: RETURN
B18: PUT (SX, SY), B18%, PSET: RETURN
B19: PUT (SX, SY), B19%, PSET: RETURN
B20: PUT (SX, SY), B20%, PSET: RETURN
B21: PUT (SX, SY), B21%, PSET: RETURN
B22: PUT (SX, SY), B22%, PSET: RETURN
B23: PUT (SX, SY), B23%, PSET: RETURN
B24: PUT (SX, SY), B24%, PSET: RETURN
B25: PUT (SX, SY), B25%, PSET: RETURN
B26: PUT (SX, SY), B26%, PSET: RETURN
B27: PUT (SX, SY), B27%, PSET: RETURN
B28: PUT (SX, SY), B28%, PSET: RETURN
B29: PUT (SX, SY), B29%, PSET: RETURN
B30: PUT (SX, SY), B30%, PSET: RETURN
B31: PUT (SX, SY), B31%, PSET: RETURN
B32: PUT (SX, SY), B32%, PSET: RETURN
B33: PUT (SX, SY), B33%, PSET: RETURN
B34: PUT (SX, SY), B34%, PSET: RETURN
B35: PUT (SX, SY), B35%, PSET: RETURN
B36: PUT (SX, SY), B36%, PSET: RETURN
b37: PUT (SX, SY), b37%, PSET: RETURN
b38: PUT (SX, SY), b38%, PSET: RETURN
b39: PUT (SX, SY), b39%, PSET: RETURN
b40: PUT (SX, SY), b40%, PSET: RETURN
b41: PUT (SX, SY), b41%, PSET: RETURN
b42: PUT (SX, SY), b42%, PSET: RETURN
b43: PUT (SX, SY), b43%, PSET: RETURN
b44: PUT (SX, SY), b44%, PSET: RETURN
b45: PUT (SX, SY), b45%, PSET: RETURN
b46: PUT (SX, SY), b46%, PSET: RETURN
b47: PUT (SX, SY), b47%, PSET: RETURN
ADD:
LLT = LEVEL MOD 10
LTT = LEVEL \ 10
ADD$ = ""
IF LTT = 1 THEN ADD$ = ADD$ + "1"
IF LTT = 2 THEN ADD$ = ADD$ + "2"
IF LTT = 3 THEN ADD$ = ADD$ + "3"
IF LTT = 4 THEN ADD$ = ADD$ + "4"
IF LTT = 5 THEN ADD$ = ADD$ + "5"
IF LTT = 6 THEN ADD$ = ADD$ + "6"
IF LTT = 7 THEN ADD$ = ADD$ + "7"
IF LTT = 8 THEN ADD$ = ADD$ + "8"
IF LTT = 9 THEN ADD$ = ADD$ + "9"
IF LTT = 10 THEN ADD$ = ADD$ + "0"
IF LTT = 0 THEN ADD$ = ADD$ + "0"
IF LLT = 1 THEN ADD$ = ADD$ + "1"
IF LLT = 2 THEN ADD$ = ADD$ + "2"
IF LLT = 3 THEN ADD$ = ADD$ + "3"
IF LLT = 4 THEN ADD$ = ADD$ + "4"
IF LLT = 5 THEN ADD$ = ADD$ + "5"
IF LLT = 6 THEN ADD$ = ADD$ + "6"
IF LLT = 7 THEN ADD$ = ADD$ + "7"
IF LLT = 8 THEN ADD$ = ADD$ + "8"
IF LLT = 9 THEN ADD$ = ADD$ + "9"
IF LLT = 0 THEN ADD$ = ADD$ + "0"

RETURN
PALET:
C1 = C(1): C2 = C(1) - 1
IF C(1) = 0 THEN C1 = 7: C2 = 8
IF C(1) = 1 THEN C1 = 8: C2 = 15
PALETTE 1, C1
PALETTE 9, C2
C1 = C(2): C2 = C(2) - 1
IF C(2) = 0 THEN C1 = 7: C2 = 8
IF C(2) = 1 THEN C1 = 8: C2 = 15
PALETTE 2, C1
PALETTE 10, C2
C1 = C(3): C2 = C(3) - 1
IF C(3) = 0 THEN C1 = 7: C2 = 8
IF C(3) = 1 THEN C1 = 8: C2 = 15
PALETTE 6, C2
C1 = C(4): C2 = C(4) - 1
IF C(4) = 0 THEN C1 = 7: C2 = 8
IF C(4) = 1 THEN C1 = 8: C2 = 15
PALETTE 5, C1
PALETTE 13, C2
RETURN

THEEND:
FOR A = 100 TO 1 STEP -1
CIRCLE (320 * RND + 160, 150 + 50 * RND), A, 12
CIRCLE (320 * RND + 160, 150 + 50 * RND), A, 14
CIRCLE (320 * RND + 160, 150 + 50 * RND), A, 4
SOUND 37 + A, .08: SOUND 1037 - A * 10, .08: SOUND 100, 0
NEXT A
LOCATE 13, 33: COLOR 15: PRINT "T H E    E N D"
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
RETURN



