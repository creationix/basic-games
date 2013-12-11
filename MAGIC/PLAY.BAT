@echo off
echo Card Maker
:1
qbasic /run shuffle.bas
edit cards.dat
goto 1
