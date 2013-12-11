DEFINT A-Z
RANDOMIZE (TIMER)
SCREEN 12
DIM c1%(400), c2%(400), c3%(400), c4%(400), G%(200)
DIM t1%(1000), t2%(1000), t3%(1000), t4%(1000)
FOR N = 1 TO 4
FOR A = 1 TO 20
CIRCLE (19, 10), A, N + 8, , , 1 / 2
CIRCLE (21, 10), A, 15, , , 1 / 2
CIRCLE (20, 10), A, N, , , 1 / 2
NEXT A
IF N = 1 THEN GET (0, 0)-(39, 19), c1%
IF N = 2 THEN GET (0, 0)-(39, 19), c2%
IF N = 3 THEN GET (0, 0)-(39, 19), c3%
IF N = 4 THEN GET (0, 0)-(39, 19), c4%
NEXT N
CLS
FOR N = 1 TO 4
FOR A = 1 TO 40
CIRCLE (20, 39), A, N + 8, , , 2 / 1
CIRCLE (20, 41), A, 15, , , 2 / 1
CIRCLE (20, 40), A, N, , , 2 / 1
NEXT A
IF N = 1 THEN GET (0, 0)-(39, 79), t1%
IF N = 2 THEN GET (0, 0)-(39, 79), t2%
IF N = 3 THEN GET (0, 0)-(39, 79), t3%
IF N = 4 THEN GET (0, 0)-(39, 79), t4%
NEXT N
DIM L(33, 25)
lv = INT(30 * RND + 1)
IF lv = 1 THEN add$ = "01"
IF lv = 2 THEN add$ = "02"
IF lv = 3 THEN add$ = "03"
IF lv = 4 THEN add$ = "04"
IF lv = 5 THEN add$ = "05"
IF lv = 6 THEN add$ = "06"
IF lv = 7 THEN add$ = "07"
IF lv = 8 THEN add$ = "08"
IF lv = 9 THEN add$ = "09"
IF lv = 10 THEN add$ = "10"
IF lv = 11 THEN add$ = "11"
IF lv = 12 THEN add$ = "12"
IF lv = 13 THEN add$ = "13"
IF lv = 14 THEN add$ = "14"
IF lv = 15 THEN add$ = "15"
IF lv = 16 THEN add$ = "16"
IF lv = 17 THEN add$ = "17"
IF lv = 18 THEN add$ = "18"
IF lv = 19 THEN add$ = "19"
IF lv = 20 THEN add$ = "20"
IF lv = 21 THEN add$ = "21"
IF lv = 22 THEN add$ = "22"
IF lv = 23 THEN add$ = "23"
IF lv = 24 THEN add$ = "24"
IF lv = 25 THEN add$ = "25"
IF lv = 26 THEN add$ = "26"
IF lv = 27 THEN add$ = "27"
IF lv = 28 THEN add$ = "28"
IF lv = 29 THEN add$ = "29"
IF lv = 30 THEN add$ = "30"
OPEN "\tim\conquest\conquest.l" + add$ FOR INPUT AS #1
ctn = 0
FOR gy = 1 TO 20
INPUT #1, A$
FOR gx = 1 TO 32
px = gx: py = gy
L = ASC(MID$(A$, gx, 1)) - 100
L(gx, gy) = L
IF L > ctn THEN ctn = L
NEXT gx
NEXT gy
CLOSE #1
REDIM C(ctn, 10)
REDIM ct(ctn, ctn)
FOR A = 1 TO ctn
C(A, 4) = 32
C(A, 5) = 32
C(A, 6) = 1
C(A, 7) = 1
NEXT A
FOR gy = 1 TO 20
FOR gx = 1 TO 32
L = L(gx, gy)
C(L, 1) = C(L, 1) + 1
ct(L, L(gx - 1, gy)) = ct(L, L(gx - 1, gy)) + 1
ct(L, L(gx + 1, gy)) = ct(L, L(gx + 1, gy)) + 1
ct(L, L(gx, gy - 1)) = ct(L, L(gx, gy - 1)) + 1
ct(L, L(gx, gy + 1)) = ct(L, L(gx, gy + 1)) + 1
IF gx < C(L, 4) THEN C(L, 4) = gx
IF gy < C(L, 5) THEN C(L, 5) = gy
IF gx > C(L, 6) THEN C(L, 6) = gx
IF gy > C(L, 7) THEN C(L, 7) = gy
NEXT gx
NEXT gy
CR = 1
pn = 2
DO
LOCATE 26, 11: COLOR 15: PRINT "Select player number and press 'space'"
PUT (0, 400), c1%, PSET
PUT (0, 420), c2%, PSET
LINE (0, 440)-(40, 480), 0, BF
IF pn > 2 THEN PUT (0, 440), c3%, PSET
IF pn = 4 THEN PUT (0, 460), c4%, PSET
IF pn = 2 THEN PUT (40, 400), t2%, PSET
IF pn = 3 THEN PUT (40, 400), t3%, PSET
IF pn = 4 THEN PUT (40, 400), t4%, PSET
DO: A$ = INKEY$: LOOP WHILE A$ = ""
IF A$ = "2" THEN pn = 2
IF A$ = "3" THEN pn = 3
IF A$ = "4" THEN pn = 4
IF A$ = " " THEN CR = 0
LOOP WHILE CR = 1
FOR q = 1 TO pn
FOR G = 1 TO 5
t = 0
DO
DO
A = INT(ctn * RND) + 1
LOOP WHILE C(A, 2) > 0 OR C(A, 1) < 5
FOR j = 1 TO ctn
IF ct(A, j) > 0 AND C(j, 2) > 0 THEN CR = 1
NEXT j
t = t + 1
LOOP WHILE t < 50 AND CR = 1

C(A, 2) = 2 ^ (G - 1)
C(A, 3) = 0
NEXT G
NEXT q
FOR q = 1 TO pn
G = INT(5 * RND) + 1
DO
A = INT(ctn * RND) + 1
LOOP WHILE C(A, 2) > 0 AND C(A, 1) < 5
C(A, 2) = 2 ^ (G - 1)
C(A, 3) = 0
NEXT q
GOSUB level
GOSUB CLAR:
mn = -2: PT = 1: GOSUB TURN
mn = 0: GOTO go
chose:
PT = 0
h = 0
DO
DO
TH = TH + 1
PT = PT + 1
mn = -1
GOSUB TURN
IF TH = ctn THEN PT = pn
LOOP WHILE PT < pn
PT = 0
LOOP WHILE TH < ctn
PLAY "mb l8 o2 acdo4acdo2acd"
RETURN
rand:
TH = 0
DO
FOR d = 1 TO pn
IF d = 1 THEN PUT (40, 400), t1%, PSET
IF d = 2 THEN PUT (40, 400), t2%, PSET
IF d = 3 THEN PUT (40, 400), t3%, PSET
IF d = 4 THEN PUT (40, 400), t4%, PSET
TH = TH + 1
q = 0
DO
q = q + 1
DO
G = INT(ctn * RND) + 1
LOOP WHILE C(G, 0) <> 0
CR = 1
t = 0
FOR A = 1 TO ctn
IF ct(A, G) > 0 AND A <> G AND d = C(A, 0) THEN t = 1
NEXT A
IF C(G, 2) > 0 AND t = 1 THEN CR = 0
IF C(G, 2) > 0 AND q > 20 THEN CR = 0
IF t = 1 THEN IF q > 50 THEN CR = 0
IF q > 100 THEN CR = 0
LOOP WHILE CR = 1
C(G, 0) = d
di = G: GOSUB CITY
IF TH = ctn THEN d = pn
NEXT d
LOOP WHILE TH < ctn
RETURN
go:
PT = INT(4 * RND)
DO: PT = PT + 1
IF PT > pn THEN GOSUB UPDATE: PT = 1
FL = 2: mn = 0: OMN = -1
s = 0
FOR A = 1 TO ctn
IF C(A, 0) = PT THEN s = 1
NEXT A
IF s = 1 THEN GOSUB TURN
LOOP
UPDATE:
FOR A = 1 TO ctn
FOR B = 1 TO 10
C(A, B) = ABS(C(A, B))
NEXT B
NEXT A
FOR A = 1 TO ctn
rc = 1
FOR E = 1 TO ctn
IF C(E, 3) > 0 AND ct(A, E) AND C(E, 0) = C(A, 0) THEN rc = 2
NEXT E
B = C(A, 0)
G = C(A, 2)
FOR C = 0 TO 4
X(C) = INT(G / 2 ^ C) MOD 2
NEXT C
GD(B) = GD(B) + X(0) * rc
PS(B) = PS(B) + X(1) * rc
i(B) = i(B) + X(2) * rc
CO(B) = CO(B) + X(3) * rc
t(B) = t(B) + X(4) * rc
NEXT A
RETURN
CLAR:
 LINE (80, 400)-(639, 479), 0, BF: RETURN
TURN:
PUT (0, 400), c1%, PSET
PUT (0, 420), c2%, PSET
LINE (0, 440)-(40, 480), 0, BF
IF pn > 2 THEN PUT (0, 440), c3%, PSET
IF pn = 4 THEN PUT (0, 460), c4%, PSET
IF PT = 1 THEN PUT (40, 400), t1%, PSET
IF PT = 2 THEN PUT (40, 400), t2%, PSET
IF PT = 3 THEN PUT (40, 400), t3%, PSET
IF PT = 4 THEN PUT (40, 400), t4%, PSET
IF DX < 1 THEN DX = 1
IF DY < 1 THEN DY = 1
IF DX > 32 THEN DX = 32
IF DY > 20 THEN DY = 20
GET (DX * 20 - 20, DY * 20 - 20)-(DX * 20 - 1, DY * 20 - 1), G%
CR = 1
OMN = -100
DO
A$ = INKEY$
ODX = DX: ODY = DY
IF A$ = "q" THEN RUN "\tim\menu.bas"
IF A$ = "G" THEN GOSUB GOLD
IF A$ = "C" THEN GOSUB COAL
IF A$ = "F" THEN GOSUB FLT
IF A$ = "8" OR A$ = "W" THEN DY = DY - 1
IF A$ = "4" OR A$ = "A" THEN DX = DX - 1
IF A$ = "6" OR A$ = "D" THEN DX = DX + 1
IF A$ = "2" OR A$ = "S" THEN DY = DY + 1
IF A$ = "Z" THEN A$ = ","
IF A$ = "X" THEN A$ = "."
IF A$ = "." THEN mc = mc + 1
IF A$ = "," THEN mc = mc - 1
IF A$ = "`" THEN A$ = " "
IF mn = 0 THEN
s(PT) = 0
FOR A = 1 TO ctn
IF C(A, 2) >= 32 AND C(A, 0) = PT THEN s(PT) = 1
NEXT A
IF s(PT) = 0 THEN
mn = -6: GOSUB TURN: A$ = "": CR = 1: mn = 0
IF C(L(DX, DY), 2) < 32 THEN C(L(DX, DY), 2) = C(L(DX, DY), 2) + 32
di = L(DX, DY): GOSUB CITY
CR = 1
END IF
END IF
IF OMN = mn AND A$ <> "." AND A$ <> "," AND A$ <> " " THEN GOTO SKIP
IF mn = -1 THEN mxc = 1
IF mn = -2 THEN mxc = 2
IF mn = -3 THEN mxc = 4
IF mn = -4 THEN mxc = 4
IF mn = -5 THEN mxc = 5
IF mn = -6 THEN mxc = 1
IF mn = 0 THEN mxc = 6
IF mn = 1 THEN mxc = 5
IF mn = 2 THEN mxc = 6
IF mn = 3 THEN mxc = 3
IF mn = 4 THEN mxc = 4
IF mn = 5 THEN mxc = 2
IF mn = 7 THEN mxc = 1
IF mn = 8 THEN mxc = 1
IF mn = 10 THEN mxc = 7
IF mc < 1 THEN mc = mxc
IF mc > mxc THEN mc = 1
IF OMN <> mn THEN GOSUB CLAR
OMN = mn
IF mn = 10 THEN
COLOR 7: IF mc = 1 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 27, 11: PRINT "Add cell"
COLOR 7: IF mc = 2 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 28, 11: PRINT "Remove cell"
COLOR 7: IF mc = 3 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 27, 31: PRINT "New country"
COLOR 7: IF mc = 4 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 28, 31: PRINT "Erase country"
COLOR 7: IF mc = 5 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 27, 51: PRINT "Save Map"
COLOR 7: IF mc = 6 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 28, 51: PRINT "Load Map"
COLOR 7: IF mc = 7 THEN COLOR 15: ' IF A$ = " " THEN
LOCATE 28, 71: PRINT "Exit"
END IF
IF mn = -6 THEN
LOCATE 27, 14: COLOR 12: PRINT "LOCATE STOCKPILE! "; : COLOR PT + 8: PRINT "PLAYER"; PT
IF A$ = " " THEN IF C(L(DX, DY), 0) = PT THEN RETURN
END IF
IF mn = -2 THEN
COLOR 7: IF mc = 1 THEN COLOR 15: IF A$ = " " THEN GOSUB chose: RETURN
LOCATE 27, 11: PRINT "Chose Countries"
COLOR 7: IF mc = 2 THEN COLOR 15: IF A$ = " " THEN GOSUB rand: RETURN
LOCATE 28, 11: PRINT "Random Contries"
END IF
IF mn = -1 THEN
IF A$ = " " THEN IF C(L(DX, DY), 0) = 0 AND L(DX, DY) <> 0 THEN C(L(DX, DY), 0) = PT: di = L(DX, DY): GOSUB CITY: RETURN
LOCATE 27, 14: COLOR 15: PRINT "Press space when on country"
END IF
IF mn = 0 THEN
COLOR 7: IF mc = 1 THEN COLOR 15: IF A$ = " " THEN mn = 1
LOCATE 27, 11: PRINT "Building Menu"
COLOR 7: IF mc = 2 THEN COLOR 15: IF A$ = " " THEN mn = 2
LOCATE 28, 11: PRINT "Moving Menu"
COLOR 7: IF mc = 3 THEN COLOR 15: IF A$ = " " THEN mn = 3
LOCATE 27, 30: PRINT "Info Menu"
COLOR 7: IF mc = 4 THEN COLOR 15: IF A$ = " " THEN CR = 0
LOCATE 28, 30: PRINT "End turn"
COLOR 7: IF mc = 5 THEN COLOR 15: IF A$ = " " THEN CR = 2
LOCATE 27, 50: PRINT "Save Game"
COLOR 7: IF mc = 6 THEN COLOR 15: IF A$ = " " THEN CR = 3
LOCATE 28, 50: PRINT "Load Game"
A$ = ""
END IF
IF mn = 1 THEN
LOCATE 26, 11: COLOR 15: PRINT "Gold"; GD(PT)
LOCATE 26, 21: COLOR 15: PRINT "Pasture"; PS(PT)
LOCATE 26, 31: COLOR 15: PRINT "Iron"; i(PT)
LOCATE 26, 41: COLOR 15: PRINT "Coal"; CO(PT)
LOCATE 26, 51: COLOR 15: PRINT "Timber"; t(PT)
COLOR 7: IF mc = 1 THEN COLOR 15:  IF A$ = " " THEN GOSUB HORSE: CR = 1:
LOCATE 27, 11: PRINT "Raise Horse"
COLOR 7: IF mc = 2 THEN COLOR 15: IF A$ = " " THEN GOSUB BOAT: CR = 1
LOCATE 28, 11: PRINT "Build boat"
COLOR 7: IF mc = 3 THEN COLOR 15:   IF A$ = " " THEN GOSUB WEAPON: CR = 1
LOCATE 27, 31: PRINT "Build weapon"
COLOR 7: IF mc = 4 THEN COLOR 15: IF A$ = " " THEN GOSUB BCITY: CR = 1
LOCATE 28, 31: PRINT "Build citY"
COLOR 7: IF mc = 5 THEN COLOR 15:  IF A$ = " " THEN mn = 0
LOCATE 27, 51: PRINT "Return to Main Menu"
LOCATE 26, 11: COLOR 15: PRINT "Gold"; GD(PT)
LOCATE 26, 21: COLOR 15: PRINT "Pasture"; PS(PT)
LOCATE 26, 31: COLOR 15: PRINT "Iron"; i(PT)
LOCATE 26, 41: COLOR 15: PRINT "Coal"; CO(PT)
LOCATE 26, 51: COLOR 15: PRINT "Timber"; t(PT)
A$ = ""
END IF
IF mn = 7 THEN
COLOR 15:  IF A$ = " " THEN WT = L(DX, DY): RETURN
LOCATE 27, 11: PRINT "Where to"
END IF
IF mn = 2 THEN
COLOR 7: IF mc = 1 THEN COLOR 15:  IF A$ = " " THEN GOSUB mhorse: CR = 1
LOCATE 27, 11: PRINT "Move Horse"
COLOR 7: IF mc = 2 THEN COLOR 15:  IF A$ = " " THEN GOSUB mboat: CR = 1
LOCATE 28, 11: PRINT "Move Boat"
COLOR 7: IF mc = 3 THEN COLOR 15:  IF A$ = " " THEN GOSUB mweapon: CR = 1
LOCATE 27, 31: PRINT "Move Weapon"
IF FL > 0 THEN COLOR 7 ELSE COLOR 8
IF mc = 4 THEN COLOR 15: IF A$ = " " AND FL > 0 THEN GOSUB attack: CR = 1
LOCATE 28, 31: PRINT "Attack Enemy!"
COLOR 7: IF mc = 5 THEN COLOR 15:  IF A$ = " " THEN mn = 0
LOCATE 27, 51: PRINT "Return to Main Menu"
IF FL = 1 THEN COLOR 7 ELSE COLOR 8
IF mc = 6 THEN COLOR 15: IF A$ = " " AND FL = 1 THEN GOSUB MOVESTOCK: CR = 1: FL = FL - 1
LOCATE 28, 51: PRINT "Move Stockpile"
A$ = ""
END IF
IF mn = 3 THEN
COLOR 7: IF mc = 1 THEN COLOR 15: ' IF a$ = " " THEN go
LOCATE 27, 11: PRINT "Count Neighbors"
COLOR 7: IF mc = 2 THEN COLOR 15:  IF A$ = " " THEN di = L(DX, DY): IF di > 0 THEN GOSUB FORCE:
LOCATE 28, 11: PRINT "Count Strength"
COLOR 7: IF mc = 3 THEN COLOR 15:  IF A$ = " " THEN mn = 0
LOCATE 27, 31: PRINT "Return to Main Menu"
A$ = ""
END IF
IF mn = 8 THEN
LOCATE 26, 12: COLOR 14: PRINT "Bring boat from where"
LOCATE 27, 12: COLOR 14: PRINT "Hit water to cancel"
IF A$ = " " THEN WT = L(DX, DY): RETURN
END IF
IF mn = 5 THEN
LOCATE 26, 12: COLOR 14: PRINT t$
COLOR 7: IF mc = 1 THEN COLOR 15:  IF A$ = " " THEN ch = 1: RETURN
LOCATE 27, 11: PRINT t1$
COLOR 7: IF mc = 2 THEN COLOR 15:  IF A$ = " " THEN ch = 2: RETURN
LOCATE 28, 11: PRINT t2$
A$ = ""
END IF
SKIP:
IF DX < 1 THEN DX = 1
IF DY < 1 THEN DY = 1
IF DX > 32 THEN DX = 32
IF DY > 20 THEN DY = 20
IF ODX <> DX OR ODY <> DY THEN IF POINT(ODX * 20 - 20, ODY * 20 - 20) = 15 THEN PUT (ODX * 20 - 20, ODY * 20 - 20), G%, PSET: GET (DX * 20 - 20, DY * 20 - 20)-(DX * 20 - 1, DY * 20 - 1), G%
IF ODX <> DX OR ODY <> DY THEN IF POINT(ODX * 20 - 20, ODY * 20 - 20) <> 15 THEN px = ODX: py = ODY: GOSUB PP: GET (DX * 20 - 20, DY * 20 - 20)-(DX * 20 - 1, DY * 20 - 1), G%
LINE (DX * 20 - 19, DY * 20 - 19)-(DX * 20 - 2, DY * 20 - 2), 15, B
HH:
LOOP WHILE CR = 1
IF CR = 2 THEN GOSUB save: CR = 1
IF CR = 3 THEN GOSUB load: CR = 1:
IF PT = 1 THEN PUT (40, 400), t1%, PSET
IF PT = 2 THEN PUT (40, 400), t2%, PSET
IF PT = 3 THEN PUT (40, 400), t3%, PSET
IF PT = 4 THEN PUT (40, 400), t4%, PSET
IF CR = 1 THEN GOTO HH
RETURN
mboat:
LTV = L(DX, DY)
IF LTV < 0 THEN LTV = 0
IF C(LTV, 0) <> PT THEN RETURN
IF C(LTV, 9) = 0 THEN RETURN
A$ = ""
mn = 7: GOSUB TURN: mn = 2
A$ = ""
sp = 0
FOR py = C(WT, 5) - 1 TO C(WT, 7) + 1
FOR px = C(WT, 4) - 1 TO C(WT, 6) + 1
IF L(px, py) = 0 AND px > 0 AND py > 0 AND py < 21 AND px < 33 THEN
IF L(px - 1, py) = WT AND L(px, py) = 0 THEN sp = sp + 1
IF L(px + 1, py) = WT AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py - 1) = WT AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py + 1) = WT AND L(px, py) = 0 THEN sp = sp + 1
END IF
NEXT px
NEXT py
IF sp <= 0 THEN RETURN
IF C(WT, 0) <> PT THEN RETURN
B1 = 0: IF C(LTV, 8) > 0 AND C(WT, 8) = 0 THEN t$ = "Bring horse?": t1$ = "Yes": t2$ = "No": mn = 5: GOSUB TURN: mn = 2: IF ch = 1 THEN B1 = 1
B2 = 0: IF C(LTV, 10) > 0 AND C(WT, 10) = 0 THEN t$ = "Bring weapon?": t1$ = "Yes": t2$ = "No": mn = 5: OMN = 1: GOSUB TURN: mn = 2: IF ch = 1 THEN B2 = 1
IF B1 = 1 THEN C(LTV, 8) = 0: C(WT, 8) = -1
IF B2 = 1 THEN C(LTV, 10) = 0: C(WT, 10) = -1
C(LTV, 9) = C(LTV, 9) - 1: C(WT, 9) = C(WT, 9) + 1
di = LTV: GOSUB CITY: di = WT: GOSUB CITY
RETURN
mhorse:
LTV = L(DX, DY)
IF C(LTV, 0) <> PT THEN RETURN
IF C(LTV, 8) <= 0 THEN RETURN
A$ = ""
mn = 7: GOSUB TURN: mn = 2
A$ = ""
IF ct(LTV, WT) = 0 THEN RETURN
IF C(WT, 8) <> 0 THEN RETURN
IF C(WT, 0) <> PT THEN RETURN
C(LTV, 8) = 0: di = LTV: GOSUB CITY
C(WT, 8) = -1: di = WT: GOSUB CITY
RETURN
MOVESTOCK:
LTV = L(DX, DY)
IF C(LTV, 0) <> PT THEN RETURN
IF C(LTV, 2) < 32 THEN RETURN
A$ = ""
mn = 7: GOSUB TURN: mn = 2
A$ = ""
IF C(WT, 2) >= 32 THEN RETURN
IF C(WT, 0) <> PT THEN RETURN
C(LTV, 2) = C(LTV, 2) - 32: di = LTV: GOSUB CITY
C(WT, 2) = C(WT, 2) + 32: di = WT: GOSUB CITY
RETURN
mweapon:
LTV = L(DX, DY)
IF C(LTV, 0) <> PT THEN RETURN
IF C(LTV, 10) <= 0 THEN RETURN
A$ = ""
mn = 7: GOSUB TURN: mn = 2
A$ = ""
IF ct(LTV, WT) = 0 THEN RETURN
IF C(WT, 10) <> 0 THEN RETURN
IF C(WT, 0) <> PT THEN RETURN
C(LTV, 10) = 0: di = LTV: GOSUB CITY
C(WT, 10) = -1: di = WT: GOSUB CITY
RETURN
attack:
di = L(DX, DY)
IF di = 0 THEN RETURN
IF C(di, 0) = PT THEN RETURN
GOSUB fforce
'IF f(pt) = 0 THEN RETURN
df = C(di, 0)
A$ = ""
mn = 8: GOSUB TURN: mn = 2
A$ = ""
WF = WT
BB = 0: IF C(WT, 0) = PT AND C(WT, 9) > 0 THEN BB = 1
IF BB = 1 THEN
B1 = 0: IF C(WF, 8) > 0 THEN t$ = "Bring horse?": t1$ = "Yes": t2$ = "No": mn = 5: GOSUB TURN: mn = 2: IF ch = 1 THEN B1 = 1
B2 = 0: IF C(WF, 10) > 0 THEN t$ = "Bring weapon?": t1$ = "Yes": t2$ = "No": mn = 5: OMN = 1: GOSUB TURN: mn = 2: IF ch = 1 THEN B2 = 1
END IF
IF BB <= 0 THEN BB = 0: B1 = 0: B2 = 0
F(PT) = F(PT) + BB * 2 + B1 + B2 * 3
IF F(PT) * RND > F(df) * RND THEN s = 1 ELSE s = 0
IF s = 1 THEN
C(di, 9) = 0: GOSUB CITY
IF BB = 1 THEN
FOR py = C(di, 5) - 1 TO C(di, 7) + 1
FOR px = C(di, 4) - 1 TO C(di, 6) + 1
IF L(px, py) = 0 AND px > 0 AND py > 0 AND py < 21 AND px < 33 THEN
IF L(px - 1, py) = di AND L(px, py) = 0 THEN sp = sp + 1
IF L(px + 1, py) = di AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py - 1) = di AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py + 1) = di AND L(px, py) = 0 THEN sp = sp + 1
END IF
NEXT px
NEXT py
IF sp > 0 THEN C(di, 9) = 1
IF B1 = 1 THEN C(di, 8) = 1: C(WF, 8) = 0
IF B2 = 1 THEN C(di, 10) = 1: C(WF, 10) = 0
C(WF, 9) =  -1:
 Hz = di
 : di = WF
 : GOSUB CITY:
  di = Hz
END IF
C(di, 0) = PT
PLAY "mb o4 l8adeo3l16cel2c"
gr = di
IF C(di, 2) >= 32 THEN
C(di, 2) = C(di, 2) - 32
GD(PT) = GD(PT) + GD(df): GD(df) = 0
CO(PT) = CO(PT) + CO(df): CO(df) = 0
i(PT) = i(PT) + i(df): i(df) = 0
t(PT) = t(PT) + t(df): t(df) = 0
LOCATE 28, 40: COLOR 15: PRINT "Stockpile Looted!": PLAY "o2l4el2al4el2cp2o4l8ecal4ecl16el8l16aacl8bel16cal16cal4bl16dcl8el16bcl8>e"
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
END IF
FOR t = 1 TO ctn
IF ct(gr, t) > 0 THEN di = t: GOSUB CITY
NEXT t
di = gr
END IF
IF s = 0 THEN PLAY "mBo1l8adl4el8cl2e"
IF BB = 1 THEN
C(WF, 9) = C(WF, 9) = -1:
IF B1 = 1 THEN C(WF, 8) = 0
IF B2 = 1 THEN C(WF, 10) = 0
Hz = di: di = WF: GOSUB CITY: di = Hz
END IF
FL = FL - 1
RETURN
FORCE:
GOSUB fforce
GOSUB CLAR
LOCATE 26, 11: PRINT "Owned by "; : COLOR o + 8: PRINT "Player"; o
LOCATE 27, 11: COLOR 9: PRINT "Forces"; F(1)
LOCATE 28, 11: COLOR 10: PRINT "Forces"; F(2)
IF pn >= 3 THEN LOCATE 27, 41: COLOR 11: PRINT "Forces"; F(3)
IF pn = 4 THEN LOCATE 28, 41: COLOR 12: PRINT "Forces"; F(4)
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
OMN = 0
RETURN
fforce:
IF di = 0 THEN RETURN
FOR A = 1 TO pn
F(A) = 0
NEXT A
FOR t = 1 TO ctn
IF ct(di, t) > 0 THEN
o = C(t, 0)
F(o) = F(o) + 1: 'country
F(o) = F(o) + ABS(C(t, 3)) * 2: 'city
F(o) = F(o) + ABS(C(t, 8)) * 1: 'horse
IF t = di THEN F(o) = F(o) + ABS(C(t, 9)) * 2: 'boat
F(o) = F(o) + ABS(C(t, 10)) * 3: 'weapon
IF C(t, 2) >= 32 THEN F(o) = F(o) + 1: 'stockpile
END IF
NEXT t
RETURN:
BCITY:
IF C(L(DX, DY), 0) <> PT THEN RETURN
RT = 1
w = 0
IF GD(PT) >= 4 THEN RT = 0: w = w + 1
IF i(PT) >= 1 AND CO(PT) >= 1 AND GD(PT) >= 1 AND t(PT) >= 1 THEN RT = 2: w = w + 1
IF RT = 1 THEN RETURN
IF w = 2 THEN t$ = "Make or buy city?": t1$ = "Make with supplies": t2$ = "Buy with gold": mn = 5: GOSUB TURN: mn = 1: IF ch = 1 THEN RT = 2 ELSE RT = 0
IF C(L(DX, DY), 3) = 1 THEN RETURN
C(L(DX, DY), 3) = 1
di = L(DX, DY):
FOR HTA = 1 TO ctn
IF ct(HTA, L(DX, DY)) > 0 THEN di = HTA: IF C(di, 0) = C(L(DX, DY), 0) THEN GOSUB CITY
NEXT HTA
IF RT = 0 THEN GD(PT) = GD(PT) - 4 ELSE IF RT = 2 THEN i(PT) = i(PT) - 1: CO(PT) = CO(PT) - 1: GD(PT) = GD(PT) - 1: t(PT) = t(PT) - 1
RETURN
BOAT:
lv = L(DX, DY)
IF C(lv, 0) <> PT THEN RETURN
CR = 1
w = 0
IF t(PT) >= 3 THEN CR = 0: w = w + 1
IF GD(PT) >= 3 THEN CR = 2: w = w + 1
IF CR = 1 THEN RETURN
IF w = 2 THEN t$ = "Make or buy boat?": t1$ = "Make with supplies": t2$ = "Buy with gold": mn = 5: GOSUB TURN: mn = 1: IF ch = 1 THEN CR = 0 ELSE CR = 2
sp = 0
FOR py = C(lv, 5) - 1 TO C(lv, 7) + 1
FOR px = C(lv, 4) - 1 TO C(lv, 6) + 1
IF L(px, py) = 0 AND px > 0 AND py > 0 AND py < 21 AND px < 33 THEN
IF L(px - 1, py) = lv AND L(px, py) = 0 THEN sp = sp + 1
IF L(px + 1, py) = lv AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py - 1) = lv AND L(px, py) = 0 THEN sp = sp + 1
IF L(px, py + 1) = lv AND L(px, py) = 0 THEN sp = sp + 1
END IF
NEXT px
NEXT py
IF sp = 0 THEN RETURN
C(lv, 9) = C(lv, 9) + 1
IF CR = 0 THEN t(PT) = t(PT) - 3
IF CR = 2 THEN GD(PT) = GD(PT) - 3
di = lv: GOSUB CITY
HORSE:
lv = L(DX, DY)
IF C(lv, 0) <> PT THEN RETURN
IF PS(PT) < 3 THEN RETURN
IF INT(C(lv, 2) / 2) MOD 2 = 0 THEN : RETURN
IF C(lv, 8) = 1 THEN RETURN
C(lv, 8) = 1
di = lv: GOSUB CITY
PS(PT) = PS(PT) - 3
RETURN
WEAPON:
IF C(L(DX, DY), 0) <> PT THEN RETURN
RT = 1
w = 0
IF GD(PT) >= 2 THEN RT = 0: w = w + 1
IF i(PT) >= 1 AND CO(PT) >= 1 THEN RT = 2: w = w + 1
IF RT = 1 THEN RETURN
IF w = 2 THEN t$ = "Make or buy weapon?": t1$ = "Make with supplies": t2$ = "Buy with gold": mn = 5: GOSUB TURN: mn = 1: IF ch = 1 THEN RT = 2 ELSE RT = 0
IF C(L(DX, DY), 10) = 1 THEN RETURN
C(L(DX, DY), 10) = 1
di = L(DX, DY): GOSUB CITY
IF RT = 0 THEN GD(PT) = GD(PT) - 2 ELSE IF RT = 2 THEN i(PT) = i(PT) - 1: CO(PT) = CO(PT) - 1
RETURN
save:
OPEN "conquest.sav" FOR OUTPUT AS #1
WRITE #1, pn, ctn, PT, FL
FOR A = 1 TO ctn
A$ = ""
FOR B = 0 TO 10
A$ = A$ + CHR$(C(A, B) + 100)
NEXT B
PRINT #1, A$
NEXT A
FOR A = 1 TO pn
WRITE #1, GD(A), PS(A), i(A), CO(A), t(A)
NEXT A
FOR Y = 1 TO 20
A$ = ""
FOR X = 1 TO 32
A$ = A$ + CHR$(L(X, Y) + 100)
NEXT X
PRINT #1, A$
NEXT Y
FOR A = 1 TO ctn
A$ = ""
FOR B = 1 TO ctn
A$ = A$ + CHR$(ct(A, B) + 100)
NEXT B
PRINT #1, A$
NEXT A
CLOSE #1
RETURN
load:
OPEN "conquest.sav" FOR INPUT AS #1
INPUT #1, pn, ctn, PT, FL
REDIM C(ctn, 10)
FOR A = 1 TO ctn
INPUT #1, A$
FOR B = 0 TO 10
C(A, B) = ASC(MID$(A$, B + 1, 1)) - 100
NEXT B
NEXT A
FOR A = 1 TO pn
INPUT #1, GD(A), PS(A), i(A), CO(A), t(A)
NEXT A
FOR Y = 1 TO 20
INPUT #1, A$
FOR X = 1 TO 32
L(X, Y) = ASC(MID$(A$, X, 1)) - 100
NEXT X
NEXT Y
REDIM ct(ctn, ctn)
FOR A = 1 TO ctn
INPUT #1, A$
FOR B = 1 TO ctn
ct(A, B) = ASC(MID$(A$, B, 1)) - 100
NEXT B
NEXT A
CLOSE #1
GOTO level
RETURN
level:
FOR py = 1 TO 20
FOR px = 1 TO 32
L = 0: GOSUB PPP
NEXT px
NEXT py
FOR di = 1 TO ctn
GOSUB CITY
NEXT di
RETURN
CITY:
rc = 1
FOR A = 1 TO ctn
IF C(A, 3) > 0 AND ct(di, A) AND C(A, 0) = C(di, 0) THEN rc = 2
NEXT A
FOR py = C(di, 5) - 1 TO C(di, 7) + 1
FOR px = C(di, 4) - 1 TO C(di, 6) + 1
IF ABS(L(px, py)) = di THEN GOSUB PP: IF L(px, py) < 0 THEN L(px, py) = 0
NEXT px
NEXT py
G = C(di, 2)
FOR ga = 0 TO 5
A = ga
tp(A) = INT(G / 2 ^ A) MOD 2
IF tp(A) = 1 THEN
IF ga = 5 THEN rc = 1
FOR PA = 1 TO rc
DO:
X = C(di, 4) + (C(di, 6) - C(di, 4)) * RND
Y = C(di, 5) + (C(di, 7) - C(di, 5)) * RND
LOOP WHILE L(X, Y) <> di OR POINT(X * 20 - 1, Y * 20 - 1) = 15
A = ga
IF A = 5 THEN A = 8
sx = X * 20 - 20: sy = Y * 20 - 20: C = C(di, 0): GOSUB LP
NEXT PA
END IF
NEXT ga
FOR F = 8 TO 10 STEP 2
IF C(di, F) <> 0 THEN
DO:
X = C(di, 4) + (C(di, 6) - C(di, 4)) * RND
Y = C(di, 5) + (C(di, 7) - C(di, 5)) * RND
CR = 0
IF POINT(X * 20 - 20, Y * 20 - 20) = 15 THEN CR = 1
IF L(X, Y) <> di THEN CR = 1
LOOP WHILE CR = 1
sx = X * 20 - 20: sy = Y * 20 - 20: A = F - 3:
C = C(di, 0)
GOSUB LP
END IF
NEXT F
FOR bt = 1 TO C(di, 9)
DO
DO
X = C(di, 4) - 1 + (C(di, 6) - C(di, 4) + 2) * RND
Y = C(di, 5) - 1 + (C(di, 7) - C(di, 5) + 2) * RND
LOOP WHILE X < 1 OR Y < 1 OR X > 32 OR Y > 20
CR = 0
IF L(X, Y) <> 0 THEN CR = 1
IF CR = 0 THEN
CR = 1
IF L(X - 1, Y) = di THEN CR = 0
IF L(X + 1, Y) = di THEN CR = 0
IF L(X, Y - 1) = di THEN CR = 0
IF L(X, Y + 1) = di THEN CR = 0
END IF
IF X < 1 OR Y < 1 OR X > 32 OR Y > 20 THEN CR = 1
LOOP WHILE CR = 1
C = C(di, 0): sx = X * 20 - 20: sy = Y * 20 - 20: A = 6: GOSUB LP
L(X, Y) = -di
NEXT bt
'GET (DX * 20 - 20, DY * 20 - 20)-(DX * 20 - 1, DY * 20 - 1), G%
RETURN
LP:
IF A = 0 THEN
LINE (sx, sy)-(sx + 19, sy + 19), 15
LINE (sx, sy + 19)-(sx + 19, sy), 15
LINE (sx + 6, sy + 7)-(sx + 14, sy + 13), 15, BF
END IF
IF A = 1 THEN
LINE (sx, sy + 10)-(sx + 10, sy + 19), 15
LINE (sx + 9, sy + 1)-(sx + 10, sy + 19), 15
LINE (sx + 19, sy + 10)-(sx + 10, sy + 19), 15
LINE (sx, sy + 19)-(sx + 10, sy + 10), 15
LINE (sx, sy + 19)-(sx + 19, sy + 19), 15
LINE (sx + 19, sy + 19)-(sx + 10, sy + 10), 15
END IF
IF A = 2 THEN
LINE (sx, sy)-(sx + 19, sy + 3), 15, BF
LINE (sx + 8, sy)-(sx + 12, sy + 19), 15, BF
LINE (sx, sy + 17)-(sx + 19, sy + 19), 15, BF
END IF
IF A = 3 THEN
LINE (sx, sy)-(sx + 3, sy + 5), 15, BF
LINE (sx + 16, sy + 4)-(sx + 19, sy + 9), 15, BF
LINE (sx + 2, sy + 15)-(sx + 5, sy + 19), 15, BF
END IF
IF A = 4 THEN
LINE (sx + 3, sy + 3)-(sx + 17, sy + 7), 15, BF
LINE (sx + 5, sy)-(sx + 15, sy + 8), 15, BF
LINE (sx + 9, sy)-(sx + 10, sy + 19), 15, B
LINE (sx + 5, sy + 18)-(sx + 15, sy + 19), 15, B
END IF
IF A = 5 THEN
LINE (sx + 1, sy + 1)-(sx + 5, sy + 5), 15, BF
LINE (sx + 4, sy + 7)-(sx + 7, sy + 19), 15, BF
LINE (sx + 4, sy + 7)-(sx + 18, sy + 10), 15, BF
LINE (sx + 16, sy + 10)-(sx + 18, sy + 19), 15, BF
END IF
IF A = 6 THEN
LINE (sx + 5, sy + 2)-(sx + 7, sy + 10), C + 8, BF
LINE (sx + 15, sy + 2)-(sx + 13, sy + 10), C + 8, BF
LINE (sx, sy + 17)-(sx + 19, sy + 19), C + 8, BF
LINE (sx + 1, sy + 10)-(sx + 19, sy + 13), C + 8, BF
LINE (sx + 3, sy + 10)-(sx + 17, sy + 16), C + 8, BF
END IF
IF A = 7 THEN
LINE (sx + 5, sy + 8)-(sx + 15, sy + 12), 15, BF
LINE (sx + 8, sy + 17)-(sx + 15, sy + 19), 15, BF
LINE (sx + 2, sy + 4)-(sx + 5, sy + 16), 15, BF
END IF
IF A = 8 THEN
LINE (sx, sy)-(sx + 5, sy + 19), 15, BF
LINE (sx, sy)-(sx + 19, sy + 5), 15, BF
LINE (sx + 19, sy)-(sx + 15, sy + 19), 15, BF
END IF
PSET (sx, sy), 15
RETURN
LVP:
XX = X: YY = Y
HX = px: HY = py
FOR TX = -1 TO 1
FOR TY = -1 TO 1
px = HX + TX: py = HY + TY: GOSUB PP
NEXT TY
NEXT TX
X = XX: Y = YY
px = HX: py = HY
RETURN
PP:
IF px < 1 OR py < 1 OR px > 32 OR py > 20 THEN RETURN
L = L(px, py)
PPP:
sx = px * 20 - 20: sy = py * 20 - 20
IF sx < 0 OR sy < 0 OR sx > 620 OR sy > 460 THEN RETURN
LINE (sx, sy)-(sx + 19, sy + 19), 0, BF
PSET (sx + 10, sy + 10), 15
IF L = 0 THEN RETURN
IF L > 0 THEN GOSUB LM: RETURN
RETURN
LM:
lv = L(px, py)
TL = 0: TT = 0: TR = 0: TD = 0
IF L(px - 1, py) <> lv THEN TL = 1
IF L(px, py - 1) <> lv THEN TT = 1
IF L(px + 1, py) <> lv THEN TR = 1
IF L(px, py + 1) <> lv THEN TD = 1
C = C(lv, 0)
IF C = 0 THEN C = 7
LINE (sx + 6, sy + 3)-(sx + 13, sy + 16), C, BF
LINE (sx + 3, sy + 6)-(sx + 16, sy + 13), C, BF
IF TD = 0 AND TR = 0 THEN LINE (sx + 10, sy + 10)-(sx + 19, sy + 19), C, BF
IF TD = 0 AND TL = 0 THEN LINE (sx + 10, sy + 10)-(sx, sy + 19), C, BF
IF TT = 0 AND TR = 0 THEN LINE (sx + 10, sy + 10)-(sx + 19, sy), C, BF
IF TT = 0 AND TL = 0 THEN LINE (sx + 10, sy + 10)-(sx, sy), C, BF
IF TD = 0 THEN LINE (sx + 3, sy + 10)-(sx + 17, sy + 19), C, BF
IF TT = 0 THEN LINE (sx + 3, sy + 10)-(sx + 17, sy), C, BF
IF TR = 0 THEN LINE (sx + 10, sy + 3)-(sx + 19, sy + 17), C, BF
IF TL = 0 THEN LINE (sx + 10, sy + 3)-(sx, sy + 17), C, BF
IF C(lv, 3) = 1 THEN
LINE (sx, sy)-(sx + 18, sy + 19), 7
LINE (sx + 1, sy + 10)-(sx + 10, sy + 19), 8
LINE (sx + 11, sy)-(sx + 19, sy + 10), 8
LINE (sx + 1, sy)-(sx + 19, sy + 19), 7
LINE (sx, sy + 10)-(sx + 9, sy + 19), 8
LINE (sx + 10, sy)-(sx + 18, sy + 10), 8
END IF
RETURN
p:
CIRCLE (sx + 10, sy + 10), 8, 9
CIRCLE (sx + 10, sy + 11), 8, 9
CIRCLE (sx + 11, sy + 11), 8, 9
CIRCLE (sx + 11, sy + 10), 8, 9
RETURN

GOLD:
A$(1) = "W"
A$(2) = "I"
A$(3) = "Z"
A$(4) = "A"
A$(5) = "R"
A$(6) = "D"
CR = 1
FOR A = 1 TO 6
DO
A$ = INKEY$
IF A$ <> "" THEN IF A$ <> A$(A) THEN CR = 0: SOUND 100, 1 ELSE SOUND 1000, 1: SOUND 2000, 1
LOOP WHILE A$ = ""
NEXT A
IF CR = 1 THEN GD(PT) = GD(PT) + 3: PLAY "MB L8 ACDO4 ADL2A"
RETURN
COAL:
A$(1) = "S"
A$(2) = "O"
A$(3) = "R"
A$(4) = "C"
A$(5) = "E"
A$(6) = "R"
A$(7) = "E"
A$(8) = "R"
CR = 1
FOR A = 1 TO 8
DO
A$ = INKEY$
IF A$ <> "" THEN IF A$ <> A$(A) THEN CR = 0: SOUND 100, 1 ELSE SOUND 1000, 1: SOUND 2000, 1
LOOP WHILE A$ = ""
NEXT A
IF CR = 1 THEN CO(PT) = CO(PT) + 3: PLAY "MB L8 ACDO4 ADL2A"
RETURN
FLT:
A$(1) = "A"
A$(2) = "T"
A$(3) = "T"
A$(4) = "A"
A$(5) = "C"
A$(6) = "K"
CR = 1
FOR A = 1 TO 6
DO
A$ = INKEY$
IF A$ <> "" THEN IF A$ <> A$(A) THEN CR = 0: SOUND 100, 1 ELSE SOUND 1000, 1: SOUND 2000, 1
LOOP WHILE A$ = ""
NEXT A
IF CR = 1 THEN FL = 2: PLAY "MB L8 ACDO4 ADL2A"
RETURN

