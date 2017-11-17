function vi
	set -l arg
	for arg in $argv
		if string match -- '-*' $arg
			continue
		end
		if test -e $arg; and test (stat -c '%U' $arg) != (whoami)
			sudo vim $argv
			return $status
		end
		if test ! -e $arg; and test -e (dirname $arg); and test (stat -c '%U' (dirname $arg)) != (whoami)
			sudo vim $argv
			return $status
		end
	end
	vim $argv
	return $status
end
