#! /usr/bin/bash

DOTFILES_PATH=~/.dotfiles

configs=(fontconfig fish)
locals=(fonts themes backgrounds)

for config in ${configs[@]}; do
  ln -sf $DOTFILES_PATH/.config/$config ~/.config
done

for local in ${locals[@]}; do
  ln -sf $DOTFILES_PATH/.local/$local ~/.local
done
