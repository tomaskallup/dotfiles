#! /usr/bin bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

mkdir -p ~/.config/nvim/
ln -s $DIR/nvim/colors ~/.config/nvim/colors
ln -s $DIR/nvim/init.vim ~/.config/nvim/init.vim
ln -s $DIR/coc-settings.json ~/.config/nvim/coc-settings.json
