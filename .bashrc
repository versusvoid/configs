# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

export BROWSER=firefox
export EDITOR=nvim
export VISUAL=$EDITOR
export RUSTC_WRAPPER=sccache

# Jap
export GTK_IM_MODULE=fcitx
export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache
export XMODIFIERS=@im=fcitx
export QT_IM_MODULE=fcitx

# Wayland
export QT_QPA_PLATFORM=wayland
export MOZ_ENABLE_WAYLAND=1
export _JAVA_AWT_WM_NONREPARENTING=1
export STUDIO_JDK=/usr/lib/jvm/java-8-openjdk

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias o='less'
alias vi='$EDITOR'
alias view='$EDITOR -R'

if [ -z "$SSH_AUTH_SOCK" ]; then
	pkill -u $USER ssh-agent
	eval `ssh-agent | head -n 2`
fi

shopt -q login_shell && ( pgrep sway > /dev/null || sway )
