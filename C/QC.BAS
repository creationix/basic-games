'€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
'€€                                                                        €€
'€€   €€€   €   €   €€€   €  €       €€€€  €€€€  €€€€€ €€€€€  €€€   €€€€   €€
'€€  €   €  €   €  €   €  € €        €     €   €   €     €   €   €  €   €  €€
'€€  €   €  €   €  €      €€    €€€  €€€   €   €   €     €   €   €  €€€€   €€
'€€  € € €  €   €  €   €  € €        €     €   €   €     €   €   €  € €    €€
'€€   €€€    €€€    €€€   €  €       €€€€  €€€€  €€€€€   €    €€€   €  €   €€
'€€      €                                                                 €€
'€€                            By Tim Caswell                              €€
'€€                                                                        €€
'€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€
'
'   I wrote this program for two reasons.  First I wanted to prove to myself
'that I could make profesional looking applications.  Second I lost my QC.EXE
'file and it was very hard to write in C using MS-Dos Edit.  This program is
'compatable with: Q-Basic, Quick-Basic, FirstBasic and a few other basic
'languages.  It has no global varibles or even user made data types.  Every
'line label is on its own line and all sub calls use the CALL command.
'
'
'
'

SCREEN 0: WIDTH 80                      'Set the screen
DEFINT A-Z                              'Use integers to speed program

										'  Set defaults

file$ = "Untitled.c"                    'File name
MaxLength = 2000                        'Maxumum lines in program
DIM prog$(MaxLength), m$(9), opt(5)
DIM clip$(MaxLength)
ClipLen = 0                             'Size of clipboard
ProgLength = 5                          'Starting blank lines
opt(1) = 4                              'Memory is large
opt(2) = 2                              '286 Code
opt(3) = 1                              'Code is Optimized
opt(4) = 2                              'Output is EXE
opt(5) = 0                              'Change one only
x = 1: y = 1: sy = -2                   'Start at top of program

CLS                                     'Clear the program
COLOR 9, 0                              'Set the color
CALL frame                              'Draw the frame
LOCATE 2, 39 - LEN(file$) \ 2: COLOR 9, 0: PRINT " "; file$; " "

DO
a$ = INKEY$: t$ = a$                    'Get key pushed and make a copy of it

IF a$ = CHR$(6) THEN                    'File Menu
	m$(1) = " &New           "          '\
	m$(2) = " &Open...       "          ' \
	m$(3) = " &Save          "          '  \
	m$(4) = " Save &As...    "          '   \
	m$(5) = " &Change dir... "          '    \ Call the menu!
	m$(6) = "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"           '    /
	m$(7) = " &Print...      "          '   /
	m$(8) = "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"           '  /
	m$(9) = " E&xit          "          ' /
	rpt = menu(1, 2, 15, 9, m$())       '/
   
	IF rpt = 1 THEN                     'User selects New...
		CALL clearit(prog$(), MaxLength)'Clear the program
		file$ = "Untitled"              'Reset the title
		chg = 0                         'New program is unchanged
		y = 1: x = 1: sy = -2           'Go to top of program
		canrun = 0                      'Tell computer it isn't compiled
	END IF

	IF rpt = 2 THEN                     'User Selects Open...
		f$ = OpenIt$(prog$(), ProgLength, MaxLength)    'Call opening sub
		IF f$ <> "" THEN                'If a file is opened...
			file$ = f$                  'Set new title
			chg = 0                     'Opened program is unchanged
			y = 1: x = 1: sy = -2       'Go to top of computer
			canrun = 0                  'Tell computer it isn't compiled
		END IF
	END IF
	IF rpt = 3 THEN                     'User selects save...
		CALL save(prog$(), file$, ProgLength)   'Call Saving sub
		chg = 0                         'Saved file is unchanged
	END IF
	IF rpt = 4 THEN                     'User selects save as...
		file$ = saveas$                 'Get the name of file
		CALL save(prog$(), file$, ProgLength)   'Call saving sub
		chg = 0                         'Saved file is unchanged
	END IF
	IF rpt = 5 THEN                     'User selects change directory...
		f$ = Opendir$                   'get the name of the new directory
		IF f$ <> "" THEN CHDIR f$       'If valid change the current dir.
	END IF
	IF rpt = 7 THEN                     'User selects Print
		CALL printit(prog$(), file$, ProgLength)   'Call the printing sub
	END IF
	IF rpt = 9 THEN                     'User selects Exit
		IF chg = 1 THEN                 'if program is changed...
			a = ask("Do you want to save it first?")    'ask if want saved
			IF a = 1 THEN CALL save(prog$(), file$, ProgLength) 'save it
		END IF
		CLS : SYSTEM                    'Exit to dos!
	END IF
	CALL frame                          'Draw the frame
	LOCATE 2, 39 - LEN(file$) \ 2
	COLOR 9, 0: PRINT " "; file$; " "   'Write the title
	upt = 1                             'Signal flag to update
END IF
IF a$ = CHR$(5) THEN                    'If user selects the Edit menu
	m$(1) = "Cu&t            "          '\
	m$(2) = "&Copy           "          ' \
	m$(3) = "&Paste          "          '  \ Set the Edit menu
	m$(4) = "Clea&r          "          '   /
	m$(5) = "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"           '  /
	m$(6) = "&New Line       "          ' /
	m$(7) = "&Erase Line     "          '/
	IF BlockS = 0 THEN m$(1) = "Cut            "    'Disable options if
	IF BlockS = 0 THEN m$(2) = "Copy           "    'clipboard is empty or
	IF ClipLen <= 0 THEN m$(3) = "Paste          "  'nothing is currently
	IF BlockS = 0 THEN m$(4) = "Delete         "    'highlighted.
	rpt = menu(9, 2, 15, 7, m$())       'Call the menu
	IF rpt = 1 OR rpt = 2 THEN          'user selects cut or copy...
		b = 0                           '\
		FOR a = BlockS TO BlockE        ' \
			b = b + 1                   '  \ Copy highlighted
			clip$(b) = prog$(a)         '  / text to clipboard
		NEXT a                          ' /
		ClipLen = b                     '/
	END IF
	IF rpt = 1 OR rpt = 4 THEN          'User selects cut or clear...
		FOR a = 1 TO BlockE - BlockS                  ' Clear the highlighted
			CALL ShiftUp(BlockS, ProgLength, prog$()) ' text and move program
		NEXT a                                        ' up.
	END IF
	IF rpt = 3 THEN                     'User selects paste...
		b = ClipLen                     'Get the clipLength
		FOR a = 1 TO b                              '\ Make room to place
			CALL ShiftDown(y, ProgLength, prog$())  '| the clipboard into
		NEXT a                                      '/ the program.
		FOR a = 1 TO b                              '\
			prog$(a + y - 1) = clip$(a)             '| Copy the clipboard
		NEXT a                                      '/ to the screen.
	END IF
	IF rpt = 6 THEN                                 'User selects new Line...
		CALL ShiftDown(y, ProgLength, prog$())      'insert a new line
	END IF
	IF rpt = 7 THEN                                 'User selects eraseline...
		CALL ShiftUp(y, ProgLength, prog$())        'Erase the line
	END IF
	BlockS = 0: BlockE = 0                          'Reset highlight
	CALL frame                                      'Draw the frame
	LOCATE 2, 39 - LEN(file$) \ 2
	COLOR 9, 0: PRINT " "; file$; " "               'Write the title
	upt = 1                                         'Signal flad to update
END IF
IF a$ = CHR$(3) THEN                                'User selects compile...
	m$(1) = "&Compile        "                      '\
	m$(2) = "Compile && Run  "                      ' \ Run the menu
	m$(3) = "&Run Program    "                      ' /
	rpt = menu(15, 2, 15, 3, m$())                  '/
	IF rpt = 3 THEN                                 'User selects Run program
		IF chg = 1 THEN IF ask("Do you want to recompile?") = 1 THEN rpt = 2
	END IF
	IF rpt = 1 OR rpt = 2 THEN                      'User selects compile..
		COLOR 12, 0                                 'change color to red
		CLS                                         'clear the screen
		c$ = "Qcl " + file$                         '\
		IF opt(1) = 1 THEN c$ = c$ + " /AS"         ' \
		IF opt(1) = 2 THEN c$ = c$ + " /AC"         '  \
		IF opt(1) = 3 THEN c$ = c$ + " /AM"         '   \
		IF opt(1) = 4 THEN c$ = c$ + " /AL"         '    \
		IF opt(2) = 1 THEN c$ = c$ + " /G0"         '     \ Calculate The
		IF opt(2) = 2 THEN c$ = c$ + " /G2"         '     / Command to compile
		IF opt(2) = 3 THEN c$ = c$ + " /Gc"         '    /
		IF opt(4) = 1 THEN c$ = c$ + " /Fb"         '   /
		IF opt(4) = 2 THEN c$ = c$ + " /Fe"         '  /
		IF opt(4) = 3 THEN c$ = c$ + " /Fm"         ' /
		IF opt(4) = 4 THEN c$ = c$ + " /Fo"         '/
		SHELL c$                        'Run the command
		canrun = 1                      'Tell computer it can run
	END IF
	IF rpt = 2 OR rpt = 3 AND canrun > 0 THEN       'User chooses run
		CLS                                         'Clear the screen
		c$ = LEFT$(file$, INSTR(file$, ".") - 1)    'Calculate the command
		SHELL c$                        'Run the program
	END IF
	CALL frame                          'Draw the frame
	LOCATE 2, 39 - LEN(file$) \ 2
	COLOR 9, 0: PRINT " "; file$; " "   'Write the title
	upt = 1                             'Set flag to update
END IF
IF a$ = CHR$(4) THEN                    'User selects
	m$(1) = "&Space Program  "          '\
	m$(2) = "&Fix keywords   "          ' \
	m$(3) = "&Trim program   "          '  \ Run the menu
	m$(4) = "&Command...     "          ' /
	rpt = menu(24, 2, 15, 4, m$())      '/
	IF rpt = 1 THEN                     'user selects Space Program...
		CALL fixSpace(prog$(), ProgLength)          'call utility
	END IF
	IF rpt = 2 THEN                     'user selects Fix Keywords...
		CALL fixkeyword(prog$(), ProgLength)        'call utility
	END IF
	IF rpt = 3 THEN                     'user selects Trim Program...
		CALL Trim(prog$(), ProgLength, MaxLength)   'call utility
	END IF
	IF rpt = 4 THEN                     'user selects Command...
		COLOR 0, 7                      'use menu colors
		CALL box(25, 13, 30, 1)         'Draw a window
		LOCATE 14, 26
		PRINT "Command: ";              '\ Input the command
		c$ = kinp$(17)                  '/
		COLOR 7, 0                      'Use dos colors
		CLS : SHELL c$                  'run the command
		PRINT "Press any key to return" '\ Pause for a key
		DO: LOOP WHILE INKEY$ = ""      '/
	END IF
	CALL frame                          'Draw theframe
	LOCATE 2, 39 - LEN(file$) \ 2
	COLOR 9, 0: PRINT " "; file$; " "   'Write the Title
	upt = 1                             'Set flag to update
END IF
IF a$ = CHR$(15) THEN                   'User selects options menu...
	DO                                  'Start options loop
		m$(1) = "&Memory "              'Set memory option
		IF opt(1) = 1 THEN m$(1) = m$(1) + "Small   "
		IF opt(1) = 2 THEN m$(1) = m$(1) + "Compact "
		IF opt(1) = 3 THEN m$(1) = m$(1) + "Medium  "
		IF opt(1) = 4 THEN m$(1) = m$(1) + "Large   "
		m$(2) = "&Code   "              'Set code option
		IF opt(2) = 1 THEN m$(2) = m$(2) + "8086    "
		IF opt(2) = 2 THEN m$(2) = m$(2) + "286     "
		IF opt(2) = 3 THEN m$(2) = m$(2) + "Pascal  "
		m$(3) = "&Optimized   No "      'Set Optimazation option
		IF opt(3) = 1 THEN m$(3) = "&Optimized  Yes "
		m$(4) = "Out&put "              'Set output option
		IF opt(4) = 1 THEN m$(4) = m$(4) + "Bound   "
		IF opt(4) = 2 THEN m$(4) = m$(4) + "EXE     "
		IF opt(4) = 3 THEN m$(4) = m$(4) + "Map     "
		IF opt(4) = 4 THEN m$(4) = m$(4) + "Object  "
		m$(5) = "&Done   "              'Add done option
		rpt = menu(31, 2, 15, 5, m$())  'Run the menu
		IF rpt = 1 THEN                 'User selects memory option...
			m$(1) = "&Small   "                '\
			m$(2) = "&Compact "                ' \
			m$(3) = "&Medium  "                '  \ Use menu to ask choice
			m$(4) = "&Large   "                ' /
			opt(1) = menu(10, 10, 8, 4, m$())  '/
		END IF
		IF rpt = 2 THEN                 'User selects code option...
			m$(1) = "&8086    "         '\
			m$(2) = "&286     "         '| Set menu to ask choice
			m$(3) = "&Pascal  "         '/
			opt(2) = menu(10, 10, 8, 3, m$())   'Run the menu
		END IF
		IF rpt = 3 THEN                 'User selects optimization option...
			m$(1) = "&Normal   "                    '\
			m$(2) = "&Optimized"                    '| Use menu to ask choice
			opt(3) = menu(10, 10, 9, 2, m$()) - 1   '/
		END IF
		IF rpt = 4 THEN                 'User selects Output option...
			m$(1) = "&Bound   "         '\
			m$(2) = "&EXE     "         ' \ Set Menu to ask choice
			m$(3) = "&MAP     "         ' /
			m$(4) = "&Object  "         '/
			opt(4) = menu(10, 10, 8, 4, m$())   'Run the menu
		END IF
		CALL frame                      'Draw the frame
	LOOP WHILE rpt > 0 AND rpt < 5      'Go to start unless user is done
	LOCATE 2, 39 - LEN(file$) \ 2
	COLOR 9, 0: PRINT " "; file$; " "   'Write the title
	upt = 1                             'Set flag to update
END IF
IF a$ = CHR$(19) THEN                   'User selects search menu...
	m$(1) = "&Search...      "          '\
	m$(2) = "&Change...      "          ': Ask search option
	rpt = menu(40, 2, 15, 2, m$())      '/
	IF rpt = 1 THEN                     'User selects search...
		COLOR 0, 7                      'Use menu colors
		CALL box(25, 13, 30, 1)         'Draw box
		LOCATE 14, 26                   '\
		PRINT "Search for what: ";      '| Ask what to search for
		sr$ = kinp$(12)                 '/
		IF sr$ <> "" THEN               ' If search is valid...
		y = search(y, ProgLength, sr$, prog$()) 'Move cursor to find position
		END IF
	END IF
	IF rpt = 2 THEN                     'User selects Change option...
		DO                              'Start change loop
			m$(1) = "&Search for:" + LEFT$(sr$ + SPACE$(9), 9) '\
			m$(2) = "Change &to :" + LEFT$(ch$ + SPACE$(9), 9) ' \
			m$(3) = "&Change ":                                ' |Run the
			m$(4) = "  << Change &Now >>  "                    ' |Change menu
			IF opt(5) = 1 THEN m$(3) = m$(3) + "all      "     ' |
			IF opt(5) = 0 THEN m$(3) = m$(3) + "next     "     ' /
			rpt = menu(30, 10, 20, 4, m$())                    '/
			IF rpt = 1 THEN             ' User selects Search for...
				COLOR 0, 7              ' Use menu colors
				CALL box(25, 13, 30, 1)     'Draw input box
				LOCATE 14, 26               '\
				PRINT "Search for what: ";  '| input the search string
				sr$ = kinp$(12)             '/
			END IF
			IF rpt = 2 THEN
				COLOR 0, 7
				CALL box(25, 13, 30, 1)
				LOCATE 14, 26: PRINT "Change to: "; : ch$ = kinp$(18)
			END IF
			IF rpt = 3 THEN opt(5) = ask("Do you want to change all?")
			IF rpt = 4 AND (sr$ = "" OR ch$ = "") THEN rpt = -1
			CALL frame
		LOOP WHILE rpt <> 4 AND rpt <> 0
		IF rpt = 4 THEN CALL change(y, ProgLength, sr$, ch$, prog$(), opt(5))
	END IF
	CALL frame
	LOCATE 2, 39 - LEN(file$) \ 2: COLOR 9, 0: PRINT " "; file$; " "
	upt = 1
END IF
IF a$ = CHR$(1) THEN
	m$(1) = " &Quick &Editor  "
	m$(2) = " By &Tim &Caswell"
	m$(3) = " (&c)-1998      "
	rpt = menu(63, 2, 15, 3, m$())
	IF rpt = 1 THEN a = ask(" Is this Quick? ")
	IF rpt = 2 THEN a = ask(" Yes I made it! ")
	IF rpt = 3 THEN a = ask("My own copyright.")
	CALL frame
	LOCATE 2, 39 - LEN(file$) \ 2: COLOR 9, 0: PRINT " "; file$; " "
	upt = 1
END IF

IF a$ = CHR$(0) + "S" THEN
	IF BlockS > 0 OR BlockE > 0 THEN BlockS = 0: BlockE = 0: upt = 1
	IF x - 1 < LEN(prog$(y)) THEN
		prog$(y) = LEFT$(prog$(y), x - 1) + MID$(prog$(y), x + 1)
		COLOR 9, 0: LOCATE y - sy, 2: CALL tline(prog$(y))
	ELSE
		IF x = LEN(prog$(y)) THEN
			CALL ShiftUp(y, ProgLength, prog$())
			CALL update(sy, prog$(), BlockS, BlockE)
		END IF
	END IF
END IF
IF ASC(a$ + " ") = 9 THEN t$ = "   ": mode = 1
IF a$ = CHR$(0) + CHR$(132) THEN
	y = y - 1
	IF BlockE = 0 OR BlockE < BlockS THEN
		BlockE = y + 1: BlockS = y + 1
	ELSE
		BlockS = y + 1
	END IF
	upt = 1
END IF
IF a$ = CHR$(0) + CHR$(118) THEN
	y = y + 1
	IF BlockE = 0 OR BlockE < BlockS THEN
		BlockE = y - 1: BlockS = y - 1
	ELSE
		BlockE = y - 1
	END IF
	upt = 1
END IF
IF a$ = CHR$(0) + CHR$(119) THEN x = 1: y = 1
IF a$ = CHR$(0) + CHR$(117) THEN x = 1: y = ProgLength
IF a$ = CHR$(0) + CHR$(82) THEN mode = 1 - mode
IF a$ = CHR$(0) + "I" THEN y = y - 18
IF a$ = CHR$(0) + "Q" THEN y = y + 18
IF a$ = CHR$(0) + "G" THEN x = 1
IF a$ = CHR$(0) + "O" THEN x = LEN(prog$(y)) + 1
IF a$ = CHR$(0) + "H" THEN y = y - 1
IF a$ = CHR$(0) + "P" THEN y = y + 1
IF a$ = CHR$(0) + "K" THEN x = x - 1
IF a$ = CHR$(0) + "M" THEN x = x + 1
IF a$ = CHR$(13) THEN
	IF mode = 1 THEN
		CALL ShiftDown(y + 1, ProgLength, prog$())
		prog$(y + 1) = MID$(prog$(y), x)
		prog$(y) = LEFT$(prog$(y), x - 1)
		upt = 1
	END IF
	x = 1: y = y + 1
END IF
IF a$ = CHR$(8) THEN
	IF BlockS > 0 OR BlockE > 0 THEN BlockS = 0: BlockE = 0: upt = 1
	t$ = " "
	x = x - 1
	IF x > LEN(RTRIM$(prog$(y))) THEN x = LEN(RTRIM$(prog$(y))) + 1
	IF x < LEN(RTRIM$(prog$(y))) AND x > 1 THEN x = x + 1: prog$(y) = LEFT$(prog$(y), x - 2) + MID$(prog$(y), x): t$ = "": COLOR 9, 0: LOCATE y - sy, 2, 0: CALL tline(prog$(y))
	IF x < 1 THEN
		t$ = ""
		x = LEN(prog$(y - 1)) + 2
		prog$(y - 1) = prog$(y - 1) + prog$(y)
		CALL ShiftUp(y, ProgLength, prog$())
		y = y - 1: upt = 1: chg = 1
	ELSE
		mode = 0
	END IF
END IF
IF x < 1 THEN x = 1: CALL alert ELSE IF x > 79 THEN x = 79: CALL alert
IF y - sy < 3 THEN sy = y - 3: upt = 1
IF sy < -2 THEN sy = -2
IF y - sy > 23 THEN sy = y - 23: upt = 1
IF sy > MaxLength - 23 THEN sy = MaxLength - 23
IF y - sy > 23 THEN y = 23 + sy: CALL alert
IF y < 1 THEN y = 1: CALL alert
IF y > ProgLength THEN y = ProgLength: CALL alert
IF y - sy > 23 THEN sy = y - 23: upt = 1
IF upt = 1 THEN upt = 0: CALL update(sy, prog$(), BlockS, BlockE): LOCATE 2, 39 - LEN(file$) \ 2: COLOR 9, 0: PRINT " "; file$; " "
LOCATE 25, 60, 0: COLOR 0, 11: PRINT USING "≥        ####:"; y; : PRINT USING "###"; x;
COLOR 9, 0

LOCATE y - sy, x + 1, 1, 31 - (mode * 3 + 1), 31

IF ASC(t$ + " ") > 31 AND t$ <> "" THEN
	IF BlockS > 0 OR BlockE > 0 THEN BlockS = 0: BlockE = 0: upt = 1
	chg = 1
	DO WHILE LEN(prog$(y)) < x
	prog$(y) = prog$(y) + " "
	LOOP
	IF mode = 0 THEN MID$(prog$(y), x) = t$
	IF mode = 1 THEN prog$(y) = prog$(y) + "   ": MID$(prog$(y), x) = t$ + MID$(prog$(y), x):
	COLOR 9, 0: LOCATE y - sy, 2, 0: CALL tline(prog$(y))
	IF t$ = "   " THEN x = x + 2
	x = x + 1
	IF y > ProgLength THEN ProgLength = y
END IF

IF a$ = CHR$(8) THEN x = x - 1
prog$(y) = RTRIM$(prog$(y))
LOOP

SUB alert
FOR a = 1 TO 2
SOUND 1000 * a, .1
SOUND 100 * a, .1
SOUND 200 * a, .1
NEXT a
END SUB

FUNCTION ask (t$)
x = 39 - LEN(t$) \ 2
y = 13
COLOR 0, 7
CALL box(x, y, LEN(t$), 1)
LOCATE y + 1, x + 1: PRINT t$
DO
a$ = UCASE$(INKEY$)
LOOP WHILE a$ = ""
IF a$ = "Y" THEN ask = 1 ELSE ask = 0
END FUNCTION

FUNCTION askn$ (t$)
x = 39 - LEN(t$) \ 2
y = 13
COLOR 0, 7
CALL box(x, y, LEN(t$), 1)
LOCATE y + 1, x + 1: PRINT t$
DO
a$ = UCASE$(INKEY$)
LOOP WHILE a$ = ""
askn$ = a$
END FUNCTION

SUB box (x, y, w, h)
LOCATE y, x, 0: PRINT "⁄"; STRING$(w, "ƒ"); "ø";
FOR a = 1 TO h
LOCATE y + a, x: PRINT "≥"; STRING$(w, " "); "≥≤";
NEXT a
LOCATE y + h + 1, x: PRINT "¿"; STRING$(w, "ƒ"); "Ÿ≤";
LOCATE y + h + 2, x + 1: PRINT STRING$(w + 2, "≤");
END SUB

SUB change (y, ProgLength, sr$, ch$, prog$(), o)
a = y
DO
	a = a + 1
	IF a > ProgLength THEN a = 1
	b = INSTR(prog$(a), sr$)
	IF b > 0 THEN prog$(a) = LEFT$(prog$(a), b - 1) + ch$ + MID$(prog$(a), b + LEN(sr$)): SOUND 200, .3: IF o = 0 THEN EXIT SUB
LOOP WHILE a <> y
END SUB

SUB clearit (prog$(), maxP)
FOR a = 1 TO maxP
prog$(a) = ""
NEXT a
END SUB

FUNCTION cPRINT$ (a$, c)
r$ = ""
ok = 0
FOR a = 1 TO LEN(a$)
IF MID$(a$, a, 1) = "&" THEN ok = 1
NEXT a
FOR a = 1 TO LEN(a$)
b$ = MID$(a$, a, 1)
COLOR c
IF ok = 0 THEN COLOR (c + 8) MOD 9
IF b$ = "&" THEN COLOR 15: a = a + 1: b$ = MID$(a$, a, 1): r$ = b$
PRINT b$;
NEXT a
cPRINT$ = r$
END FUNCTION

SUB fixkeyword (prog$(), ProgLength)
DIM kew$(32)
OPEN "keywords.txt" FOR INPUT AS #1
FOR a = 1 TO 32
	INPUT #1, kew$(a)
NEXT a
CLOSE #1
FOR a = 1 TO ProgLength
FOR b = 1 TO 32
c = INSTR(UCASE$(prog$(a)), UCASE$(kew$(b)))
IF c > 0 THEN MID$(prog$(a), c) = kew$(b)
NEXT b
NEXT a
END SUB

SUB fixSpace (prog$(), ProgLength)
FOR a = 1 TO ProgLength
	FOR b = 1 TO LEN(prog$(a))
		IF MID$(prog$(a), b, 1) = "," THEN
			IF MID$(prog$(a) + " ", b + 1, 1) <> " " THEN prog$(a) = LEFT$(prog$(a), b) + " " + MID$(prog$(a), b + 1): SOUND 37, .1: b = b - 1
			DO WHILE MID$(prog$(a) + "++", b + 1, 2) = "  "
				prog$(a) = LEFT$(prog$(a), b) + MID$(prog$(a), b + 2): SOUND 300, .1
			LOOP
		END IF
	NEXT b
	prog$(a) = RTRIM$(prog$(a))
NEXT a
END SUB

SUB frame
LOCATE 1, 1
COLOR 0, 7
a$ = cPRINT$("  &File  &Edit  &Compile  &Debug  &Options  &Search                            &About  ", 0)
COLOR 9, 0
PRINT "…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "∫                                                                              ∫";
PRINT "»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº";
LOCATE 25, 1: COLOR 15, 3
PRINT " <Ctrl+Letter=Menu>  <Ctrl+Pageup or Pagedown=Hilight>                          ";
END SUB

FUNCTION kinp$ (wid)
k$ = ""
y = CSRLIN: x = POS(0)
sx = x
kinp$ = ""
DO
	LOCATE y, x, 1
	a$ = INKEY$: b$ = a$
	IF a$ = CHR$(8) THEN a$ = "": IF sx < x THEN kinp$ = LEFT$(k$, LEN(k$) - 1): x = x - 1: LOCATE y, x: PRINT " ": a$ = "": SOUND 300, .1: SOUND 200, .1: SOUND 100, .1
	IF a$ = CHR$(13) THEN a$ = ""
	IF a$ <> "" THEN IF x - sx <= wid THEN k$ = k$ + a$: PRINT a$: x = x + 1: SOUND 1000, .1: SOUND 0, 0 ELSE SOUND 100, .1
	IF a$ = CHR$(27) THEN kinp$ = a$: EXIT FUNCTION
LOOP WHILE b$ <> CHR$(13)
kinp$ = k$
END FUNCTION

FUNCTION menu (x, y, w, h, m$())
DIM k$(9)
COLOR 0, 7
CALL box(x, y, w, h)
ch = 1
FOR a = 1 TO h
	c = 0: COLOR , 7
	IF ch = a THEN c = 7: COLOR , 0
	LOCATE y + a, x + 1
	k$(a) = cPRINT$(m$(a), c)
NEXT a

DO
DO: a$ = INKEY$: LOOP WHILE a$ = ""

IF a$ = CHR$(0) + "H" THEN ch = ch - 1
IF a$ = CHR$(0) + "P" THEN ch = ch + 1
IF ch < 1 THEN ch = h
IF ch > h THEN ch = 1
IF a$ = CHR$(27) THEN ch = 0: a$ = CHR$(13)

FOR a = 1 TO h
	IF UCASE$(a$) = UCASE$(k$(a)) THEN ch = a: a$ = CHR$(13)
NEXT a
FOR a = 1 TO h
	c = 0: COLOR , 7
	IF ch = a THEN c = 7: COLOR , 0
	LOCATE y + a, x + 1
	k$(a) = cPRINT$(m$(a), c)
NEXT a

LOOP WHILE a$ <> CHR$(13)

menu = ch
END FUNCTION

FUNCTION Opendir$
DIM dlist$(50)
SHELL "DIR /ad /b /On >DIRLIST.TXT"
OPEN "DIRLIST.TXT" FOR INPUT AS #1
c = 0
DO
c = c + 1
INPUT #1, dirLine$
FileCount% = FileCount% + 1
dlist$(FileCount%) = RTRIM$(LEFT$(dirLine$, 8))
LOOP WHILE NOT EOF(1)
CLOSE #1
KILL "dirlist.txt"
fil = FileCount%
COLOR 0, 7
CALL box(20, 6, 40, 14)
c = 0
FOR a = 0 TO 3
FOR b = 1 TO 13
c = c + 1
LOCATE 6 + b, 21 + a * 10
IF fil >= c THEN PRINT dlist$(c)
NEXT b
NEXT a
LOCATE 20, 21
PRINT "What folder:";
f$ = kinp$(10)
f$ = LTRIM$(RTRIM$(f$))
IF f$ = "" THEN EXIT FUNCTION
f$ = UCASE$(f$)
ok = 0
FOR a = 1 TO 50
	IF dlist$(a) = f$ THEN ok = 1
NEXT a
IF f$ = ".." THEN ok = 1
IF f$ = "\" THEN ok = 1
IF ok = 0 THEN CALL alert: f$ = "": EXIT FUNCTION
Opendir$ = f$
END FUNCTION

FUNCTION OpenIt$ (prog$(), maxP, MaxL)
DIM dlist$(100)
typ$ = "*.c"
start:
fil = 0: FileCount% = 0
SHELL ("DIR " + typ$ + " /b  /On >DIRLIST.TXT")
OPEN "DIRLIST.TXT" FOR INPUT AS #1
DO
	IF NOT EOF(1) THEN INPUT #1, dirLine$ ELSE dirLine$ = ""
IF INSTR(dirLine$, ".") AND FileCount% < 62 THEN
	FileCount% = FileCount% + 1
	dlist$(FileCount%) = LTRIM$(RTRIM$(dirLine$))
	IF dlist$(FileCount%) = "DIRLIST.TXT" THEN FileCount% = FileCount% - 1
END IF
LOOP WHILE NOT EOF(1)
CLOSE #1
KILL "dirlist.txt"
fil = FileCount%
COLOR 0, 7
CALL box(16, 3, 48, 17)
dlist$(fil + 1) = "<Cancel>"
dlist$(fil + 2) = "________"
fil = fil + 2
DO
c = 0
FOR a = 0 TO 3
FOR b = 1 TO 16
c = c + 1
IF ch = c THEN COLOR 15, 0 ELSE COLOR 0, 7
LOCATE 3 + b, 17 + a * 12
IF fil >= c THEN PRINT dlist$(c)
NEXT b
NEXT a
DO
a$ = INKEY$
LOOP WHILE a$ = ""

IF a$ = CHR$(0) + "H" THEN ch = ch - 1
IF a$ = CHR$(0) + "P" THEN ch = ch + 1
IF a$ = CHR$(0) + "K" THEN ch = ch - 16
IF a$ = CHR$(0) + "M" THEN ch = ch + 16
IF ch > fil THEN ch = ch - fil
IF ch < 1 THEN ch = ch + fil
IF a$ = CHR$(27) THEN ch = fil - 1: a$ = CHR$(13)
LOOP WHILE a$ <> CHR$(13)
f$ = dlist$(ch)

IF f$ = "<Cancel>" THEN EXIT FUNCTION

IF f$ = "________" THEN
	LOCATE 20, 17
	PRINT "Enter search paremeters:";
	typ$ = kinp$(10): GOTO start
END IF


ok = 0
FOR a = 1 TO 100
	IF dlist$(a) = f$ THEN ok = 1
NEXT a
IF ok = 0 THEN CALL alert: f$ = "": EXIT FUNCTION
FOR a = 1 TO MaxL
prog$(a) = ""
NEXT a
OPEN f$ FOR INPUT AS #1
a = 1
DO WHILE NOT EOF(1)
LINE INPUT #1, prog$(a)
FOR t = 1 TO LEN(prog$(a))
	IF MID$(prog$(a), t, 1) = CHR$(9) THEN MID$(prog$(a), t, 1) = " "
NEXT t
LOCATE 25, 60, 0: COLOR 0, 11: PRINT USING "≥        ####:"; a; : PRINT USING "###"; 1;
a = a + 1
LOOP
maxP = a
CLOSE #1
OpenIt$ = f$
END FUNCTION

SUB printit (prog$(), file$, maxp)
OPEN "printer.out" FOR OUTPUT AS #1
PRINT #1, SPACE$(40 - LEN(file$) \ 2); file$
PRINT #1, "Lines:"; maxp
PRINT #1, "ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"
FOR a = 1 TO maxp
    PRINT #1, USING "####: "; a;
    PRINT #1, prog$(a)
NEXT a
CLOSE #1
SHELL "type printer.out >prn"
KILL "printer.out"
END SUB

SUB save (prog$(), file$, maxP)
f$ = file$
IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".c"
OPEN f$ FOR OUTPUT AS #1
FOR a = 1 TO maxP
PRINT #1, prog$(a)
NEXT a
CLOSE #1

END SUB

FUNCTION saveas$
COLOR 0, 7
CALL box(20, 13, 40, 1)
LOCATE 14, 21: PRINT "Save as:";
f$ = kinp$(10)
saveas$ = f$
END FUNCTION

FUNCTION search (y, ProgLength, sr$, prog$())
IF y < 1 THEN y = 1
a = y
s = 0
DO
a = a + 1
IF a > ProgLength THEN a = 1
g = INSTR(prog$(a), sr$)
IF g > 0 THEN s = a: a = y
LOOP WHILE a <> y
SOUND 500, .2
IF s = 0 THEN LOCATE 13, 20: a = ask("Search string not found!")
search = s
END FUNCTION

SUB ShiftDown (y, maxP, prog$())
SOUND 37, .1
prog$(maxP) = ""
FOR sy = maxP TO y STEP -1
SWAP prog$(sy), prog$(sy + 1)
NEXT sy
maxP = maxP + 1
END SUB

SUB ShiftUp (y, maxP, prog$())
SOUND 37, .1
prog$(y) = ""
FOR sy = y TO maxP + 1
SWAP prog$(sy + 1), prog$(sy)
NEXT sy
maxP = maxP - 1
IF maxP < 4 THEN maxP = 4
END SUB

SUB title (file$)
LOCATE 2, 39 - LEN(file$) \ 2: COLOR 9, 0: PRINT " "; file$; " "
END SUB

SUB tline (p$)
'PRINT MID$(prog$(y + sy) + SPACE$(78), 1, 78);     'Fast mono
mode = 0
l = LEN(p$)
IF l > 78 THEN l = 78
FOR x = 1 TO l
	a$ = MID$(p$, x, 1): a = ASC(MID$(p$, x, 1))
	c = 0
	IF a = 34 THEN mode = 1 - mode: c = 1
	IF a >= 48 AND a <= 57 THEN c = 4
	IF a >= 65 AND a <= 90 THEN c = 2
	IF a >= 97 AND a <= 122 THEN c = 2
	IF a < 32 THEN a$ = "˛"
	IF a > 127 THEN c = 3
	IF mode = 1 THEN c = 1
COLOR (c + 9) MOD 16
PRINT a$;
NEXT x
IF LEN(p$) < 78 THEN PRINT SPACE$(78 - LEN(p$));
END SUB

SUB Trim (prog$(), ProgLength, MaxLength)
ProgLength = 0
FOR a = 1 TO MaxLength
	prog$(a) = RTRIM$(prog$(a))
	IF LEN(prog$(a)) > 0 THEN ProgLength = a
NEXT a
END SUB

SUB update (sy, prog$(), BlockS, BlockE)
FOR y = 3 TO 23
COLOR 9, 0
IF y + sy >= BlockS AND y + sy <= BlockE THEN COLOR , 7
LOCATE y, 2, 0
CALL tline(prog$(y + sy))
NEXT y
END SUB

