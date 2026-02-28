#
#                          ⢸⣦⡈⠻⣿⣿⣿⣶⣄
#                          ⢸⣿⣿⣦⡈⠻⣿⣿⣿⣷⣄
#                    ⣀⣀⣀⣀⣀⣀⣼⣿⣿⣿⣿ ⠈⠻⣿⣿⣿⣷⣄
#                    ⠈⠻⣿⣿⣿⣿⣿⡿⠿⠛⠁   ⠈⠻⢿⣿⣿⣷⣄
#
# Personal zsh configuration of Jess Archer <jess@jessarcher.com>

#--------------------------------------------------------------------------
# Oh My Zsh
#--------------------------------------------------------------------------

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

plugins=(
    npm
    vi-mode
    composer
    cp
    dnf
    docker
    docker-compose
    git
    httpie
    rsync
    # tmux
    z
    brew
    history-substring-search
)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh

#--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------

# Decrease delay that vi-mode waits for the end of a key sequence
export KEYTIMEOUT=15

typeset -U path cdpath fpath
path=(
    $HOME/.local/bin
    /opt/homebrew/bin
    /opt/homebrew/opt/node@20/bin
    /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    $path
)

setopt auto_cd
cdpath=(
    $HOME/Code
)

zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %d
zstyle ':completion:*:descriptions' format %B%d%b
zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
    'local-directories named-directories'

export EDITOR=nvim
export GIT_EDITOR=nvim
#export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export FZF_DEFAULT_COMMAND='ag -u -g ""'

unsetopt sharehistory

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias vi="nvim"
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"

export NODE_EXTRA_CA_CERTS="/opt/homebrew/share/ca-certificates/cacert.pem"

# NEW ADDITION FOR PYENV
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/markkinney/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/markkinney/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/markkinney/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/markkinney/google-cloud-sdk/completion.zsh.inc'; fi

# Make sure homebrew is in the path
export PATH="/opt/homebrew/bin:$PATH"

# Start tmux on startup
if [ -z "$TMUX" ] && [ "$TERM" = "xterm-kitty" ]; then
    tmux attach || exec tmux new-session && exit
fi
