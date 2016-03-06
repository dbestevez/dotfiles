bindkey -v

# Load zsh configuration
for file in ~/.zsh/(config|functions)/*; do
    source "$file"
done

# Aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases;
fi
