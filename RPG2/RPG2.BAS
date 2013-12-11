DECLARE SUB ANIM ()
DECLARE SUB PlayWav (FILENAME$, freq&)
DECLARE SUB charpic (mx%, my%, FILENAME$)
DECLARE SUB swapevents (X1%, Y1%, X2%, Y2%)
DECLARE SUB fight ()
DECLARE SUB die (file$)
DECLARE SUB died ()
DECLARE SUB win ()
DECLARE SUB AddMonster (f$)
DECLARE SUB AddCharacter (f$)
DECLARE SUB faces ()
DECLARE SUB blackout ()
DECLARE SUB frame ()
DECLARE FUNCTION runrpg$ (label$)
DECLARE SUB WORLD ()
DECLARE SUB addevent (x%, y%, label$)
DECLARE SUB LoadRPG (file$)
DECLARE FUNCTION Where% (label$)
DECLARE SUB LoadMap (file$)
DECLARE SUB additem (itm$)
DECLARE SUB takeitem (itm$)
DECLARE FUNCTION ifItem% (itm$)
DECLARE SUB font (x!, y!, txt$)
DECLARE SUB credits ()

DECLARE SUB ending ()
DECLARE SUB scroll (txt$)
DECLARE SUB delay (t%)
DECLARE SUB loadScreen (FILENAME$)
DECLARE SUB MIDIInit ()
DECLARE SUB center (txt$)
DECLARE SUB STARTMIDI (FILENAME$)
DECLARE SUB DMAInit ()
DECLARE SUB loadpal (FILENAME$)
DECLARE SUB GameInit ()
DEFINT A-Z
' RPG game # 2 - Shadow Falls
' Setting:  Mideveal, Dark Ages
' Quest: ???
'
' Supports:
'   MIDI background music:
'       Songs for each character
'       Songs for main map
'       Music for fights
'       others...
'   DMA Blaster effects:
'       Play back at any rate
'       Sound Blaster effects for all
'       Sound Effects...
'   VGA graphics:
'       320x240 with 256 colors
'       Full screen pics
'       Palette animation
'       Smart graphics loading
'
' Credits:
'   Made by: Three Sharks Entertainment (TSE)
'   Tim Caswell - Programmer
'   Greg Burris - Music
'   Charlie Bassett - Art and story line
'   ???????????? - Play tester
'   Mike Huff - background MIDI code.
'   Rick Elbers - author of the QBasic Interrupt for MIDI
'   Mike Huff - Audio file player that plays using the DMA channels.
'
' DISCLAIMER:
'   ----------
'   This program directly accesses a lot of memory.  It may interfere with
'   pointers held by other programs on your computer.
'   If your computer suffers crashes, loss of data, or is taken over by
'   smurfs as a result of this game, I won't be responsible for it.

'**** START OF CODE ****
' My Subs and Functions
COMMON SHARED blaster, DELAYSEC&

' MIDI subs and Functions
DECLARE FUNCTION BytesRequired& (FILENAME$)
DECLARE SUB DriversLoaded (SBMIDI%, SBSIM%)
DECLARE SUB GetIntVector (IntNum%, Segment%, Offset%)
DECLARE SUB LoadAndPlayMIDI (FILENAME$, MIDISegment%, MIDIOffset%)
DECLARE FUNCTION MIDIError$ ()
DECLARE SUB stopMIDI ()
DECLARE FUNCTION TimeMIDI! ()

' DMA SUBS and Functions
DECLARE FUNCTION SpeakerStatus% ()
DECLARE FUNCTION DMAStatus% ()
DECLARE FUNCTION DMADone% ()
DECLARE FUNCTION ResetDSP% ()
DECLARE SUB FMVolume (Right%, Left%, Getvol%)
DECLARE SUB VocVolume (Right%, Left%, Getvol%)
DECLARE SUB MasterVolume (Right%, Left%, Getvol%)
DECLARE SUB MicVolume (Gain%, Getvol%)
DECLARE SUB LineVolume (Right%, Left%, Getvol%)
DECLARE SUB CDVolume (Right%, Left%, Getvol%)
DECLARE SUB InputSource (InputSrc%, GetSrc%)
DECLARE SUB WriteDSP (byte%)
DECLARE SUB SetStereo (OnOff%)
DECLARE FUNCTION ReadDSP% ()
DECLARE SUB WriteDAC (byte%)
DECLARE SUB SpeakerState (OnOff%)
DECLARE SUB DMAState (StopGo%)
DECLARE FUNCTION ReadDAC% ()
DECLARE SUB DMAPlay (Segment&, Offset&, length&, freq&)
DECLARE SUB DMARecord (Segment&, Offset&, length&, freq&)
DECLARE SUB GetBLASTER (DMA%, BasePort%, IRQ%)
DECLARE FUNCTION DSPVersion! ()
COMMON SHARED BasePort%, LenPort%, Channel%, IRQ%

' MIDI data
DIM SHARED MIDI.PLAYTIME AS SINGLE
DIM SHARED MIDI.ERROR AS INTEGER
DIM SHARED MIDI.LOADED AS INTEGER
DIM SHARED SBMIDI.INTERRUPT AS INTEGER
DIM SHARED SBSIM.INTERRUPT AS INTEGER
MIDI.PLAYTIME = 0
MIDI.ERROR = 0
MIDI.LOADED = 0
SBMIDI.INTERRUPT = &H80
SBSIM.INTERRUPT = &H81

CONST MAXLABELS = 50
CONST MAXITEMS = 50
CONST MAXEVENTS = 30
CONST MAXPROG = 300

' $DYNAMIC

DIM SHARED pic(400, 20)
DIM SHARED fon%(64, 127)
DIM SHARED lab(MAXLABELS), party$(6), enemy$(6)
DIM SHARED labl$(MAXLABELS), prog$(MAXPROG), list$(MAXITEMS)
DIM SHARED plx, ply, lbl, Mapx, MapY, COMD$(25)
DIM SHARED EV$(MAXEVENTS), EY(MAXEVENTS), EX(MAXEVENTS), MODE
DIM SHARED opaque(20)
DIM SHARED map(180, 110)
DIM solid(20), light(20), tile$(20)

solid(2) = 2: solid(4) = 2: solid(8) = 2: solid(0) = 2: 'fLOOR TYPES
solid(1) = 1: solid(3) = 1: solid(5) = 1: solid(6) = 1: solid(14) = 1: solid(18) = 1: solid(12) = 1: solid(19) = 1: solid(20) = 1 ' SOLID TYPES
light(12) = 1: light(13) = 1: light(14) = 1: light(15) = 1: light(18) = 1 'LIGHT ENOUGH TO PUSH
opaque(3) = 1: opaque(5) = 1: opaque(9) = 1: opaque(6) = 1 'OPAQUE
opaque(11) = 2
opaque(19) = 2
COMD$(0) = "LABEL": COMD$(1) = "GOTO": COMD$(2) = "MIDI": COMD$(3) = "WAV"
COMD$(4) = "MAP": COMD$(5) = "FIGHT": COMD$(6) = "WORLD": COMD$(7) = "RPG"
COMD$(8) = "EVENT": COMD$(9) = "MONSTER": COMD$(10) = "CHARACTER"
COMD$(11) = "DIE": COMD$(12) = "WIN": COMD$(13) = "CHARPIC": COMD$(14) = "COLOR"
COMD$(15) = "ASK": COMD$(16) = "SAY": COMD$(17) = "ADDITEM": COMD$(18) = "TAKEITEM"
COMD$(19) = "IFITEM": COMD$(20) = "THEN": COMD$(21) = "ENDIF": COMD$(22) = "WAIT"
COMD$(23) = "BLACKOUT"

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
COLOR 15
PALETTE 15, 0
FOR a = 0 TO 127
LOCATE 1, 1
IF a > 30 THEN PRINT CHR$(a) ELSE PRINT " "
GET (0, 0)-(7, 7), fon%(0, a)
NEXT a


'Game code starts here
'$DYNAMIC
blaster = 0: 'Tries to finD blaster
SCREEN 0
CLS
DMAInit
MIDIInit
IF blaster = 1 THEN
    FILENAME$ = "13.mid"
    REDIM MIDI%(BytesRequired&(FILENAME$) \ 2)
    LoadAndPlayMIDI FILENAME$, VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
END IF
DEF SEG = VARSEG(pic(0, 0))
BLOAD "rpg2.pic", 0

GameInit

DO
ANIM
a$ = INKEY$
LOOP WHILE a$ <> CHR$(13)
GOSUB playit
' Return to the system
CALL ending
playit:
VIEW PRINT 21 TO 25
DEF SEG = &HA000
BLOAD "frame.pic", 0
LoadRPG "Main.rpg"
com$ = runrpg$("start")
DO
a$ = INKEY$
ox = plx: oy = ply
IF a$ = "-" THEN DELAYSEC& = DELAYSEC& * .8
IF a$ = "+" THEN DELAYSEC& = DELAYSEC& * 1.2
IF a$ = "8" THEN ply = ply - 1
IF a$ = "4" THEN plx = plx - 1
IF a$ = "6" THEN plx = plx + 1
IF a$ = "2" THEN ply = ply + 1
IF a$ = "s" THEN
    INPUT "Save screen as"; f$
    DEF SEG = &HA000
    BSAVE f$, 0, 64000
END IF
IF a$ = "P" THEN
    PRINT "Push which way ";
    DX = 0: DY = 0
    DO
    ANIM
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
    ANIM
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
                f$ = MID$(com$, sp + 1)
                LoadRPG f$
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
    ANIM
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
                f$ = MID$(com$, sp + 1)
                LoadRPG f$
                com$ = runrpg$(l$)
                GOTO loopstart
            END IF
        END IF
    NEXT a
END IF
ANIM

LOOP WHILE a$ <> "Q"



RETURN

'DriversLoaded routine data
SBMIDIData:
DATA 156,30,6,80,83,81,82,87,86,85,139,236,80,184,14,16,142,216,142,192,88,131,78,24,1,199,70,12,255,255,128,62
DATA 68,1,0,117,59,198,6,68,1,1,251,252,11,219,120,21,129,251,13,0,115,37,131,102,24,254,209,227,255,151,40,0
DATA 137,70,12,235,22,247,219,75,129,251,3,0,115,13,131,102,24,254,209,227,255,151,34,0,137,70,12,198,6,68,1,0
DATA 93,94,95,90,89,91,88,7,31,157,207,156,250,30,6,80,184,14,16,142,216,142,192,161,145,1,1,6,28,0,114,6
DATA 176,32,230,32,235,9,255,6,28,0,156,255,30,18,0,83,81,82,87,86,85,139,236,250,128,62,67,1,0,117,54,140
DATA 22,32,0,137,38,30,0,140,216,142,208,188,66,1,198,6,67,1,1,251,252,131,62,133,1,0,116,10,128,62,21,3
DATA 0,117,3,232,143,4,250,139,38,30,0,142,22,32,0,198,6,67,1,0,251,93,94,95,90,89,91,88,7,31,157,207
DATA 30,6,80,83,81,82,87,86,85,156,184,14,16,142,216,142,192,228,96,10,192,120,18,60,83,117,14,180,2,205,22,36
SBSIMData:
DATA 46,143,6,134,1,46,143,6,132,1,46,143,6,130,1,46,131,14,130,1,1,46,131,62,110,1,0,116,6,184,1,0
DATA 233,193,0,128,255,5,119,25,10,255,116,27,81,80,51,192,138,207,128,225,127,249,211,208,46,35,6,126,1,88,89,117
DATA 6,184,2,0,233,157,0,250,46,140,30,138,1,14,31,140,22,140,1,137,38,142,1,142,22,152,1,139,38,154,1,85
DATA 139,236,86,87,6,83,163,144,1,137,22,148,1,137,14,146,1,180,98,205,33,137,30,150,1,180,80,140,203,205,33,199
DATA 6,110,1,1,0,251,252,50,192,255,30,118,1,139,94,248,83,134,251,3,219,3,219,50,255,254,14,124,1,117,11,129
DATA 6,152,1,0,0,198,6,124,1,20,139,243,91,50,255,30,7,255,156,176,1,114,5,131,38,130,1,254,250,199,6,110
DATA 1,0,0,80,180,80,139,30,150,1,205,33,88,91,7,95,94,139,229,93,139,14,146,1,142,22,140,1,139,38,142,1
DATA 142,30,138,1,46,255,54,130,1,46,255,54,132,1,46,255,54,134,1,207,85,139,236,131,236,10,137,70,248,137,94,250

REM $STATIC
SUB AddCharacter (f$)
FOR a = 1 TO 6
IF party$(a) = "none.chr" THEN party$(a) = f$: a = 6
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

SUB AddMonster (f$)
FOR a = 1 TO 6
IF enemy$(a) = "none.chr" THEN enemy$(a) = f$: a = 6
NEXT a
END SUB

SUB ANIM
STATIC HP
HP = (HP + 1) MOD 64
delay 1
OUT &H3C8, 1
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(HP - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((HP + 20) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, ABS(((HP + 40) MOD 64) - 32) + 31
OUT &H3C9, 0: OUT &H3C9, ABS(((HP) MOD 64) * 2 - 63): OUT &H3C9, 0
OUT &H3C8, 80
FOR a = 0 TO 15         '80-95 Fire shades
OUT &H3C9, 32 + ((HP + a * 4) MOD 64 \ 2)
OUT &H3C9, ((HP + a * 4) MOD 64) * ((HP + a * 4) MOD 64) \ 64
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

DEFSNG A-Z
'BytesRequired - Returns the amount of memory needed to store a file.
FUNCTION BytesRequired& (FILENAME$)
'Open the file.
FF% = FREEFILE
OPEN FILENAME$ FOR BINARY AS #FF%
'Store the length of the file.
FileLen& = LOF(FF%)
'Close the file.
CLOSE FF%
'If the length of the file is 0, assume it does not exist and delete it.
IF FileLen& = 0 THEN KILL FILENAME$
'Return the length of the file as the number of bytes required.
BytesRequired& = FileLen&
END FUNCTION

SUB center (txt$)
LOCATE , 40 - LEN(txt$) \ 2
PRINT txt$
END SUB

DEFINT A-Z
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

DEFSNG A-Z
SUB credits
STARTMIDI "13.mid"
CLS
scroll "Shadow Falls"
scroll "Credits:"
scroll "Three Sharks Entertainment (TSE)"
scroll "Tim Caswell - Programmer"
scroll "Greg Burris - Music"
scroll "Charlie Bassett - Art and story line"
scroll "???????????? - Play tester"
scroll "Mike Huff - background MIDI and DMA"
scroll "Rick Elbers - Interrupt for MIDI"

END SUB

DEFINT A-Z
SUB delay (t%)
FOR a& = 1 TO t% * DELAYSEC& / 40
t! = TIMER
NEXT a&
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

DEFSNG A-Z
FUNCTION DMADone%
Count% = INP(LenPort%)
Count2% = INP(LenPort%)
Count& = CLNG(Count% + 1) * CLNG(Count2% + 1)
IF (Count& - 1) >= &HFFFF& THEN junk% = INP(DSPDataAvail%): DMADone% = -1
END FUNCTION

DEFINT A-Z
SUB DMAInit
' DMA init
CLS
GetBLASTER Channel%, BasePort%, IRQ% ' Parses BLASTER environment
IF blaster = 0 THEN EXIT SUB
PRINT STRING$(80, 196)
IF ResetDSP% THEN 'resets DSP (returns true if sucessful)
   PRINT "DSP reset sucessfully!"
ELSE
   PRINT "DSP failed to reset, try another port."
   STOP
END IF

SpeakerState 1 'turn the speaker on
PRINT "Sound Card DSP version:"; DSPVersion!

MasterVolume Right%, Left%, -1 'this puts the mixer volumes in Right% and Left%
PRINT "Master volume is set at: Right-"; Right%; " Left-"; Left%
MasterVolume 13, 13, 0 '15,15,0 cranks the master volume all the way up.

END SUB

DEFSNG A-Z
SUB DMAPlay (Segment&, Offset&, length&, freq&)
' Transfers and plays the contents of the buffer.
length& = length& - 1
Page% = 0
MemLoc& = Segment& * 16 + Offset&
SELECT CASE Channel%
    CASE 0
       PgPort% = &H87
       AddPort% = &H0
       LenPort% = &H1
       ModeReg% = &H48
    CASE 1
       PgPort% = &H83
       AddPort% = &H2
       LenPort% = &H3
       ModeReg% = &H49
    CASE 2
       PgPort% = &H81
       AddPort% = &H4
       LenPort% = &H5
       ModeReg% = &H4A
    CASE 3
       PgPort% = &H82
       AddPort% = &H6
       LenPort% = &H7
       ModeReg% = &H4B
    CASE ELSE
       PRINT "DMA channels 0-3 only are supported."
       EXIT SUB
END SELECT

OUT &HA, &H4 + Channel%
OUT &HC, &H0
OUT &HB, ModeReg%
OUT AddPort%, MemLoc& AND &HFF
OUT AddPort%, (MemLoc& AND &HFFFF&) \ &H100
IF (MemLoc& AND 65536) THEN Page% = Page% + 1
IF (MemLoc& AND 131072) THEN Page% = Page% + 2
IF (MemLoc& AND 262144) THEN Page% = Page% + 4
IF (MemLoc& AND 524288) THEN Page% = Page% + 8
OUT PgPort%, Page%
OUT LenPort%, length& AND &HFF
OUT LenPort%, (length& AND &HFFFF&) \ &H100
OUT &HA, Channel%

IF freq& < 23000 THEN
   TimeConst% = 256 - 1000000 \ freq&
   WriteDSP &H40
   WriteDSP TimeConst%
   WriteDSP &H14
   WriteDSP (length& AND &HFF)
   WriteDSP ((length& AND &HFFFF&) \ &H100)
ELSE
   IF DSPVersion! >= 3 THEN
      TimeConst% = ((65536 - 256000000 \ freq&) AND &HFFFF&) \ &H100
      WriteDSP &H40
      WriteDSP TimeConst%
      WriteDSP (length& AND &HFF)
      WriteDSP ((length& AND &HFFFF&) \ &H100)
      WriteDSP &H91
   ELSE
      PRINT "You need a Sound Blaster with a DSP v3.x+ to play at high speed."
      EXIT SUB
   END IF
END IF
END SUB

SUB DMAState (StopGo%)
' Stops or continues DMA play.
IF StopGo% THEN WriteDSP &HD4 ELSE WriteDSP &HD0

END SUB

DEFINT A-Z
SUB DriversLoaded (SBMIDI%, SBSIM%) STATIC

'Check the interrupt handlers for int 80h-89h to see if they contain
'program code from either SBSIM or SBMIDI.  Only those 10 interrupts
'are checked because chances are slim that either driver will be loaded
'at int 8Ah or higher, and they will never load themselves below
'80h.

FOR i% = &H80 TO &H8A
    'Get the address of the interrupt handler.
    GetIntVector i%, Segment%, Offset%
    'If the address is null, then the interrupt is not in use, and can be
    'skipped.
    IF Segment% = 0 AND Offset% = 0 THEN GOTO Skip:
  
    'Point to the segment of the interrupt handler.
    DEF SEG = Segment%
    RESTORE SBMIDIData:
    FOR J% = 0 TO 255
        'Read a byte of the SBMIDI program code that has been previously
        'saved.
        READ Byte1%
        'Read a byte of code from the current interrupt handler.
        Byte2% = PEEK(Offset% + J%)
        'Do they match?  If so, we may have found SBMIDI!
        IF Byte1% = Byte2% THEN
            MatchSBMIDI% = 1
        'If not, this interrupt is definitely not occupied by SBMIDI.
        ELSE
            SELECT CASE J%
                CASE IS = 14, 15, 113, 114, 235, 236
                CASE ELSE
                    MatchSBMIDI% = 0
                    EXIT FOR
            END SELECT
        END IF
    NEXT J%
    'If there's a match, set SBMIDI% to the current interrupt.
    IF MatchSBMIDI% THEN SBMIDI% = i%
    RESTORE SBSIMData:
    FOR J% = 0 TO 255
        'Read a byte of the SBSIM program code that has been previously
        'saved.
        READ Byte1%
        'Read a byte of code from the current interrupt handler.
        Byte2% = PEEK(Offset% + J%)
        'If the values match, SBSIM may be loaded at this interrupt.
        IF Byte1% = Byte2% THEN
            MatchSBSIM% = 1
        'If not, then it isn't.
        ELSE
            MatchSBSIM% = 0
            EXIT FOR
        END IF
    NEXT J%
    'If this interrupt handler is a match, set SBSIM% to the current
    'interrupt number.
    IF MatchSBSIM% THEN SBSIM% = i%
  
    'If both SBMIDI% and SBSIM% have been detected, there's no need to
    'check the rest of the interrupt handling routines.
    IF MatchSBMIDI% AND MatchSBSIM% THEN EXIT FOR
Skip:
NEXT i%
END SUB

DEFSNG A-Z
FUNCTION DSPVersion!
' Gets the DSP version.
WriteDSP &HE1
Temp% = ReadDSP%
Temp2% = ReadDSP%
DSPVersion! = VAL(STR$(Temp%) + "." + STR$(Temp2%))
END FUNCTION

SUB ending
credits
SCREEN 0: WIDTH 80
COLOR 7, 0
CLS
stopMIDI
SYSTEM
END SUB

DEFINT A-Z
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

SUB FMVolume (Right%, Left%, Getvol%)
IF blaster = 0 THEN EXIT SUB
OUT BasePort% + 4, &H26
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

DEFSNG A-Z
SUB font (x, y, txt$)
FOR a = 1 TO LEN(txt$)
PUT (x + a * 8 - 8, y), fon%(0, (ASC(MID$(txt$, a, 1)))), PSET
LINE (x + a * 8 - 8, y + 8)-(x + a * 8 - 1, y + 11), 0, BF
NEXT a
END SUB

DEFINT A-Z
SUB frame
DEF SEG = &HA000
BLOAD "frame.pic", 0
END SUB

SUB GameInit
CLS
SCREEN 13
CLS
loadpal "GAME.pal"
'credits
loadScreen "Title.pic"
DELAYSEC& = 0
t! = TIMER
FOR a = 0 TO 2
IF TIMER - t! < 1 THEN a = 0
DELAYSEC& = DELAYSEC& + 1
NEXT a

END SUB

SUB GetBLASTER (DMA%, BasePort%, IRQ%)
IF blaster = 0 THEN EXIT SUB
' This subroutine parses the BLASTER environment string and returns settings.
IF LEN(ENVIRON$("BLASTER")) = 0 THEN PRINT "BLASTER environment variable not set.": blaster = 0: EXIT SUB
FOR length% = 1 TO LEN(ENVIRON$("BLASTER"))
   SELECT CASE MID$(ENVIRON$("BLASTER"), length%, 1)
      CASE "A"
        BasePort% = VAL("&H" + MID$(ENVIRON$("BLASTER"), length% + 1, 3))
      CASE "I"
        IRQ% = VAL(MID$(ENVIRON$("BLASTER"), length% + 1, 1))
      CASE "D"
        DMA% = VAL(MID$(ENVIRON$("BLASTER"), length% + 1, 1))
   END SELECT
NEXT
END SUB

SUB GetIntVector (IntNum%, Segment%, Offset%) STATIC
'If the code hasn't been loaded already, do it now.
IF GetIntVCodeLoaded% = 0 THEN
    asm$ = asm$ + CHR$(&H55)
    asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)
    asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)
    asm$ = asm$ + CHR$(&H8A) + CHR$(&H7)
    asm$ = asm$ + CHR$(&HB4) + CHR$(&H35)
    asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)
    asm$ = asm$ + CHR$(&H8C) + CHR$(&HC1)
    asm$ = asm$ + CHR$(&H89) + CHR$(&HDA)
    asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
    asm$ = asm$ + CHR$(&H89) + CHR$(&HF)
    asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
    asm$ = asm$ + CHR$(&H89) + CHR$(&H17)
    asm$ = asm$ + CHR$(&H5D)
    asm$ = asm$ + CHR$(&HCB)
    asm$ = asm$ + CHR$(&H34) + CHR$(&H0)
    asm$ = asm$ + CHR$(&H60)
    asm$ = asm$ + CHR$(&H23) + CHR$(&H0)
    GetIntVCodeLoaded% = 1
END IF
'Execute the code
DEF SEG = VARSEG(asm$)
CALL ABSOLUTE(IntNum%, Segment%, Offset%, SADD(asm$))
END SUB

FUNCTION ifItem (itm$)
    i = 0
    FOR a = 1 TO MAXITEMS
        IF list$(a) = itm$ THEN i = a
    NEXT a
    ifItem = i
END FUNCTION

DEFSNG A-Z
SUB InputSource (InputSrc%, GetSrc%)
OUT BasePort% + 4, &HC
IF GetSrc% THEN
   InputSrc% = INP(BasePort% + 5) AND 2 + INP(BasePort% + 5) AND 4
ELSE
   OUT BasePort% + 5, InputSrc% AND 7
END IF
END SUB

DEFINT A-Z
SUB LineVolume (Right%, Left%, Getvol%)
IF blaster = 0 THEN EXIT SUB
OUT BasePort% + 4, &H2E
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

'LoadAndPlayMIDI - Loads a MIDI file into memory and plays it
SUB LoadAndPlayMIDI (FILENAME$, MIDISegment%, MIDIOffset%)
IF blaster = 0 THEN EXIT SUB
'See if an extension was supplied, and if not, add one.
IF INSTR(FILENAME$, ".") = 0 THEN FILENAME$ = FILENAME$ + ".MID"
'Open the file
FF% = FREEFILE
OPEN FILENAME$ FOR BINARY AS #FF%
FileLen& = LOF(FF%)
CLOSE #FF%
'If the file is empty, delete it and exit now.
IF FileLen& = 0 THEN KILL FILENAME$: MIDI.ERROR = 1: EXIT SUB
'If the file is too large, exit now.
IF FileLen& > 65536 THEN MIDI.ERROR = 2: EXIT SUB
'Make the filename an ASCIIZ string.
FILENAME$ = FILENAME$ + CHR$(0)
'Check if the MIDI loading code has already been loaded;
'if not, do it now.
IF LoadCodeLoaded% = 0 THEN
        asm1$ = asm1$ + CHR$(&H1E)
        asm1$ = asm1$ + CHR$(&H55)
        asm1$ = asm1$ + CHR$(&H89) + CHR$(&HE5)
        asm1$ = asm1$ + CHR$(&HB8) + CHR$(&H0) + CHR$(&H3D)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HE)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H17)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H10)
        asm1$ = asm1$ + CHR$(&H8E) + CHR$(&H1F)
        asm1$ = asm1$ + CHR$(&HCD) + CHR$(&H21)
        asm1$ = asm1$ + CHR$(&H89) + CHR$(&HC6)
        asm1$ = asm1$ + CHR$(&HB4) + CHR$(&H3F)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&HF)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H17)
        asm1$ = asm1$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HC)
        asm1$ = asm1$ + CHR$(&H8E) + CHR$(&H1F)
        asm1$ = asm1$ + CHR$(&H89) + CHR$(&HF3)
        asm1$ = asm1$ + CHR$(&HCD) + CHR$(&H21)
        asm1$ = asm1$ + CHR$(&HB4) + CHR$(&H3E)
        asm1$ = asm1$ + CHR$(&HCD) + CHR$(&H21)
        asm1$ = asm1$ + CHR$(&H5D)
        asm1$ = asm1$ + CHR$(&H1F)
        asm1$ = asm1$ + CHR$(&HCA) + CHR$(&HA) + CHR$(&H0)
        LoadCodeLoaded% = 1
END IF
'Call the assembly language routine.
DEF SEG = VARSEG(asm1$)
CALL ABSOLUTE(VARSEG(FILENAME$), SADD(FILENAME$), MIDISegment%, MIDIOffset%, &HFFFF, SADD(asm1$))
'Check to see if the MIDI playing code has previously been loaded.
'If not, load it now.
IF PlayCodeLoaded% = 0 THEN
        'Load the machine codes into a string.
        asm2$ = asm2$ + CHR$(&H55)
        asm2$ = asm2$ + CHR$(&H89) + CHR$(&HE5)
        asm2$ = asm2$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm2$ = asm2$ + CHR$(&H8B) + CHR$(&H17)
        asm2$ = asm2$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
        asm2$ = asm2$ + CHR$(&H8B) + CHR$(&H7)
        asm2$ = asm2$ + CHR$(&HBB) + CHR$(&H4) + CHR$(&H0)
        asm2$ = asm2$ + CHR$(&HCD) + CHR$(SBMIDI.INTERRUPT)
        asm2$ = asm2$ + CHR$(&HBB) + CHR$(&H5) + CHR$(&H0)
        asm2$ = asm2$ + CHR$(&HCD) + CHR$(SBMIDI.INTERRUPT)
        asm2$ = asm2$ + CHR$(&H5D)
        asm2$ = asm2$ + CHR$(&HCA) + CHR$(&H4) + CHR$(&H0)
        'Indicate that the code has been loaded.
        PlayCodeLoaded% = 1
END IF
'Call the machine language routine to play the music.
DEF SEG = VARSEG(asm2$)
CALL ABSOLUTE(MIDISegment%, MIDIOffset%, SADD(asm2$))
'Start the MIDI timer.
MIDI.PLAYTIME = TIMER
END SUB

SUB LoadMap (file$)
'ERASE map
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

DEFSNG A-Z
SUB loadScreen (FILENAME$)
DEF SEG = &HA000
BLOAD FILENAME$, 0
DEF SEG
END SUB

SUB MasterVolume (Right%, Left%, Getvol%)
OUT BasePort% + 4, &H22
'PRINT BasePort%
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

DEFINT A-Z
SUB MicVolume (Volume%, Getvol%)
OUT BasePort% + 4, &HA
IF Getvol% THEN
   Volume% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, Volume% AND &HF
END IF
END SUB

FUNCTION MIDIError$
SELECT CASE MIDI.ERROR
        CASE 0: MIDIError$ = "NO ERROR"
        CASE 1: MIDIError$ = "FILE CONTAINS NO DATA"
        CASE 2: MIDIError$ = "FILE IS TOO LARGE"
        CASE 3: MIDIError$ = "NO MIDI FILE PLAYING"
        CASE ELSE: MIDIError$ = "UNKNOWN ERROR"
END SELECT
END FUNCTION

SUB MIDIInit
IF blaster = 0 THEN EXIT SUB
center "Looking for sound drivers..."
DriversLoaded SBMIDI.INTERRUPT, SBSIM.INTERRUPT
SELECT CASE SBMIDI.INTERRUPT
        CASE 0:
                center "UH-OH!!  The SBMIDI driver could not be found!"
                center "Are you sure you want to continue? (Y/N)"
                a$ = UCASE$(INPUT$(1))
                blaster = 0
                IF a$ <> "Y" THEN
                        SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
                END IF
        CASE ELSE:
                PRINT
                center "SBMIDI driver found!"
               
END SELECT
SELECT CASE SBSIM.INTERRUPT
        CASE 0:
                center "UH-OH!!  The SBSIM driver could not be found!"
                center "Are you sure you want to continue? (Y/N)"
                a$ = UCASE$(INPUT$(1))
                blaster = 0
                IF a$ <> "Y" THEN
                        SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
                END IF
        CASE ELSE:
                center "SBSIM driver found!"
                PRINT
                'Prompt the user for a key press.
                
END SELECT

END SUB

DEFSNG A-Z
SUB pause
DO: LOOP WHILE INKEY$ <> ""
DO: LOOP WHILE INKEY$ = ""
END SUB

DEFINT A-Z
'
SUB PlayWav (FILENAME$, freq&)
IF blaster = 0 THEN EXIT SUB

' filename$ Wav to play
' freq& (1000-41000Hz)

DIM WavBuffer(1 TO 1) AS STRING * 32767 'Make a 32k buffer for file.
OPEN FILENAME$ FOR BINARY AS #1
DO

    'Get 32k from file (skip header on WAV)
    GET #1, 44 + (32767 * CurrentPlay!), WavBuffer(1)
    CurrentPlay! = CurrentPlay! + 1
    length& = LOF(1) - 44
    IF length& > 32767 THEN length& = 32767 'Adjust length if needed to 32k
    DMAPlay VARSEG(WavBuffer(1)), VARPTR(WavBuffer(1)), length&, freq&

    DO UNTIL a = 11500: a = a + 1: LOOP: a = 0
LOOP UNTIL EOF(1)

'Use DMARecord to record in the background.
'and use DMAPlay to playback the same buffer you recorded to or you could
'even write the buffer to a file.
'DMARecord VARSEG(WavBuffer(1)), VARPTR(WavBuffer(1)), Length&, Freq&

END SUB

DEFSNG A-Z
FUNCTION ReadDAC%
' Reads a byte from the DAC.
WriteDSP &H20
ReadDAC% = ReadDSP%
END FUNCTION

FUNCTION ReadDSP%
' Reads a byte from the DSP
DO
LOOP UNTIL INP(BasePort% + 14) AND &H80
ReadDSP% = INP(BasePort% + 10)
END FUNCTION

FUNCTION ResetDSP%
' Resets the DSP
OUT BasePort% + 6, 1
FOR Count% = 1 TO 4
   junk% = INP(BasePort% + 6)
NEXT
OUT BasePort% + 6, 0
IF INP(BasePort% + 14) AND &H80 = &H80 AND INP(BasePort% + 10) = &HAA THEN
   ResetDSP% = -1
ELSE
   ResetDSP% = 0
END IF
END FUNCTION

DEFINT A-Z
FUNCTION runrpg$ (label$)
a = Where(label$)
IF a < 0 THEN EXIT FUNCTION
runrpg$ = ""
DO
ANIM
a = a + 1
cmd = ASC(LEFT$(prog$(a) + " ", 1)) - 200
com$ = MID$(prog$(a), 2)
IF cmd = 1 THEN a = Where(com$)
IF cmd = 2 THEN STARTMIDI com$
IF cmd = 3 THEN PlayWav com$, 10000
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
    DO: ANIM: a$ = UCASE$(INKEY$): LOOP WHILE a$ <> "Y" AND a$ <> "N"
    IF a$ = "N" THEN PRINT "NO": a = a + 1 ELSE PRINT "YES"
END IF
IF cmd = 16 THEN PRINT UCASE$(com$)
IF cmd = 17 THEN additem com$
IF cmd = 18 THEN takeitem com$
IF cmd = 19 THEN IF ifItem(com$) = 0 THEN a = a + 1
IF cmd = 23 THEN blackout
IF cmd = 25 THEN
    DO: ANIM: LOOP WHILE INKEY$ = ""
END IF
LOOP WHILE cmd <> 22 AND a < MAXPROG
WORLD
END FUNCTION

DEFSNG A-Z
SUB savePal (FILENAME$)
DIM pal(767) AS STRING * 1
OUT &H3C8, 0
FOR a% = 0 TO 767
    pal(a%) = CHR$(INP(&H3C9))
NEXT a%
DEF SEG = VARSEG(pal(0))
BSAVE FILENAME$, 0, 768
DEF SEG
END SUB

SUB SaveScreen (FILENAME$)
DEF SEG = &HA000
BSAVE FILENAME$, 0, 64000
DEF SEG
END SUB

SUB scroll (txt$)
FOR sy = 191 TO 0 STEP -1
PSET (320 * RND, 200 * RND), INT(3 * RND) + 1
ANIM
sx = ((20 - LEN(txt$) \ 2) * 8 - 8)
font sx, sy, txt$
IF INKEY$ = CHR$(13) THEN sy = 0: CLS
NEXT sy
LINE (0, 0)-(320, 9), 0, BF
END SUB

SUB SetStereo (OnOff%)
OUT BasePort% + 4, &HE
IF OnOff% THEN OUT BasePort% + 5, 2 ELSE OUT BasePort% + 5, 0
END SUB

DEFINT A-Z
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
IF a MOD 5 = 0 THEN DO: ANIM: LOOP WHILE INKEY$ = "": IF prog$(a) = "" THEN a = MAXPROG
NEXT a

END SUB

DEFSNG A-Z
SUB SpeakerState (OnOff%)
' Turns speaker on or off.
IF OnOff% THEN WriteDSP &HD1 ELSE WriteDSP &HD3
END SUB

FUNCTION SpeakerStatus%
OUT BasePort% + 4, &HD8
IF INP(BasePort% + 5) = &HFF THEN SpeakerStatus% = -1 ELSE SpeakerStatus% = 0
END FUNCTION

DEFINT A-Z
          ''
SUB STARTMIDI (FILENAME$)
IF blaster = 0 THEN EXIT SUB
stopMIDI
REDIM MIDI%(BytesRequired&(FILENAME$) \ 2)
LoadAndPlayMIDI FILENAME$, VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
END SUB

'StopMIDI - Stops playing MIDI file
          ''
SUB stopMIDI
IF blaster = 0 THEN EXIT SUB
'Stop the music!!
asm$ = asm$ + CHR$(&HBB) + CHR$(&H4) + CHR$(&H0)
asm$ = asm$ + CHR$(&HCD) + CHR$(SBMIDI.INTERRUPT)
asm$ = asm$ + CHR$(&HCB)
'These next commented lines are for using the converted code.
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(Offset%)
'No MIDI file is playing, so reset the timer
MIDI.PLAYTIME = 0
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

DEFSNG A-Z
FUNCTION TimeMIDI!
'If a MIDI file is paused, lock the current playing time
IF PAUSED > 0! THEN
    TimeMIDI! = PAUSED
'If a MIDI file is playing, carry out the timing routine
ELSEIF MIDI.PLAYTIME THEN
    'Get the current time
    CurrentTime! = TIMER
    'If midnight has come since the MIDI file started playing, change
    'CurrentTime! accordingly
    IF CurrentTime! - MIDI.PLAYTIME < 0 THEN
        CurrentTime! = 86400 + CurrentTime!
    END IF
    'Get the final result
    TimeMIDI! = CurrentTime! - MIDI.PLAYTIME
ELSE
    MIDI.ERROR = 3
END IF
END FUNCTION

SUB VocVolume (Right%, Left%, Getvol%)
OUT BasePort% + 4, &H4
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

DEFINT A-Z
FUNCTION Where (label$)
    t = -2
    FOR a = 0 TO lbl

        IF labl$(a) = label$ THEN t = lab(a)
    NEXT a
    IF t = -2 THEN BEEP: PRINT "can't find "; label$; "!"
    Where = t
END FUNCTION

SUB win
PRINT "You Win!"
SYSTEM
END SUB

SUB WORLD
DIM LightM(12, 8)
lu = 0: DO: lu = lu + 1: LOOP WHILE opaque(map(plx, ply - lu)) <> 1 AND ply - lu > 0 AND lu < 4
ld = 0: DO: ld = ld + 1: LOOP WHILE opaque(map(plx, ply + ld)) <> 1 AND ply + ld <= MapY AND ld < 4
ll = 0: DO: ll = ll + 1: LOOP WHILE opaque(map(plx - ll, ply)) <> 1 AND plx - ll > 0 AND ll < 6
lr = 0: DO: lr = lr + 1: LOOP WHILE opaque(map(plx + lr, ply)) <> 1 AND plx + lr <= Mapx AND lr < 6
lul = 0: DO: lul = lul + 1: LOOP WHILE opaque(map(plx - lul, ply - lul)) <> 1 AND plx - lul > 0 AND ply - lul > 0 AND lul < 4
lur = 0: DO: lur = lur + 1: LOOP WHILE opaque(map(plx + lur, ply - lur)) <> 1 AND plx + lur <= Mapx AND ply - lur > 0 AND lur < 4
ldl = 0: DO: ldl = ldl + 1: LOOP WHILE opaque(map(plx - ldl, ply + ldl)) <> 1 AND plx - ldl > 0 AND ply + ldl <= MapY AND ldl < 4
ldr = 0: DO: ldr = ldr + 1: LOOP WHILE opaque(map(plx + ldr, ply + ldr)) <> 1 AND plx + ldr <= Mapx AND ply + ldr <= MapY AND ldr < 4
FOR a = -lu + 1 TO ld - 1: LightM(6, 4 + a) = 2: NEXT a
FOR a = -ll + 1 TO lr - 1: LightM(6 + a, 4) = 2: NEXT a
FOR a = -lul + 1 TO ldr - 1: LightM(6 + a, 4 + a) = 2: NEXT a
FOR a = -ldl + 1 TO lur - 1: LightM(6 + a, 4 - a) = 2: NEXT a
LightM(6, 4) = 2
DO
redo = 0
FOR y = 1 TO 7
    FOR x = 1 TO 11
        IF LightM(x, y) = 0 THEN
            IF LightM(x - 1, y) = 2 THEN LightM(x, y) = 1 ELSE IF LightM(x + 1, y) = 2 THEN LightM(x, y) = 1
            IF LightM(x, y - 1) = 2 THEN LightM(x, y) = 1 ELSE IF LightM(x, y + 1) = 2 THEN LightM(x, y) = 1
            IF LightM(x + 1, y + 1) = 2 THEN LightM(x, y) = 1 ELSE IF LightM(x + 1, y - 1) = 2 THEN LightM(x, y) = 1
            IF LightM(x - 1, y + 1) = 2 THEN LightM(x, y) = 1 ELSE IF LightM(x - 1, y - 1) = 2 THEN LightM(x, y) = 1
        END IF
        IF LightM(x, y) = 1 THEN
            sx = plx + x - 6
            sy = ply + y - 4
            IF sx < 1 THEN sx = 1 ELSE IF sx > Mapx THEN sx = Mapx
            IF sy < 1 THEN sy = 1 ELSE IF sy > MapY THEN sy = MapY
            IF opaque(map(sx, sy)) = 2 THEN LightM(x, y) = 2: redo = 1
        END IF
    NEXT x
NEXT y
LOOP WHILE redo = 1
FOR y = -3 TO 3
    FOR x = -5 TO 5
        IF LightM(x + 6, y + 4) > 0 THEN
            sx = plx + x: sy = ply + y: sh = 0
            IF plx + x < 1 THEN sx = 1: sh = 1 ELSE IF plx + x > Mapx THEN sx = Mapx: sh = 1
            IF ply + y < 1 THEN sy = 1: sh = 1 ELSE IF ply + y > MapY THEN sy = MapY: sh = 1
            l = map(sx, sy)
            IF x = 0 AND y = 0 AND MODE = 0 THEN l = 10
            IF sh = 1 THEN LINE (x * 20 + 150, y * 20 + 60)-(x * 20 + 169, y * 20 + 79), 128, BF: PUT (x * 20 + 150, y * 20 + 60), pic(0, l)
            IF sh = 0 THEN PUT (x * 20 + 150, y * 20 + 60), pic(0, l), PSET
        ELSE
            LINE (x * 20 + 150, y * 20 + 60)-(x * 20 + 169, y * 20 + 79), 0, BF:
        END IF
    NEXT x
NEXT y

END SUB

          ''
SUB WriteDAC (byte%)
IF blaster = 0 THEN EXIT SUB
' Writes a byte to the DAC.
WriteDSP &H10
WriteDSP byte%
END SUB

DEFSNG A-Z
SUB WriteDSP (byte%)
' Writes a byte to the DSP
DO
LOOP WHILE INP(BasePort% + 12) AND &H80
OUT BasePort% + 12, byte%
END SUB

