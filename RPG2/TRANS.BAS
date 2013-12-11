DECLARE SUB swapevents (X1%, Y1%, X2%, Y2%)
DECLARE SUB sframe (mx%, my%)
DECLARE SUB STARTMIDI (F$)
DECLARE SUB StartWav (F$)
DECLARE SUB fight ()
DECLARE SUB die (file$)
DECLARE SUB died ()
DECLARE SUB win ()
DECLARE SUB AddMonster (F$)
DECLARE SUB AddCharacter (F$)
DECLARE SUB charpic (mx%, my%, FILENAME$)
DECLARE SUB faces ()
DECLARE SUB blackout ()
DECLARE SUB frame ()
DECLARE FUNCTION runrpg$ (label$)
DECLARE SUB anim (hp%)
DECLARE SUB loadpal (FILENAME$)
DECLARE SUB WORLD ()
DECLARE SUB addevent (x%, y%, label$)
DECLARE SUB LoadRPG (file$)
DECLARE FUNCTION Where% (label$)
DECLARE SUB LoadMap (file$)
DECLARE SUB additem (itm$)
DECLARE SUB takeitem (itm$)
DECLARE FUNCTION ifItem% (itm$)
DECLARE SUB rpg (file$, label$)

DEFINT A-Z

CONST MAXLABELS = 50
CONST MAXITEMS = 50
CONST MAXEVENTS = 30
CONST MAXPROG = 300
DIM SHARED map(180, 110), lab(MAXLABELS), party$(6), enemy$(6)
DIM SHARED labl$(MAXLABELS), prog$(MAXPROG), list$(MAXITEMS)
DIM SHARED plx, ply, lbl, Mapx, MapY, COMD$(25)
DIM SHARED EV$(MAXEVENTS), EY(MAXEVENTS), EX(MAXEVENTS), MODE
DIM solid(20), light(20)
DIM SHARED opaque(20), tile$(20)
solid(2) = 2: solid(4) = 2: solid(8) = 2: solid(0) = 2: 'fLOOR TYPES
solid(1) = 1: solid(3) = 1: solid(5) = 1: solid(6) = 1: solid(14) = 1: solid(18) = 1: solid(12) = 1: solid(19) = 1: solid(20) = 1 ' SOLID TYPES
light(12) = 1: light(13) = 1: light(14) = 1: light(15) = 1: light(18) = 1 'LIGHT ENOUGH TO PUSH
opaque(3) = 1: opaque(5) = 1: opaque(9) = 1: opaque(6) = 1 'OPAQUE
opaque(11) = 2
opaque(19) = 2
COMD$(0) = "LABEL": COMD$(1) = "GOTO": COMD$(2) = "MIDI": COMD$(3) = "WAV": COMD$(4) = "MAP": COMD$(5) = "FIGHT": COMD$(6) = "WORLD": COMD$(7) = "RPG": COMD$(8) = "EVENT": COMD$(9) = "MONSTER": COMD$(10) = "CHARACTER": COMD$(11) = "DIE": COMD$(12) = "WIN": COMD$(13) = "CHARPIC": COMD$(14) = "COLOR": COMD$(15) = "ASK": COMD$(16) = "SAY": COMD$(17) = "ADDITEM": COMD$(18) = "TAKEITEM": COMD$(19) = "IFITEM": COMD$(20) = "THEN": COMD$(21) = "ENDIF": COMD$(22) = "WAIT": COMD$(23) = "BLACKOUT"

tile$(1) = "a worn path"
tile$(2) = "sparkling water"
tile$(3) = "a stone wall"
tile$(4) = "soft grass"
tile$(5) = "a tree"
tile$(6) = "mountains"
tile$(7) = "a rock"
tile$(8) = "the floor"
tile$(9) = "a door"
tile$(10) = "a person"
tile$(11) = "lava"
tile$(12) = "a table"
tile$(13) = "a chair"
tile$(14) = "a clock"
tile$(15) = "a chest"
tile$(16) = "the head of a bed"
tile$(17) = "the foot of a bed"
tile$(18) = "a dressor"
tile$(19) = "a fireplace"
tile$(20) = "a window"

FOR a = 1 TO 6
party$(a) = "none.chr"
enemy$(a) = "none.chr"
NEXT a
SCREEN 13
CLS
VIEW PRINT 20 TO 25
CLS 2
loadpal "game.pal"
DIM SHARED p(400, 20)
DEF SEG = VARSEG(p(0, 0))
BLOAD "rpg2.pic", 0
DEF SEG = &HA000
BLOAD "frame.pic", 0
LoadRPG "Main.rpg"
com$ = runrpg$("start")
DO
a$ = INKEY$
ox = plx: oy = ply
IF a$ = "8" THEN ply = ply - 1
IF a$ = "4" THEN plx = plx - 1
IF a$ = "6" THEN plx = plx + 1
IF a$ = "2" THEN ply = ply + 1
IF a$ = "s" THEN
    INPUT "Save screen as"; F$
    DEF SEG = &HA000
    BSAVE F$, 0, 64000
END IF
IF a$ = "P" THEN
    PRINT "Push which way ";
    DX = 0: DY = 0
    DO
    a$ = INKEY$
    IF a$ = "8" THEN DX = 0: DY = -1: PRINT "UP"
    IF a$ = "4" THEN DX = -1: DY = 0: PRINT "LEFT"
    IF a$ = "6" THEN DX = 1: DY = 0: PRINT "RIGHT"
    IF a$ = "2" THEN DX = 0: DY = 1: PRINT "DOWN"
    LOOP WHILE DX = 0 AND DY = 0
    IF light(map(plx + DX, ply + DY)) = 1 THEN
        IF solid(map(plx + DX * 2, ply + DY * 2)) = 2 THEN
            swapevents plx + DX * 2, ply + DY * 2, plx + DX, ply + DY
            SWAP map(plx + DX * 2, ply + DY * 2), map(plx + DX, ply + DY)
            plx = plx + DX: ply = ply + DY: WORLD
        ELSE
            IF solid(map(plx, ply)) = 2 THEN
                swapevents plx, ply, plx + DX, ply + DY
                SWAP map(plx, ply), map(plx + DX, ply + DY)
                plx = plx + DX: ply = ply + DY: WORLD
            ELSE
                PRINT "No Room to move"
                
            END IF
        END IF
        
    ELSE
        PRINT "Can't move that."
    END IF
END IF

IF a$ = "U" OR a$ = "T" THEN
    PRINT "Use or Talk to what? ";
    DX = 0: DY = 0
    DO
    a$ = INKEY$
    IF a$ = "8" THEN DX = 0: DY = -1: PRINT "UP"
    IF a$ = "4" THEN DX = -1: DY = 0: PRINT "LEFT"
    IF a$ = "6" THEN DX = 1: DY = 0: PRINT "RIGHT"
    IF a$ = "2" THEN DX = 0: DY = 1: PRINT "DOWN"
    LOOP WHILE DX = 0 AND DY = 0
    EV = 0
    FOR a = 0 TO MAXEVENTS
        IF EX(a) = plx + DX AND EY(a) = ply + DY THEN
            EV = 1
            com$ = runrpg$(EV$(a))
loopstart2:
            IF com$ <> "" THEN
                sp = INSTR(com$, " ")
                l$ = LEFT$(com$, sp - 1)
                F$ = MID$(com$, sp + 1)
                LoadRPG F$
                com$ = runrpg$(l$)
                GOTO loopstart2
            END IF
        END IF
    NEXT a
    IF EV = 0 THEN PRINT "Nothing to use!"
END IF
IF a$ = "L" THEN
    PRINT "Look which way ";
    DX = 0: DY = 0
    DO
    a$ = INKEY$
    IF a$ = "8" THEN DX = 0: DY = -1: PRINT "UP"
    IF a$ = "4" THEN DX = -1: DY = 0: PRINT "LEFT"
    IF a$ = "6" THEN DX = 1: DY = 0: PRINT "RIGHT"
    IF a$ = "2" THEN DX = 0: DY = 1: PRINT "DOWN"
    LOOP WHILE DX = 0 AND DY = 0
    PRINT "You see "; tile$(map(plx + DX, ply + DY))
    IF map(plx + DX, ply + DY) = 20 THEN
        plx = plx + DX
        ply = ply + DY
        TX = ox: TY = oy
        MODE = 1: WORLD
        DO: LOOP WHILE INKEY$ = ""
        ox = plx: oy = ply
        plx = TX: ply = TY
        MODE = 0: WORLD
        ox = TX: oy = TY
    END IF
END IF
IF a$ = "I" THEN
    PRINT
    PRINT "Inventory..."
    FOR a = 1 TO MAXITEMS
        IF list$(a) <> "" THEN PRINT list$(a)
    NEXT a
    PRINT
END IF
IF plx < 1 THEN plx = 1
IF ply < 1 THEN ply = 1
IF plx > Mapx THEN plx = Mapx
IF ply > MapY THEN ply = MapY
l = map(plx, ply)
IF solid(l) = 1 THEN plx = ox: ply = oy
IF ox <> plx OR oy <> ply THEN
    WORLD
    FOR a = 0 TO MAXEVENTS
        IF EX(a) = plx AND EY(a) = ply THEN
            com$ = runrpg$(EV$(a))
loopstart:
            IF com$ <> "" THEN
                sp = INSTR(com$, " ")
                l$ = LEFT$(com$, sp - 1)
                F$ = MID$(com$, sp + 1)
                LoadRPG F$
                com$ = runrpg$(l$)
                GOTO loopstart
            END IF
        END IF
    NEXT a
END IF
hp = (hp + 1) MOD 64
anim hp
LOOP WHILE a$ <> "Q"

SUB AddCharacter (F$)
FOR a = 1 TO 6
IF party$(a) = "none.chr" THEN party$(a) = F$: a = 6
NEXT a
faces
END SUB

SUB addevent (x, y, label$)
FOR a = 0 TO MAXEVENTS
IF EV$(a) = "" THEN EX(a) = x: EY(a) = y: EV$(a) = label$: a = MAXEVENTS
NEXT a
END SUB

SUB additem (itm$)
    FOR a = 1 TO MAXITEMS
        IF list$(a) = "" THEN list$(a) = itm$: a = MAXITEMS
    NEXT a
END SUB

SUB AddMonster (F$)
FOR a = 1 TO 6
IF enemy$(a) = "none.chr" THEN enemy$(a) = F$: a = 6
NEXT a
END SUB

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

SUB blackout
FOR a = 1 TO 100
FOR sy = 1 TO 7
FOR sx = 1 TO 11
x = sx * 20 - 20 * RND + 50
y = sy * 20 - 20 * RND
IF POINT(x, y) < 128 THEN PSET (x, y), POINT(x, y) + 128
NEXT sx
NEXT sy
NEXT a
CLS
END SUB

SUB charpic (mx, my, FILENAME$)
IF UCASE$(FILENAME$) = "NONE.CHR" THEN EXIT SUB
OPEN FILENAME$ FOR BINARY AS #1
IF LOF(1) = 0 THEN PRINT FILENAME$; " not found!": CLOSE #1: EXIT SUB
CLOSE #1
OPEN FILENAME$ FOR INPUT AS #1
INPUT #1, name$
'Name
FOR y = 1 TO 30
INPUT #1, a$
FOR x = 1 TO 30
c = ASC(MID$(a$, x, 1)) - 128
sx = x + mx - 1
sy = y + my - 1
IF c > 3 THEN PSET (sx, sy), c
NEXT x
NEXT y
CLOSE #1
sy = (my) \ 8 + 5
sx = (mx - 4) \ 8 + 1
'VIEW PRINT
'LOCATE sy, sx: PRINT LEFT$(name$, 6)
'VIEW PRINT 20 TO 25
'CLS 2
END SUB

SUB die (file$)
IF file$ = "" THEN died
FOR a = 1 TO 6
IF party$(a) = file$ THEN party$(a) = "none.chr": a = 6
NEXT a
faces
END SUB

SUB died
PRINT "You died!"
SYSTEM
END SUB

SUB faces
charpic 5, 8, party$(1): 'sframe 5, 8
charpic 280, 8, party$(2): ' sframe 280, 8
charpic 5, 48, party$(3): 'sframe 5, 48
charpic 280, 48, party$(4): ' sframe 280, 48
charpic 5, 88, party$(5): 'sframe 5, 88
charpic 280, 88, party$(6): ' sframe 280, 88
END SUB

SUB fight
LINE (0, 0)-(320, 150), 0, BF
PRINT "You are in a fight..."
FOR a = 1 TO 6
IF enemy$(a) <> "none.chr" THEN
charpic 5 + (a MOD 2) * 30, a * 15, enemy$(a)
END IF
IF party$(a) <> "none.chr" THEN
charpic 260 + (a MOD 2) * 30, a * 15, party$(a)
END IF
NEXT a
PRINT
' The fight
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
PRINT "You win!!!"
FOR a = 1 TO 6              'Kill all the monsters
    enemy$(a) = "none.chr"
NEXT a
LINE (0, 0)-(320, 150), 0, BF
frame
WORLD
faces
END SUB

SUB frame
DEF SEG = &HA000
BLOAD "frame.pic", 0
END SUB

FUNCTION ifItem (itm$)
    i = 0
    FOR a = 1 TO MAXITEMS
        IF list$(a) = itm$ THEN i = a
    NEXT a
    ifItem = i
END FUNCTION

SUB LoadMap (file$)
ERASE map
DEF SEG = VARSEG(map(0, 0))
BLOAD file$, 0
DEF SEG
Mapx = map(0, 0)
MapY = map(0, 1)
WORLD
END SUB

SUB loadpal (FILENAME$)
DIM pal(767)  AS STRING * 1
DEF SEG = VARSEG(pal(1))
BLOAD FILENAME$, 0
DEF SEG
OUT &H3C8, 0
FOR a% = 3 TO 767
    OUT &H3C9, ASC(pal(a%))
NEXT a%
END SUB

SUB LoadRPG (file$)
FOR a = 0 TO MAXEVENTS
    EV$(a) = ""
    EX(a) = 0
    EY(a) = 0
NEXT a
FOR a = 0 TO MAXLABELS
    labl$(a) = ""
    lab(a) = 0
NEXT a

'FOR a = 1 TO MAXPROG
'prog$(a) = ""
'NEXT a
OPEN file$ FOR INPUT AS #1
length = 0:         ' Finds the length of the file
WHILE NOT EOF(1)
    LINE INPUT #1, a$
    length = length + 1
WEND
length = length - 1
CLOSE #1
OPEN file$ FOR INPUT AS #1
lbl = 0
FOR a = 1 TO length
    LINE INPUT #1, p$
    p$ = LCASE$(p$)
    k$ = "ERROR IN" + STR$(a) + "'" + p$ + "'"
    IF LEFT$(p$, 1) = "%" THEN k$ = "LABEL " + MID$(p$, 3): labl$(lbl) = MID$(p$, 3): lab(lbl) = a: lbl = lbl + 1
    IF LEFT$(p$, 5) = "label" THEN k$ = "LABEL " + MID$(p$, 7)
    IF LEFT$(p$, 4) = "goto" THEN k$ = CHR$(201) + MID$(p$, 6)
    IF LEFT$(p$, 4) = "midi" THEN k$ = CHR$(202) + MID$(p$, 6)
    IF LEFT$(p$, 3) = "wav" THEN k$ = CHR$(203) + MID$(p$, 5)
    IF LEFT$(p$, 3) = "map" THEN k$ = CHR$(204) + MID$(p$, 5)
    IF LEFT$(p$, 5) = "fight" THEN k$ = CHR$(205)
    IF LEFT$(p$, 5) = "world" THEN k$ = CHR$(206)
    IF LEFT$(p$, 3) = "rpg" THEN k$ = CHR$(207) + MID$(p$, 5)
    IF LEFT$(p$, 5) = "event" THEN k$ = CHR$(208) + MID$(p$, 7)
    IF LEFT$(p$, 7) = "monster" THEN k$ = CHR$(209) + MID$(p$, 9)
    IF LEFT$(p$, 9) = "character" THEN k$ = CHR$(210) + MID$(p$, 11)
    IF LEFT$(p$, 3) = "die" THEN k$ = CHR$(211) + MID$(p$, 5)
    IF LEFT$(p$, 3) = "win" THEN k$ = CHR$(212)
    IF LEFT$(p$, 7) = "charpic" THEN k$ = CHR$(213) + MID$(p$, 9)
    IF LEFT$(p$, 5) = "color" THEN k$ = CHR$(214) + MID$(p$, 7)
    IF LEFT$(p$, 3) = "ask" THEN k$ = CHR$(215) + MID$(p$, 5)
    IF LEFT$(p$, 3) = "say" THEN k$ = CHR$(216) + MID$(p$, 5)
    IF LEFT$(p$, 7) = "additem" THEN k$ = CHR$(217) + MID$(p$, 9)
    IF LEFT$(p$, 8) = "takeitem" THEN k$ = CHR$(218) + MID$(p$, 10)
    IF LEFT$(p$, 6) = "ifitem" THEN k$ = CHR$(219) + MID$(p$, 8)
    IF LEFT$(p$, 4) = "then" THEN k$ = CHR$(220)
    IF LEFT$(p$, 5) = "endif" THEN k$ = CHR$(221)
    IF LEFT$(p$, 4) = "wait" THEN k$ = CHR$(222)
    IF LEFT$(p$, 8) = "blackout" THEN k$ = CHR$(223)
    IF LEFT$(p$, 5) = "pause" THEN k$ = CHR$(225)
    IF LEFT$(p$, 1) = "'" THEN k$ = "    " + UCASE$(MID$(p$, 2))
    prog$(a) = k$
NEXT a
lbl = lbl - 1
CLOSE #1
END SUB

FUNCTION runrpg$ (label$)
a = Where(label$)
IF a < 0 THEN EXIT FUNCTION
runrpg$ = ""
DO
a = a + 1
cmd = ASC(LEFT$(prog$(a) + " ", 1)) - 200
com$ = MID$(prog$(a), 2)
IF cmd = 1 THEN a = Where(com$)
'IF cmd = 2 THEN STARTMIDI com$
'IF cmd = 3 THEN StartWav com$
IF cmd = 4 THEN
    plx = VAL(MID$(com$, 1, 3))
    ply = VAL(MID$(com$, 4, 3))
    file$ = MID$(com$, 7)
    LoadMap file$
END IF
IF cmd = 5 THEN fight
IF cmd = 6 THEN WORLD
IF cmd = 7 THEN runrpg$ = com$:  cmd = 22
IF cmd = 8 THEN
    x = VAL(MID$(com$, 1, 3))
    y = VAL(MID$(com$, 4, 3))
    l$ = MID$(com$, 7)
    addevent x, y, l$
END IF
IF cmd = 9 THEN AddMonster com$
IF cmd = 10 THEN AddCharacter com$
IF cmd = 11 THEN die com$
IF cmd = 12 THEN win
IF cmd = 13 THEN charpic 145, 40, com$
IF cmd = 14 THEN COLOR VAL(com$) * 16 + 15
IF cmd = 15 THEN
    PRINT UCASE$(com$); "? ";
    DO: a$ = UCASE$(INKEY$): LOOP WHILE a$ <> "Y" AND a$ <> "N"
    IF a$ = "N" THEN PRINT "NO": a = a + 1 ELSE PRINT "YES"
END IF
IF cmd = 16 THEN PRINT UCASE$(com$)
IF cmd = 17 THEN additem com$
IF cmd = 18 THEN takeitem com$
IF cmd = 19 THEN IF ifItem(com$) = 0 THEN a = a + 1
IF cmd = 23 THEN blackout
IF cmd = 25 THEN
    DO
        hp = (hp + 1) MOD 64
        anim hp
    LOOP WHILE INKEY$ = ""
END IF
LOOP WHILE cmd <> 22 AND a < MAXPROG
WORLD
END FUNCTION

SUB sframe (mx, my)
FOR a = 0 TO 4
LINE (mx - a, my - a)-(mx + 30 + a, my - a), 64 - a * 3
LINE (mx - a, my + 30 + a)-(mx - a, my - a), 64 - a * 3
LINE (mx - a, my + 30 + a)-(mx + 30 + a, my + 30 + a), 64 - a * 3
LINE (mx + 30 + a, my - a)-(mx + 30 + a, my + 30 + a), 64 - a * 3
NEXT a

END SUB

SUB showprog
FOR a = 1 TO MAXPROG
IF prog$(a) <> "" AND LEFT$(prog$(a), 1) <> "L" THEN PRINT COMD$(ASC(LEFT$(prog$(a), 1)) - 200); " "; MID$(prog$(a), 2)
IF LEFT$(prog$(a), 1) = "L" THEN PRINT prog$(a)
IF a MOD 5 = 0 THEN DO: LOOP WHILE INKEY$ = "": IF prog$(a) = "" THEN a = MAXPROG
NEXT a

END SUB

SUB swapevents (X1, Y1, X2, Y2)
    FOR a = 0 TO MAXEVENTS
        IF EX(a) = X1 AND EY(a) = Y1 THEN
            EX(a) = X2: EY(a) = Y2
        ELSE
            IF EX(a) = X2 AND EY(a) = Y2 THEN
                EX(a) = X1: EY(a) = Y1
            END IF
        END IF
    NEXT a
    
END SUB

SUB takeitem (itm$)
    FOR a = 1 TO MAXITEMS
        IF list$(a) = itm$ THEN list$(a) = "": a = MAXITEMS
    NEXT a
END SUB

FUNCTION Where (label$)
    T = -2
    FOR a = 0 TO lbl

        IF labl$(a) = label$ THEN T = lab(a)
    NEXT a
    IF T = -2 THEN BEEP: PRINT "can't find "; label$; "!"
    Where = T
END FUNCTION

SUB win
PRINT "You Win!"
SYSTEM
END SUB

SUB WORLD
DIM light(12, 8)
lu = 0: DO: lu = lu + 1: LOOP WHILE opaque(map(plx, ply - lu)) <> 1 AND ply - lu > 0 AND lu < 4
ld = 0: DO: ld = ld + 1: LOOP WHILE opaque(map(plx, ply + ld)) <> 1 AND ply + ld <= MapY AND ld < 4
ll = 0: DO: ll = ll + 1: LOOP WHILE opaque(map(plx - ll, ply)) <> 1 AND plx - ll > 0 AND ll < 6
lr = 0: DO: lr = lr + 1: LOOP WHILE opaque(map(plx + lr, ply)) <> 1 AND plx + lr <= Mapx AND lr < 6
lul = 0: DO: lul = lul + 1: LOOP WHILE opaque(map(plx - lul, ply - lul)) <> 1 AND plx - lul > 0 AND ply - lul > 0 AND lul < 4
lur = 0: DO: lur = lur + 1: LOOP WHILE opaque(map(plx + lur, ply - lur)) <> 1 AND plx + lur <= Mapx AND ply - lur > 0 AND lur < 4
ldl = 0: DO: ldl = ldl + 1: LOOP WHILE opaque(map(plx - ldl, ply + ldl)) <> 1 AND plx - ldl > 0 AND ply + ldl <= MapY AND ldl < 4
ldr = 0: DO: ldr = ldr + 1: LOOP WHILE opaque(map(plx + ldr, ply + ldr)) <> 1 AND plx + ldr <= Mapx AND ply + ldr <= MapY AND ldr < 4
FOR a = -lu + 1 TO ld - 1: light(6, 4 + a) = 2: NEXT a
FOR a = -ll + 1 TO lr - 1: light(6 + a, 4) = 2: NEXT a
FOR a = -lul + 1 TO ldr - 1: light(6 + a, 4 + a) = 2: NEXT a
FOR a = -ldl + 1 TO lur - 1: light(6 + a, 4 - a) = 2: NEXT a
light(6, 4) = 2
DO
redo = 0
FOR y = 1 TO 7
    FOR x = 1 TO 11
        IF light(x, y) = 0 THEN
            IF light(x - 1, y) = 2 THEN light(x, y) = 1 ELSE IF light(x + 1, y) = 2 THEN light(x, y) = 1
            IF light(x, y - 1) = 2 THEN light(x, y) = 1 ELSE IF light(x, y + 1) = 2 THEN light(x, y) = 1
            IF light(x + 1, y + 1) = 2 THEN light(x, y) = 1 ELSE IF light(x + 1, y - 1) = 2 THEN light(x, y) = 1
            IF light(x - 1, y + 1) = 2 THEN light(x, y) = 1 ELSE IF light(x - 1, y - 1) = 2 THEN light(x, y) = 1
        END IF
        IF light(x, y) = 1 THEN
            sx = plx + x - 6
            sy = ply + y - 4
            IF sx < 1 THEN sx = 1 ELSE IF sx > Mapx THEN sx = Mapx
            IF sy < 1 THEN sy = 1 ELSE IF sy > MapY THEN sy = MapY
            IF opaque(map(sx, sy)) = 2 THEN light(x, y) = 2: redo = 1
        END IF
    NEXT x
NEXT y
LOOP WHILE redo = 1
FOR y = -3 TO 3
    FOR x = -5 TO 5
        IF light(x + 6, y + 4) > 0 THEN
            sx = plx + x: sy = ply + y: sh = 0
            IF plx + x < 1 THEN sx = 1: sh = 1 ELSE IF plx + x > Mapx THEN sx = Mapx: sh = 1
            IF ply + y < 1 THEN sy = 1: sh = 1 ELSE IF ply + y > MapY THEN sy = MapY: sh = 1
            l = map(sx, sy)
            IF x = 0 AND y = 0 AND MODE = 0 THEN l = 10
            IF sh = 1 THEN LINE (x * 20 + 150, y * 20 + 60)-(x * 20 + 169, y * 20 + 79), 128, BF: PUT (x * 20 + 150, y * 20 + 60), p(0, l)
            IF sh = 0 THEN PUT (x * 20 + 150, y * 20 + 60), p(0, l), PSET
        ELSE
            LINE (x * 20 + 150, y * 20 + 60)-(x * 20 + 169, y * 20 + 79), 0, BF:
        END IF
    NEXT x
NEXT y

END SUB

