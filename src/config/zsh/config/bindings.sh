# oh-my-zsh/plugins/vi-mode
bindkey -M vicmd 'e' edit-command-line

# 1ambda/zsh-snippets
bindkey '^s' zsh-snippets-widget-list
bindkey '^x' zsh-snippets-widget-expand

# zsh-users/zsh-autosuggestions
bindkey -M vicmd ' ' autosuggest-accept
bindkey -M vicmd 'L' autosuggest-accept

# zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
