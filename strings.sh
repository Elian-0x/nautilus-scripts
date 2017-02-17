#!/bin/bash

OUT=$1".txt"
xterm -e script -c "strings $1" $OUT &
