# Editor
export EDITOR=vim

# Use neovim if available
if type nvim > /dev/null; then
    export EDITOR=nvim
    alias vim=nvim
fi

export VISUAL=$EDITOR

# Language
export LC_ALL=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Less
export LESS="-R"
export LESSOPEN="|$HOME/.bin/lessfilter.sh %s"

# Path
export PATH="$HOME/.themer:$HOME/.bin:$PATH"

# Terminal
[[ $TMUX = "" ]] && export TERM="xterm-256color"

# Clipmenu + rofi
export CM_LAUNCHER=rofi-script

# Environment configurations
if [ -d $HOME/.environment ]; then
    for file in $HOME/.environment/*; do
        source $file
    done
fi
