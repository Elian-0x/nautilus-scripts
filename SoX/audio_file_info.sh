#!/bin/bash

# Get Audio File Information and generate spectrogram (.png)
# by Elian
# Sept 2014

if [ "$1" != "" ]; then

	echo "Audio file: $1"
	sox $1 -n stats spectrogram

else
	echo "Error: audio filename is missing..."
fi
