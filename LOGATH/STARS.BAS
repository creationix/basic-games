DEFINT A-Z
SCREEN 1
CLS
DO
x = 320 * RND
y = 200 * RND
PSET (x, y), 3
PSET (x - 1, y), 1
PSET (x + 1, y), 1
PSET (x, y - 1), 1
PSET (x, y + 1), 1
PSET (x - 2, y), 2
PSET (x + 2, y), 2
PSET (x, y - 2), 2
PSET (x, y + 2), 2
PSET (x - 3, y), 0
PSET (x + 3, y), 0
PSET (x, y - 3), 0
PSET (x, y + 3), 0
PSET (x - 4, y), 1
PSET (x + 4, y), 1
PSET (x, y - 4), 1
PSET (x, y + 4), 1

x = 320 * RND
y = 200 * RND
LINE (x - 25, y - 25)-(x + 25, y + 25), 0, BF

LOOP

