# ---- SSH agent (Proton Pass) ----
export SSH_AUTH_SOCK="$HOME/.ssh/proton-pass-agent.sock"

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS

# ---- General options ----
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS NO_BEEP
bindkey -e   # emacs-style line editing

# ---- Completion ----
BREW_PREFIX=/opt/homebrew
fpath=($BREW_PREFIX/share/zsh-completions $BREW_PREFIX/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---- Tools ----
command -v fzf    >/dev/null && source <(fzf --zsh)        # Ctrl-R, Ctrl-T, Alt-C
if command -v fd >/dev/null; then
  export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
  export FZF_CTRL_T_COMMAND="\$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
fi
command -v mise   >/dev/null && eval "$(mise activate zsh)"     # per-project language versions
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"  # z <dir>
command -v starship >/dev/null && eval "$(starship init zsh)"

# ---- Aliases ----
if command -v eza >/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll='eza -lh --git --group-directories-first'
  alias la='eza -lha --git --group-directories-first'
  alias lt='eza --tree --level=2'
fi
command -v bat >/dev/null && alias cat='bat --paging=never'
alias ..='cd ..'
alias ...='cd ../..'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

# ---- Plugins (syntax highlighting must be last) ----
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
