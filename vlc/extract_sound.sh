#!/bin/bash

# Extract sound in wav from mpeg video files with vlc
# by Elian
# 2016

# chmod +x extract_sound.sh
# ./extract_sound.sh

for i in *mpeg; do vlc -I dummy --sout "#transcode{acodec=s16l,channels=2}:std{access=file,mux=wav,dst=$i.wav}" $i vlc://quit; done
