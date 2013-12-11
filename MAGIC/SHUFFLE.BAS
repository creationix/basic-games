DECLARE FUNCTION convert$ (a$)
DEFINT A-Z
DIM SHARED n$(100), t$(100), m$(100), d$(100, 4)
OPEN "cards.dat" FOR INPUT AS #1
DO
cd = cd + 1
INPUT #1, n$
IF EOF(1) THEN GOTO done
l = LEN(n$)
n$(cd) = LEFT$(SPACE$((30 - l) / 2) + n$ + SPACE$(30), 30)
INPUT #1, t$(cd), m$
m$(cd) = convert$(m$)
FOR a = 1 TO 4
LINE INPUT #1, d$
d$(cd, a) = convert$(d$)
NEXT a
done:
LOOP WHILE NOT EOF(1)
CLOSE #1
FOR a = 1 TO cd
sc = INT(cd * RND + 1)
SWAP n$(a), n$(sc)
SWAP t$(a), t$(sc)
SWAP m$(a), m$(sc)
SWAP d$(a, 1), d$(sc, 1)
SWAP d$(a, 2), d$(sc, 2)
SWAP d$(a, 3), d$(sc, 3)
SWAP d$(a, 4), d$(sc, 4)
NEXT a
OPEN "deck.dat" FOR OUTPUT AS #1
FOR a = 1 TO cd
WRITE #1, n$(a), t$(a), LEFT$(m$(a), 5)
PRINT #1, d$(a, 1)
PRINT #1, d$(a, 2)
PRINT #1, d$(a, 3)
PRINT #1, d$(a, 4)
NEXT a
CLOSE #1
RUN "magic"

FUNCTION convert$ (a$)
t$ = ""
FOR a = 1 TO LEN(a$)
g$ = MID$(a$, a, 1)
IF g$ = "…" THEN g$ = "()"
IF g$ = " " THEN g$ = "(ù)"
IF g$ = "À" THEN g$ = "()"
IF g$ = "Ã" THEN g$ = "()"
IF g$ = "Õ" THEN g$ = "(≠)"
t$ = t$ + g$
NEXT a
t$ = LEFT$(t$ + SPACE$(30), 30)
convert$ = t$
END FUNCTION

