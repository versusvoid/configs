so /usr/share/vim/vim80/defaults.vim
set hlsearch
set ignorecase
set smartcase
set foldmethod=indent
set nofixendofline
filetype off
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <silent> <C-s> :w<CR><C-s>

set langmap=ё`йqцwуeкrеtнyгuшiщoзpх[ъ]фaыsвdаfпgрhоjлkдlж\\;э'яzчxсcмvиbтnьmб\\,ю.Ё~ЙQЦWУEКRЕTНYГUШIЩOЗPХ{Ъ}ФAЫSВDАFПGРHОJЛKДLЖ:Э\\"ЯZЧXСCМVИBТNЬMЮ>Б<

let s:curl = system("command -v curl")
silent !test -f "$(dirname $MYVIMRC)/.vim/spell/ru.utf-8.spl"
if len(s:curl) && v:shell_error
        silent !mkdir -p "$(dirname $MYVIMRC)/.vim/spell/"
        silent !curl -L http://ftp.vim.org/vim/runtime/spell/ru.utf-8.spl -o "$(dirname $MYVIMRC)/.vim/spell/ru.utf-8.spl"
        redraw
endif

call vundle#begin()

Plugin 'dag/vim-fish'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

call vundle#end()
set hidden
let g:racer_cmd = "racer"

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <Leader>gd <Plug>(rust-doc)

filetype plugin on
autocmd BufWritePre * %s/\s\+$//e

if $USER == "root"
	colorscheme torte
endif

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
"iabbrev lambda  λ
"iabbrev mu      μ
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
