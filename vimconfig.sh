#! /bin/bash

cd ~
mkdir -p ~/.vim/bundle
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
git clone git://github.com/eagleshine/vimrc.git ~/.vim/vimrc
vim +BundleInstall +qall
ln -s .vim/vimrc/.vimrc .vimrc
ln -s .vim/vimrc/post-checkout .vim/vimrc/.git/hooks/post-checkout

if [[-d ~/vimtmp]];
then
    rm -r ~/vimtmp;
fi
