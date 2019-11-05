function rs -w redshift
	killall redshift 2>/dev/null
	if test (count $argv) -gt 0
		swaymsg exec "redshift -O $argv"
	end
end
