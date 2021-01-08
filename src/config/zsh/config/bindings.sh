# zsh-users/zsh-autosuggestions
bindkey -M vicmd ' ' autosuggest-accept
bindkey -M vicmd 'L' autosuggest-accept

# zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -M vicmd 'e' edit-command-line

bindkey '^ ' snippet-expand
