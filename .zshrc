ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep notify
setopt hist_ignore_all_dups
bindkey -e

autoload -Uz compinit && compinit

# Change definition of what a word is
autoload -U select-word-style
select-word-style bash

# zinit ice depth=1
# zinit light romkatv/powerlevel10k

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
# zinit light Aloxaf/fzf-tab

# snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::docker
zinit snippet OMZP::rust

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3A" beginning-of-line # alt+up
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[1;3B" end-of-line # alt+down
bindkey "^[[F" end-of-line

# Vim style with alt 
bindkey "^[h" backward-word
bindkey "^[l" forward-word
bindkey "^[j" beginning-of-line # Home
bindkey "^[k" end-of-line # Home

# Shell Integrations
eval "$(starship init zsh)"
source "$HOME/.cargo/env"

if type zoxide &> /dev/null 
then
  eval "$(zoxide init zsh)"
  # alias cd="z"
fi


# alias
alias ls="ls --color=auto"
alias l="ls -lFh"
alias la="ls -lFah"
alias source_idf="source ~/esp/idf/export.sh"

# Created by `pipx` on 2024-09-03 06:58:21
export PATH="$PATH:/home/shreyash/.local/bin"
eval "$(register-python-argcomplete pipx)"

# common used functions
switch_dm(){
  if [[ $# -ne 2 ]]; then
    echo "usage $0 <current> <new>";
    return -1
  fi

  systemctl cat $1 > /dev/null &&
    systemctl cat $2 > /dev/null &&
    sudo systemctl disable $1 &&
    sudo systemctl enable $2
}
