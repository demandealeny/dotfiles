# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " %{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}
setopt promptsubst

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

## enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# use vim as the visual editor
export VISUAL=nvim
export EDITOR=$VISUAL

# Go config
export GOPATH=$HOME/projects/go
export PATH="$GOPATH/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# ensure dotfiles bin directory is loaded first
export PATH="/usr/local/heroku/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH"
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="minimal"
DISABLE_AUTO_TITLE="true"
plugins=(git ruby)
source $ZSH/oh-my-zsh.sh

#eval $(ssh-agent -s)
#ssh-add

notes() {
  folder="$HOME/resources/notes"
  file=$1

  if [ ! -d "$folder" ]; then
    mkdir -p $folder
  fi

  if [ -z "$file" ]; then
    vim "$folder/notes.md"
  else
    vim "$folder/$file.md"
  fi
}

# Alias
alias tmux='TERM=xterm-256color tmux -2'
alias l='ls -l'
alias la='ls -la'
alias gs='g s'
alias gst='g st'
alias zshconf='vim ~/.zshrc && source ~/.zshrc'
alias start_postgre='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias t='tmux'
alias v='nvim'
alias ta='tmux attach'
alias grd='git rebase origin/develop develop'
alias grs='git rebase origin/staging staging'
alias grm='git rebase origin/master master'
alias :q='exit'
alias :w='exit'
alias unlock='ps -U $(whoami) -ef | grep i3lock | awk "{print $2}" | xargs kill'
alias c='clear;'
alias tig-reflog='git reflog --pretty=raw | tig --pretty=raw'
alias nvs='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'
alias xrandr-home="xrandr --output eDP1 --auto --output HDMI1 --mode 1920x1080 --left-of eDP1"
alias xrandr-office="xrandr --output eDP1 --auto --output DP1 --mode 2560x1440 --left-of eDP1"
alias docker-clean-container="docker rm `docker ps -qa --no-trunc --filter 'status=exited'`"
alias docker-clean-images="docker rmi `docker images | grep 'none' | awk '/ / { print $3 }'`"
alias docker-clean="docker-clean-container && docker-clean-images"
alias vpncopy="cat ~/resources/vpncriteo | clipcopy"
alias ermsssh="cat ~/resources/storetail.pass | clipcopy; ssh ermsv1"

export REACT_EDITOR='vim'

setxkbmap -option caps:escape

bindkey -v

function zle-line-init zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

export NVM_DIR="$HOME/.nvm"
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
export PATH="$HOME/.yarn/bin:$PATH"

[ -s $HOME/.cargo/env ] && source $HOME/.cargo/env

# Launch manually if needed.
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

fpath=($fpath "/home/leny/.zfunctions")

  # Set Spaceship ZSH as a prompt
  # autoload -U promptinit; promptinit
  # prompt spaceship
