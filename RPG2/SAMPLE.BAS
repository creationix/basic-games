'SAMPLE.BAS
'QMIDI v3.0 demonstration program.
'by Jesse Dorland (jessedorland@hotmail.com)
'Released to the Public Domain, March 1998
'
'This program demonstrates many of QMIDI's features, including:
'       MIDI Loading
'       MIDI Playing
'       MIDI Timing
'       MIDI Pausing/Resuming
'       Background MIDI Playing
'
'NOTE: You must load the sound drivers included with QMIDI before running
'this program.
'
'The final demonstration in this program requires a VGA graphics card.  The
'other demos have no special requirements.
'
'QMIDI.BAS contains the core source code for QMIDI.  Cut and paste the entire
'contents of QMIDI.BAS into your own code to use the QMIDI routines.
'
'
'Declare QMIDI subroutines.
DECLARE SUB LoadAndPlayMIDI (Filename$, MIDISegment%, MIDIOffset%)
DECLARE SUB LoadMIDI (Filename$, MIDISegment%, MIDIOffset%)
DECLARE SUB PlayMIDI (MIDISegment%, MIDIOffset%)
DECLARE SUB StopMIDI ()
DECLARE FUNCTION BytesRequired& (Filename$)
DECLARE SUB DriversLoaded (SBMIDI%, SBSIM%)
DECLARE FUNCTION TimeMIDI! ()
DECLARE FUNCTION MIDIError$ ()
DECLARE SUB PauseMIDI ()
DECLARE SUB ResumeMIDI ()
DECLARE SUB GetIntVector (IntNum%, Segment%, Offset%)
'The following subroutines are not used by QMIDI; they just make the
'demos a little flashier.
DECLARE SUB SetPal (Col%, R%, G%, B%)
DECLARE SUB GetPal (Col%, R%, G%, B%)
DECLARE SUB Center (Text$)

'The following code is REQUIRED in programs that use QMIDI in order for
'all features to work properly.
DIM SHARED MIDI.PLAYTIME AS SINGLE
DIM SHARED MIDI.ERROR AS INTEGER
DIM SHARED SBMIDI.INTERRUPT AS INTEGER
DIM SHARED SBSIM.INTERRUPT AS INTEGER
DIM SHARED PAUSED AS SINGLE
MIDI.PLAYTIME = 0
MIDI.ERROR = 0

'DEMO CODE STARTS HERE
'$DYNAMIC
'Set text mode
SCREEN 0: WIDTH 80, 25: CLS
'Change the background to a dark blue color.  It's just a change of pace from
'the usual black.
SetPal 0, 0, 0, 21
'PRINT THE MAIN SCREEN.
'Print the title in light cyan.
COLOR 11, 0
Center "QMIDI DEMO"
'Print a description of the program in bright white.
COLOR 15, 0
Center "A demonstration of the features in QMIDI v3.0"
PRINT
'Print the sound driver warning.
COLOR 12, 0
Center "NOTE: If the sound drivers have not been loaded, quit now!"
Center "Press Q to quit or any other key to begin the demo."
'Get a key press.
A$ = UCASE$(INPUT$(1))
'If the user pressed Q abort the program.
IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE DRIVERSLOADED DEMONSTRATION
CLS
'Print the DriversLoaded syntax in yellow.
COLOR 14, 0
Center "DriversLoaded (SBMIDI%, SBSIM%)"
'Print the DriverLoaded description in white.
COLOR 15, 0
Center "Attempts to detect if the sound drivers have been loaded."
'Print the "detecting..." message
PRINT
COLOR 12, 0
Center "Looking for sound drivers..."
DriversLoaded SBMIDI.INTERRUPT, SBSIM.INTERRUPT
'Print the status of the detection.
SELECT CASE SBMIDI.INTERRUPT
        CASE 0:
                Center "UH-OH!!  The SBMIDI driver could not be found!"
                Center "Are you sure you want to continue? (Y/N)"
                A$ = UCASE$(INPUT$(1))
                IF A$ <> "Y" THEN
                        SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
                END IF
        CASE ELSE:
                PRINT
                Center "SBMIDI driver found!"
                
END SELECT
SELECT CASE SBSIM.INTERRUPT
        CASE 0:
                Center "UH-OH!!  The SBSIM driver could not be found!"
                Center "Are you sure you want to continue? (Y/N)"
                A$ = UCASE$(INPUT$(1))
                IF A$ <> "Y" THEN
                        SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
                END IF
        CASE ELSE:
                Center "SBSIM driver found!"
                PRINT
                'Prompt the user for a key press.
                Center "Press Q to quit of any other key to continue the demo."
                A$ = UCASE$(INPUT$(1))
                'If the user pressed Q, abort the program.
                IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
END SELECT

'START THE LOADMIDI DEMONSTRATION
CLS
'Print the LoadMIDI syntax in yellow.
COLOR 14, 0
Center "LoadMIDI (Filename$, MIDISegment%, MIDIOffset%)"
'Print the LoadMIDI description in white.
COLOR 15, 0
Center "Loads a MIDI file into memory."
'Print the loading message.
PRINT
COLOR 12, 0
Center "Loading sample MIDI file..."
'Load one of the sample MIDI files into an array.
DIM MIDI%(BytesRequired&("SAMPLE2.MID") \ 2)
LoadMIDI "SAMPLE2.MID", VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
'Tell the user that we're done loading.
Center "Done!!"
PRINT
'Prompt the user for a key press.
Center "Press Q to quit or any other key to continue the demo."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE PLAYMIDI DEMONSTRATION
CLS
'Print the PlayMIDI syntax in yellow.
COLOR 14, 0
Center "PlayMIDI (MIDISegment%, MIDIOffset%)"
'Print the PlayMIDI description in white.
COLOR 15, 0
Center "Plays a MIDI file that is currently loaded in memory."
'Print a "playing" message.
PRINT
COLOR 12, 0
Center "Playing music..."
PlayMIDI VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
Center "You should now be listening to music."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN StopMIDI: SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE STOPMIDI DEMONSTRATION
CLS
'Print the StopMIDI syntax in yellow.
COLOR 14, 0
Center "StopMIDI ()"
'Print the StopMIDI description in white.
COLOR 15, 0
Center "Stops the currently playing MIDI file."
COLOR 12, 0
'Print a "stopping..." message.
PRINT
Center "Stopping music..."
'Attempt to stop the music.
StopMIDI
'The music should no longer be playing.
Center "You shouldn't hear any more music."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE LOADANDPLAYMIDI DEMONSTRATION
CLS
'Print the LoadAndPlayMIDI syntax in yellow.
COLOR 14, 0
Center "LoadAndPlayMIDI (Filename$, MIDISegment%, MIDIOffset%)"
'Print the LoadAndPlayMIDI description in white.
COLOR 15, 0
Center "Loads a MIDI file into memory and begins playing it."
'Display a message while loading the file.
COLOR 12, 0
PRINT
Center "Loading and playing MIDI file..."
'Attempt to load one of the sample MIDI files and begin playing it.
REDIM MIDI%(BytesRequired&("SAMPLE3.MID") \ 2)
LoadAndPlayMIDI "SAMPLE3.MID", VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
Center "Done!!  You should be listening to music now."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN StopMIDI: SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE TIMEMIDI DEMONSTRATION
CLS
'Print the TimeMIDI syntax in yellow.
COLOR 14, 0
Center "TimeMIDI ()"
'Print the TimeMIDI description in white.
COLOR 15, 0
Center "Returns the number of seconds a MIDI file has been playing."
PRINT
'Print how long the MIDI file started in the last demo has been playing/
COLOR 13, 0
Center "MIDI file has been playing" + STR$(INT(TimeMIDI!)) + " seconds and counting!"
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
COLOR 13, 0
DO
A$ = UCASE$(INKEY$)
'If the user pressed Q, stop the music and abort the program.
IF A$ = "Q" THEN StopMIDI: SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
IF A$ <> "" THEN EXIT DO
'Update the MIDI time counter.
LOCATE 4, 1
Center "MIDI file has been playing" + STR$(INT(TimeMIDI!)) + " seconds and counting!"
LOOP

'START THE PAUSEMIDI DEMONSTRATION
CLS
'Print the PauseMIDI syntax in yellow.
COLOR 14, 0
Center "PauseMIDI ()"
'Print the PauseMIDI description in white.
COLOR 15, 0
Center "Pauses the currently playing MIDI file."
COLOR 12, 0
'Print a "pausing..." message.
PRINT
Center "Pausing music..."
'Attempt to pause the music.
PauseMIDI
'The music should no longer be playing.
Center "You shouldn't hear anything now."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END

'START THE RESUMEMIDI DEMONSTRATION
CLS
'Print the ResumeMIDI syntax in yellow.
COLOR 14, 0
Center "ResumeMIDI ()"
'Print the PauseMIDI description in white.
COLOR 15, 0
Center "Resumes playing of a paused MIDI file."
COLOR 12, 0
'Print a "resuming..." message.
PRINT
Center "Starting music..."
'Attempt to resume the music.
ResumeMIDI
'The music should now be playing.
Center "The music should pick up where it left off."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END


'START THE BACKGROUND PLAYING DEMONSTRATION
CLS
'Print the title in yellow.
COLOR 14
Center "Background MIDI Playing"
'Print the description.
COLOR 12
PRINT
Center "The following is a demonstration of how QMIDI can play MIDI files in"
Center "the background while the program continues to run.  This demo"
Center "requires VGA graphics."
'Prompt the user for a key press.
PRINT
Center "Press Q to quit the demo or any other key to continue."
Center "Once the next demo has started, press ESC to end the program."
A$ = UCASE$(INPUT$(1))
'If the user pressed Q, abort the program.
IF A$ = "Q" THEN StopMIDI: SCREEN 1: SCREEN 0: WIDTH 80, 25: CLS : END
'Stop the currently playing MIDI file.
StopMIDI
'Switch to 256-color VGA mode.
SCREEN 13
'Print the title and "press a key" messages.
COLOR 14
Center "QMIDI v3.0 Background Music Demo"
COLOR 15
LOCATE 24, 1
Center "Press ESC to Quit"
Center "Press Space to Pause/Resume;;"
'Dimension an array to hold the original palette information for colors
'16-31.
DIM PalStore%(1 TO 16, 1 TO 3)
FOR I% = 16 TO 31
'Get the palette information for color I%
GetPal I%, R%, G%, B%
'Store the palette information for color I%
PalStore%(I% - 15, 1) = R%
PalStore%(I% - 15, 2) = G%
PalStore%(I% - 15, 3) = B%
NEXT I%
'Start printing on line 10.
LOCATE 10, 1
RESTORE BigText:
'Set the printing color to 16
Col% = 16
FOR I% = 1 TO 6
FOR K% = 1 TO 5
'Read one line of the giant "QMIDI" text.
READ Text$
'Set the printing color.
COLOR Col%
'Print the text.
PRINT Text$;
'Decrement the Col% variable.
Col% = Col% - 1
'We only want to use 5 colors from 16-20 for the "QMIDI" text.
IF Col% < 16 THEN Col% = 20
NEXT K%
'Go to the next line
PRINT
NEXT I%
'Change the background to a dark blue color.  If you don't like this color,
'you can change the values.  A black background made it retina-burning to
'look at.
SetPal 0, 0, 0, 21
'Draw a border around the screen text.
LINE (3, 37)-(317, 40), 22, BF
LINE (3, 142)-(317, 145), 29, BF
'Draw a box around the large "QMIDI" text.
LINE (3, 65)-(317, 122), 25, B

'This program contains 16 "captions."  Each caption is some text that scrolls
'from left to right underneath the large "QMIDI" text.
'
'Start reading data from the Captions label.
RESTORE Captions
'Start on caption 1.
CapNo% = 1
'Read in a caption
READ Caption$, CapCol%
'Start printing the caption at the far right end of the screen.
CapX% = 40
'Set the color to the 8.
COLOR 8
'Print how long the MIDI file has been playing
LOCATE 7, 1
Center "Playing time:" + STR$(PlayTime!) + " seconds"
'Set the color to white.
COLOR 15
'Attempt to load and play a sample MIDI file.
REDIM MIDI%(BytesRequired&("SAMPLE1.MID") \ 2)
LoadAndPlayMIDI "SAMPLE1.MID", VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
'Set the printing color.
Col% = 17
'A key press will end the program.
DO
'Store the previous playing time
PlayTimeP! = PlayTime!
'Get the number of seconds the MIDI file has been playing.
PlayTime! = INT(TimeMIDI!)
'SAMPLE1.MID runs for approximately 2 minutes and 4 seconds.  If more than
'124 seconds has elapsed, the file needs to be restarted.
IF PlayTime! > 124 THEN
        PlayMIDI VARSEG(MIDI%(0)), VARPTR(MIDI%(0))
END IF
'Wait for vertical retrace 6 times.  This makes the palette rotate at a
'nice speed, and reduces screen flicker.
FOR I% = 1 TO 6: WAIT &H3DA, 8, 8: WAIT &H3DA, 8: NEXT I%
IF PlayTimeP! <> PlayTime! THEN
'Clear line 7.
LOCATE 7, 22: PRINT STRING$(11, 32);
'Print the number of seconds the MIDI file has been playing.
COLOR 8
LOCATE 7, 23
PRINT LTRIM$(STR$(PlayTime!)) + " seconds";
END IF
COLOR CapCol%
'If the beginning of the text has gone off the left side of the screen...
IF CapX% <= 0 THEN
'Locate the cursor at the beginning of the line
LOCATE 17, 1
ELSE
'Otherwise, locate the cursor at the beginning of the text.
LOCATE 17, CapX%
END IF
'If the end of the caption has gone off the right side of the screen...
IF 40 - CapX% < LEN(Caption$) THEN
'Clip the end of the string so it will fit on one line.
CapText$ = LEFT$(Caption$, 40 - CapX%)
ELSE
'Otherwise, make no changes to the string.
CapText$ = Caption$
END IF
'If the beginning of the caption has gone off the left side of the screen...
IF CapX% <= 0 THEN
'Clip the beginning of the string so it will fit.
CapText$ = RIGHT$(CapText$, CapX% - 1 + LEN(CapText$))
END IF
'Print the caption.
PRINT CapText$;
'Decrement the column position of the caption text, so it will scroll one
'column to the left.
CapX% = CapX% - 1
'If the entire caption has scrolled off the left side of the screen...
IF CapX% <= -LEN(Caption$) THEN
'Reset the caption column position to the far right side.
CapX% = 40
'Switch to the next caption.
CapNo% = CapNo% + 1
'Make sure that we haven't gone past the last caption - if we have, loop
'back to the beginning.
IF CapNo% > 16 THEN CapNo% = 1
'Start reading data from the Captions label.
RESTORE Captions
'Read data until the desired caption is reached.
FOR I% = 1 TO CapNo%
'Read in the next caption and caption color.
READ Caption$, CapCol%
NEXT I%
END IF
'When the caption color changes, the large "QMIDI" text changes to similar
'colors.  The following code sets which colors should be used for the "QMIDI"
'text.
SELECT CASE CapCol%
        'If light green was used for the caption text, use green shades for
        'the "QMIDI" text.
        CASE IS = 10: NoRed% = 1: NoGreen% = 0: NoBlue% = 1
        'If light cyan was used for the caption text, use cyan shades
        '(green and blue mixed create Cyan)
        CASE IS = 11: NoRed% = 1: NoGreen% = 0: NoBlue% = 0
        'If light red was used for the caption text, use red shades
        'for the "QMIDI" text.
        CASE IS = 12: NoRed% = 0: NoGreen% = 1: NoBlue% = 1
        'If light magenta was used for the caption text, use purple shades
        '(red and blue mixed create Purple)
        CASE IS = 13: NoRed% = 0: NoGreen% = 1: NoBlue% = 0
        'If yellow was used for the caption text, use yellow shades
        '(red and green mixed create Yellow)
        CASE IS = 14: NoRed% = 0: NoGreen% = 0: NoBlue% = 1
        'If white was used for the caption text, use neutral colors
        '(red, green, and blue mixed create shades of Gray)
        CASE IS = 15: NoRed% = 0: NoGreen% = 0: NoBlue% = 0
END SELECT
'Rotate the palette of colors 16-31
FOR I% = 16 TO 31
'Get the Red value of color Col%.
R% = PalStore%(Col% - 15, 1)
'If red shouldn't be shown, clear the R% variable.
IF NoRed% THEN R% = 0
'Do the same for the Green value...
G% = PalStore%(Col% - 15, 2)
IF NoGreen% THEN G% = 0
'and again for the Blue value.
B% = PalStore%(Col% - 15, 3)
IF NoBlue% THEN B% = 21
IF B% < 21 THEN B% = 21
'Set the palette of color I%
SetPal I%, R%, G%, B%
'Decrement Col% to get new palette values
Col% = Col% - 1
'Make sure the Col% variable does not go outside the range of 16 and 30.
IF Col% < 16 THEN Col% = 30
NEXT I%
'Set the color of the MIDI counter to the same value as the caption color.
'Since part of the MIDI counter is not reprinted each time in order to
'reduce flicker, the palette must be changed if the color is to be changed.

'Get the color values of the caption color and the color used for the
'MIDI counter.
GetPal CapCol%, R%, G%, B%
GetPal 8, R2%, G2%, B2%
'If they are not the same, execute some code that will provide a smooth
'transition from one color to the other.
IF R% <> R2% OR G% <> G2% OR B% <> B2% THEN
'Make the color values of the counter color become a little more similar
'to those of the caption color.
IF R2% < R% THEN R2% = R2% + 4
IF R2% > R% THEN R2% = R2% - 4
IF G2% < G% THEN G2% = G2% + 4
IF G2% > G% THEN G2% = G2% - 4
IF B2% < B% THEN B2% = B2% + 4
IF B2% > B% THEN B2% = B2% - 4
SetPal 8, R2%, G2%, B2%
END IF
A$ = INKEY$
SELECT CASE A$
    CASE CHR$(27)
        EXIT DO
    CASE CHR$(32)
        IF PAUSED THEN
            ResumeMIDI
        ELSE
            PauseMIDI
        END IF
END SELECT
LOOP
'When a key is pressed, stop the music...
StopMIDI
'Restore text mode....
SCREEN 0: WIDTH 80, 25: CLS
'And quit.
END

'The following is data for the large "QMIDI" text that appears in the final
'demonstration.
BigText:
DATA " ллллллллл"," ллл   ллл"," лллл"," лллллл  "," лллл"
DATA " лл     лл"," лл л л лл","  лл "," лл   лл ","  лл "
DATA " лл     лл"," лл  л  лл","  лл "," лл    лл","  лл "
DATA " лл  л  лл"," лл     лл","  лл "," лл   лл ","  лл "
DATA " ллллллллл"," лл     лл"," лллл"," лллллл  "," лллл"
DATA "     л    ","          ","     ","         ","     "


'The following is data for the "captions" that scroll by underneath the large
'"QMIDI" text in the final demonstration.
Captions:
DATA "Playing in the Background!! ",11
DATA "'Impossible!' you say? ",10
DATA "Not with QMIDI!! ",12
DATA "With QMIDI, you can add MIDI file playing to your programs with a few lines of code!  QMIDI's features include: ",13
DATA "* Background MIDI playing - files play without interrupting your program, and cause virtually no slowdown! ",14
DATA "* Flexibility - run QMIDI normally and take full advantage of its features, or use only the basic features, with the benefit of extra memory for other tasks! ",15
DATA "* Compatibility - QMIDI is compatible with most sound cards! ",10
DATA "QMIDI is known to work with the following flavors of BASIC: ",14
DATA "QBasic v1.x               QuickBASIC v4.x               Visual BASIC for DOS       and       Microsoft PDS! ",15
DATA "Thanks to Mike Huff, for the QuickBASIC MIDI code, which I ported to QBasic. ",14
DATA "Also, thanks to Rick Elbers, who wrote the Interrupt routine used in QMIDI v1.0. ", 14
DATA "Finally, credit is due to Angelo Mottola, for the Pause/Resume routines that he contributed. ", 14
DATA "If you'd like to suggest a feature for the next version of QMIDI, or if you have any questions or problems, please feel free to e-mail me at: ",12
DATA "jessedorland@hotmail.com ",10
DATA "And don't forget that you can always find the latest version of QMIDI (and related files) here: ",15
DATA "http://www.primenet.com/~merlin57/qmidi/ ",12

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
MIDI.ERROR = 0
END FUNCTION

SUB Center (Text$)
'As far as we know, a carriage return should be printed.
NoCR% = 0
'Get the number of screen columns.
DEF SEG = &H40
MaxCol% = PEEK(&H4A) \ 2
DEF SEG
'If the last two characters in the string are semi colons, than a carriage
'return should not be printed.
IF RIGHT$(Text$, 2) = ";;" THEN NoCR% = 1: Text$ = LEFT$(Text$, LEN(Text$) - 2)

'Locate the cursor on the appropriate place
LOCATE CSRLIN, MaxCol% - LEN(Text$) \ 2, 0
'Print the text.
IF NoCR% THEN
        PRINT Text$;
ELSE
        PRINT Text$
END IF
END SUB

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

SUB GetPal (Col%, R%, G%, B%)
'Send the color to port 3C7H
OUT &H3C7, Col%
'Retrieve the Red, Green, and Blue color values.
R% = INP(&H3C9)
G% = INP(&H3C9)
B% = INP(&H3C9)
END SUB

'LoadAndPlayMIDI - Loads a MIDI file into memory and plays it
SUB LoadAndPlayMIDI (Filename$, MIDISegment%, MIDIOffset%)
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'Open the file
FF% = FREEFILE
OPEN Filename$ FOR BINARY AS #FF%
FileLen& = LOF(1)
CLOSE #FF%
'If the file is empty, delete it and exit now.
IF FileLen& = 0 THEN KILL Filename$: MIDI.ERROR = 1: EXIT SUB
'If the file is too large, exit now.
IF FileLen& > 65535 THEN MIDI.ERROR = 2: EXIT SUB
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
MIDI.ERROR = 0
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
MIDI.ERROR = 0
END SUB

'LoadMIDI - loads a MIDI file into memory
SUB LoadMIDI (Filename$, MIDISegment%, MIDIOffset%) STATIC
'See if an extension was supplied, and if not, add one.
IF INSTR(Filename$, ".") = 0 THEN Filename$ = Filename$ + ".MID"
'Open the file
FF% = FREEFILE
OPEN Filename$ FOR BINARY AS #FF%
FileLen& = LOF(1)
CLOSE #FF%
'If the file is empty, delete it and exit now.
IF FileLen& = 0 THEN KILL Filename$: MIDI.ERROR = 1: EXIT SUB
'If the file is too large, exit now.
IF FileLen& > 65535 THEN MIDI.ERROR = 2: EXIT SUB
'Make the filename an ASCIIZ string.
Filename$ = Filename$ + CHR$(0)
'Check if the MIDI loading code has already been loaded;
'if not, do it now.
IF LoadCodeLoaded% = 0 THEN
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
        LoadCodeLoaded% = 1
END IF
'Call the assembly language routine.
DEF SEG = VARSEG(asm$)
CALL ABSOLUTE(VARSEG(Filename$), SADD(Filename$), MIDISegment%, MIDIOffset%, &HFFFF, SADD(asm$))
MIDI.ERROR = 0
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

SUB PauseMIDI STATIC
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

'PlayMIDI - Begins playing a MIDI file in the background.
SUB PlayMIDI (MIDISegment%, MIDIOffset%) STATIC
'Check to see if the MIDI playing code has previously been loaded.
'If not, load it now.
IF PlayCodeLoaded% = 0 THEN
        'Load the machine codes into a string.
        asm$ = asm$ + CHR$(&H55)
        asm$ = asm$ + CHR$(&H89) + CHR$(&HE5)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H8)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H17)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H5E) + CHR$(&H6)
        asm$ = asm$ + CHR$(&H8B) + CHR$(&H7)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H4) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBMIDI.INTERRUPT)
        asm$ = asm$ + CHR$(&HBB) + CHR$(&H5) + CHR$(&H0)
        asm$ = asm$ + CHR$(&HCD) + CHR$(SBMIDI.INTERRUPT)
        asm$ = asm$ + CHR$(&H5D)
        asm$ = asm$ + CHR$(&HCA) + CHR$(&H4) + CHR$(&H0)
        'Indicate that the code has been loaded.
        PlayCodeLoaded% = 1
END IF
'Call the machine language routine to play the music.
DEF SEG = VARSEG(asm$)
CALL ABSOLUTE(MIDISegment%, MIDIOffset%, SADD(asm$))
'Start the MIDI timer.
MIDI.PLAYTIME = TIMER
MIDI.ERROR = 0
END SUB

SUB ResumeMIDI STATIC
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

SUB SetPal (Col%, R%, G%, B%)
'Send the color to port 3C8H
OUT &H3C8, Col%
'Set the red, green, and blue color values.
OUT &H3C9, R%
OUT &H3C9, G%
OUT &H3C9, B%
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
MIDI.ERROR = 0
PAUSED = 0!
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

