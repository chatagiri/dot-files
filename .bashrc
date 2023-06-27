# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
alias l1='ls -1'
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

## tmux session config                                                                                                                    
if [[ ! -n $TMUX ]]; then
    tmux new-session
fi
if [[ ! -n $TMUX && $- == *l* ]]; then
  # get the IDs
  ID="`tmux list-sessions`"
  if [[ -z "$ID" ]]; then
    tmux new-session
  fi
  create_new_session="Create New Session"
  ID="$ID\n${create_new_session}:"
  ID="`echo $ID | $PERCOL | cut -d: -f1`"
  if [[ "$ID" = "${create_new_session}" ]]; then
    tmux new-session
  elif [[ -n "$ID" ]]; then
    tmux attach-session -t "$ID"
  else
 :  # Start terminal normally
 fi
fi

alias k="kubectl"

source /usr/local/bin/git-prompt.sh
source /usr/local/bin/git-completion.sh
stty stop undef

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\]\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
export PATH="/home/$(whoami)/.krew/bin:/home/$(whoami)/google-cloud-sdk/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/$(whoami)/.local/bin:/home/$(whoami)/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.bash.inc' ]; then . '/usr/local/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/google-cloud-sdk/completion.bash.inc' ]; then . '/usr/local/google-cloud-sdk/completion.bash.inc'; fi

HISTSIZE=1000000
