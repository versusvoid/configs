function make-arch-container
	mkdir -p $args[1]
	sudo pacstrap -i -c $args[1] \
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
