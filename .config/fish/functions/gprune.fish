function gprune
	git switch master
	git fetch -p
	for b in (git branch -vv | rg 'origin/.*: gone\]' | sed 's/^\s*\(\S\+\).*/\1/g')
		git branch -D $b
	end
end

