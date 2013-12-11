SCREEN 13: CLS
PALETTE 0, 65536 * 40
LINE (5, 3)-(290, 190), 15, B
LINE (7, 5)-(288, 188), 15, B
LOCATE 4, 8: PRINT "  << Dynamite Men >>   "
LOCATE 8, 8: PRINT "     Installation:    "
LOCATE 12, 9: PRINT "  Source disk (A/B)?"
EE:
A$ = INPUT$(1)
IF A$ <> "A" AND A$ <> "a" AND A$ <> "B" AND A$ <> "b" THEN BEEP: GOTO EE
KE$ = A$
LINE (8, 80)-(287, 187), 0, BF
LOCATE 12, 6: PRINT "Warning!!! The game directory"
LOCATE 14, 6: PRINT "must be `C:\VITAL'!!!"
LOCATE 16, 6: PRINT "If you have some problems ,"
LOCATE 18, 6: PRINT "please exit !!!"
BEEP
A$ = INPUT$(1)
LINE (8, 80)-(287, 187), 0, BF
EE2:
LOCATE 12, 11: PRINT "Install now (Y/n)?"
A$ = INPUT$(1)
IF A$ = "n" OR A$ = "N" THEN END
IF A$ = CHR$(13) OR A$ = "Y" OR A$ = "y" THEN  ELSE GOTO EE2
SCREEN 2: SCREEN 0
COLOR 15, 9
LOCATE 1, 1: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
COLOR 15, 9
LOCATE 2, 1: PRINT "€                                Vital Fight                                  €"
COLOR 15, 9
LOCATE 3, 1: PRINT "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"
COLOR 7, 0
LOCATE 4, 1: PRINT "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
END
SHELL "C:"
SHELL "CD\"
SHELL "MD VITAL"
SHELL KE$ + ":"
SHELL "COPY VITAL\*.* C:\VITAL"
CLS
COLOR 15, 4
LOCATE 1, 1: PRINT "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
COLOR 15, 4
LOCATE 2, 1: PRINT "€                                Finish !!!                                   €"
COLOR 15, 4
LOCATE 3, 1: PRINT "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€"
COLOR 7, 0
LOCATE 4, 1: PRINT "ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
LOCATE 6, 1: PRINT "Please use QuickBASIC to open BOMB.BAS."
BEEP
END

