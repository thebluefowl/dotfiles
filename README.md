# dotfiles

zsh + Starship + Ghostty (Nord), git with SSH signing via Proton Pass, mise for Node/Python/Go.

## New machine

    git clone <this repo> ~/dotfiles && ~/dotfiles/install.sh

Files in `home/` are symlinked into `$HOME`; existing files are backed up first.
Git identity goes in the untracked `~/.gitconfig.local` (created as a template by `install.sh`).
After adding a brew package, run `brew bundle dump --file=~/dotfiles/Brewfile --force`.
