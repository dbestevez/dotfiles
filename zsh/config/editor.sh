export EDITOR=vim

# Use neovim if available
if type nvim > /dev/null; then
    export EDITOR=nvim
    alias vim=nvim
fi
