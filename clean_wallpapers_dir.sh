#!/bin/bash

# clean_wallpapers_dir.sh
# Elian

# Version 0.1
# 13.07.2017

# ----------------------------------------------------------------------------------------------

rename "y/A-Z/a-z/" * >/dev/null 2>&1									# Tous les noms de fichiers et extensions en minuscules
rename "s/\.jpeg/\.jpg/" *.jpeg	 >/dev/null 2>&1						# Renomme tous les .jpeg en .jpg

BASE_DIR=$(pwd)
NAME_DIR=$(basename $BASE_DIR)											# nom du repertoire seul

echo "[>] working dir "$BASE_DIR


for file in *.*; do														# Pour chaque fichier du dossier courant

	EXT=${file##*.}														# extension seulement
	NAME_NOEXT=${file%.*}												# nom du fichier sans extension

	F_JPG=$NAME_NOEXT".jpg"												# nom du fichier de sortie

	case $EXT in

		"png")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.png}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
				convert "${file}" "${file%.png}$STR.jpg"
			fi
		;;

		"bmp")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.bmp}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
				convert "${file}" "${file%.bmp}$STR.jpg"
			fi
		;;

		"gif")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.gif}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
				convert "${file}" "${file%.gif}$STR.jpg"
			fi
		;;

		"tif")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.tif}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
				convert "${file}" "${file%.tif}$STR.jpg"
			fi
		;;

		"tiff")

			if [ ! -e "$F_JPG" ]; then									# si le fichier.jpg n'existe pas
				convert "${file}" "${file%.tiff}.jpg"
			else														# s'il existe déjà
				STR=$(openssl rand -hex 3)								# ajouter caracteres aléatoires
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

