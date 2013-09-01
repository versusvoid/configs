#!/bin/sh

ask () {
	echo $1"? [y/n]: ";
	read -n 1 answ;
	echo "";
	return [ $answ == "y" -o $answ == "Y" ];
}


apt-get update

yes | apt-get upgrade

yes | apt-get install build-essential vim guake git unrar flashplugin-downloader flashplugin-installer

git config --global user.email "whatever@mail.com"
git config --global user.name  "Versus Void"

git config --global push.default simple

ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/guake.desktop

echo '\
#       - - - Logitech Marble Mouse Settings - - -\
#\
#       For the sake of comments below, a Logitech Marble Mouse has buttons\
#       labeled from left to right: A (large), B, C, D (large). \
\
#       Preferred options for right-handed usage are:\
#       Left to right:  A=1,normal click  B=2,middle-click  C=2,middle-click  D=3,right-click\
#       Press button B (hold button while rolling trackball) to emulate wheel-scrolling. \
\
#       Preferred options for left-handed usage (saying "alternate-click" instead of "right click"):\
#       Left to right:  A=3,alternate-click  B=2,middle-click  C=2,middle-click  D=1,normal click\
#       Press button C (hold button while rolling trackball) to emulate wheel-scrolling.\
\
#       The trackball can scroll in two-axes, unlike a typical wheel mouse. Adjust the\
#       settings to constrain the scroll action to vertical-axis-only if you prefer.\
\
#       Pressing both large buttons simultaneously (b) produces a "back" action (=8). Finally,\
#       pressing and holding button B while rolling the trackball emulates wheel-rolling action.\
\
Section "InputClass"\
        Identifier  "Marble Mouse"\
        MatchProduct "Logitech USB Trackball"\
        MatchIsPointer "on"\
        MatchDevicePath "/dev/input/event*"\
        Driver "evdev"\
#       Physical button #s:     A b D - - - - B C    b = A & D simultaneously;   - = no button\
        Option "ButtonMapping" "3 8 1 4 5 6 7 2 2"\
#       Option "ButtonMapping" "1 8 3 4 5 6 7 2 2"   #  For right-hand placement\
#       Option "ButtonMapping" "3 8 1 4 5 6 7 2 2"   #  For left-hand placement\
#\
#       EmulateWheel refers to emulating a mouse wheel using Marble Mouse trackball.\
        Option "EmulateWheel" "true"\
#       Option "EmulateWheelButton" "8"              # Factory default; use "9" for left-side placement.\
        Option "EmulateWheelButton" "9"\
#\
#       EmulateWheelInertia specifies how far (in pixels) the pointer must move to\
#       generate button press/release events in wheel emulation mode.\
        Option "EmulateWheelInertia" "10"            # Factory default: 50\
#\
#       Option "ZAxisMapping" "4 5"\
        Option "ZAxisMapping" "4 5"\
#       Option "XAxisMapping" "6 7"                  # Disable this for vertical-only scrolling.\
#       Option "XAxisMapping" "6 7"\
#       Emulate3Buttons refers to the act of pressing buttons A and D\
#       simultaneously to emulate a middle-click or wheel click.\
        Option "Emulate3Buttons" "true"\
#       Option "Emulate3Buttons" "true"              # Factory default.\
EndSection' >> /usr/share/X11/xorg.conf.d/10-evdev.conf

if ask "Change sound card" then
    echo '\
pcm.!default {\
    type plug\
    slave.pcm "dmix:CARD=1,DEVICE=0,RATE=48000"\
}' > .asoundrc
    echo -e "defaults.pcm.card 1\ndefaults.pcm.device 0\ndefaults.ctl.card 1" > /etc/asound.conf;
fi

amixer sset Master unmute

mkdir Documents/configs
pushd Documents/configs
git init
git remote add origin https://github.com/versusvoid/configs.git
git fetch
git checkout master
cp .bashrc .vimrc ~/
popd

. .bashrc

# -- ghc
pushd /usr/lib/i386-linux-gnu
ln -s libgmp.so.10.0.5 libgmp.so.3
popd

pushd $HOME/Downloads
wget http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-i386-unknown-linux.tar.bz2
tar -xf ghc-7.6.3-i386-unknown-linux.tar.bz2
pushd ghc-7.6.3
./configure --prefix=$HOME && make install
popd
rm -r ghc-7.6.3*
# -- cabal
yes | apt-get install libgmp-dev libzip-dev
wget http://hackage.haskell.org/packages/archive/cabal-install/1.16.0.2/cabal-install-1.16.0.2.tar.gz
tar -xf cabal-install-1.16.0.2.tar.gz
pushd cabal-install-1.16.0.2
sed -i '{ s/DEFAULT_PREFIX=.*/DEFAULT_PREFIX="${HOME}"/;
	  s#${EXTRA_CONFIGURE_OPTS}#--package-db='$(~/bin/ghc-pkg list | head -n 1 | sed s/://)'#;
          /Setup install/ i\
  ./Setup haddock ${VERBOSE} \\\
    || die "Documenting the ${PKG} package failed"

;}' bootstrap.sh
chmod u+x bootstrap.sh
./bootstrap.sh
popd
rm -r cabal-install*
popd

cabal update
cabal-install hscolor
cabal-install happy
cabal-install ghc-mod

# -- vim
pushd .vim

mkdir autoload bundle syntax
wget -P syntax https://raw.github.com/urso/haskell_syntax.vim/master/syntax/haskell.vim
wget -P autoload https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
pushd bundle

git clone https://github.com/scrooloose/syntastic.git
yes | rm -r syntastic/.git*

git clone https://github.com/Shougo/vimproc.vim.git
yes | rm -r vimproc.vim/.git*
pushd vimproc.vim
make
popd

git clone https://github.com/eagletmt/ghcmod-vim.git
yes | rm -r ghcmod-vim/.git* *.sh
popd

git clone https://github.com/Shougo/neocomplete.vim.git
cp -r neocomplete.vim/{autoload,doc,plugin,vest} ./
yes | rm -r neocomplete.vim

git clone https://github.com/ujihisa/neco-ghc.git
cp -r neco-ghc/autoload ./
yes | rm -r neco-ghc

mkdir spell
wget -P spell http://ftp.vim.org/vim/runtime/spell/ru.utf-8.spl

popd

mkdir Programming

sed -i 's#\(OnlyShowIn=.*\)#\1LXDE;#' /etc/xdg/autostart/gnome-keyring-pkcs11.desktop
echo '127.0.0.1   vk.com' >> /etc/host
