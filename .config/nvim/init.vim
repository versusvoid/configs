if !has('nvim')
	so $VIMRUNTIME/defaults.vim
endif
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	!yay -S --noconfirm --needed fzf
	!mkdir -p ~/.local/share/nvim/site/autoload
	!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
if empty(glob('/usr/share/nvim/runtime/autoload/youcompleteme.vim'))
	" !yay -S --noconfirm --needed --asdeps typescript python-jedi
	" It's default packaging is awful, so it's easier to install it globaly
	" !yay -S --noconfirm neovim-youcompleteme-core-git
endif

set hlsearch
set ignorecase
set smartcase
set incsearch

let g:pyindent_open_paren = 'shiftwidth()'
set smartindent
set foldmethod=indent
set nofixendofline
set wildmode=longest:full
"set bufhidden=wipe
set hidden
set tabpagemax=10
set switchbuf=usetab

set linebreak
set fileencodings=utf-8,cp1251

filetype off
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <C-t> :FZF<cr>
nnoremap <C-_> :Rg<cr>
nnoremap <silent> <C-s> :w<CR><C-s>

set langmap=ё`йqцwуeкrеtнyгuшiщoзpх[ъ]фaыsвdаfпgрhоjлkдlж\\;э'яzчxсcмvиbтnьmб\\,ю.Ё~ЙQЦWУEКRЕTНYГUШIЩOЗPХ{Ъ}ФAЫSВDАFПGРHОJЛKДLЖ:Э\\"ЯZЧXСCМVИBТNЬMЮ>Б<

let g:ale_linters = {'python': ['flake8']}
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'dag/vim-fish'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/pgsql.vim'
call plug#end()

set hidden

filetype plugin on
autocmd BufWritePre * %s/\s\+$//e

if system("pstree -ps " . getpid() . "| grep -o guake") ==? "guake\n"
	let guake = 1
else
	let guake = 0
endif
if system("dconf read '/apps/guake/style/font/palette-name'") ==? "'Solarized Light'\n" && guake
	set background=light
	let g:solarized_contrast = "high"
	let g:solarized_termtrans = 1
	colorscheme solarized
else
	set background=dark
endif


if $USER == "root"
	colorscheme murphy
	highlight Normal ctermbg=DarkRed
endif

