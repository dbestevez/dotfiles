# dbestevez/zsh-snippets
bindkey '^S^J' zsh-snippets-widget-list
bindkey '^S^L' zsh-snippets-widget-expand
bindkey '^S^K' zsh-snippets-widget-search
bindkey '^S^H' zsh-snippets-widget-jump

# zsh-users/zsh-autosuggestions
bindkey -M vicmd ' ' autosuggest-accept
bindkey -M vicmd 'L' autosuggest-accept

# zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
