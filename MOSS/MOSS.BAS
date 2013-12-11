DECLARE SUB Game (room%)
DECLARE SUB newgame ()
DECLARE SUB alarm ()
DECLARE FUNCTION menu% ()
DECLARE SUB center (a$)
DECLARE SUB Intro ()
DECLARE FUNCTION EndGame% ()
DECLARE SUB ClearMEM ()
DECLARE SUB fire ()

TYPE room
  t AS INTEGER
  b AS INTEGER
  r AS INTEGER
  l AS INTEGER
END TYPE

DEFINT A-Z
CONST RoomNum = 30
DIM SHARED r(RoomNum) AS room, rn$(RoomNum), CurSong
DIM SHARED f(41, 26), p%(50, 30), pic(7, 7, RoomNum), d$(3, RoomNum)
DEF SEG = VARSEG(p%(0, 0)): BLOAD "moss.pic", 0: 'loads the pics
GOSUB LoadMap
SCREEN 0
WIDTH 40
n = 1
DO
SELECT CASE menu
CASE 1: newgame
CASE 2: 'LoadGame
CASE 3: Intro
CASE 4: IF EndGame THEN END
END SELECT
LOOP


LoadMap:
  FOR a = 1 TO 30
    READ r(a).t, r(a).b, r(a).r, r(a).l, rn$(a)
    FOR y = 1 TO 7
      FOR x = 1 TO 7
        READ pic(x, y, a)
      NEXT x
    NEXT y
    FOR y = 1 TO 3
      READ d$(y, a)
    NEXT y
  NEXT a
RETURN
'    N- S- E- W-   Name of Room
DATA 02,00,00,00,"South Forest        "
DATA 1,2,5,5,5,2,1
DATA 1,2,4,4,4,2,1
DATA 2,1,4,4,4,2,1
DATA 2,1,4,4,4,1,1
DATA 1,1,2,4,4,2,1
DATA 1,1,1,4,4,1,1
DATA 2,1,2,4,4,2,1
DATA "You are at the edge of the forest.  As you look around you can't"
DATA "understand how something so horrible could have happened.  The "
DATA "birds are chirping and the whole forest seems alive."
DATA 03,01,00,00,"Drawbridge          "
DATA 7,7,5,5,5,7,7
DATA 8,8,5,5,5,8,8
DATA 8,8,5,5,5,8,8
DATA 8,8,5,5,5,8,8
DATA 8,8,5,5,5,8,8
DATA 8,8,5,5,5,8,8
DATA 1,6,5,5,5,6,1
DATA "You are on the drawbridge to the Castle Moss.  As you look below"
DATA "you see something green and slimy swim by.  It sends shivers down
DATA "your spine."
DATA 04,02,00,27,"South Hallway       "
DATA 7,2,5,5,5,2,7
DATA 7,2,5,5,5,2,7
DATA 2,2,5,5,5,2,7
DATA 2,2,5,5,5,2,7
DATA 5,5,5,5,5,2,7
DATA 5,5,5,5,5,2,7
DATA 2,2,5,5,5,2,7
DATA "This is the southern hallway.  There is a tower to the west.  The,"
DATA "exit to the castle is to the south.",""
DATA 05,03,10,00,"North Hallway       "
DATA 7,5,5,5,5,5,7
DATA 7,2,5,5,5,2,7
DATA 7,2,5,5,5,2,7
DATA 7,2,5,5,5,5,5
DATA 7,2,5,5,5,5,5
DATA 7,2,5,5,5,2,7
DATA 7,2,5,5,5,2,7
DATA "You are in the northern hallway.  You see a pictire of Lord Bistmuth"
DATA "on the wall to the west.  There is a sprinkling fountain to the north"
DATA "and another hallway to the east."
DATA 06,04,14,17,"Fountain            "
DATA 7,7,5,5,5,7,7
DATA 5,5,5,5,5,5,5
DATA 5,5,8,8,8,5,5
DATA 5,8,8,9,8,8,5
DATA 5,8,8,9,8,8,5
DATA 5,5,8,8,8,5,5
DATA 2,5,5,5,5,5,2
DATA "This is the main fountain of the castle.  To the north is the throne"
DATA "room.  To the west is the park.  The east is the kitchen and to the"
DATA "south is the main hallway."
DATA 07,05,16,00,"Throne Room         "
DATA 7,7,7,10,7,7,7
DATA 7,5,6,5,6,5,7
DATA 7,5,5,6,5,5,10
DATA 7,6,5,5,5,6,7
DATA 7,5,5,5,5,5,7
DATA 7,5,6,5,6,5,7
DATA 7,5,5,5,5,5,7
DATA "This is a cold empty room.  There are six pillars on the walls.  This"
DATA "was the place where Lord Bistmuth once ruled Castle Moss in peace.",""
DATA 09,06,00,08,"Back of Castle      "
DATA 8,8,8,8,8,8,8
DATA 8,8,8,8,8,2,7
DATA 8,8,8,8,8,2,7
DATA 2,2,2,2,2,2,7
DATA 2,2,2,2,2,2,7
DATA 2,2,2,2,2,2,7
DATA 7,2,2,2,2,2,7
DATA "It is dark out here.  There is a forest to the north.  There are"
DATA "towers on either side of you.  That green thing is over here to."
DATA "The secret wall is to the south."
DATA 00,00,07,00,"Back of Castle      "
DATA 8,8,8,2,8,8,8
DATA 7,8,8,8,8,8,8
DATA 7,8,8,8,8,8,8
DATA 7,2,8,8,8,2,2
DATA 7,2,2,2,2,2,2
DATA 7,2,2,2,2,2,2
DATA 7,7,7,7,7,7,7
DATA "It is darker over here, and the moat is a lot deeper.  If there was"
DATA "any chance of crossing it would be at the other side where the water"
DATA "is shallow."
DATA 00,07,00,00,"North Forest        "
DATA 2,2,2,2,1,2,2
DATA 2,1,2,2,2,1,2
DATA 2,2,2,1,2,2,2
DATA 1,2,2,2,2,1,2
DATA 2,2,1,2,2,8,8
DATA 1,2,2,8,8,8,8
DATA 2,2,8,8,8,8,8
DATA "This is like the south forest except all life has been sucked out of "
DATA "here.  There is a burnt tree ahead of you.  That must be the one the"
DATA "dark man shot with the ball of fire."
DATA 00,28,11,04,"East Hallway        "
DATA 7,7,7,7,7,7,7
DATA 5,5,5,5,5,5,7
DATA 5,5,5,5,5,5,7
DATA 5,5,5,5,5,5,10
DATA 5,5,5,5,5,5,7
DATA 5,5,5,5,5,5,7
DATA 7,7,6,5,6,7,7
DATA "This is a smaller hallway.  There is a tower to the south.  to the east"
DATA "is the room where knights once trained for battles and quest.  There are"
DATA "more pictures on the walls here of past kings and lords."
DATA 12,00,13,10,"Training Room       "
DATA 7,7,7,10,7,7,7
DATA 5,5,5,5,5,5,7
DATA 5,11,11,11,11,5,7
DATA 5,11,11,11,11,5,10
DATA 5,11,11,11,11,5,7
DATA 5,5,5,5,5,5,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 00,11,00,00,"Supply Closet       "
DATA 7,7,7,7,7,7,7
DATA 7,12,5,12,5,12,7
DATA 7,5,12,5,12,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,12,7
DATA 7,12,5,5,5,5,7
DATA 7,12,12,5,5,5,7
DATA "","",""
DATA 00,00,00,11,"Knights Lounge      "
DATA 7,7,7,7,7,7,7
DATA 5,5,5,5,5,5,7
DATA 5,5,5,5,5,5,7
DATA 5,5,5,4,4,4,7
DATA 5,5,5,4,8,8,7
DATA 5,5,5,4,8,8,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 15,00,00,05,"Main Dining Room    "
DATA 7,7,7,7,5,5,7
DATA 7,5,5,5,5,5,7
DATA 5,5,5,5,5,5,7
DATA 5,5,12,5,12,5,7
DATA 5,5,5,5,5,5,7
DATA 7,5,5,12,5,5,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 00,14,00,00,"Main Kitchen        "
DATA 7,7,7,7,7,7,7
DATA 7,6,6,6,6,6,7
DATA 7,6,5,5,5,6,7
DATA 7,6,5,4,5,6,7
DATA 7,6,5,5,5,5,7
DATA 7,6,6,6,5,5,7
DATA 7,6,6,6,5,5,7
DATA "","",""
DATA 26,00,00,06,"Kings Chamber       "
DATA 5,5,5,5,5,5,7
DATA 3,3,8,9,8,12,7
DATA 3,3,5,8,5,5,7
DATA 3,3,5,5,5,5,10
DATA 5,5,5,11,11,11,7
DATA 5,5,5,11,11,11,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 23,18,05,00,"Park Enterance      "
DATA 8,4,4,2,2,7,7
DATA 8,4,4,1,2,2,7
DATA 8,4,4,4,4,4,4
DATA 8,4,4,4,4,4,4
DATA 8,4,4,2,4,4,4
DATA 8,4,4,1,2,2,7
DATA 8,4,4,2,2,7,7
DATA "","",""
DATA 17,24,00,19,"South-East Park     "
DATA 8,4,4,2,2,7,7
DATA 8,4,4,4,4,2,7
DATA 2,2,4,4,4,2,7
DATA 2,2,1,4,4,2,7
DATA 4,4,4,4,4,2,7
DATA 4,4,4,4,2,1,7
DATA 2,2,4,4,2,2,7
DATA "","",""
DATA 20,00,18,00,"South-West Park     "
DATA 7,2,4,4,2,8,8
DATA 7,4,4,2,2,2,8
DATA 7,4,4,2,2,2,2
DATA 7,2,4,4,2,2,2
DATA 7,1,4,4,4,4,4
DATA 7,2,2,2,4,4,4
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 21,19,00,00,"West Park           "
DATA 7,2,4,4,2,8,8
DATA 7,4,4,4,2,1,8
DATA 7,2,4,4,2,8,8
DATA 7,2,1,4,4,8,8
DATA 7,2,2,4,4,8,8
DATA 7,2,4,4,2,8,8
DATA 7,2,4,4,2,8,8
DATA "","",""
DATA 25,20,22,00,"North-West Park     "
DATA 7,1,2,2,2,2,7
DATA 7,2,2,4,4,4,4
DATA 7,1,4,4,4,4,4
DATA 7,4,4,4,2,2,2
DATA 7,4,4,2,1,8,8
DATA 7,4,4,2,8,8,8
DATA 7,4,4,2,2,8,8
DATA "","",""
DATA 00,23,00,21,"North-East Park     "
DATA 7,7,7,7,7,7,7
DATA 4,4,4,4,4,1,7
DATA 4,4,4,4,4,4,7
DATA 8,2,2,2,4,4,7
DATA 8,8,8,2,4,4,7
DATA 8,8,8,1,4,4,7
DATA 8,8,8,8,4,4,7
DATA "","",""
DATA 22,17,00,00,"East Park           "
DATA 9,8,8,4,4,2,7
DATA 8,8,8,4,4,2,7
DATA 8,8,4,4,4,1,7
DATA 8,8,4,4,2,2,7
DATA 8,2,4,4,1,2,7
DATA 8,2,4,4,2,2,7
DATA 8,4,4,4,2,2,7
DATA "","",""
DATA 18,00,00,00,"Weapons Shop        "
DATA 7,7,7,10,7,7,7
DATA 7,9,5,5,5,9,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,6,6,6,6,6,7
DATA 7,6,3,3,3,6,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 00,21,00,00,"North-West Tower    "
DATA 8,7,7,7,7,7,8
DATA 7,7,5,5,5,7,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,7,7,10,7,7,7
DATA "","",""
DATA 00,16,00,00,"North-East Tower    "
DATA 8,7,7,7,7,7,8
DATA 7,7,5,5,5,7,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,7,7,10,7,7,7
DATA "","",""
DATA 00,00,03,00,"South-West Tower    "
DATA 7,7,7,7,7,7,7
DATA 7,7,5,5,5,7,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,10
DATA 7,5,5,5,5,5,7
DATA 7,7,5,5,5,7,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 10,00,00,00,"South-East Tower    "
DATA 7,7,7,10,7,7,7
DATA 7,7,5,5,5,7,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,5,5,5,5,5,7
DATA 7,7,5,5,5,7,7
DATA 7,7,7,7,7,7,7
DATA "","",""
DATA 00,00,00,00,"                    "
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA "","",""
DATA 00,00,00,00,"                    "
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0
DATA "","",""
music:

IF CurSong < 0 THEN CurSong = -CurSong: n = 1
' Fight1
IF CurSong = 1 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo3<t255l4dp8l8ap4l2"
  CASE 2: PLAY ">d<l8ab->c<b-agab-"
  CASE 3: PLAY "gap8al4fl2d.p4l8d"
  CASE 4: PLAY "efep4efgab-ap8"
  CASE 5: PLAY "gab-a>c<b-ap8>"
  CASE 6: PLAY "cl4fdl2c<l4b-"
  END SELECT
END IF
'Fight2
IF CurSong = 2 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo2t255 l8aaba>c<"
  CASE 2: PLAY "a>d<al4<aaaa>l8aa"
  CASE 3: PLAY "ba>c<a>d<al4<aaaa>"
  CASE 4: PLAY "l8aaba>c<a>d<a"
  CASE 5: PLAY ">e<a>f<a>g<a>a<a>g"
  CASE 6: PLAY "<a>f<a>e<a>d<a>c<abaap8"
  END SELECT
END IF
'Bottom floor
IF CurSong = 3 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo2<t90l8cca-"
  CASE 2: PLAY "gl4a-ga-l2fp8l8fe"
  CASE 3: PLAY "fga-b-a-ga-l1fl8eee"
  CASE 4: PLAY "fl4gl8eel4fl8fg"
  CASE 5: PLAY "l4a-l8ffl8eeefggeef"
  CASE 6: PLAY "ffga-a-ffefga-b-a-ga-l1f"
  END SELECT
END IF
'Top floor and kings chamber
IF CurSong = 4 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo1t80l4<d>dd.l8el4d<bbl2el8g>c<l4bad"
  CASE 2: PLAY "eg.l8el4f#.l8>cl4el2d.p4p4l8<b>cl4dd."
  CASE 3: PLAY "l8edcl4<b.l8bl2el8g>cl4<bl2al4ef#gl2b"
  CASE 4: PLAY "l8agl2g.p4p4l4ggf#al2gl8ef#l4geel2el4df#"
  CASE 5: PLAY "f#.l8fl4gl2f#l4ef#gl2a.l4bb.l8b>l4c<bbag"
  CASE 6: PLAY "bagabl8agl4gl2dl8abl4cbl8agl2g.p4p4l4d"
  END SELECT
END IF
'fountains
IF CurSong = 5 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo2t200l4agl8fel4gl2dl4ffl8edcdl1e"
  CASE 2: PLAY "l4cccl8del4dl2a.l4ddl8c<bab>l1cp4l4ag"
  CASE 3: PLAY "l8fel4gl2d.l4ffl8edcd l1el4cccl8de"
  CASE 4: PLAY "l4dl2<a.>l4ddl8c<bab>l1cl4ccl8baga"
  CASE 5: PLAY "l1gl4ccl8dc<bal1gp4l4agl8fel4gl2d.l4ff"
  CASE 6: PLAY "l8edcd l1e l4cccl8de>l2c.<l8fa>l2c.<l8fa>l1c"
  END SELECT
END IF
'Forest
IF CurSong = 6 THEN
  SELECT CASE n
  CASE 1: PLAY "<t90l8gaagl2ap8l8gabl4agl8f#ggf#l2gp8"
  CASE 2: PLAY "l8f#gal4gf#l8ef#f#el2f#p8l8ef#gl4"
  CASE 3: PLAY "f#el1>cl2c.<p4l8abbal2bp8l8ab>c<l4"
  CASE 4: PLAY "bal8gaagl2ap8l8gabl4agl8f#ggf#l2gp8l8"
  CASE 5: PLAY "fgamll4gf#l1>ddmnl8dcc<bl2bp8>l8ccdd"
  CASE 6: PLAY "cc<b>dcc<bl2b>p8l8ccddcc<bl8>c<bbal2al8>c"
  END SELECT
END IF
'Winning the game         
IF CurSong = 7 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo2t245l4ggggaal8gel4ccl8c"
  CASE 2: PLAY "cdcl4dl1el4ggggaal8gel4ccc"
  CASE 3: PLAY "l8eeedl1cl8aal2al4aggl2gl4"
  CASE 4: PLAY "bbb.l8gl1al2aal8gel4c.l8"
  CASE 5: PLAY "cclBcddl1e"
  CASE 6: PLAY "l8ccl4cddl1c"
  END SELECT
END IF
'Guest Room
IF CurSong = 8 THEN
  SELECT CASE n
  CASE 1: PLAY "mbo1t180mn>l4d<mll8gab>"
  CASE 2: PLAY "cl4d<mngmlg>mnemll8cde"
  CASE 3: PLAY "f#l4g<mngmlg>mncmll8dc<"
  CASE 4: PLAY "bamnl4bml>l8c<bagmnl4aml"
  CASE 5: PLAY "l8bagf#l2g.<mn>"
  CASE 6: PLAY "p4"
  END SELECT
END IF
n = (n MOD 6) + 1
RETURN


'Magic room                   :PLAY "t240l4ed#l8dd#dc#l4c<bb-b>c<bl8b-bb-al4g#gf#gb-l8ffl4efb-l8ffl4efl8b-ab-b>l4cc#dd#t240l4ed#l8dd#dc#l4c<bb-b>c<bl8b-bb-al4g#gf#gb-l8ffl4efb-l8ffl4efl8b-ab-b>l4cc#dd#"

SUB alarm
PALETTE 0, 10
PALETTE 0, 32
PALETTE 0, 63
PALETTE 0, 32
PALETTE 0, 10
PALETTE 0, 0
END SUB

SUB center (a$)
y = CSRLIN
x = 20 - (LEN(a$) \ 2)
LOCATE y, x: PRINT a$
FOR a = 1 TO LEN(a$)
  f(x + a - 1, y) = 1
NEXT a
END SUB

SUB ClearMEM
FOR y = 1 TO 25
FOR x = 1 TO 40
f(x, y) = 0
NEXT x
NEXT y
END SUB

FUNCTION EndGame
LOCATE 12
COLOR 12, 7
center "Are you sure you want to exit?"
COLOR 15, 0
k = 0
DO
fire
a$ = UCASE$(INKEY$)
IF a$ = "Y" THEN k = 2
IF a$ = "N" THEN k = 1
LOOP WHILE k = 0
EndGame = k - 1
END FUNCTION

SUB fire
x = INT(40 * RND) + 1
y = INT(25 * RND) + 1
FOR s = 1 TO 2
FOR a = -s TO s
FOR b = -s TO s
IF x + a > 0 AND y + b > 0 AND x + a < 41 AND y + b < 26 THEN IF f(x + a, y + b) = 0 THEN LOCATE y + b, x + a: COLOR 10: PRINT "Û";
NEXT b
NEXT a
FOR a = -s TO s
FOR b = -s TO s
IF x + a > 0 AND y + b > 0 AND x + a < 41 AND y + b < 26 THEN IF f(x + a, y + b) = 0 THEN LOCATE y + b, x + a: COLOR 7: PRINT "Û";
NEXT b
NEXT a
FOR a = -s TO s
FOR b = -s TO s
IF x + a > 0 AND y + b > 0 AND x + a < 41 AND y + b < 26 THEN IF f(x + a, y + b) = 0 THEN LOCATE y + b, x + a: COLOR 0, 0: PRINT " ";
NEXT b
NEXT a
NEXT s
END SUB

SUB Game (room)
SCREEN 12
CLS
DO
COLOR 10
LOCATE 20, 2: LOCATE 20, 2: PRINT LEFT$(d$(1, room) + SPACE$(76), 76)
LOCATE 21, 2: LOCATE 21, 2: PRINT LEFT$(d$(2, room) + SPACE$(76), 76)
LOCATE 22, 2: LOCATE 22, 2: PRINT LEFT$(d$(3, room) + SPACE$(76), 76)
LINE (0, 0)-(639, 479), 15, B
LINE (0, 40)-(639, 40), 15
sx = 200: sy = 120: rt = room
FOR y = 1 TO 7
FOR x = 1 TO 7
PUT (x * 10 + sx, y * 10 + sy), p%(0, pic(x, y, rt)), PSET
NEXT x
NEXT y
sx = 200: sy = 50: rt = r(room).t
FOR y = 1 TO 7
FOR x = 1 TO 7
PUT (x * 10 + sx, y * 10 + sy), p%(0, pic(x, y, rt)), PSET
NEXT x
NEXT y
sx = 130: sy = 120: rt = r(room).l
FOR y = 1 TO 7
FOR x = 1 TO 7
PUT (x * 10 + sx, y * 10 + sy), p%(0, pic(x, y, rt)), PSET
NEXT x
NEXT y
sx = 270: sy = 120: rt = r(room).r
FOR y = 1 TO 7
FOR x = 1 TO 7
PUT (x * 10 + sx, y * 10 + sy), p%(0, pic(x, y, rt)), PSET
NEXT x
NEXT y
sx = 200: sy = 190: rt = r(room).b
FOR y = 1 TO 7
FOR x = 1 TO 7
PUT (x * 10 + sx, y * 10 + sy), p%(0, pic(x, y, rt)), PSET
NEXT x
NEXT y
LOCATE 2, 34: COLOR 12
PRINT rn$(room)
COLOR 13
LOCATE 29, 2: PRINT "                                                 ";
LOCATE 29, 2: PRINT "Do What? ";
DO: a$ = UCASE$(INKEY$): LOOP WHILE a$ = ""
IF a$ = "N" OR a$ = "8" THEN PRINT "North"; : IF r(room).t > 0 THEN room = r(room).t ELSE PRINT " CAN'T"; : alarm
IF a$ = "S" OR a$ = "2" THEN PRINT "South"; : IF r(room).b > 0 THEN room = r(room).b ELSE PRINT " CAN'T"; : alarm
IF a$ = "E" OR a$ = "6" THEN PRINT "East"; : IF r(room).r > 0 THEN room = r(room).r ELSE PRINT " CAN'T"; : alarm
IF a$ = "W" OR a$ = "4" THEN PRINT "West"; : IF r(room).l > 0 THEN room = r(room).l ELSE PRINT " CAN'T"; : alarm
IF a$ = "!" THEN CurSong = -1: PLAY "mbp16p16p16p16"
IF a$ = "@" THEN CurSong = -2: PLAY "mbp16p16p16p16"
IF a$ = "#" THEN CurSong = -3: PLAY "mbp16p16p16p16"
IF a$ = "$" THEN CurSong = -4: PLAY "mbp16p16p16p16"
IF a$ = "%" THEN CurSong = -5: PLAY "mbp16p16p16p16"
IF a$ = "^" THEN CurSong = -6: PLAY "mbp16p16p16p16"
IF a$ = "&" THEN CurSong = -7: PLAY "mbp16p16p16p16"
IF a$ = "*" THEN CurSong = -8: PLAY "mbp16p16p16p16"
IF a$ = "(" THEN CurSong = -9: PLAY "mbp16p16p16p16"
IF a$ = ")" THEN CurSong = -10: PLAY "mbp16p16p16p16"
LOOP

END SUB

SUB Intro
WIDTH 80
OPEN "moss.txt" FOR INPUT AS #1
CLS
DO WHILE NOT EOF(1)
LINE INPUT #1, a$
a$ = LEFT$(a$ + SPACE$(80), 80)
FOR x = 1 TO 78
g$ = MID$(a$, x, 1)
IF g$ = CHR$(34) THEN c = 1 - c
IF g$ = CHR$(34) THEN COLOR 7 ELSE IF c = 1 THEN COLOR 12 ELSE COLOR 9
IF g$ = "-" OR g$ = "|" THEN COLOR 8 ELSE IF g$ = "Û" THEN COLOR 7 ELSE IF g$ = "Î" THEN COLOR 2
PRINT g$;
NEXT x
PRINT
IF g$ = "-" THEN DO: LOOP WHILE INKEY$ = ""
LOOP
CLOSE
COLOR 15
WIDTH 40
END SUB

FUNCTION menu
ClearMEM
CLS
WIDTH 40
LOCATE 7
COLOR 15, 0: center "Castle of Moss"
PRINT
COLOR 9: center "By Tim Caswell"
PRINT
PRINT
PRINT
COLOR 14
center "1 - New Game  "
PRINT
center "2 - Load Game "
PRINT
center "3 - View Intro"
PRINT
center "4 - Quit Game "
PRINT
k = 0
DO
fire
a$ = INKEY$
IF a$ = "1" THEN k = 1
IF a$ = "2" THEN k = 2
IF a$ = "3" THEN k = 3
IF a$ = "4" THEN k = 4
LOOP WHILE k = 0
menu = k
END FUNCTION

SUB newgame
ON PLAY(1) GOSUB music
PLAY ON

PLAY "p16p16p16p16"
Game 1
END SUB

