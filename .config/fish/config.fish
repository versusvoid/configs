set -x EDITOR vim
set -x BROWSER chromium
set -x RUSTC_WRAPPER sccache

function fish_greeting
    echo use z as cd
    echo use fzf '(Ctrl+T)'
    echo use bat as cat
    echo use fn fr ffn ffr fdn fdr
    echo use rg as grep
    echo use peco as interactive grep
    echo use ncdu as du
end

function smiley
    echo '¯\_(ツ)_/¯'
end

set ff '
    function ffn;
        if test (count $argv) -lt 2;
            echo "ffn [dir] [iname] ..." 1>&2;
            return 1;
        end;
        find $argv[1] -type f -iname $argv[2] $argv[3..-1];
    end
'
eval $ff
eval (echo $ff | sed '{s/iname/iregex/g; s/ffn/ffr/g;}')
eval (echo $ff | sed '{s/type f/type d/g; s/ffn/fdn/g;}')
eval (echo $ff | sed '{s/iname/iregex/g; s/type f/type d/g; s/ffn/fdr/g;}')
eval (echo $ff | sed '{s/-type f//g; s/ffn/fn/g;}')
eval (echo $ff | sed '{s/-type f//g; s/iname/iregex/g; s/ffn/fr/g;}')
set -e ff

set -x EMSCRIPTEN "/usr/lib/emscripten"
set -x EMSCRIPTEN_FASTCOMP "/usr/lib/emscripten-fastcomp"
set -x PATH $PATH $EMSCRIPTEN

#set -x PYTHONSTARTUP $HOME/.python2rc

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias tar='bsdtar'

if functions -q fzf_key_bindings
    fzf_key_bindings
end
