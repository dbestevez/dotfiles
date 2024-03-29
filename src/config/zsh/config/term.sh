export DISABLE_AUTO_TITLE="true"
export AUTO_TITLE="false"

if [[ $TERM == xterm-kitty ]] && [[ -f /etc/profile.d/vte/sh ]]; then
    source /etc/profile.d/vte.sh
    __vte_osc7
fi

# Theme
[[ -f $HOME/.config/zsh/config/environments/theme.sh ]] \
    && source $HOME/.config/zsh/config/environments/theme.sh

# Fix cursor when opening new windows inside tmux
[[ "$CURSOR" != "" ]] && echo -ne $CURSOR && clear
