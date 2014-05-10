#!/bin/sh

test -d ~/.vim || mkdir ~/.vim
pushd ~/.vim

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

cp $(dirname $0)/.vimrc ~/
