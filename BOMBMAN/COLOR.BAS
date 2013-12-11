SCREEN 13
FOR a = 1 TO 128
r = ABS(63 - a) MOD 64
g = (a) MOD 64
b = (a * 2) MOD 64
PALETTE a, r + g * 256 + b * 65536
LINE (a, 0)-(a, 200), a
NEXT a

