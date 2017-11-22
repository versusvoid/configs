function fish_prompt --description 'Write out the prompt'
	set stats $status $CMD_DURATION

	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	if not set -q __fish_color_blue
		set -g __fish_color_blue (set_color -o blue)
	end

	switch $USER

	case root toor

		if not set -q __fish_prompt_cwd
			if set -q fish_color_cwd_root
				set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
			else
				set -g __fish_prompt_cwd (set_color $fish_color_cwd)
			end
		end

		printf '%s@%s %s%s%s# ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

	case '*'

		if not set -q __fish_prompt_cwd
			set -g __fish_prompt_cwd (set_color $fish_color_cwd)
		end

		if test $stats[1] != 0
			printf "%s -> [%s]%s\n" (set_color -o red) $stats[1] (set_color normal)
		end
		if test $stats[2] -gt 30000
			set -l mil (math "$stats[2] % 1000")
			set -l t (math "$stats[2] / 1000")

			set -l s (math "$t % 60")
			set -l t (math "$t / 60")

			set -l m (math "$t % 60")
			set -l h (math "$t / 60")
			printf " in "
			if test $h -gt 0
				printf "%s:%s:" $h $m
			else if test $m -gt 0
				printf "%s:" $m
			end
			printf "%s.%s\n" $s $mil
		end
		set -l ssh_note
		if set -q SSH_TTY
			set ssh_note "[ssh]"
		end
		printf '[%s] %s%s%s\f\r%s%s%s> ' (date "+%H:%M:%S") "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" \
			(set_color -o red) $ssh_note (set_color normal)
	end
end
