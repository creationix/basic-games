DIM p%(200, 1 TO 5)
DEF SEG = VARSEG(p%(0, 1))
BLOAD "Planets.pic", 0
SCREEN 7
DO
PUT (299 * RND, 179 * RND), p%(0, INT(5 * RND) + 1), PSET
LOOP

