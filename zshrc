# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mveron"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

plugins=(mveron gitfast zsh-syntax-highlighting vagrant)

source $ZSH/oh-my-zsh.sh

### Added by the Heroku Toolbelt
export PATH="$HOME/bin:$PATH"

meldiff()
{
  git difftool  --tool=meld
}

pgrep()
{
  ps aux | grep -v grep | grep -i $1
}

alias tmux="TERM=screen-256color tmux"

alias :vst='vagrant status'
alias :vs='vagrant stop'
alias :vd='vagrant destroy'
alias :vblr='VBoxManage list runningvms'
alias :vbls='VBoxManage list vms'

alias gs='git st'
alias gss='git sync'
alias gd='git diff'
alias gl='git l'
alias gb='git branch'

vs() {
  if [ $# -gt 0 ]; then
    vagrant ssh $1
  else
    vagrant ssh
  fi
}
#alias vs='vagrant ssh'
alias vss='vagrant status'
alias vr='vagrant reload'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vh='vagrant provision'

alias tn='tmux new -s '
alias tl='tmux ls'
alias ta='tmux a -t '

## case-insensitive (all), partial-word and thenn substring (taken from https://github.com/christoomey/dotfiles)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
      'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

unsetopt correct_all

setopt auto_cd
cdpath=($HOME/code/pixelfusion $HOME/code/mine $HOME/code/umami)

EDITOR=vim

export GOPATH=~/code/mine/go
export PATH=$PATH:$GOPATH:$HOME/.rvm/bin:$HOME/.composer/vendor/bin # Add RVM to PATH for scripting
