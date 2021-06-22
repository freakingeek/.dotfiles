function autoremove
  sudo pacman -Rns (pacman -Qtdq)
end