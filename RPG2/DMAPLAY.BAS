'----------------------------------------------
' DMA Play
' By Mike Huff (1996)
' Audio file player that plays using the DMA channels.
' Runs in QBASIC, QuickBASIC, PDS, VBDOS, and even GW-BASIC!!! (If you add
' line numbers and remove the SUBs, FUNCTIONS, and do a few other things.)
' Use DMADone% to detect the end of a transfer.
' Tested on a 486DX4-120mHz with a Reveal Sound FX card.
' tested on Cyrix 100Mhz with Orchid ESS Audiodrive (SBPro)
'        -setting master volume to 13 got rid ofjunk noise at end
' Program downloaded from http://www.ocf.berkeley.edu/~horie
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
DECLARE SUB DMAPlay (Segment&, Offset&, Length&, Freq&)
DECLARE SUB DMARecord (Segment&, Offset&, Length&, Freq&)
DECLARE SUB GetBLASTER (DMA%, BasePort%, IRQ%)
DECLARE FUNCTION DSPVersion! ()
COMMON SHARED BasePort%, LenPort%, Channel%

CLS
PRINT "DMAPlay"
PRINT "By Mike Huff"
PRINT "Modified By Martin Rampersad (To play entire file instead of first 32k)"
PRINT "Comments, etc. can be sent to MHuff@gnn.com or to Rampersad@Globalserve.net"
GetBLASTER Channel%, BasePort%, IRQ% ' Parses BLASTER environment
PRINT STRING$(80, 196)
IF ResetDSP% THEN 'resets DSP (returns true if sucessful)
   PRINT "DSP reset sucessfully!"
ELSE
   PRINT "DSP failed to reset, try another port."
END IF

SpeakerState 1 'turn the speaker on
PRINT "Sound Card DSP version:"; DSPVersion!

MasterVolume Right%, Left%, -1 'this puts the mixer volumes in Right% and Left%
PRINT "Master volume is set at: Right-"; Right%; " Left-"; Left%
MasterVolume 13, 13, 0 '15,15,0 cranks the master volume all the way up.

DIM WavBuffer(1 TO 1) AS STRING * 32767 'Make a 32k buffer for file.
INPUT "WAV/VOC/SND file to play: ", Filename$
OPEN Filename$ FOR BINARY AS #1
INPUT "Frequency to play at: (1000-41000Hz)", Freq&

DO

GET #1, 44 + (32767 * CurrentPlay!), WavBuffer(1)'Get 32k from file (skip header on WAV)

CurrentPlay! = CurrentPlay! + 1

Length& = LOF(1) - 44
IF Length& > 32767 THEN Length& = 32767 'Adjust length if needed to 32k
DMAPlay VARSEG(WavBuffer(1)), VARPTR(WavBuffer(1)), Length&, Freq&

DO UNTIL a = 11500: a = a + 1: LOOP: a = 0
LOOP UNTIL EOF(1)

'Use DMARecord to record in the background.
'and use DMAPlay to playback the same buffer you recorded to or you could
'even write the buffer to a file.
'DMARecord VARSEG(WavBuffer(1)), VARPTR(WavBuffer(1)), Length&, Freq&

CLS
COLOR 7
PRINT "DMA transfer completed!"

SUB CDVolume (Right%, Left%, Getvol%)
OUT BasePort% + 4, &H28
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

FUNCTION DMADone%
Count% = INP(LenPort%)
Count2% = INP(LenPort%)
Count& = CLNG(Count% + 1) * CLNG(Count2% + 1)
IF (Count& - 1) >= &HFFFF& THEN junk% = INP(DSPDataAvail%): DMADone% = -1
END FUNCTION

SUB DMAPlay (Segment&, Offset&, Length&, Freq&)
' Transfers and plays the contents of the buffer.
Length& = Length& - 1
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
OUT LenPort%, Length& AND &HFF
OUT LenPort%, (Length& AND &HFFFF&) \ &H100
OUT &HA, Channel%

IF Freq& < 23000 THEN
   TimeConst% = 256 - 1000000 \ Freq&
   WriteDSP &H40
   WriteDSP TimeConst%
   WriteDSP &H14
   WriteDSP (Length& AND &HFF)
   WriteDSP ((Length& AND &HFFFF&) \ &H100)
ELSE
   IF DSPVersion! >= 3 THEN
      TimeConst% = ((65536 - 256000000 \ Freq&) AND &HFFFF&) \ &H100
      WriteDSP &H40
      WriteDSP TimeConst%
      WriteDSP (Length& AND &HFF)
      WriteDSP ((Length& AND &HFFFF&) \ &H100)
      WriteDSP &H91
   ELSE
      PRINT "You need a Sound Blaster with a DSP v3.x+ to play at high speed."
      EXIT SUB
   END IF
END IF
END SUB

SUB DMARecord (Segment&, Offset&, Length&, Freq&)
Length& = Length& - 1
MemLoc& = Segment& * 16 + Offset&
Page% = 0
SELECT CASE Channel%
    CASE 0
       PgPort% = &H87
       AddPort% = &H0
       LenPort% = &H1
       ModeReg% = &H44
    CASE 1
       PgPort% = &H83
       AddPort% = &H2
       LenPort% = &H3
       ModeReg% = &H45
    CASE 2
       PgPort% = &H81
       AddPort% = &H4
       LenPort% = &H5
       ModeReg% = &H46
    CASE 3
       PgPort% = &H82
       AddPort% = &H6
       LenPort% = &H7
       ModeReg% = &H47
    CASE ELSE
       EXIT SUB
END SELECT

OUT &HA, &H4 + Channel%
OUT &HC, &H0
OUT &HB, ModeReg%
OUT AddPort%, MemLoc& AND &HFF
OUT AddPort%, (MemLoc& AND &HFFFF&) \ &H100
IF (LongByte& AND 65536) THEN Page% = Page% + 1
IF (LongByte& AND 131072) THEN Page% = Page% + 2
IF (LongByte& AND 262144) THEN Page% = Page% + 4
IF (LongByte& AND 524288) THEN Page% = Page% + 8
OUT PgPort%, Page%
OUT LenPort%, Length& AND &HFF
OUT LenPort%, (Length& AND &HFFFF&) \ &H100
OUT &HA, Channel%

IF Freq& <= 23000 THEN
   TimeConst% = 256 - 1000000 \ Freq&
   WriteDSP &H40
   WriteDSP TimeConst%
   WriteDSP &H24
   WriteDSP (Length& AND &HFF)
   WriteDSP ((Length& AND &HFFFF&) \ &H100)
ELSE
   IF DSPVersion! >= 3 THEN
      TimeConst% = ((65536 - 256000000 / Freq&) AND &HFFFF&) \ &H100
      WriteDSP &H40
      WriteDSP TimeConst%
      WriteDSP (Length& AND &HFF)
      WriteDSP ((Length& AND &HFFFF&) \ &H100)
      WriteDSP &H99
   ELSE
      PRINT "You need a Sound Blaster with a DSP 3.x+ to record at high speed."
      EXIT SUB
   END IF
END IF

END SUB

SUB DMAState (StopGo%)
' Stops or continues DMA play.
IF StopGo% THEN WriteDSP &HD4 ELSE WriteDSP &HD0

END SUB

FUNCTION DSPVersion!
' Gets the DSP version.
WriteDSP &HE1
Temp% = ReadDSP%
Temp2% = ReadDSP%
DSPVersion! = VAL(STR$(Temp%) + "." + STR$(Temp2%))
END FUNCTION

SUB FMVolume (Right%, Left%, Getvol%)
OUT BasePort% + 4, &H26
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
END SUB

SUB GetBLASTER (DMA%, BasePort%, IRQ%)
' This subroutine parses the BLASTER environment string and returns settings.
IF LEN(ENVIRON$("BLASTER")) = 0 THEN PRINT "BLASTER environment variable not set.": EXIT SUB
FOR Length% = 1 TO LEN(ENVIRON$("BLASTER"))
   SELECT CASE MID$(ENVIRON$("BLASTER"), Length%, 1)
      CASE "A"
        BasePort% = VAL("&H" + MID$(ENVIRON$("BLASTER"), Length% + 1, 3))
      CASE "I"
        IRQ% = VAL(MID$(ENVIRON$("BLASTER"), Length% + 1, 1))
      CASE "D"
        DMA% = VAL(MID$(ENVIRON$("BLASTER"), Length% + 1, 1))
   END SELECT
NEXT

END SUB

SUB InputSource (InputSrc%, GetSrc%)
OUT BasePort% + 4, &HC
IF GetSrc% THEN
   InputSrc% = INP(BasePort% + 5) AND 2 + INP(BasePort% + 5) AND 4
ELSE
   OUT BasePort% + 5, InputSrc% AND 7
END IF
END SUB

SUB LineVolume (Right%, Left%, Getvol%)
OUT BasePort% + 4, &H2E
IF Getvol% THEN
   Left% = INP(BasePort% + 5) \ 16
   Right% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, (Right% + Left% * 16) AND &HFF
END IF
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

SUB MicVolume (Volume%, Getvol%)
OUT BasePort% + 4, &HA
IF Getvol% THEN
   Volume% = INP(BasePort% + 5) AND &HF
   EXIT SUB
ELSE
   OUT BasePort% + 5, Volume% AND &HF
END IF
END SUB

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

SUB SetStereo (OnOff%)
OUT BasePort% + 4, &HE
IF OnOff% THEN OUT BasePort% + 5, 2 ELSE OUT BasePort% + 5, 0
END SUB

SUB SpeakerState (OnOff%)
' Turns speaker on or off.
IF OnOff% THEN WriteDSP &HD1 ELSE WriteDSP &HD3
END SUB

FUNCTION SpeakerStatus%
OUT BasePort% + 4, &HD8
IF INP(BasePort% + 5) = &HFF THEN SpeakerStatus% = -1 ELSE SpeakerStatus% = 0
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

SUB WriteDAC (byte%)
' Writes a byte to the DAC.
WriteDSP &H10
WriteDSP byte%
END SUB

SUB WriteDSP (byte%)
' Writes a byte to the DSP
DO
LOOP WHILE INP(BasePort% + 12) AND &H80
OUT BasePort% + 12, byte%
END SUB

