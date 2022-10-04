#
#                                    ________
#                                  |\\W#####M\
#                                  |M\\W#####M\
#                                  |#M\\W#####M\
#                                  |##M\\W#####M\
#                                  A###M\\W#####M\
#                         _______,a#####M|\W#####M\
#                         \W############W  \W#####M\
#                          \W##########W    \W#####M\
#                           'YW#####W7'      \W#####M\
#                              ¯¯¯¯¯          ¯¯¯¯¯¯¯¯
#
#           Personal .zshrc file of Jess Archer <jess@jessarcher.com>
#

# Plugins {{{
# ==============================================================================

    # Load the Antibody plugin manager for zsh.
    source <(antibody init)

    # Setup required env var for oh-my-zsh plugins
    export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"

    antibody bundle robbyrussell/oh-my-zsh
    antibody bundle robbyrussell/oh-my-zsh path:plugins/git
    antibody bundle robbyrussell/oh-my-zsh path:plugins/git-flow
    antibody bundle robbyrussell/oh-my-zsh path:plugins/jsontools
    antibody bundle robbyrussell/oh-my-zsh path:plugins/nmap
    antibody bundle robbyrussell/oh-my-zsh path:plugins/npm
    antibody bundle robbyrussell/oh-my-zsh path:plugins/ssh-agent
    antibody bundle robbyrussell/oh-my-zsh path:plugins/tmux
    antibody bundle robbyrussell/oh-my-zsh path:plugins/tmuxinator

    # Other bundles
    antibody bundle sampson-chen/sack
    antibody bundle zsh-users/zsh-autosuggestions

    # This needs to be the last bundle.
    antibody bundle zsh-users/zsh-syntax-highlighting

    # Load the theme.
    antibody bundle dracula/zsh

# }}}

# Configuration {{{
# ==============================================================================

    HYPHEN_INSENSITIVE="true"
    ENABLE_CORRECTION="false"
    COMPLETION_WAITING_DOTS="true"
    HIST_STAMPS="yyyy-mm-dd"

    typeset -U path cdpath fpath

    # Vim mode
    bindkey -v
    export KEYTIMEOUT=1

    # export ANDROID_HOME="$HOME/Android/Sdk/"

    export GIT_EDITOR=vim

    path=(
        ~/Applications
        ~/bin/
        "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        ~/.npm-global/bin
        ~/.npm/
        /opt/homebrew/bin
        /opt/homebrew/opt
        # ${ANDROID_HOME}tools/
        # ${ANDROID_HOME}platform-tools/
        $path
    )


    zstyle ':completion:*' group-name ''
    zstyle ':completion:*:descriptions' format %d
    zstyle ':completion:*:descriptions' format %B%d%b
    zstyle ':completion:*:complete:(cd|pushd):*' tag-order \
            'local-directories named-directories'

    export EDITOR='vim'
    export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'
    export ARTISAN_OPEN_ON_MAKE_EDITOR='nvr'
    export FZF_DEFAULT_COMMAND='ag -u -g ""'

    unsetopt sharehistory

# }}}

# Aliases & Functions {{{
# ==============================================================================

    homestead() {
        ( cd ~/Homestead && vagrant $* )
    }

    # Git
    alias g="git"
    alias gs="git s"
    alias nah="git reset --hard;git clean -df"
    alias co="git checkout"

    # General
    alias vim="nvim"
    alias mux="tmuxinator"
    alias copy="xclip -selection clipboard"
    alias paste="xclip -o -selection clipboard"

    # Open vim with z argument
    v() {
      if [ -n "$1" ]; then
        z $1
      fi

      nvim
    }

    # alias cd="cdls"
    open () {
        xdg-open $* > /dev/null 2>&1
    }

    if (( $+commands[tag] )); then
        tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
        alias ag=tag
    fi

# }}}
