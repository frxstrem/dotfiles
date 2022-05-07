setopt HIST_IGNORE_DUPS
SAVEHIST=0

if [[ -n "$FRX_DOTFILES" ]]; then
  export PATH="$PATH:$FRX_DOTFILES/bin"
fi

alias gst='git status'
alias k='kubectl'
