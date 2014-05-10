#!/bin/sh

ask () {
	echo $1"? [y/n]: ";
	read -n 1 answ;
	echo "";
	return [ $answ == "y" -o $answ == "Y" ];
}


sudo pacman -Syu
sudo pacman -S gvim guake git ghc


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
EndSection' >> /etc/X11/xorg.conf.d/10-evdev.conf

if ask "Change sound card" then
    echo '
pcm.!default {
    type hw
    card PCH
}

ctl.!default {
    type hw           
    card PCH
}' > ~/.asoundrc
fi

amixer sset Master unmute

test -d ~/Documents || mkdir ~/Documents
pushd Documents
git clone https://github.com/versusvoid/configs.git
cp configs/.bashrc ~/
configs/init-vim.sh
popd

. .bashrc

# -- cabal
wget http://hackage.haskell.org/packages/archive/cabal-install/1.20.0.1/cabal-install-1.20.0.1.tar.gz
tar -xf cabal-install-1.20.0.1.tar.gz
pushd cabal-install-1.20.0.1

chmod u+x bootstrap.sh
PREFIX=$HOME ./bootstrap.sh
popd
rm -r cabal-install*
popd

cabal update
pacman -S happy

test -d ~/Programming || mkdir ~/Programming
