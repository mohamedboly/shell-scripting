#!/bin/bash

set -x       # Active le mode debug et affiche chaque commande avant son exécution
set -e       # Interrompt le script dès qu'une commande retourne une erreur
set -o pipefail  # Si une commande dans un pipe (|) échoue, le script s'arrête
set -exo pipefail  # Combine les trois options (-e, -x et -o pipefail) en une seule ligne

df -h        # Affiche l'utilisation des disques en format lisible par l'humain (gigaoctets, mégaoctets)
free -g      # Affiche l'utilisation de la mémoire en gigaoctets
nproc        # Affiche le nombre de processeurs (CPU) disponibles
