#!/bin/bash

# "La petite musique"
# by Elian

# Version 0.1
# 07.03.2017

# Dépendance: sox

TEMPO=120

# La mélodie est stockée dans 2 tableaux, un pour les notes et l'autre pour le rythme.

NOTES=("C5" "B" "Bb" "A" "G" "F" "E" "D5" "D5" "D5" "D5" "E" "D5" "D5" "D5" "D5" "D5" "C5" "B" "D5" "C5" "F5" "F5-F2")
RYTHM=("4"  "8" "8"  "4" "8" "8" "8" "8"  "8"  "8"  "2"  "8" "8"  "8"  "8"  "2"  "8"  "8"  "8" "8"  "4"  "4"  "4")


# Calculer la durée d'une note en fonction du tempo et du rythme
# $1 = tempo
# $2 = division rythmique
# Renvoie la durée formatée dans $DUREE

function duree2sec
{
	MS=$((60000 / $1))	# calcul pour une noire (= 4)

	case "$2" in

		1) MS=$((4 * $MS));;	#  1 = ronde
		2) MS=$((2 * $MS));;	#  2 = blanche
		8) MS=$(($MS / 2));;	#  8 = croche
		16) MS=$(($MS / 4));;	# 16 = double-croche

	esac

	SEC=$(($MS / 1000))
	MSEC=$(($MS % 1000))
	DUREE=$(echo $SEC.$MSEC)	# format sec.msec
}


##############################################################################################################################

# Vérifier que la taille des 2 tableaux est identique

if [ ${#NOTES[@]} != ${#RYTHM[@]} ]; then
	echo "Array: size error..."
	exit
fi


COUNTER=0

while [ $COUNTER -lt ${#NOTES[@]} ]; do

	duree2sec $TEMPO ${RYTHM[$COUNTER]}

	play -n -c2 synth $DUREE sine ${NOTES[$COUNTER]} fade h 0.1 $DUREE 0.1;

	let COUNTER=COUNTER+1

done
