#!/usr/bin/env sh

root_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)

link_dir () {
  target=~/.config/$1

  if [ -f "$target" ]; then
    echo "$target already exists as a file";
  elif [ -d "$target" ]; then
    echo "$target already exists as a directory";
  else
    ln -s $root_dir/.config/$1 $target
  fi
}

link_dir nvim
link_dir fnott
link_dir waybar
link_dir home-manager
link_dir ueberzugpp
link_dir ranger
