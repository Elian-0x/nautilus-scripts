#!/bin/bash

# extract_pdf_cover.sh
# by Elian

# 10.02.2017

# Extraire la première page (image) de tous les pdf d'un dossier pour récupérer
# la couverture du ebook et faire une miniature en la redimentionnant

# Dépendances: sudo apt-get install imagemagick
#			   sudo apt-get install poppler-utils


for fichiers in *.pdf; do

	NAME_NOEXT=${fichiers%.*}
	OUT=$NAME_NOEXT"_cover"
	pdfimages -f 1 -l 1 -j "$fichiers" $OUT

done

DIR="covers"

mkdir $DIR

# pdfimages
# 	-f <int>	: first page to convert
# 	-l <int>    : last page to convert
# 	-j          : write JPEG images as JPEG files

for images in *.jpg; do

	NAME_NOEXT=${images%.*}
	OUT=$NAME_NOEXT"_resize.jpg"
	convert $images -resize 300x200 -verbose $OUT
	mv $OUT $DIR

done

rm *.jpg

exit 0
