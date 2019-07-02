#! /usr/bin bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir ~/.vim
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/config ~/.vim/config
ln -s $DIR/.gitconfig ~/.gitconfig
ln -s $DIR/.zshrc ~/.zshrc
