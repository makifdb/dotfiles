#!/bin/bash

packages="$(pwd)/packages/packages.list"
aur_packages="$(pwd)/packages/aur_packages.list"

while IFS= read -r line
do
	sudo pacman --noconfirm --needed -S "$line"
done <"$packages"


while IFS= read -r line
do
	/usr/bin/yay --save --noconfirm --noanswerdiff --noansweredit --noanswerclean -S "$line"
done <"$aur_packages"
