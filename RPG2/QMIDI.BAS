'QMIDI v3.0
'QBasic/QuickBASIC background MIDI player
'by Jesse Dorland (jessedorland@hotmail.com)
'Released to the Public Domain, March 1998
'
'See SAMPLE.BAS for a demo, and be sure to read the documentation before
'using QMIDI, even if you're familiar with previous versions..
'
'Acknowledgements:
'   Mike Huff      - author of the QuickBASIC MIDI code that QMIDI is based
'                    on.
'   Rick Elbers    - author of the QBasic Interrupt routine that was used in
'                    version 1.0.
'   Angelo Mottola - contributed the new Pause/Resume code.
'
'If you decide to use QMIDI, please tell me what you think of it and
'give me some ideas for improvements.  My e-mail address is at the top of
'the code and in the documentation.
'
'-Jesse
'
'DISCLAIMER
'----------
'If your computer suffers crashes, loss of data, or is taken over by
'smurfs as a result of using QMIDI, I won't be responsible for it.
'Reading the documentation should ensure safe operation, but I'm not
'making any guarantees.  You have been warned....

'**** START OF CODE ****

'Returns the amount of memory required to load a MIDI file
DECLARE FUNCTION BytesRequired& (Filename$)
'Detects whether the supplied sound drivers are loaded
DECLARE SUB DriversLoaded (SBMIDI%, SBSIM%)
'Internal functon used by DriversLoaded
DECLARE SUB GetIntVector (IntNum%, Segment%, Offset%)
'Loads and plays a file using SBSIM
DECLARE SUB LoadAndPlayLarge (Filename$)
'Loads and plays a file using SBMIDI
DECLARE SUB LoadAndPlayMIDI (Filename$, MIDISegment%, MIDIOffset%)
'Loads a file using SBSIM
DECLARE SUB LoadLarge (Filename$)
'Loads a file using SBMIDI
DECLARE SUB LoadMIDI (Filename$, MIDISegment%, MIDIOffset%)
'Returns the last error that occurred (if any)
DECLARE FUNCTION MIDIError$ ()
'Pauses a file that is currently playing
DECLARE SUB PauseMIDI ()
'Resumes playing a file after it has been paused
DECLARE SUB ResumeMIDI ()
'Plays a file loaded with LoadLarge
DECLARE SUB PlayLarge ()
'Plays a file loaded with LoadMIDI
DECLARE SUB PlayMIDI (MIDISegment%, MIDIOffset%)
'Stops any MIDI file that is currently playing.
DECLARE SUB StopMIDI ()
'Returns the amount of time a file has been playing
DECLARE FUNCTION TimeMIDI! ()

'The following code is REQUIRED in programs that use QMIDI in order for
'all features to work properly.

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

'Insert your own code beginning here.


'The data statements below are REQUIRED in programs that use the
'DriversLoaded routine.  Do not edit any of the data; it will cause
'the routine to return inaccurate information.
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

'BytesRequired - Returns the amount of memory needed to store a file.
FUNCTION BytesRequired& (Filename$)
'Open the file.
FF% = FREEFILE
OPEN Filename$ FOR BINARY AS #FF%
'Store the length of the file.
FileLen& = LOF(FF%)
'Close the file.
CLOSE FF%
'If the length of the file is 0, assume it does not exist and delete it.
IF FileLen& = 0 THEN KILL Filename$
'Return the length of the file as the number of bytes required.
BytesRequired& = FileLen&
END FUNCTION

DEFINT A-Z
SUB DriversLoaded (SBMIDI%, SBSIM%) STATIC

'Check the interrupt handlers for int 80h-89h to see if they contain
'program code from either SBSIM or SBMIDI.  Only those 10 interrupts
'are checked because chances are slim that either driver will be loaded
'at int 8Ah or higher, and they will never load themselves below
'80h.

FOR I% = &H80 TO &H8A
    'Get the address of the interrupt handler.
    GetIntVector I%, Segment%, Offset%
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
    IF MatchSBMIDI% THEN SBMIDI% = I%
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
    IF MatchSBSIM% THEN SBSIM% = I%
  
    'If both SBMIDI% and SBSIM% have been detected, there's no need to
    'check the rest of the interrupt handling routines.
    IF MatchSBMIDI% AND MatchSBSIM% THEN EXIT FOR
Skip:
NEXT I%
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

DEFSNG A-Z
SUB LoadAndPlayLarge (Filename$) STATIC
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'The sound driver needs an ASCIIZ string (a string that ends with
'character 0) for a file name.
IF RIGHT$(Filename$, 1) <> CHR$(0) THEN Filename$ = Filename$ + CHR$(0)
'Initialize the MIDI driver and load the file in memory
IF LoadCodeLoaded% = 0 THEN
        Lasm$ = ""
        Lasm$ = Lasm$ + CHR$(&H55)
        Lasm$ = Lasm$ + CHR$(&H89) + CHR$(&HE5)
        Lasm$ = Lasm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        Lasm$ = Lasm$ + CHR$(&H8B) + CHR$(&H7)
        Lasm$ = Lasm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
        Lasm$ = Lasm$ + CHR$(&H8B) + CHR$(&H17)
        Lasm$ = Lasm$ + CHR$(&HBB) + CHR$(&H0) + CHR$(&H5)
        Lasm$ = Lasm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        Lasm$ = Lasm$ + CHR$(&H5D)
        Lasm$ = Lasm$ + CHR$(&HCB)
        LoadCodeLoaded% = 1
END IF
DEF SEG = VARSEG(Lasm$)
Offset% = SADD(Lasm$)
CALL ABSOLUTE(SADD(Filename$), VARSEG(Filename$), Offset%)

'Start the music!!
IF PlayCodeLoaded% = 0 THEN
        Pasm$ = ""
        Pasm$ = Pasm$ + CHR$(&HB8) + CHR$(&H1) + CHR$(&H0)
        Pasm$ = Pasm$ + CHR$(&HBA) + CHR$(&H1) + CHR$(&H0)
        Pasm$ = Pasm$ + CHR$(&HBB) + CHR$(&H1) + CHR$(&H5)
        Pasm$ = Pasm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        Pasm$ = Pasm$ + CHR$(&HCB)
        PlayCodeLoaded% = 1
END IF
DEF SEG = VARSEG(Pasm$)
Offset% = SADD(Pasm$)
CALL ABSOLUTE(Offset%)
MIDI.LOADED = 1
MIDI.PLAYTIME = TIMER
END SUB

'LoadAndPlayMIDI - Loads a MIDI file into memory and plays it
SUB LoadAndPlayMIDI (Filename$, MIDISegment%, MIDIOffset%)
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'Open the file
FF% = FREEFILE
OPEN Filename$ FOR BINARY AS #FF%
FileLen& = LOF(FF%)
CLOSE #FF%
'If the file is empty, delete it and exit now.
IF FileLen& = 0 THEN KILL Filename$: MIDI.ERROR = 1: EXIT SUB
'If the file is too large, exit now.
IF FileLen& > 65536 THEN MIDI.ERROR = 2: EXIT SUB
'Make the filename an ASCIIZ string.
Filename$ = Filename$ + CHR$(0)
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
CALL ABSOLUTE(VARSEG(Filename$), SADD(Filename$), MIDISegment%, MIDIOffset%, &HFFFF, SADD(asm1$))
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

SUB LoadLarge (Filename$) STATIC
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'The sound driver needs an ASCIIZ string (a string that ends with
'character 0) for a file name.
IF RIGHT$(Filename$, 1) <> CHR$(0) THEN Filename$ = Filename$ + CHR$(0)
'Initialize the MIDI driver and load the file in memory
IF CodeLoaded% = 0 THEN
        asm$ = ""
        asm$ = asm$ + CHR$(&H55)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H7)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H0) + CHR$(&H5)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        asm$ = asm$ + CHR$(&H5D)
        asm$ = asm$ + CHR$(&HCB)
        CodeLoaded% = 1
END IF
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(SADD(Filename$), VARSEG(Filename$), Offset%)
MIDI.LOADED = 1
END SUB

'LoadMIDI - loads a MIDI file into memory
SUB LoadMIDI (Filename$, MIDISegment%, MIDIOffset%) STATIC
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'Open the file
FF% = FREEFILE
OPEN Filename$ FOR BINARY AS #FF%
FileLen& = LOF(FF%)
CLOSE #FF%
'If the file is empty, delete it and exit now.
IF FileLen& = 0 THEN KILL Filename$: MIDI.ERROR = 1: EXIT SUB
'If the file is too large, exit now.
IF FileLen& > 65536 THEN MIDI.ERROR = 2: EXIT SUB
'Make the filename an ASCIIZ string.
Filename$ = Filename$ + CHR$(0)
'Check if the assembly language code has already been loaded;
'if not, do it now.
IF CodeLoaded% = 0 THEN
        asm$ = asm$ + CHR$(&H1E)
        asm$ = asm$ + CHR$(&H55)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)
        asm$ = asm$ + CHR$(&HB8) + CHR$(&H0) + CHR$(&H3D)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HE)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H10)
        asm$ = asm$ + CHR$(&H8E) + CHR$(&H1F)
        asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HC6)
        asm$ = asm$ + CHR$(&HB4) + CHR$(&H3F)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&HF)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HA)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&HC)
        asm$ = asm$ + CHR$(&H8E) + CHR$(&H1F)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HF3)
        asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)
        asm$ = asm$ + CHR$(&HB4) + CHR$(&H3E)
        asm$ = asm$ + CHR$(&HCD) + CHR$(&H21)
        asm$ = asm$ + CHR$(&H5D)
        asm$ = asm$ + CHR$(&H1F)
        asm$ = asm$ + CHR$(&HCA) + CHR$(&HA) + CHR$(&H0)
        CodeLoaded% = 1
END IF
'Call the assembly language routine.
DEF SEG = VARSEG(asm$)
CALL ABSOLUTE(VARSEG(Filename$), SADD(Filename$), MIDISegment%, MIDIOffset%, &HFFFF, SADD(asm$))
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

'PauseMIDI - Pauses a MIDI file that is currently playing
SUB PauseMIDI
'If no MIDI file is playing, exit now
IF MIDI.PLAYTIME = 0 THEN EXIT SUB
'Pause the music.
IF CodeLoaded% = 0 THEN
        asm$ = ""
        asm$ = asm$ + CHR$(&HB8) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBA) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H3) + CHR$(&H5)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        asm$ = asm$ + CHR$(&HCB)
        CodeLoaded% = 1
END IF
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(Offset%)
'Save the number of seconds the MIDI file has been playing.
PAUSED = TimeMIDI!
'If it hasn't been playing long enough for TimeMIDI! to return
'a value greater than 0, change PAUSED to a tiny positive value.
IF PAUSED = 0! THEN PAUSED = .00001
'Indicate that the file has stopped playing.
MIDI.PLAYTIME = 0
END SUB

SUB PlayLarge STATIC
'If no MIDI file is loaded, exit now
IF MIDI.LOADED = 0 THEN EXIT SUB
'Start the music!!
IF CodeLoaded% = 0 THEN
        asm$ = ""
        asm$ = asm$ + CHR$(&HB8) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBA) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H1) + CHR$(&H5)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        asm$ = asm$ + CHR$(&HCB)
        CodeLoaded% = 1
END IF
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(Offset%)
MIDI.PLAYTIME = TIMER
END SUB

'PlayMIDI - Begins playing a MIDI file in the background.
SUB PlayMIDI (MIDISegment%, MIDIOffset%) STATIC
'Check to see if the MIDI playing code has previously been loaded.
'If not, load it now.
IF CodeLoaded% = 0 THEN
        'Load the machine codes into a string.
        asm$ = asm$ + CHR$(&H55)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H7)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H4) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HCD) + CHR$(&H80)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H5) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HCD) + CHR$(&H80)
        asm$ = asm$ + CHR$(&H5D)
        asm$ = asm$ + CHR$(&HCA) + CHR$(&H4) + CHR$(&H0)
        'Indicate that the code has been loaded.
        CodeLoaded% = 1
END IF
'Call the machine language routine to play the music.
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(MIDISegment%, MIDIOffset%, Offset%)
'Start the MIDI timer.
MIDI.PLAYTIME = TIMER
END SUB

'ResumeMIDI - Starts playing a MIDI file after it has been paused
SUB ResumeMIDI
'If no MIDI file is paused, exit now
IF PAUSED = 0! THEN EXIT SUB
'Resume playing.
IF CodeLoaded% = 0 THEN
        asm$ = ""
        asm$ = asm$ + CHR$(&HB8) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBA) + CHR$(&H1) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H4) + CHR$(&H5)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBSIM.INTERRUPT)
        asm$ = asm$ + CHR$(&HCB)
        CodeLoaded% = 1
END IF
DEF SEG = VARSEG(asm$)
Offset% = SADD(asm$)
CALL ABSOLUTE(Offset%)
MIDI.PLAYTIME = TIMER - PAUSED
PAUSED = 0!
END SUB

'StopMIDI - Stops playing MIDI file
SUB StopMIDI
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

