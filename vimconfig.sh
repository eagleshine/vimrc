#! /usr/bin/bash

mkdir -p ~/.vim/bundle
git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone http://github.com/eagleshine/vimrc ~/.vim/vimrc
vim +BundleInstall +qall
ln -s .vim/vimrc/.vimrc .vimrc
