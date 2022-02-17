#!/bin/bash

packages= "./packages/packages.list"
aur_packages= "./packages/aur_packages.list"

while IFS= read -r line
do
	sudo pacman --noconfirm ---needed -S '%s ' "$line"
done <"$packages"


while IFS= read -r line
do
	/usr/bin/yay --save --answerclean All --answerdiff All --noconfirm -S '%s ' "$line"
done <"$aur_packages"
