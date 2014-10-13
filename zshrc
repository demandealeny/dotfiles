# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " %{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '

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

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

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
alias tmux='TERM=xterm-256color tmux -2'
alias tmuxinator='TERM=xterm-256color tmuxinator'
alias mux='TERM=xterm-256color mux'
alias unist='unicorn_rails -c config/unicorn.rb -d -w &'
alias ngacs='sudo tail -f /var/log/nginx/access.log'
alias ngerr='sudo tail -f /var/log/nginx/error.log'
alias zr='zeus rspec'
alias l='ls -l'
alias la='ls -la'
alias up='sudo apt-get update && sudo apt-get upgrade'
alias zshconf='vim ~/.zshrc && source ~/.zshrc'
alias rtest='rake db:drop RAILS_ENV=test && rake db:create RAILS_ENV=test && rake db:migrate RAILS_ENV=test'
alias grep='grep -rin'

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

export PATH="/home/vagrant/.rvm/gems/ruby-2.1.2/bin:/home/vagrant/.rvm/gems/ruby-2.1.2@global/bin:/home/vagrant/.rvm/rubies/ruby-2.1.2/bin:/usr/local/heroku/bin:/home/vagrant/.rbenv/shims:/home/vagrant/.rbenv/bin:/home/vagrant/.bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/vagrant/.rvm/bin:/home/vagrant/.rvm/bin"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
