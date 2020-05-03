# Function initialization
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

change_directory () {
  if [ $# -eq 0 ]; then
    command cd "$@"
  else
    command pushd "$@" > /dev/null
  fi
}

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xjf $1     ;;
      *.tar.gz)  tar xzf $1     ;;
      *.bz2)     bunzip2 $1     ;;
      *.rar)     unrar e $1     ;;
      *.gz)      gunzip $1      ;;
      *.tar)     tar xf $1      ;;
      *.tbz2)    tar xjf $1     ;;
      *.tgz)     tar xzf $1     ;;
      *.zip)     unzip $1       ;;
      *.Z)       uncompress $1  ;;
      *.7z)      7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Configuration
export DISPLAY=:0 # For WSL export to x server on windows
stty -ixon # enable ctrl+s for forward search

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Custom Prompt
GREEN="\[\033[38;5;10m\]"
RESET="\[$(tput sgr0)\]"
YELLOW="\[\033[38;5;11m\]"
PURPLE="\[\033[38;5;105m\]"
export PS1="\A${RESET} ${GREEN}\u${RESET} \w${RESET}${PURPLE}\$(parse_git_branch)${RESET} ${YELLOW}\\$ ${RESET}"

# KEY BINDING
# VARIABLE EXPORT
alias ll="ls -alh"
alias cd="change_directory"
alias dirs="dirs -v -l"
alias la="ls -larth"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
