DECLARE SUB PlayersDialog ()
DECLARE SUB WeaponsDialog ()
DECLARE SUB GraphicsDialog ()
DECLARE SUB SoundDialog ()
DECLARE SUB MusicDialog ()
DECLARE SUB LoadDialog ()
DECLARE SUB SaveDialog ()
DECLARE SUB NewGame ()
DECLARE SUB MainMenu (a%)
DECLARE SUB FileMenu ()
DECLARE SUB OptionsMenu ()
DECLARE SUB about ()
DECLARE SUB dmenu (txt$)
DECLARE SUB mdoor (x%, y%, w%, h%, t$, n$)
DECLARE FUNCTION inputi% (prompt$)
DECLARE FUNCTION inputs$ (prompt$)

DECLARE SUB cbox (x%, y%, w%, h%)
DECLARE SUB ibox (x%, y%, w%, h%)
DECLARE SUB message (m$)
DECLARE SUB font (x%, y%, m$)
DECLARE SUB button (x%, y%, w%, h%)
DECLARE SUB ibutton (x%, y%, w%, h%)
DECLARE SUB effect (t$)

DEFINT A-Z
DIM SHARED IsSound
IsSound = 1
DIM SHARED wht%(64, 255), nul AS STRING * 1
nul = CHR$(0)
SCREEN 9

COLOR 7
'FOR a = 0 TO 255
'LOCATE 1, 1: PRINT CHR$(a)
'FOR y = 0 TO 15
'FOR x = 0 TO 7
'IF POINT(x, y) = 0 THEN
    'IF POINT(x, y + 1) = 7 THEN PSET (x, y), 15
'END IF
'NEXT x
'NEXT y
'GET (0, 0)-(7, 15), wht%(0, a)
'NEXT a
DEF SEG = VARSEG(wht%(0, 0))
'BSAVE "white.fnt", 0, VARPTR(wht%(64, 255))
BLOAD "white.fnt", 0

valid = 0
CLS
KEY 16, CHR$(12) + CHR$(83)
ON KEY(16) GOSUB Reboot
KEY(16) ON
CALL mdoor(0, 0, 640, 350, "SMG", "Scorched Earth II (no game in progress)")

font 5, 27, "&File       &Options    &About"
message "Welcome to Scorched Earth II"

DO

a$ = INKEY$
IF a$ = nul + CHR$(33) THEN MainMenu 1: a$ = ""
IF a$ = nul + CHR$(24) THEN MainMenu 2: a$ = ""
IF a$ = nul + CHR$(30) THEN MainMenu 3: a$ = ""
IF a$ <> "" THEN message ("You pressed " + a$)

LOOP


Reboot:
message "Sorry Ctrl-Alt-Del is disabled in Scorch II"
RETURN

SUB about
message "Scorch II - By Tim Caswell"
END SUB

SUB button (x, y, w, h)
LINE (x - 1, y - 1)-(x + w + 1, y + h + 1), 0, B
LINE (x, y)-(x + w, y + h), 7, BF
cbox x, y, w, h
cbox x + 1, y + 1, w - 2, h - 2
cbox x + 2, y + 2, w - 4, h - 4
cbox x + 3, y + 3, w - 6, h - 6
END SUB

SUB cbox (x, y, w, h)
LINE (x, y)-(x + w, y), 15, BF
LINE (x, y + h)-(x + w, y + h), 8, BF
LINE (x, y)-(x, y + h), 15, BF
LINE (x + w, y)-(x + w, y + h), 8, BF
PSET (x + w, y), 7
PSET (x, y + h), 7
END SUB

SUB FileMenu
x = 1: y = 48: w = 8 * 9 + 6: h = 16 * 4 + 6
DIM p%((w + 2) * (h + 2) \ 2)
GET (x - 1, y - 1)-(x + w + 1, y + h + 1), p%
LINE (x - 1, y - 1)-(x + w + 1, y + h + 1), 0, B
LINE (x, y)-(x + w, y + h), 7, BF
cbox x, y, w, h
ibox x + 1, y + 1, w - 2, h - 2
font x + 4, y + 4, "&Load..."
font x + 4, y + 20, "&Save..."
font x + 4, y + 36, "&New"
font x + 4, y + 52, "E&xit"
che = 0
ch = 5
DO
och = ch
a$ = UCASE$(INKEY$)
IF a$ = nul + CHR$(72) THEN ch = ch - 1
IF a$ = nul + CHR$(80) THEN ch = ch + 1
IF ch < 1 THEN ch = 4
IF ch > 4 THEN ch = 1
IF a$ = "L" THEN ch = 1: a$ = CHR$(13)
IF a$ = "S" THEN ch = 2: a$ = CHR$(13)
IF a$ = "N" THEN ch = 3: a$ = CHR$(13)
IF a$ = "X" THEN ch = 4: a$ = CHR$(13)
IF a$ = CHR$(27) THEN ch = 5: a$ = CHR$(13)
IF a$ = CHR$(13) THEN che = ch
IF ch <> och THEN
IF och < 5 THEN font x + 4, y + och * 16 - 12, "ллллллллл"
IF ch < 5 THEN font x + 4, y + ch * 16 - 12, "ллллллллл"
END IF
LOOP WHILE che = 0
IF che = 1 THEN LoadDialog
IF che = 2 THEN SaveDialog
IF che = 3 THEN NewGame
IF che = 4 THEN SYSTEM
PUT (x - 1, y - 1), p%, PSET
END SUB

SUB font (x, y, m$)
a = 0
FOR n = 1 TO LEN(m$)
    a = a + 1
    p$ = MID$(m$, n, 1)
    IF p$ = "~" THEN
        n = n + 1
        IF x + a * 8 < 640 AND y < 340 THEN PUT (x + a * 8 - 8, y), wht(0, 196), XOR
    END IF
    IF p$ = "&" THEN
        n = n + 1
        IF x + a * 8 < 640 AND y < 340 THEN PUT (x + a * 8 - 8, y + 1), wht(0, 95), XOR
    END IF
    IF x + a * 8 < 640 AND y < 340 THEN PUT (x + a * 8 - 8, y), wht(0, ASC(MID$(m$, n, 1))), XOR
NEXT n
END SUB

SUB GraphicsDialog

END SUB

SUB ibox (x, y, w, h)
LINE (x, y)-(x + w, y), 8, BF
LINE (x, y + h)-(x + w, y + h), 15, BF
LINE (x, y)-(x, y + h), 8, BF
LINE (x + w, y)-(x + w, y + h), 15, BF
PSET (x + w, y), 7
PSET (x, y + h), 7
END SUB

SUB ibutton (x, y, w, h)
LINE (x - 1, y - 1)-(x + w + 1, y + h + 1), 0, B
LINE (x, y)-(x + w, y + h), 7, BF
ibox x, y, w, h
ibox x + 1, y + 1, w - 2, h - 2
ibox x + 2, y + 2, w - 4, h - 4
ibox x + 3, y + 3, w - 6, h - 6
END SUB

SUB LoadDialog
END SUB

SUB MainMenu (a)
che = 0
ch = a
f = 1
DO
och = ch
a$ = UCASE$(INKEY$)
IF a$ = nul + CHR$(75) THEN ch = ch - 1
IF a$ = nul + CHR$(77) THEN ch = ch + 1
IF ch < 1 THEN ch = 3
IF ch > 3 THEN ch = 1
IF a$ = CHR$(27) THEN ch = 5: a$ = CHR$(13)
IF a$ = CHR$(13) OR a$ = nul + CHR$(80) THEN che = ch
IF och <> ch THEN IF och < 4 THEN font 5 + och * 88 - 88, 27, "лллллллллл"
IF och <> ch OR f = 1 THEN IF ch < 4 THEN font 5 + ch * 88 - 88, 27, "лллллллллл"
IF f = 1 THEN f = 0
LOOP WHILE che = 0
IF ch < 4 THEN font 5 + ch * 88 - 88, 27, "лллллллллл"

IF che = 1 THEN FileMenu
IF che = 2 THEN OptionsMenu
IF che = 3 THEN about
END SUB

SUB mdoor (x, y, w, h, t$, n$)
z = 0
LINE (x - 1, y - 1)-(x + w + 1, y + h + 1), 0, B
LINE (x, y)-(x + w, y + h), 7, BF
cbox x - 1, y - 1, w + 2, h + 2
cbox x - 2, y - 2, w + 4, h + 4
IF INSTR(t$, "S") THEN
ibox x + 1, y + 1, w - 2, 20
ibox x + 2, y + 2, w - 4, 20
font x + (w - LEN(n$) * 8 + 8) / 2, y + 4, n$
z = z + 22
END IF
IF INSTR(t$, "M") THEN
ibox x + 1, y + 1 + z, w - 2, 20
ibox x + 2, y + 2 + z, w - 4, 20
z = z + 22
END IF
cbox x, y + z, w, h - z
ibox x + 1, y + 1 + z, w - 2, h - 2 - z
IF INSTR(t$, "W") THEN LINE (x + 3, y + 3 + z)-(x + w - 3, y + h - 3), 15, BF
IF INSTR(t$, "B") THEN LINE (x + 3, y + 3 + z)-(x + w - 3, y + h - 3), 0, BF
IF INSTR(t$, "G") THEN LINE (x + 3, y + 3 + z)-(x + w - 3, y + h - 3), 8, BF
END SUB

SUB message (z$)
m$ = " "
FOR a = 1 TO LEN(z$)
t$ = MID$(z$, a, 1)
IF t$ = CHR$(0) THEN t$ = "<nul>"
IF t$ = CHR$(7) THEN t$ = "<bel>"
IF t$ = CHR$(9) THEN t$ = "<tab>"
IF t$ = CHR$(13) THEN t$ = "<enter>"
m$ = m$ + t$
NEXT a
'm$ = m$ + "chr$(" + STR$(ASC(RIGHT$(z$, 1))) + ") "
m$ = m$ + " "
w = LEN(m$) * 8 + 8
h = 50
y = 165
x = 320 - w \ 2
DIM p%((w + 2) * (h + 2) \ 2)
GET (x - 1, y - 1)-(x + w + 1, y + h + 1), p%
button x, y, w, h
button 300, y + 20, 40, 21
font x + 4, y + 3, m$
font 310, y + 23, "OK"
DO: LOOP WHILE INKEY$ <> CHR$(13)
ibutton 300, y + 20, 40, 21
font 310, y + 24, "OK"
FOR a = 1 TO 5000: NEXT a
PUT (x - 1, y - 1), p%, PSET
DO: LOOP WHILE INKEY$ <> ""
END SUB

SUB MusicDialog
END SUB

SUB NewGame
END SUB

SUB OptionsMenu
x = 90: y = 48: w = 8 * 12 + 6: h = 16 * 6 + 6
DIM p%((w + 2) * (h + 2) \ 2)
GET (x - 1, y - 1)-(x + w + 1, y + h + 1), p%
LINE (x - 1, y - 1)-(x + w + 1, y + h + 1), 0, B
LINE (x, y)-(x + w, y + h), 7, BF
cbox x, y, w, h
ibox x + 1, y + 1, w - 2, h - 2
font x + 4, y + 4, "&Players..."
font x + 4, y + 20, "&Weapons..."
font x + 4, y + 36, "&Graphics..."
font x + 4, y + 52, "&Sound..."
font x + 4, y + 68, "&Music..."
font x + 4, y + 84, "Sound &On/&Off"
che = 0
ch = 7
DO
och = ch
a$ = UCASE$(INKEY$)
IF a$ = nul + CHR$(72) THEN ch = ch - 1
IF a$ = nul + CHR$(80) THEN ch = ch + 1
IF ch < 1 THEN ch = 6
IF ch > 6 THEN ch = 1
IF a$ = "P" THEN ch = 1: a$ = CHR$(13)
IF a$ = "W" THEN ch = 2: a$ = CHR$(13)
IF a$ = "G" THEN ch = 3: a$ = CHR$(13)
IF a$ = "S" THEN ch = 4: a$ = CHR$(13)
IF a$ = "M" THEN ch = 5: a$ = CHR$(13)
IF a$ = "O" THEN ch = 6: a$ = CHR$(13)
IF a$ = CHR$(27) THEN ch = 7: a$ = CHR$(13)
IF a$ = CHR$(13) THEN che = ch
IF ch <> och THEN
IF och < 7 THEN font x + 4, y + och * 16 - 12, "лллллллллллл"
IF ch < 7 THEN font x + 4, y + ch * 16 - 12, "лллллллллллл"
END IF
LOOP WHILE che = 0

IF che = 1 THEN PlayersDialog
IF che = 2 THEN WeaponsDialog
IF che = 3 THEN GraphicsDialog
IF che = 4 THEN SoundDialog
IF che = 5 THEN MusicDialog
IF che = 6 THEN IsSound = 1 - IsSound:  IF IsSound THEN SOUND 300, 1: message "Sound ON": SOUND 500, 1:  ELSE message "Sound OFF"
 
PUT (x - 1, y - 1), p%, PSET
END SUB

SUB PlayersDialog
END SUB

SUB SaveDialog
END SUB

SUB SoundDialog
END SUB

SUB WeaponsDialog
END SUB

