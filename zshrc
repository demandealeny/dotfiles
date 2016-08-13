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

# enable colored output from ls, etc
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
export VISUAL=vim
export EDITOR=$VISUAL

# Go config
export GOPATH=$HOME/projects/go
export PATH="$GOPATH/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# ensure dotfiles bin directory is loaded first
export PATH="/usr/local/heroku/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$PATH"
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# load rbenv if available
#if which rbenv &>/dev/null ; then
  #eval "$(rbenv init - --no-rehash)"
#fi

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
export ZSH_THEME="bira"
DISABLE_AUTO_TITLE="true"
plugins=(git ruby)
source $ZSH/oh-my-zsh.sh
# source ~/.nvm/nvm.sh
eval $(ssh-agent -s)
ssh-add

#export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '
# Launch node
# nvm use 0.10

# Alias
alias tmux='TERM=xterm-256color tmux -2'
alias tmuxinator='TERM=xterm-256color tmuxinator'
alias mux='TERM=xterm-256color mux'
alias unist='unicorn_rails -c config/unicorn.rb -d -w &'
alias ngacs='sudo tail -f /var/log/nginx/access.log'
alias ngerr='sudo tail -f /var/log/nginx/error.log'
alias zr='zeus rspec'
alias l='ls -l'
alias la='ls -la'
alias gs='g s'
alias gst='g st'
alias nv='nvim'
alias up='sudo apt-get update && sudo apt-get upgrade'
alias db:reset='rak db:drop && rak db:create && rak db:migrate'
alias zshconf='vim ~/.zshrc && source ~/.zshrc'
alias rmigrate='rak db:migrate && rak db:rollback && rak db:migrate'
alias rtest='rak db:drop RAILS_ENV=test && rak db:create RAILS_ENV=test && rak db:migrate RAILS_ENV=test'
alias egrep='grep -rn'
alias ssh-tco-prod='ssh tco_prod@sd-49068.dedibox.fr -p 622'
alias tprod='ssh-tco-prod -t "cd webapp/current/; bash -l"'
alias start_postgre='pg_ctl -D /usr/local/var/postgres -l logfile start'
alias t='tmux'
alias ta='tmux attach'
alias htg='history | grep '
alias gopath='export GOPATH=`pwd`'
alias grs='git rebase origin/staging staging'
alias grm='git rebase origin/master master'
alias sperso='ssh root@perso.ks'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM
export PATH="$PATH:$HOME/ressources/phantomjs/bin"
export PATH="$PATH:$HOME/bin"
