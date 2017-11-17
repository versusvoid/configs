set -x EDITOR vim
set -x BROWSER chromium

set -x EMSCRIPTEN "/usr/lib/emscripten"
set -x EMSCRIPTEN_FASTCOMP "/usr/lib/emscripten-fastcomp"
set -x PATH $PATH $EMSCRIPTEN

set -x CARGO_INCREMENTAL 1
set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src

set -x PYTHONSTARTUP $HOME/.python2rc

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias tar='bsdtar'
