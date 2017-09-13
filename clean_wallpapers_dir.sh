#!/bin/bash

# clean_wallpapers_dir.sh
# Elian

# Version 0.2
# 13.07.2017

# -----------------------------------------------------------------------------------------------------------------

if [ $# != 1 ]; then													# teste les paramètres de l'invite
	echo "./clean_wallpapers_dir.sh <dir>"
	exit
fi

cd $1

BASE_DIR=$(pwd)
NAME_DIR=$(basename $BASE_DIR)											# nom du repertoire seul

echo "[>] working dir "$BASE_DIR

rename "y/A-Z/a-z/ if -f;" ./*											# minuscules


for file in *.*; do														# Pour chaque fichier du dossier courant

	EXT=${file##*.}														# extension seulement
	NAME_NOEXT=${file%.*}												# nom du fichier sans extension

	F_JPG=$NAME_NOEXT".jpg"												# nom du fichier de sortie

	case $EXT in

		"jpeg")
			rename "s/\.jpeg/\.jpg/" "$file"
		;;

		"png")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.png}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
				convert "${file}" "${file%.png}$STR.jpg"
			fi
		;;

		"bmp")

			if [ ! -e "$F_JPG" ]; then
				convert "${file}" "${file%.bmp}.jpg"
			else
				STR=$(openssl rand -hex 3)
				convert "${file}" "${file%.bmp}$STR.jpg"
			fi
		;;

		"gif")

			if [ ! -e "$F_JPG" ]; then
				convert "${file}" "${file%.gif}.jpg"
			else
				STR=$(openssl rand -hex 3)
				convert "${file}" "${file%.gif}$STR.jpg"
			fi
		;;

		"tif")

			if [ ! -e "$F_JPG" ]; then
				convert "${file}" "${file%.tif}.jpg"
			else
				STR=$(openssl rand -hex 3)
				convert "${file}" "${file%.tif}$STR.jpg"
			fi
		;;

		"tiff")

			if [ ! -e "$F_JPG" ]; then
				convert "${file}" "${file%.tiff}.jpg"
			else
				STR=$(openssl rand -hex 3)
				convert "${file}" "${file%.tiff}$STR.jpg"
			fi
		;;

		"db")
			if [ -e "thumbs.db" ]; then									# supprime Thumbs.db (en minuscules à cause du rename)
				rm "thumbs.db"
			fi
		;;
	esac
done

convert *.jpg $NAME_DIR.pdf >/dev/null 2>&1

echo "done"

