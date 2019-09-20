function bat --wraps=bat
	set -l parents (pstree -ps $fish_pid)
	set -l theme "Monokai Extended Bright"
	if string match -q '*guake*' $parents
		set -l guake_theme (dconf read '/apps/guake/style/font/palette-name')
		if test "'Solarized Light'" = $guake_theme
			set theme GitHub
		end
	end

	if string match -q '*alacritty*' $parents
		if rg -Fq 'colors: *light' $HOME/.config/alacritty/alacritty.yml
			set theme GitHub
		end
	end

	env BAT_THEME=$theme /usr/bin/bat $argv
end

