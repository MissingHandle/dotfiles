# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/Users/gabesaravia/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

#
# Directory / Prompt Setup
#
hash -d code=$HOME/Code

#
# Prompt Config
#

# a fine reference:
# http://www.nparikh.org/unix/prompt.php#zsh

# git in your prompt - woot!
source ~/Config/zsh-git-prompt/zshrc.sh

#
#
PROMPT='%~ $(git_super_status)%# '

#
# ZSH Behavior
#

zstyle ':completion:*' rehash true


#
# Env Vars
#

export ARCHFLAGS='-arch x86_64'
export EDITOR='subl -w'
export PGDATA='/usr/local/var/postgres'
export DAVE='awesome'

#
# Aliases
#

# Shell
  alias lsl='ls -la'
  alias edit_zsh='subl ~/.zshrc &'
  alias reload='source ~/.zshrc'
  alias cdsnap='cd ~/Code/SnapPea'
  alias cdsmoov='cd ~/Code/smoothie'
  alias cdint='cd ~/Code/fooda_integration'
  alias cdderp='cd ~/Code/fooda_deploybot'
  alias cdhack='cd ~/Code/globalhack'


# Git
	alias g='git'
	alias gs='git status'
	alias ga='git add'
	alias gc='git checkout'
	alias gd='git diff'
	alias gdc='git diff --cached'
	alias gb='git branch'
	alias gcm='git commit'
  alias gcmm='git commit -m'
	alias gl='git log'
	alias push='git push'
  alias pull='git pull'
  alias rebase='git rebase'
  alias rmaster='git rebase -i origin/master'
  alias merge='git merge'


# Ruby et. al.
  alias  b='bundle'
  alias be='bundle exec'
  alias bi='bundle install'

# Rails
  alias up='bundle exec rails s'
  alias dbredo='bundle exec rake db:drop db:create db:structure:load db:seed db:test:prepare'


#
# Console Functions
#


# Git
function clean() {
  REMOTES="$@";
  if [ -z "$REMOTES" ]; then
    REMOTES=$(git remote);
  fi
  REMOTES=$(echo "$REMOTES" | xargs -n1 echo)
  RBRANCHES=()
  while read REMOTE; do
    CURRBRANCHES=($(git ls-remote $REMOTE | awk '{print $2}' | grep 'refs/heads/' | sed 's:refs/heads/::'))
    RBRANCHES=("${CURRBRANCHES[@]}" "${RBRANCHES[@]}")
  done < <(echo "$REMOTES" )
  [[ $RBRANCHES ]] || exit
  LBRANCHES=($(git branch | sed 's:\*::' | awk '{print $1}'))
  for i in "${LBRANCHES[@]}"; do
    skip=
    for j in "${RBRANCHES[@]}"; do
      [[ $i == $j ]] && { skip=1; echo -e "\033[32m Keeping $i \033[0m"; break; }
    done
    [[ -n $skip ]] || { echo -e "\033[31m $(git branch -D $i) \033[0m"; }
  done
}


#
# Initializations
#

# rbenv
eval "$(rbenv init -)"
