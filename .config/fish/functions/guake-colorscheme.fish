function guake-colorscheme
	if test (dconf read '/apps/guake/style/font/palette-name') = "'Solarized Light'"
		guake --change-palette='Solarized Dark Higher Contrast'
	else
		guake --change-palette='Solarized Light'
	end
end

