#!/bin/bash

# Url archive
# by Elian

# Version 0.1
# 24.02.2017

# Archive url in a text file. Run from Open With add-on for Firefox.

FILE_URL="archive_url.txt"
LINK=${@}

SCRIPT=$(readlink -f "$0")
CURRENT_PATH=$(dirname "$SCRIPT")
cd $CURRENT_PATH

echo $LINK >> $FILE_URL

exit 0
