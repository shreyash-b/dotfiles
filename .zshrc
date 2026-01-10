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

zinit ice wait
zinit light-mode for \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-syntax-highlighting

zinit ice wait
which fzf 2>&1 > /dev/null && eval "$(fzf --zsh)" &&
  zinit light-mode for \
      Aloxaf/fzf-tab \
      joshskidmore/zsh-fzf-history-search

zinit snippet OMZP::git

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history
bindkey "^[[1;5D" backward-word # alt left
bindkey "^[[1;5C" forward-word # alt right
bindkey "^[[1;3D" backward-word # option left
bindkey "^[[1;3C" forward-word # option right
bindkey "^[[H" beginning-of-line # Home
bindkey "^[[1~" beginning-of-line # Home in TMUX
bindkey "^[[F" end-of-line # End
bindkey "^[[4~" end-of-line # End in TMUX

# Vim style with alt 
bindkey "^[h" backward-word
bindkey "^[l" forward-word
bindkey "^[j" beginning-of-line 
bindkey "^[k" end-of-line 

# Shell Integrations
eval "$(starship init zsh)"
# source "$HOME/.cargo/env"

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
export PATH="$PATH:$HOME/.local/bin"
eval "$(register-python-argcomplete pipx)"


set_env_var(){
    echo "Setting $1 to $2"
    export $1=$2
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# pnpm
export PNPM_HOME="/home/shreyash/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
