ZSH_THEME_GIT_PROMPT_PREFIX="branch: %{$fg[teal]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

get_git_branch () {
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

get_git_status () {
  INDEX=$(command git status --porcelain -b 2> /dev/null)

  local hasUntrackedFiles=false
  local hasAddedFiles=false
  local hasModifiedFiles=false
  local hasRenamedFiles=false
  local hasDeletedFiles=false
  local isUnmerged=false
  local hasDiverged=true
  local isAhead=false
  local isBehind=false
  local hasStashedFiles=false

  #First we establish the status of the repo
  if $(echo "$INDEX" | grep -E '^\?\? ' &> /dev/null); then
    hasUntrackedFiles=true
  fi
  if $(echo "$INDEX" | grep '^A  ' &> /dev/null); then
    hasAddedFiles=true
  fi
  if $(echo "$INDEX" | grep '^ M ' &> /dev/null); then
    hasModifiedFiles=true
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    hasModifiedFiles=true
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    hasModifiedFiles=true
  fi
  if $(echo "$INDEX" | grep '^R  ' &> /dev/null); then
    hasRenamedFiles=true
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    hasDeletedFiles=true
  elif $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    hasDeletedFiles=true
  elif $(echo "$INDEX" | grep '^AD ' &> /dev/null); then
    hasDeletedFiles=true
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    isUnmerged=true
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    isAhead=true
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    isBehind=true
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    hasDiverged=true
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    hasStashedFiles=true
  fi

  #Next, we use that info to determine if the repo is clean
  local isClean=true
  if [ "$hasUntrackedFiles" = true ] || [ "$hasAddedFiles" = true ] || [ "$hasModifiedFiles" = true ] || [ "$hasRenamedFiles" = true ] || [ "$hasDeletedFiles" = true ] ; then
    isClean=false
  fi

  #Finally, we setup & echo the status variable
  declare branch_status
  
  if [ "$isClean" = true ] ; then
    if [[ "$isAhead" = true && "$isBehind" = true ]] ; then
      branch_status="⬡"
    elif [ "$isAhead" = true ] ; then
      branch_status="△"
    elif [ "$isBehind" = true ] ; then
      branch_status="▽"
    else
      branch_status=" " #clean
    fi
  else 
    if [[ "$isAhead" = true && "$isBehind" = true ]] ; then
      branch_status="⬢"
    elif [ "$isAhead" = true ] ; then
      branch_status="▲"
    elif [ "$isBehind" = true ] ; then
      branch_status="▼"
    else
      branch_status="*" #dirty
    fi
  fi

  echo $branch_status
}


generate_git_prompt () {
  local _branch=$(get_git_branch)$(get_branch_review_status)
  _status=$(get_git_status)
  local _result=""
  if [[ "${_branch}x" != "x" ]]; then
    _result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
    if [[ "${_status}x" != "x" ]]; then
      _result="$_result $_status"
    fi
    _result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
  echo $_result
}

get_branch_review_status () {
   _review=$(command git config --get-all remote.origin.push )  #refs/for/my_branch_name/mobreview -> add branch name
    if [[ $_review == *$(get_git_branch)/mobreview ]]; then
      _review="/✓" #automatic code reviews
    else 
      _review="" #no code review
  fi

  echo $_review
}

if [[ "%#" == "#" ]]; then
  _USERNAME="%{$fg_bold[red]%}%n"
else
  _USERNAME="%{$fg[green]%}%n"
fi
_USERNAME="$_USERNAME%{$reset_color%} "

_PATH="%F{blue}%~"


setopt prompt_subst
PROMPT='$_USERNAME$(generate_git_prompt)
$_PATH %F{yellow}>%f '
RPROMPT='%F{yellow}<%f%*%F{yellow}>%f' 