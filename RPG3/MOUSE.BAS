DECLARE SUB mouseHide ()
DECLARE SUB mouseShow ()
DECLARE SUB mousestatus (LB%, RB%, xmouse%, ymouse%)
DECLARE FUNCTION MouseInit% ()
DECLARE SUB MouseDriver (AX%, bx%, CX%, DX%)

DEFINT A-Z

TYPE button
    x1 AS INTEGER
    y1 AS INTEGER
    x2 AS INTEGER
    y2 AS INTEGER
    cm AS STRING * 10
    o AS STRING * 1
END TYPE

DIM SHARED mouse$

RESTORE
mouse$ = SPACE$(57)
FOR I% = 1 TO 57
  READ a$
  H$ = CHR$(VAL("&H" + a$))
  MID$(mouse$, I%, 1) = H$
NEXT I%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
CLS
MS% = MouseInit%
IF NOT MS% THEN
  PRINT "Mouse not found": LET AMOUSE$ = "NO":
  PRINT "This Game Won't Run Without Mouse"
  END
END IF
LET AMOUSE$ = "YES"

SCREEN 12
CALL mouseShow
CLS
DO
OX = X: OY = Y
a$ = INKEY$
IF a$ = "+" THEN c = c + 1
IF a$ = "-" THEN c = c - 1
IF a$ = "*" THEN c = c + 8
IF a$ = "/" THEN c = c - 8
IF c < 0 THEN c = c + 16
IF c > 15 THEN c = c - 16
OLB = LB: ORB = RB
mousestatus LB, RB, X, Y
LOCATE 1, 1
COLOR 15
PRINT "x"; X; "y"; Y
LOCATE 1, 20: PRINT "Color: "; : COLOR c: PRINT "************"
 IF LB = -1 AND OLB = 0 THEN SX = OX: SY = OY
IF LB = 0 AND OLB = -1 THEN mouseHide: LINE (OX, OY)-(SX, SY), c: mouseShow
IF LB = -1 THEN mouseHide: LINE (OX, OY)-(X, Y), c: mouseShow
IF RB THEN mouseHide: PAINT (X, Y), c, c: mouseShow
LOOP
DEFSNG A-Z

SUB bmp (filename$, X$)
CLS
OPEN filename$ FOR BINARY AS #1

header$ = SPACE$(14)
sizing$ = SPACE$(4)
GET #1, 1, header$
GET #1, 15, sizing$
bmpinfosize = CVI(sizing$)
IF bmpinfosize = 12 THEN
   infoheader$ = SPACE$(12)
   GET #1, 15, infoheader$
   nbits = CVI(MID$(infoheader$, 15, 4))
 
   IF nbits = 1 THEN
      palet$ = SPACE$(6)
      GET #1, bmpinfosize + 15, palet$
   ELSEIF nbits = 4 THEN
      palet$ = SPACE$(48)
      GET #1, bmpinfosize + 15, palet$
   ELSEIF nbits = 8 THEN
      palet$ = SPACE$(768)
      GET #1, bmpinfosize + 15, palet$
   END IF
ELSEIF bmpinfosize = 40 THEN
   infoheader$ = SPACE$(40)
   GET #1, 15, infoheader$
   nbits = CVI(MID$(infoheader$, 15, 4))
   IF nbits = 1 THEN
      palet$ = SPACE$(8)
      GET #1, bmpinfosize + 15, palet$
   ELSEIF nbits = 4 THEN
      palet$ = SPACE$(64)
      GET #1, bmpinfosize + 15, palet$
   ELSEIF nbits = 8 THEN
      palet$ = SPACE$(1024)
      GET #1, bmpinfosize + 15, palet$
   END IF
END IF
    

ft$ = MID$(header$, 1, 2)

filesize = CVL(MID$(header$, 3, 4))

r1 = CVI(MID$(header$, 7, 2))

r2 = CVI(MID$(header$, 9, 2))

offset = CVL(MID$(header$, 11, 4))


headersize = CVL(MID$(infoheader$, 1, 4))

picwidth = CVL(MID$(infoheader$, 5, 4))

picheight = CVL(MID$(infoheader$, 9, 4))

nplanes = CVI(MID$(infoheader$, 13, 4))


IF headersize = 40 THEN
   comptype = CVL(MID$(infoheader$, 17, 4))
 
   imagesize = CVL(MID$(infoheader$, 21, 4))
 
   xsize = CVL(MID$(infoheader$, 25, 4))
 
   ysize = CVL(MID$(infoheader$, 29, 4))
 
   colorsused = CVL(MID$(infoheader$, 33, 4))
 
   neededcolours = CVL(MID$(infoheader$, 37, 4))
END IF

IF nbits = 1 THEN
   SCREEN 11
ELSEIF nbits = 4 THEN
   SCREEN 12
ELSEIF nbits = 8 OR nbits = 24 THEN
   SCREEN 13
END IF
LOCATE 1, 40: PRINT "Loading Palette..."
IF bmpinfosize = 40 THEN ngroups = 4
IF bmpinfosize = 12 THEN ngroups = 3

IF nbits = 24 THEN
   IF ngroups = 3 THEN
      FOR c = 0 TO 63
         d = c * 4
         palet$ = palet$ + CHR$(d) + CHR$(d) + CHR$(d)
         palet$ = palet$ + CHR$(d) + CHR$(d) + CHR$(d + 1)
         palet$ = palet$ + CHR$(d) + CHR$(d + 1) + CHR$(d)
         palet$ = palet$ + CHR$(d + 1) + CHR$(d) + CHR$(d)
      NEXT c
   ELSEIF ngroups = 4 THEN
      FOR c = 0 TO 63
         d = c * 4
         palet$ = palet$ + CHR$(d) + CHR$(d) + CHR$(d) + CHR$(0)
         palet$ = palet$ + CHR$(d) + CHR$(d) + CHR$(d + 1) + CHR$(0)
         palet$ = palet$ + CHR$(d) + CHR$(d + 1) + CHR$(d) + CHR$(0)
         palet$ = palet$ + CHR$(d + 1) + CHR$(d) + CHR$(d) + CHR$(0)
      NEXT c
   END IF
END IF

FOR X = 1 TO LEN(palet$) STEP ngroups
   zb# = INT((ASC(MID$(palet$, X, 1))) / 4): '''45345353thghfdgdhg gfhfd
   zg# = INT((ASC(MID$(palet$, X + 1, 1))) / 4)
   zr# = INT((ASC(MID$(palet$, X + 2, 1))) / 4)
   zc# = zb# * 65536# + zg# * 256# + zr#
   cres = ASC(MID$(palet$, X + 3, 1))
   PALETTE ((X - 1) / ngroups), zc#
NEXT X

IF nbits = 24 THEN
   Y = picheight - 1
   X = 0
   dat$ = "   "
   WHILE Y >= 0
      WHILE X < picwidth
         GET 1, , dat$
         p1 = INT((ASC(MID$(dat$, 1, 1)) + ASC(MID$(dat$, 1, 1)) + ASC(MID$(dat$, 1, 1))) / 3)
         X = X + 1
      WEND
      Y = Y - 1
      X = 0
   WEND
ELSEIF nbits = 8 THEN
   Y = picheight - 1
   X = 0
   dat$ = " "
   WHILE Y >= 0
      WHILE X < picwidth
         GET 1, , dat$
         X = X + 1
      WEND
      Y = Y - 1
      X = 0
   WEND
ELSEIF nbits = 4 THEN
   Y = picheight - 1
   X = 0
   dat$ = " "
   WHILE Y >= 0
      WHILE X < picwidth
        GET 1, , dat$
        LOCATE 1, 1
        p1 = ASC(dat$) AND 15
        p2 = ASC(dat$) AND 240 / 16
        X = X + 2
      WEND
      Y = Y - 1
      X = 0
   WEND
ELSEIF nbits = 1 THEN
   Y = picheight - 1
   X = 0
   dat$ = " "
   WHILE Y >= 0
      WHILE X < picwidth
        GET 1, , dat$
        p1 = ASC(dat$)
        FOR p = 0 TO 7
        NEXT p
        X = X + 8
      WEND
      Y = Y - 1
      X = 0
   WEND
END IF

CLOSE

END SUB

SUB getbutton
DO
mousestatus LB%, RB%, xmouse%, ymouse%
IF LB% = -1 THEN EXIT DO
LOOP UNTIL INKEY$ <> ""
hotmail:
mousestatus LB%, RB%, xmouse%, ymouse%
IF LB% = -1 THEN GOTO hotmail
END SUB

SUB MouseDriver (AX%, bx%, CX%, DX%)
  DEF SEG = VARSEG(mouse$)
  mouse% = SADD(mouse$)
  CALL Absolute(AX%, bx%, CX%, DX%, mouse%)
END SUB

SUB mouseHide
 AX% = 2
 MouseDriver AX%, 0, 0, 0

END SUB

FUNCTION MouseInit%
  AX% = 0
  MouseDriver AX%, 0, 0, 0
  MouseInit% = AX%

END FUNCTION

SUB Mouseput
  AX% = 4
  CX% = X%
  DX% = Y%
  MouseDriver AX%, 0, CX%, DX%

END SUB

SUB mouseShow
  AX% = 1
  MouseDriver AX%, 0, 0, 0

END SUB

SUB mousestatus (LB%, RB%, xmouse%, ymouse%)
  AX% = 3
  MouseDriver AX%, bx%, CX%, DX%
  LB% = ((bx% AND 1) <> 0)
  RB% = ((bx% AND 2) <> 0)
  xmouse% = CX%
  ymouse% = DX%
END SUB

