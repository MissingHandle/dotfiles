# The following lines were added by compinstall
zstyle :compinstall filename '/Users/gabesaravia/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

#
# Env Vars
#
source ./zsh_custom/env

#
# Aliases
#
source ./zsh_custom/aliases

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
