DEFINT B-Z
RANDOMIZE TIMER
joy = 0
SCREEN 7
IF a = a + 1 THEN
'joy = 1
CLS
LINE (50, 50)-(150, 150), 8, BF
CIRCLE (100, 100), 0, 15
CIRCLE (100, 100), 1, 15
CIRCLE (100, 100), 2, 7
CIRCLE (100, 100), 3, 8
CIRCLE (101, 100), 0, 15
CIRCLE (101, 100), 1, 15
CIRCLE (101, 100), 2, 7
CIRCLE (101, 100), 3, 8
CIRCLE (101, 101), 0, 15
CIRCLE (101, 101), 1, 15
CIRCLE (101, 101), 2, 7
CIRCLE (101, 101), 3, 8
CIRCLE (100, 101), 0, 15
CIRCLE (100, 101), 1, 15
CIRCLE (100, 101), 2, 7
CIRCLE (100, 101), 3, 8
LOCATE 5, 1: COLOR 15: PRINT "Please center your joystick"
LOCATE 6, 5: PRINT "and press any key."
DO
OX = X: OY = Y
X = STICK(0) / 2 + 50
Y = STICK(1) / 2 + 50
CIRCLE (100, 100), 0, 15
CIRCLE (100, 100), 1, 15
CIRCLE (100, 100), 2, 7
CIRCLE (100, 100), 3, 8
CIRCLE (101, 100), 0, 15
CIRCLE (101, 100), 1, 15
CIRCLE (101, 100), 2, 7
CIRCLE (101, 100), 3, 8
CIRCLE (OX, OY), 0, 0
CIRCLE (OX, OY), 1, 0
CIRCLE (OX, OY), 2, 0
CIRCLE (OX, OY), 3, 0
CIRCLE (OX + 1, OY), 0, 0
CIRCLE (OX + 1, OY), 1, 0
CIRCLE (OX + 1, OY), 2, 0
CIRCLE (OX + 1, OY), 3, 0
CIRCLE (X, Y), 0, 15
CIRCLE (X, Y), 1, 12
CIRCLE (X, Y), 2, 4
CIRCLE (X, Y), 3, 8
CIRCLE (X + 1, Y), 0, 15
CIRCLE (X + 1, Y), 1, 12
CIRCLE (X + 1, Y), 2, 4
CIRCLE (X + 1, Y), 3, 8
LOOP WHILE INKEY$ = ""
END IF
TUR = 1
DIM T0%(560), T1%(560), T2%(560), T4%(140)
CLS
cop = INT(8 * RND)
DIM L(26, 21)
FOR T = -1 TO 2
RESTORE
CLS
FOR X = 1 TO 14
FOR Y = 1 TO 10
READ C
R = N
IF T <= 0 THEN GOTO L3
IF T > 0 THEN
CP = cop + T * 12
CP = CP MOD 16
IF C = 4 THEN C = 15 ELSE IF C > 0 THEN C = CP + C * 24 + 8 + RND
END IF
GOTO L4
L3:
IF C = 5 THEN C = 15
IF C = 1 THEN C = 7
IF C = 2 THEN C = 8
IF C = 3 THEN C = 1
IF C = 4 THEN C = 0
IF T = 0 THEN C = 0
L4:
L(X, Y) = C
NEXT Y
NEXT X
FOR X = 1 TO 14
FOR Y = 1 TO 10
C = L(X, Y)
PSET (X, Y), C MOD 16
NEXT Y
NEXT X
IF T = 0 THEN GET (1, 1)-(14, 10), T4%
IF T = 1 THEN GET (1, 1)-(14, 10), T1%
IF T = 2 THEN GET (1, 1)-(14, 10), T2%
IF T = -1 THEN GET (1, 1)-(14, 10), T0%
NEXT T
CLS

GOSUB 2

a$ = " "
cx = 15: cy = 10
3
IF a$ = " " THEN
LINE (5, 199)-(20, 0), 0, BF
LINE (5, 199)-(20, 199 - c1 * 2), 15, B
LINE (6, 199)-(20, 200 - c1 * 2), (cop + 4) MOD 8 + 8, B
LINE (6, 198)-(19, 200 - c1 * 2), (cop + 4) MOD 8, BF
FOR a = 2 TO 14 STEP 3
LINE (5 + a, 198)-(4 + a, 200 - c1 * 2), (cop + 4) MOD 8 + 1
NEXT a
LINE (25, 199)-(40, 0), 0, BF
LINE (25, 199)-(40, 199 - c2 * 2), 15, B
LINE (26, 199)-(40, 200 - c2 * 2), cop MOD 8 + 8, B
LINE (26, 198)-(39, 200 - c2 * 2), cop MOD 8, BF
FOR a = 2 TO 14 STEP 3
LINE (25 + a, 198)-(24 + a, 200 - c2 * 2), cop MOD 8 + 1
NEXT a

END IF
LOCATE 1, 1
IF M = 0 THEN PRINT "        "
IF M = 1 THEN PRINT "Moving  "
IF M = 2 THEN PRINT "Doubling"
LOCATE 1, 1
a$ = INKEY$
IF a$ = "q" THEN SYSTEM: SCREEN 0: WIDTH 80
IF joy = 1 AND TUR = 2 THEN
JX = STICK(0)
JY = STICK(1)
B1 = STRIG(0)
B2 = STRIG(4)
IF JX < 70 THEN cx = cx - 1
IF JX > 130 THEN cx = cx + 1
IF JY < 70 THEN cy = cy - 1
IF JY > 130 THEN cy = cy + 1
IF B1 = -1 THEN a$ = " "
IF B2 = -1 THEN a$ = "`"
END IF
IF TUR = 1 THEN
IF a$ = "8" THEN cy = cy - 1
IF a$ = "2" THEN cy = cy + 1
IF a$ = "4" THEN cx = cx - 1
IF a$ = "6" THEN cx = cx + 1
cx = INT(cx + .5)
cy = INT(cy + .5)
IF cx < 1 THEN cx = 1
IF cy < 1 THEN cy = 1
IF cx > 25 THEN cx = 25
IF cy > 20 THEN cy = 20
IF a$ = " " THEN IF M = 1 THEN GOSUB 4: M = 0: ' a$ = ""
IF a$ = " " THEN IF M = 2 THEN GOSUB 5: M = 0: ' a$ = ""
IF a$ = " " AND L(cx, cy) = TUR THEN IF M = 0 THEN M = 1: MX = cx: MY = cy
IF a$ = "*" AND L(cx, cy) = TUR THEN IF M = 0 THEN M = 2: MX = cx: MY = cy
END IF
IF TUR = 2 THEN
IF a$ = "W" THEN cy = cy - 1
IF a$ = "S" THEN cy = cy + 1
IF a$ = "A" THEN cx = cx - 1
IF a$ = "D" THEN cx = cx + 1
cx = INT(cx + .5)
cy = INT(cy + .5)
IF cx < 1 THEN cx = 1
IF cy < 1 THEN cy = 1
IF cx > 25 THEN cx = 25
IF cy > 20 THEN cy = 20

IF a$ = " " THEN IF M = 1 THEN GOSUB 4: M = 0: a$ = ""
IF a$ = " " THEN IF M = 2 THEN GOSUB 5: M = 0: a$ = ""
IF a$ = " " AND L(cx, cy) = TUR THEN IF M = 0 THEN M = 1: MX = cx: MY = cy
IF a$ = "`" AND L(cx, cy) = TUR THEN IF M = 0 THEN M = 2: MX = cx: MY = cy
END IF
cx = INT(cx + .5)
cy = INT(cy + .5)
IF cx < 1 THEN cx = 1
IF cy < 1 THEN cy = 1
IF cx > 25 THEN cx = 25
IF cy > 20 THEN cy = 20
X = cx: Y = cy: GOSUB 10
GOTO 3
4 IF L(cx, cy) <> 0 THEN M = 0: RETURN
L(MX, MY) = 0
X = MX: Y = MY: GOSUB 10
IF MX / 2 <> INT(MX / 2) THEN Y1 = MY * 10 - 10 ELSE Y1 = MY * 10 - 5
X1 = MX * 10 - 6 + 64 - 8
IF cx / 2 <> INT(cx / 2) THEN Y2 = cy * 10 - 10 ELSE Y2 = cy * 10 - 5
X2 = cx * 10 - 6 + 64 - 8
FOR a = 0 TO 1 STEP .05
SOUND 37 + a * 200, .1
SOUND 237 - a * 200, .1
OX3 = X3: OY3 = Y3
X3 = X2 * a + X1 * (1 - a)
Y3 = Y2 * a + Y1 * (1 - a)
IF TUR = 1 THEN
IF a > 0 THEN PUT (OX3, OY3), T1%
PUT (X3, Y3), T1%
END IF
IF TUR = 2 THEN
IF a > 0 THEN PUT (OX3, OY3), T2%
PUT (X3, Y3), T2%
END IF
NEXT a
IF TUR = 1 THEN PUT (X3, Y3), T1%
IF TUR = 2 THEN PUT (X3, Y3), T2%
L(cx, cy) = TUR
X = cx: Y = cy: GOSUB 10: GOSUB 6
IF TUR = 1 THEN TUR = 2 ELSE TUR = 1
RETURN
5 IF L(cx, cy) <> 0 THEN M = 0: RETURN
GM = 0
IF MX / 2 = INT(MX / 2) THEN TY = 2 ELSE TY = 1
IF cy = MY AND cx = MX + 1 THEN GM = 1
IF cy = MY AND cx = MX - 1 THEN GM = 1
IF cx = MX AND cy = MY + 1 THEN GM = 1
IF cx = MX AND cy = MY - 1 THEN GM = 1
IF TY = 1 AND cx = MX - 1 AND cy = MY - 1 THEN GM = 1
IF TY = 1 AND cx = MX + 1 AND cy = MY - 1 THEN GM = 1
IF TY = 2 AND cx = MX - 1 AND cy = MY + 1 THEN GM = 1
IF TY = 2 AND cx = MX + 1 AND cy = MY + 1 THEN GM = 1
IF GM = 0 THEN RETURN
FOR a = 0 TO 15
SOUND 37 + (15 - a) * 10, .2
NEXT a
L(cx, cy) = TUR
IF TUR = 1 THEN c1 = c1 + 1
IF TUR = 2 THEN c2 = c2 + 1
X = cx: Y = cy: GOSUB 6
IF TUR = 1 THEN TUR = 2 ELSE TUR = 1
FOR a = 0 TO 15
SOUND 37 + a * 10, .2
NEXT a
RETURN
6
IF INT(X) / 2 = INT(INT(X) / 2) THEN TY = 2 ELSE TY = 1
QX = X: QY = Y
FOR X = QX - 1 TO QX + 1
FOR Y = QY - 1 TO QY + 1
IF TY = 1 AND Y > QY AND X <> QX THEN GOTO 13
IF TY = 2 AND Y < QY AND X <> QX THEN GOTO 13
IF L(X, Y) = 2 AND TUR = 1 THEN L(X, Y) = 1: c2 = c2 - 1: c1 = c1 + 1: GOSUB 10
IF L(X, Y) = 1 AND TUR = 2 THEN L(X, Y) = 2: c1 = c1 - 1: c2 = c2 + 1: GOSUB 10
13
NEXT Y
NEXT X
X = QX: Y = QY
RETURN
2
FOR X = 1 TO 25
FOR Y = 1 TO 20
CL = 1
READ L
L(X, Y) = L - 1
GOSUB 10
IF L(X, Y) = 1 THEN c1 = c1 + 1
IF L(X, Y) = 2 THEN c2 = c2 + 1
NEXT Y
NEXT X
RETURN
10
IF X / 2 <> INT(X / 2) THEN SY = Y * 10 - 10 ELSE SY = Y * 10 - 5
SX = X * 10 - 6 + 64 - 8
IF SX + 14 > 320 OR SY + 10 > 200 THEN RETURN
IF CL = 0 THEN
'elay .05
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 8, BF: NEXT ZA
'elay .02
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 7, BF: NEXT ZA
'elay .02
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 15, BF: NEXT ZA
'elay .02
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 7, BF: NEXT ZA
'elay .02
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 8, BF: NEXT ZA
'elay .02
FOR ZA = 0 TO 4: LINE (SX + 4 - ZA, SY + ZA)-(SX + 9 + ZA, SY + 9 - ZA), 0, BF: NEXT ZA
END IF
CL = 0
IF L(X, Y) = -1 THEN PUT (SX, SY), T4%
IF L(X, Y) = 0 THEN PUT (SX, SY), T0%
IF L(X, Y) = 1 THEN PUT (SX, SY), T1%
IF L(X, Y) = 2 THEN PUT (SX, SY), T2%
RETURN
DATA 0,0,0,0,3,3,0,0,0,0
DATA 0,0,0,4,4,4,3,0,0,0
DATA 0,0,4,4,4,3,4,3,0,0
DATA 0,4,4,4,3,2,3,3,3,0
DATA 3,4,4,3,2,2,2,2,2,2
DATA 3,4,3,2,2,2,2,2,2,1
DATA 3,4,3,2,2,2,2,2,2,1
DATA 3,3,2,2,2,2,2,2,2,1
DATA 3,2,2,2,2,2,2,2,2,1
DATA 2,2,2,2,2,2,2,2,2,5
DATA 0,1,2,2,2,2,2,2,5,0
DATA 0,0,1,2,2,2,2,5,0,0
DATA 0,0,0,1,2,2,5,0,0,0
DATA 0,0,0,0,1,5,0,0,0,0
'
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA  0,0,0,2,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,1,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0
DATA  0,0,1,1,1,0,0,1,1,0,0,3,1,3,0,0,0,0,0,0
DATA 0,0,2,1,1,2,0,0,0,0,0,1,1,1,1,0,0,1,1,0
DATA  0,0,0,0,0,0,1,1,0,0,3,1,1,1,3,0,1,1,1,0
DATA 0,0,0,0,0,0,1,1,1,0,0,1,1,1,1,0,0,1,1,0
DATA  0,0,0,0,0,0,1,1,0,0,0,3,1,3,0,0,0,0,0,0
DATA 0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA  0,1,1,1,0,0,0,0,0,0,0,0,0,3,1,1,3,0,0,0
DATA 0,0,1,1,0,0,0,3,0,0,0,0,0,1,1,1,1,1,0,0
DATA  0,0,0,0,0,0,1,1,0,0,0,0,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,1,1,1,0,0,0,3,1,1,1,1,1,3,0
DATA  0,0,0,0,0,3,1,1,3,0,0,0,1,1,1,1,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,0,0
DATA  0,0,2,1,1,2,0,0,1,1,0,0,0,3,1,1,3,0,0,0
DATA 0,0,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0
DATA  0,1,1,1,1,1,1,0,1,1,0,2,1,2,0,0,0,0,0,0
DATA 0,2,1,1,1,1,1,2,0,0,0,1,1,1,1,0,0,0,0,0
DATA  0,1,1,1,1,1,1,0,0,0,2,1,1,1,2,0,1,1,0,0
DATA 0,0,1,1,1,1,1,0,0,0,0,1,1,1,1,0,1,1,1,0
DATA  0,0,2,1,1,2,0,0,0,0,0,2,1,2,0,0,1,1,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
'
DATA 0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0
DATA  0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0
DATA  0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,0,0
DATA 0,0,1,1,1,1,0,3,1,1,0,1,1,2,0,1,1,1,1,0
DATA  0,1,1,1,1,0,3,3,1,1,1,1,2,2,0,1,1,1,1,0
DATA 0,1,1,1,1,1,3,3,1,1,1,1,1,2,2,1,1,0,1,1
DATA  0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0
DATA 0,0,1,0,0,0,1,1,0,0,1,0,0,1,1,0,1,1,1,0
DATA  0,1,1,1,1,1,1,0,3,1,1,2,0,1,1,1,1,1,1,0
DATA 0,1,1,1,0,1,1,1,1,0,1,0,1,1,1,1,0,1,1,1
DATA  1,1,2,2,0,1,0,1,1,2,3,1,1,0,1,0,3,3,1,0
DATA 1,1,1,2,0,1,0,2,0,3,0,2,0,3,0,1,0,3,1,1
DATA  1,1,2,2,0,1,0,1,1,2,3,1,1,0,1,0,3,3,1,0
DATA 0,1,1,1,0,1,0,1,1,0,1,0,1,1,1,1,0,1,1,1
DATA  0,1,1,1,1,1,1,0,3,1,1,2,0,1,1,1,1,1,1,0
DATA 0,0,1,1,1,1,1,1,0,0,1,0,0,1,1,0,1,1,1,0
DATA  0,1,1,0,0,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0
DATA 0,1,1,0,0,0,3,3,1,1,1,1,1,2,2,0,0,0,1,1
DATA  0,1,1,1,1,0,3,3,1,1,1,1,2,2,0,1,1,1,1,0
DATA 0,0,1,1,1,1,0,3,1,1,0,1,1,2,0,1,1,1,1,0
DATA  0,0,0,0,1,1,0,1,1,0,0,1,1,0,1,1,0,0,0,0
DATA 0,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0
DATA  0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0

