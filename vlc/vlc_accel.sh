#!/bin/bash

# VLC Video acceleration recording
# by Elian
#
# chmod +x vlc_accel.sh
# Usage: ./vlc_accel.sh <file> <rate>
# Exemple: ./vlc_accel.sh "short.mp4" "1.7"

# Dependances sudo apt-get install libav-tools pavucontrol sox vlc

# NB: Résultats variables en fonction du fichier source et des codecs vlc


FICHIER_SRC=$1;							# fichier source = parametre 1 de l'invite
VITESSE=$2;								# rate = parametre 2, ex: "1.7"

EXT=${FICHIER_SRC##*.}					# extension du fichier source
NAME_NO=${FICHIER_SRC%.*}				# nom du fichier source sans extension
NAME=${NAME_NO// /_}					# remplacer les espaces par underscore

FICHIER_DEST=$NAME"_accel."$EXT;		# fichier de sortie (video accélerée seule)
FICHIER_WAV="record.wav";				# fichier de sortie (audio accéléré seulement)
FICHIER_WAV_FINAL=$NAME"_accel.wav";	# master audio


# Tester que les fichiers de sortie n'existent pas déjà

if [ ! -f "$FICHIER_SRC" ]; then						# test non-exitence du fichier source
	echo -e "Wrong source file"
	echo -e "Usage: ./vlc_make.sh <file> <rate>"
	exit
fi

if [ -f "$FICHIER_WAV" ]; then							# test exitence du fichier temporaire
	echo -e "file $FICHIER_WAV already exist"
	exit
fi

if [ -f "$FICHIER_DEST" ]; then							# test exitence du fichier video final
	echo -e "file $FICHIER_DEST already exist"
	exit
fi

if [ -f "$FICHIER_WAV_FINAL" ]; then					# test exitence du fichier audio final
	echo -e "file $FICHIER_WAV_FINAL already exist"
	exit
fi

clear
echo -e "VLC Acceleration recording by Elian\nFile : "$FICHIER_SRC

echo -e '''\nRecording test...
-> select Monitor Of audio interne stereo in record tab
-> check your recording level for libav
-> close PulseAudio Volume Control
Enter to start...'''
read

vlc --play-and-exit -I dummy --rate $VITESSE "$FICHIER_SRC" vlc://quit & avconv -v quiet -f pulse -i default $FICHIER_WAV & pavucontrol
killall -q avconv
killall -q vlc
clear

if [ -f "$FICHIER_WAV" ]; then  rm $FICHIER_WAV; fi

echo 'Enter to process from '$FICHIER_SRC' ...'
read

# --=[ Main ]=-- ######################################################################################################################

# Export video acceleree sans le son (sans visualisation)

nvlc --play-and-exit -I dummy --rate $VITESSE --no-sout-audio --sout "$FICHIER_DEST" "$FICHIER_SRC" vlc://quit;

# Lecture en accelere de la video et enregistrement du son acceléré

vlc --play-and-exit -I dummy --rate $VITESSE "$FICHIER_SRC" vlc://quit & avconv -f pulse -i default $FICHIER_WAV

# normalisation audio à -0.2dB

sox --norm=-0.2 $FICHIER_WAV $FICHIER_WAV_FINAL

# Suppression du fichier temporaire

if [ -f "$FICHIER_WAV" ]; then  rm $FICHIER_WAV; fi

echo -e "\nThat's all folks baby ;-)\n"

exit
