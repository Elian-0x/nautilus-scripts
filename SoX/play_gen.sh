#!/bin/bash

# Exemples d'utilisation de play pour générer des notes
# by Elian

# Version 0.1
# 15.02.2017

# Dépendance: sox


# -n	 :	pas de fichier en entrée
# -c2	 :	2 canaux
# synth	 :	generate a number of standard wave forms and types of noise
# len	 :	length of audio to synthesize. Format for specifying lengths in time is hh:mm:ss.frac
# type	 :	type is one of sine, square, triangle, sawtooth, trapezium, exp, [white]noise, pinknoise, brownnoise. Default is sine.
# freq	 :	frequencies at the beginning/end of synthesis in Hz
# effets :	allpass band bandpass bandreject bass bend biquad chorus channels compand contrast dcshift deemph
#			delay dither divide+ downsample earwax echo echos equalizer fade fir firfit+ flanger gain highpass hilbert input#
#			ladspa loudness lowpass mcompand mixer* noiseprof noisered norm oops output# overdrive pad phaser pitch rate remix
#			repeat reverb reverse riaa silence sinc spectrogram speed splice stat stats stretch swap synth tempo treble tremolo
#			trim upsample vad vol
# legende:
#			* Deprecated effect
#			+ Experimental effect
#			# LibSoX-only effect
#
# effopts:	effect dependent; see --help-effect
#
# ex:		chorus 0.6 0.9 50.0 0.4 0.25 2.0 -t 60.0 0.32 0.4 1.3 -s
# 			echo 0.7 0.6 50 0.2
# 			echos 0.4 0.6 900.0 0.25 900.0 0.3
# 			echo 0.7 0.89 1000.0 0.1
#
# >/dev/null 2>&1;	:	ne pas afficher les infos textes pendant la lecture


# Le chiffre après la lettre permet de préciser l'octave.
# Par défaut, octave 4.

function play_c_major_scale
{
	for note in C D E F G A B C5; do

		play -n -c2 synth 0.5 sine $note fade h 0.1 0.5 0.1 >/dev/null 2>&1;

	done
}


play -n -c2 synth 2 triangle %-12 fade h 0.1 2 0.1

play -n -c2 synth 5 sine %-12 sine %-9 sine %-5 sine %-2 fade h 0.1 5 0.1

echo -e "\nC major scale..."
play_c_major_scale
