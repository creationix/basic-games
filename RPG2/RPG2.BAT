@echo off
echo Now loading MIDI drivers
sbMIDI
echo Loading RPG II
rpg2.exe
echo unloading MIDI drivers
sbmidi /u
