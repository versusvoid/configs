function vi
	set -l arg
	if ! set -q EDITOR
		set EDITOR nvim
	end

	for arg in $argv
		if string match -- '-*' $arg
			continue
		end
		if test -e $arg; and test (stat -c '%U' $arg) != (whoami)
			sudo mkdir -p /root/.config/nvim /root/.local/share/nvim
			sudo ln -s $HOME/.config/nvim/init.vim /root/.config/nvim/ 2>/dev/null
			sudo ln -s $HOME/.local/share/nvim/site /root/.local/share/nvim/site 2>/dev/null
			sudo $EDITOR $argv
			return $status
		end
		if test ! -e $arg; and test -e (dirname $arg); and test (stat -c '%U' (dirname $arg)) != (whoami)
			sudo mkdir -p /root/.config/nvim /root/.local/share/nvim
			sudo ln -s $HOME/.config/nvim/init.vim /root/.config/nvim/ 2>/dev/null
			sudo ln -s $HOME/.local/share/nvim/site /root/.local/share/nvim/site 2>/dev/null
			sudo $EDITOR $argv
			return $status
		end
	end
	$EDITOR $argv
	return $status
end
