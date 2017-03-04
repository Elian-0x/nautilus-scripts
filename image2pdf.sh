#!/bin/bash

# Convertir des fichiers image en pdf (1 pdf par image)
# by Elian

if [ "$1" != "" ]
then
	printf %s "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" |
	while read -r arg
	do
		S=$arg
		S=${S##*/}
		convert $arg ${S%.*}.pdf
	done
fi
