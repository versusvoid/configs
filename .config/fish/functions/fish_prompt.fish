if not set -q _set_color_normal
	set -g _set_color_normal (set_color normal)
end

if not set -q _set_color_blue
	set -g _set_color_blue (set_color --bold blue)
end

if not set -q _set_color_red
	set -g _set_color_red (set_color --bold red)
end

if not set -q _set_color_brmagenta
	set -g _set_color_brmagenta (set_color --dim brmagenta)
end

if not set -q _set_color_cwd
	set -g _set_color_cwd (set_color $fish_color_cwd)
end

function fish_prompt --description 'Write out the prompt'
	set -l stats $status $CMD_DURATION
	if test $stats[1] != 0
		printf "%s -> [%s]%s\n" $_set_color_red $stats[1] $_set_color_normal
	end

	if test $stats[2] -gt 10000
		set -l mil (math "$stats[2] % 1000")
		set -l t (math -s0 "$stats[2] / 1000")

		set -l s (math -s0 "$t % 60")
		set -l t (math -s0 "$t / 60")

		set -l m (math -s0 "$t % 60")
		set -l h (math -s0 "$t / 60")
		printf " in "
		if test $h -gt 0
			printf "%02d:%02d:" $h $m
		else if test $m -gt 0
			printf "%02d:" $m
		end
		printf "%02d.%s\n" $s $mil
	end

	set -l ssh_note
	if set -q SSH_TTY
		set ssh_note "[ssh]"
	end

	set -l branch
	if test -e .git
		set branch (git branch --show-current)' '
	end

	set fish_emoji_width 2
	printf '[%s] %s%s%s%s%s%s\f\r%s%s%s🐟 ' \
		(date "+%H:%M:%S") \
		$_set_color_brmagenta $branch $_set_color_normal \
		$_set_color_cwd (prompt_pwd) $_set_color_normal \
		$_set_color_red $ssh_note $_set_color_normal
end
