#!/bin/bash

# Zeitgeist cleaner
# by Elian

# 2016

<<INFOS
	Zeitgeist "l'esprit du temps"
	Journal d'activités faisant partie de l'environnement de bureau GNOME.
	Il enregistre les activités de l'utilisateur et les évènements (fichiers ouverts, sites Web visités,
	conversations avec d'autres personnes, etc.) et rend l'information pertinente disponible aux autres applications.
	Il permet de déterminer les relations entre des éléments en se basant sur les modèles d'utilisation.
	Les fichiers ayant été ouverts sont indexés, et peuvent faire l'objet de recherches rapides sur leur nom ou leur contenu,
	via une interface dédiée : zone de recherche du dash de Unity, zone de recherche de Gnome-shell, Synapse.
	Mais les fichiers non-ouverts ne sont pas indexés. Zeitgeist n'est donc pas un logiciel indexant TOUT le contenu du disque dur.
INFOS

DIR="/home/your_name/.local/share/zeitgeist"

cd $DIR
rm -r *		# Supprime le contenu du dossier courant de manière récursive, répertoires y compris

nautilus $DIR
