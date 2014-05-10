syntax enable
set background=dark

set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

set incsearch
set smartcase
set hlsearch

set foldmethod=indent

set lbr

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

nmap <expr> <PageDown> (winheight(0)/2) . "gj"
imap <silent> <PageDown> <Esc><PageDown>i
nmap <expr> <PageUp> (winheight(0)/2) . "gk"
imap <silent> <PageUp> <Esc><PageUp>i
imap <silent> <F8> <Esc>:w<CR>a
nmap <silent> <F8> :w<CR>

" Haskell
filetype plugin indent on

let g:neocomplete#enable_at_startup = 1
let g:necoghc_enable_detailed_browse = 1

let g:syntastic_java_javac_autoload_maven_classpath = 0
let g:syntastic_haskell_ghc_mod_args = '--hlintOpt="--ignore=Redundant $"'
let g:syntastic_check_on_open = 1

execute pathogen#infect()

nmap <silent> <F1> :help<CR>
nmap <silent> <F3> :GhcModType<CR>
nmap <silent> <F4> :GhcModTypeClear<CR>
nmap <silent> <F5> :GhcModCheck<CR>
nmap <silent> <F6> :GhcModLint<CR>

"iabbrev alpha   α
"iabbrev beta    β
"iabbrev gamma   γ
"iabbrev delta   δ
"iabbrev epsilon ε 
"iabbrev zeta    ζ
"iabbrev eta     η
"iabbrev theta   θ
"iabbrev iota    ι
"iabbrev kappa   κ
iabbrev lambda  λ
iabbrev mu      μ
"iabbrev nu      ν
"iabbrev xi      ξ
"iabbrev omicron ο
"iabbrev pi      π
"iabbrev rho     ρ
"iabbrev sigma   σ
"iabbrev tau     τ
"iabbrev upsilon υ
"iabbrev phi     φ
"iabbrev chi     χ
"iabbrev psi     ψ
"iabbrev omega   ω
