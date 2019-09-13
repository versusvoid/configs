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
set linebreak
set fileencodings=utf-8,cp1251

filetype off
nnoremap <C-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
nnoremap <C-t> :FZF<cr>
nnoremap <C-_> :Rg<cr>
nnoremap <silent> <C-s> :w<CR><C-s>

set langmap=ё`йqцwуeкrеtнyгuшiщoзpх[ъ]фaыsвdаfпgрhоjлkдlж\\;э'яzчxсcмvиbтnьmб\\,ю.Ё~ЙQЦWУEКRЕTНYГUШIЩOЗPХ{Ъ}ФAЫSВDАFПGРHОJЛKДLЖ:Э\\"ЯZЧXСCМVИBТNЬMЮ>Б<
iabbrev №   #

function! init#switch_or_open(...)
	let lines = a:000
        for tabIndex in range(tabpagenr('$'))
		for bufferIndex in tabpagebuflist(tabIndex + 1)
			let bufinfo = getbufinfo(bufferIndex)[0]
			if bufinfo['hidden']
				continue
			endif
			for lineIndex in range(len(l:lines))
				let line = fnamemodify(l:lines[lineIndex], ':p')
				if bufinfo['name'] ==# line
					execute "tabnext" (tabIndex + 1)
					call remove(l:lines, lineIndex)
					break
				endif
			endfor
		endfor
        endfor

	for line in l:lines
		execute "tab split" line
	endfor
endfunction
command! -nargs=+ SwitchOrOpen call init#switch_or_open(<f-args>)

let g:fzf_action = { 'ctrl-t': 'SwitchOrOpen' }

let g:ale_java_checkstyle_config = './checkstyle.xml'
let g:ale_linters = { 'python': ['flake8'], 'java': ['checkstyle'] }
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'dag/vim-fish'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'altercation/vim-colors-solarized'
call plug#end()

set hidden

filetype plugin on
autocmd BufWritePre * %s/\s\+$//e

let light = 0
if system("pstree -ps " . getpid() . "| grep -o guake") ==? "guake\n"
    if system("dconf read '/apps/guake/style/font/palette-name'") ==? "'Solarized Light'\n"
	let light = 1
    endif
elseif system("pstree -ps " . getpid() . "| grep -o alacritty") ==? "alacritty\n"
    if system("rg -N '^colors:' $HOME/.config/alacritty/alacritty.yml") ==? "colors: *light\n"
	let light = 1
    endif
endif
if light
	set background=light
	let g:solarized_contrast = "high"
	let g:solarized_termtrans = 1
	colorscheme solarized
	highligh StatusLine cterm=reverse ctermfg=11 ctermbg=7
else
	set background=dark
endif


if $USER == "root"
	colorscheme murphy
	highlight Normal ctermbg=52
endif

