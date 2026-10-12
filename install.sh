#!/bin/zsh
# Bootstrap: symlink dotfiles into $HOME, install Homebrew packages and mise tools.
set -e
DOT="${0:A:h}"

# Symlink every file under home/ into $HOME, backing up anything already there.
backup="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"
for src in "$DOT"/home/**/*(.D); do
  rel="${src#$DOT/home/}"; dst="$HOME/$rel"
  [[ "$(readlink "$dst")" == "$src" ]] && continue
  mkdir -p "${dst:h}"
  if [[ -e "$dst" || -L "$dst" ]]; then mkdir -p "$backup/${rel:h}"; mv "$dst" "$backup/$rel"; fi
  ln -s "$src" "$dst" && echo "linked $rel"
done

# Git identity lives outside the repo
if [[ ! -e "$HOME/.gitconfig.local" ]]; then
  printf "[user]\n\tname = \n\temail = \n\tsigningkey = key::\n" > "$HOME/.gitconfig.local"
  echo "Fill in ~/.gitconfig.local (name, noreply email, SSH public key)"
fi

# Homebrew
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
brew bundle --file="$DOT/Brewfile"
chmod go-w "$(brew --prefix)/share" && chmod -R go-w "$(brew --prefix)/share/zsh"

# Languages from ~/.config/mise/config.toml
mise install

echo "Done. Open a new terminal."
