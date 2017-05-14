#!/bin/bash

# check_pulse.sh
# by Elian
# 2016

# Verifier le niveau de libav dans Pulse Audio
# Sélectionner Monitor Of audio interne stereo analogique dans src enregistrement

# Dépendances: libav, pavucontrol, vlc
#	sudo apt-get install libav-tools
#	sudo apt-get install pavucontrol

FICHIER_WAV='test.wav'
FICHIER_SRC="sample.mp3"

echo -e "\nVérification config Pulse Audio..."
echo -e "Simulation d'enregistrement Libav...\n"
echo -e "Entrée pour commencer..."
read
clear

cvlc $FICHIER_SRC vlc://quit & avconv -v quiet -f pulse -i default $FICHIER_WAV & pavucontrol

killall avconv

if test -f $FICHIER_WAV; then rm $FICHIER_WAV; fi
