# vi: expandtab shiftwidth=4
#set -x CC /usr/bin/clang
#set -x CXX /usr/bin/clang++
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

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'
alias tar='bsdtar'
alias suspend='systemctl suspend'
alias view="$EDITOR -R"
alias less='less -R'
alias free-packages 'yay -Qs (yay -Qttq | xargs echo | sed \'s/^/^\(/g; s/$/\)$/g; s/ /|/g\')'
alias gsw='git switch'
alias tree='tree -C'


if functions -q fzf_key_bindings
    fzf_key_bindings
end
