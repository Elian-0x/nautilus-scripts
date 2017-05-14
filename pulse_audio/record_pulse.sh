#!/bin/bash

# record_pulse.sh
# by Elian
# 2016

# $ chmod +x record_pulse.sh
# $ ./record_pulse.sh

# Dependances:

#	sudo apt-get install libav-tools (enregistrement avec avconv)
#	sudo apt-get install pavucontrol (reglages enregistrement)
# 	sudo apt-get install sweep (edition audio)
#	sudo apt-get install sox (normalisation audio)
#	sudo apt-get install lame (convertion mp3)

FICHIER_WAV='tmp.wav'

clear
echo -e "\nPulse audio recorder by Elian\n"
read -p 'Artist: ' ARTIST
read -p 'Title: ' TITRE

FILE_OUT=${ARTIST// /_}"_"${TITRE// /_}
WAV_OUT=$FILE_OUT".wav"
WAV_FINAL=$FILE_OUT"_N.wav"
MP3_OUT=$FILE_OUT".mp3"

echo -e "\nRecording test..."
echo -e "\nRun your audio app and press enter for run PulseAudio Volume Control\n"
echo -e "-> select Monitor Of audio interne stereo in record tab\r"
echo -e "-> check your recording level for libav\r"
echo -e "-> close PulseAudio Volume Control"
read

avconv -v quiet -f pulse -i default $FICHIER_WAV & pavucontrol
killall -q avconv
clear
if test -f $FICHIER_WAV; then rm $FICHIER_WAV; fi

clear
echo -e "\nPause your audio app and rewind your song...\r"
echo -e "Press enter for record, and play your song in your app...\r"
echo -e "Press ctrl+c to stop recording..."
read

avconv -f pulse -i default $WAV_OUT

echo -e "\n\n"

# Edition pour supprimer le blanc au début et/ou à la fin du fichier

sweep $WAV_OUT

clear
echo -e "\nnormalise the audio...\n"

# normalisation audio à -0.2dB

sox --norm=-0.2 $WAV_OUT $WAV_FINAL

clear

# Fixed bit rate stereo 128 kbps encoding, highest quality

lame -h $WAV_FINAL $MP3_OUT

# Delete tmp files

if test -f $WAV_OUT; then rm $WAV_OUT; fi
if test -f $WAV_FINAL; then rm $WAV_FINAL; fi
