#!/bin/bash

# organize.sh - sépare un dossier en sous dossiers contenant un certain nombre de fichiers...
# Elian

# Version 0.1
# 12.07.2017

# ./organize.sh <dir> <number_of_file_per_subdir>


if [ $# != 2 ]; then											# teste les paramètres de l'invite
	echo "./organize.sh <dir> <nb_files_per_subdir>"
	exit
fi

LIST_FILES="list.txt"

SRC=$1															# repertoire à traiter

NAME_DIR=$(basename $SRC)										# nom du repertoire

NB=$2															# nombre de fichiers désiré par sous-dossier

CPT_DIR=1														# compteurs
CPT_FILE=0


# ---------------------------------------------------------------------------------------------------------------------------- #

# calc_nb_subdir : calcule le nombre de sous-dossiers à créer
#
# 	$1 = nombre de fichiers du dossier
# 	$2 = nombre de fichiers par sous dossier
#
# 	$NB_SUB_DIR_FINAL : le nombre de dossiers à créer

function calc_nb_subdir()
{
	NB_SUBDIR=$(($1/$2))
	RESTE=$(($1%$2))

	if [ "$RESTE" -le "$2" ]
		then
			((NB_SUBDIR++))
	fi

	NB_SUB_DIR_FINAL=$NB_SUBDIR
}


# ---------------------------------------------------------------------------------------------------------------------------- #

if [ ! -d "$1" ]; then											# le repertoire existe?
	echo "wrong dir"
	exit
fi

PATH_VIDE=$(find $SRC -type d -empty)							# le repertoire est vide?
if [ -n "$PATH_VIDE" ]
then
	echo "empty dir"
	exit
fi

find $SRC/*.* > $LIST_FILES										# liste des fichiers avec leur path

NB_FILES=$(find $SRC/*.* | wc -l)								# nombre de fichiers du repertoire


calc_nb_subdir $NB_FILES $NB


# creation des sous dossiers

for ((cpt=1; cpt<=$NB_SUB_DIR_FINAL; cpt++))
	do
		PATH_OUT=$SRC"/"$NAME_DIR"_"$cpt
		if [ ! -d "$PATH_OUT" ]; then mkdir $PATH_OUT; fi		# si le repertoire n'exite pas le créer
	done


# Déplacer les fichiers dans les sous dossiers

if [ -s "$LIST_FILES" ]
	then
		while read filename
			do
				mv "$filename" "$SRC"/"$NAME_DIR"_"$CPT_DIR"

				((CPT_FILE+=1))

				if [ "$CPT_FILE" -ge "$NB" ]
					then
						((CPT_FILE=0))
						((CPT_DIR+=1))
				fi

			done < $LIST_FILES
fi

if test -f "$LIST_FILES"; then rm "$LIST_FILES"; fi

echo "done"

exit
