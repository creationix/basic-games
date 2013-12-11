TYPE WEAPON
   nam AS STRING * 12
   cost AS INTEGER
   size AS INTEGER
   min AS INTEGER
   max AS INTEGER
   typ AS STRING * 1
END TYPE
TYPE NORM
   nam AS STRING * 10
   cost AS INTEGER
   size AS INTEGER
   power AS INTEGER
   elec AS INTEGER
   typ AS STRING * 1
END TYPE
TYPE SHIP
   nam AS STRING * 10
   cost AS INTEGER
   size AS INTEGER
   crew AS INTEGER
   ab1 AS STRING * 1
   ab2 AS STRING * 1
END TYPE
TYPE custom
   nam AS STRING * 10
   eng AS STRING * 1
   shld AS STRING * 1
   weap AS STRING * 1
   sh AS STRING * 1
   ab3 AS STRING * 1
END TYPE
DIM SHARED w(13) AS WEAPON, e(11) AS NORM, s(16) AS NORM
DIM SHARED shp(5) AS SHIP, g(PlyNum, 6) AS custom
OPEN "Ships.dat" FOR OUTPUT AS #1
CLS
PRINT "Weapons"
PRINT
PRINT "# Name", "  Cost", " Size", " Damage", "Type"
PRINT
FOR a = 1 TO 13
READ w(a).nam, w(a).cost, w(a).size, w(a).min, w(a).max, w(a).typ
WRITE #1, w(a).nam, w(a).cost, w(a).size, w(a).min, w(a).max, w(a).typ
PRINT CHR$(64 + a); " "; w(a).nam; " "; w(a).cost, w(a).size, w(a).min; "-"; w(a).max, w(a).typ
NEXT a
PRINT
PRINT
PRINT "Engines"
PRINT
PRINT "# Name", "Cost", " Size", " Power", " Elec make"
PRINT
FOR a = 1 TO 11
READ e(a).nam, e(a).cost, e(a).size, e(a).power, e(a).elec, e(a).typ
WRITE #1, e(a).nam, e(a).cost, e(a).size, e(a).power, e(a).elec, e(a).typ
PRINT CHR$(64 + a); " "; e(a).nam; " "; e(a).cost, e(a).size, e(a).power, e(a).elec
NEXT a
PRINT
PRINT
PRINT "Sheilds"
PRINT
PRINT "# Name", "Cost", " Size", " Power", " Elec use"
PRINT
FOR a = 1 TO 16
READ s(a).nam, s(a).cost, s(a).size, s(a).power, s(a).elec, s(a).typ
WRITE #1, s(a).nam, s(a).cost, s(a).size, s(a).power, s(a).elec, s(a).typ
PRINT CHR$(64 + a); " "; s(a).nam; " "; s(a).cost, s(a).size, s(a).power, s(a).elec
NEXT a
PRINT
PRINT
PRINT "Ships"
PRINT
PRINT "# Name", "Cost", " Size", " Crew", "Ab1  Ab2"
PRINT
FOR a = 1 TO 5
READ shp(a).nam, shp(a).cost, shp(a).size, shp(a).crew, shp(a).ab1, shp(a).ab2
WRITE #1, shp(a).nam, shp(a).cost, shp(a).size, shp(a).crew, shp(a).ab1, shp(a).ab2
PRINT CHR$(64 + a); " "; shp(a).nam, shp(a).cost, shp(a).size, shp(a).crew, shp(a).ab1; "    "; shp(a).ab2
NEXT a
FOR a = 1 TO 16
READ n$, n1, n2, n3, n4, b$
WRITE #1, n$, n1, n2, n3, n4, b$
NEXT a
CLOSE #1

DATA "Ion-Gun     ",20,50,10,20,"A"
DATA "Lazer       ",05,20,05,10,"A"
DATA "Fire Blast  ",15,40,05,25,"E"
DATA "Omega Bomb  ",30,70,20,40,"C"
DATA "Scatter Bomb",10,50,05,15,"C"
DATA "Gas Spores  ",30,100,05,10,"D"
DATA "Cyanide-X   ",40,75,05,20,"D"
DATA "De-Atomizer ",50,100,10,25,"A"
DATA "Phoenex-QX  ",60,100,15,20,"B"
DATA "Nuclear Bomb",70,125,10,30,"C"
DATA "Nerve Gas   ",80,75,05,30,"D"
DATA "Shark-VB    ",90,150,20,30,"B"
DATA "Xutron Blast",100,200,20,40,"E"

DATA "Pulse Beam",100,100,03,70,"A"
DATA "Hi-Pulse  ",200,200,06,140,"A"
DATA "Mark IV   ",100,200,04,100,"A"
DATA "Mark V    ",150,225,05,150,"A"
DATA "Mark IX   ",200,250,09,200,"A"
DATA "Mark XIII ",250,275,13,300,"A"
DATA "Rocket XV ",300,240,15,200,"A"
DATA "Gravitator",120,500,18,320,"A"
DATA "Warp Power",400,300,17,500,"A"
DATA "Sub-Light ",500,300,19,510,"A"
DATA "Photon XXI",600,300,21,480,"A"

DATA "L.Sheild  ",050,040,09,100,"A"
DATA "M.Sheild  ",150,060,20,200,"A"
DATA "H.Sheild  ",220,110,29,300,"A"
DATA "Deflector ",230,070,27,250,"A"
DATA "Atom Shell",330,300,29,270,"A"
DATA "Proctecora",380,140,47,300,"A"
DATA "Duallory  ",140,170,24,130,"A"
DATA "Triallory ",250,300,42,270,"A"
DATA "Titanuim  ",220,200,34,170,"A"
DATA "Hi-Mesh   ",160,100,23,110,"A"
DATA "Tritunium ",200,170,30,160,"A"
DATA "Iron Plate",340,220,47,320,"A"
DATA "Steel Coat",310,280,47,320,"A"
DATA "Heavy Coat",430,330,61,450,"A"
DATA "Magnet Def",480,260,63,380,"A"
DATA "Clevitoran",430,340,62,430,"A"

DATA "Scout     ",100,500,200,"B","/"
DATA "Small     ",150,750,300,"/","A"
DATA "Normal    ",200,1000,400,"D","A"
DATA "Large     ",400,1250,600,"E","A"
DATA "Huge      ",650,1500,800,"E","C"

DATA "Scout     ",0,0,0,0," "
DATA "Fighter   ",1,6,2,2," "
DATA "Stinger   ",6,0,0,1," "
DATA "Cruizer   ",3,1,2,1," "
DATA "Warship   ",3,3,3,3," "
DATA "Destroyer ",4,4,4,4," "

