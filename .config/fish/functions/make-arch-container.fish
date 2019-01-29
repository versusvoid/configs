function make-arch-container
	mkdir -p $argv[1]
	sudo pacstrap -i -c $argv[1] \
		bash-completion \
		fakeroot \
		file \
		grep \
		iproute2 \
		iputils \
		logrotate \
		pacman \
		systemd-resolvconf \
		vim \
		which
end
