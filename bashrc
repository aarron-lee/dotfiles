
### load extensions ###

source "$HOME/dotfiles/git-completion.bash"
source "$HOME/dotfiles/docker-compose.bash"
source "$HOME/dotfiles/docker.bash"
source "$HOME/dotfiles/git-prompt.sh"

### ENV variables ###

# make vim the default text editor
export EDITOR="vim"

# shortened prompt that includes git branch info
RED='\[\e[0;31m\]'
WHITE='\[\e[1;37m\]'
RESET='\[\e[0m\]'
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="$RED\w$WHITE\$(__git_ps1)$RED\$$RESET "

### other ###

# load aliases
[[ -f "$HOME/dotfiles/aliases" ]] && source "$HOME/dotfiles/aliases"
