#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .zshrc.cygwin .gitconfig .sbt .sbtrc )

for file in ${DOT_FILES[@]}
do
    ln -sn $HOME/dotfiles/$file $HOME/$file
done

touch $HOME/.gitconfig.local
