#!/usr/bin/env bash
set -e -o pipefail -o nounset
cd "$(dirname "${BASH_SOURCE[0]}")"
IFS=$'\n'

# Add line to file.
# If the line already exists, do nothing
add_line_to_file() {
  local file="$1"
  local line="$2"

  if [[ ! -e "$file" ]] || ! grep -q -F -x "$line" "$file"; then
    echo "$line" >> "$file"
  fi
}

add_line_to_file ~/.bashrc "$(printf 'FRX_DOTFILES=%q; source "$FRX_DOTFILES/bashrc"; # frxstrem/dotfiles"' "$PWD")"
add_line_to_file ~/.zshrc "$(printf 'FRX_DOTFILES=%q; source "$FRX_DOTFILES/zshrc"; # frxstrem/dotfiles"' "$PWD")"

if command -v git &>/dev/null; then
  if ! git config --global --get-all include.path | grep -q -F -x "$PWD/gitconfig"; then
    git config --global --add include.path "$PWD/gitconfig"
  fi
fi

if [[ ! -e ~/.inputrc ]]; then
  ln -s "$PWD/inputrc" ~/.inputrc
else
  echo "~/.inputrc already exist; not replacing" >&2
fi
