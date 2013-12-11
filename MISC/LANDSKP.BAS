' Good randomize numbers
'	564
'       1998
'       8754
RANDOMIZE 3654

SCREEN 12

sz = 33

WINDOW (-sz * .8, -sz)-(sz, sz)
HT = 8
DIM A(sz * 1.5,  sz * 1.5)
A(1, 1) = 28
A(sz, 1) = 28
A(sz, sz) = 28
A(1, sz) = 28
LENGTH = sz - 1
WHILE LENGTH > 0
FOR SX% = 1 TO sz - 1 STEP LENGTH
FOR SY% = 1 TO sz - 1 STEP LENGTH
UP = (2 * RND - 1) / HT * LENGTH * 7
A(SX% + LENGTH / 2, SY% + LENGTH / 2) = (A(SX%, SY%) + A(SX%, SY% + LENGTH) + A(SX% + LENGTH, SY%) + A(SX% + LENGTH, SY% + LENGTH)) / 4 + UP

if sy%-length/2>0 then A(SX% + LENGTH / 2, SY%) = (A(SX%, SY%) + A(SX% + LENGTH / 2, SY% + LENGTH / 2) + A(SX% + LENGTH, SY%) + A(SX% + LENGTH / 2, SY% - LENGTH / 2)) / 4 + UP
if sx%-length/2 > 0 then A(SX%, SY% + LENGTH / 2) = (A(SX%, SY%) + A(SX% + LENGTH / 2, SY% + LENGTH / 2) + A(SX%, SY% + LENGTH) + A(SX% - LENGTH / 2, SY% + LENGTH / 2)) / 4 + UP
A(SX% + LENGTH / 2, SY% + LENGTH) = (A(SX%, SY% + LENGTH) + A(SX% + LENGTH / 2, SY% + LENGTH / 2) + A(SX% + LENGTH, SY% + LENGTH) + A(SX% + LENGTH / 2, SY% + LENGTH * 1.5)) / 4 + UP
A(SX% + LENGTH, SY% + LENGTH / 2) = (A(SX% + LENGTH, SY%) + A(SX% + LENGTH / 2, SY% + LENGTH / 2) + A(SX% + LENGTH, SY% + LENGTH) + A(SX% + LENGTH * 1.5, SY% + LENGTH / 2)) / 4 + UP

'cx = conx(SX%, SY%, A(SX%, SY%),sz)
'cy = cony(SX%, SY%, A(SX%, SY%),sz)
'PSET (cx, cy), 15
NEXT SY%
NEXT SX%
LENGTH = INT(LENGTH / 2)
WEND
' Draw the picture
FOR y% = sz TO 1 STEP -1
FOR x% = 1 TO sz
C = 10
z = A(x%, y%)
IF z < 0 THEN z = 0: C = 9

cx1 = conx(x%, y%, z,sz)
cy1 = cony(x%, y%, z,sz)
z = 0
cx2 = conx(x%, y%, z,sz)
cy2 = cony(x%, y%, z,sz)
LINE (cx1, cy1)-(cx2, cy2), 8
z = A(x% + 1, y%)
if z>0 then c = 10 else z = 0
cx2 = conx(x% + 1, y%, z,sz)
cy2 = cony(x% + 1, y%, z,sz)
IF x% < sz THEN LINE (cx1, cy1)-(cx2, cy2), C
z = A(x%, y% + 1)
if z>0 then c = 10 else z = 0
cx2 = conx(x%, y% + 1, z,sz)
cy2 = cony(x%, y% + 1, z,sz)
IF y% < sz THEN LINE (cx1, cy1)-(cx2, cy2), C
IF y% < sz AND x% < sz THEN
    z = A(x% + 1, y% + 1)
    if z>0 then c = 10  else z = 0
    cx2 = conx(x% + 1, y% + 1, z,sz)
    cy2 = cony(x% + 1, y% + 1, z,sz)
    IF y% < sz THEN LINE (cx1, cy1)-(cx2, cy2), C
    z = A(x%, y% + 1)
    cx1 = conx(x%, y% + 1, z,sz)
    cy1 = cony(x%, y% + 1, z,sz)
    z = A(x% + 1, y%)
    cx2 = conx(x% + 1, y%, z,sz)
    cy2 = cony(x% + 1, y%, z,sz)
    IF y% < sz THEN LINE (cx1, cy1)-(cx2, cy2), C
END IF
NEXT x%
NEXT y%

FUNCTION conx (x%, y%, z,sz)
conx = (x% - sz / 2) + (y% - sz / 2)
END FUNCTION

FUNCTION cony (x%, y%, z,sz)
cony = ((y% - sz / 2) - (x% - sz / 2)) / 2 + z * sz / 30 - sz \ 2
END FUNCTION

