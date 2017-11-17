function autoremove
	pacman -Qdtq | sudo pacman -Rs -
end

