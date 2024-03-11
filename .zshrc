# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#
# Default
#
# ZSH_THEME="robbyrussell"
#
# We don't stand for default!
#
ZSH_THEME="powerlevel10k/powerlevel10k"

########################
## Virtualenv loading ##
########################

## PYTHON ##
export PYTHONPATH=$PYTHONPATH:"/usr/bin/python3"
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Documents/projects
if [[ $EUID != 0 ]]; then
  if [[ -d "$HOME/.local" ]]; then
    if [[ -f "$HOME/.local/bin/virtualenvwrapper.sh" ]]; then
      source $HOME/.local/bin/virtualenvwrapper.sh
    fi
  fi
  if [[ -f "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
  fi
  if [[ -f "/usr/bin/virtualenvwrapper.sh" ]]; then
    source /usr/bin/virtualenvwrapper.sh
  fi
fi

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  bgnotify
  colored-man-pages
  poetry
  poetry-env
  python
  rsync
  sudo
  systemadmin
  ubuntu
  virtualenvwrapper
  vscode
  watson
)

source $ZSH/oh-my-zsh.sh

# User configuration

unsetopt inc_append_history
unsetopt share_history

setopt append_history
setopt hist_ignore_dups

HISTFILE=~/.zsh_history

# History Length
HISTSIZE=10000
SAVEHIST=1000000

## RVM is a bit of a pain... Save this variable later so it can be prepended to PATH ##
GEM_HOME_OLD=""
[[ "$GEM_HOME" ]] && GEM_HOME_OLD="$GEM_HOME/bin"
## Need to hold Python virtual env for it to be appended somewhere after RVM path ##
VIRTUAL_ENV_OLD=""
[[ "$VIRTUAL_ENV" ]] && VIRTUAL_ENV_OLD="$VIRTUAL_ENV/bin"

## Load scripts ##
export PATH="$PATH:$HOME/.scripts:$HOME/.localscripts:$HOME/.local"

## Load /snap/bin ##
export PATH="$PATH:/usr/sbin:/snap/bin:/sbin/:/usr/local/bin/:/usr/local/sbin/:$HOME/.local/pipx/venvs/ansible/bin/"

## Load /usr/share for LaTeX ##
export PATH="$PATH:/usr/share/texlive"

###**##################################################**###
## **                IF YOU USE RVM:                   ** ##
## ** REMOVE THIS LINE FROM .profile AND .bash_profile ** ##
## **       OTHERWISE WARNING WILL PERSIST!!           ** ##
###**##################################################**###
## Add RVM to PATH for scripting. Make sure this is the last PATH variable change. ##
if [[ "$VIRTUAL_ENV_OLD" ]]; then
  export PATH="$VIRTUAL_ENV_OLD:$PATH:$HOME/.rvm/bin"
fi
if [[ "$GEM_HOME_OLD" ]];then
  export PATH="$GEM_HOME_OLD:$PATH:$HOME/.rvm/bin"
fi

## Load RVM into a shell session *as a function* ##
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Set terminal ruby environment back to system ##
RUN="rvm use system"
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  ${RUN}
fi

test -r ~/.profile && source ~/.profile
test -r ~/.shell-common && source ~/.shell-common
test -r ~/.shell-env && source ~/.shell-env
test -r ~/.shell-aliases && source ~/.shell-aliases
#test -r ~/.tmux/.tmux.conf && tmux source-file ~/.tmux/.tmux.conf

## Remove Python virtual environment from path so it's not added multiple times. ##
PATH="${PATH//$VIRTUAL_ENV_OLD}"

alias shasum="sha1sum"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fpath=($HOME/.zsh/completion $fpath)
autoload -U compinit; compinit
