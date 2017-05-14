#!/bin/bash

# vlc_frames.sh - Extract PNG frames from video file with vlc
# by Elian
# 2016

# chmod +x vlc_frames.sh
# ./vlc_frames.sh

#	$SRC : fichier video source
#	–video-filter=scene : extraire des images
#	–vout=dummy : ne pas jouer la video pendant l'extraction
#	–scene-ratio=n : sauver un aperçu toutes les n frames
#	–scene-prefix : nom à utiliser pour les PNG
#	–scene-path : frame's directory out

RATIO=100

echo -e "PNG Frames extractor by Elian\n"
read -p 'Video file: ' SRC					# fichier source video
read -p 'Directory: ' DIR_WRKS				# repertoire de travail

FRM_NOM=${SRC%.*}							# nom de la video sans extension

if test -f $SRC
	then
		mkdir -p ./$DIR_WRKS
		echo -e "\nExtract...\n"
		cvlc $SRC --video-filter=scene --vout=dummy --scene-ratio=$RATIO --scene-prefix=$FRM_NOM --scene-path=$DIR_WRKS vlc://quit
	fi

echo -e "\nDone...\n"
exit
