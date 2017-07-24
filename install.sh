#!/bin/bash

# Install oh-my-zsh
if [ ! -d $HOME/.zgen ]; then
    echo "Installing zgen..."
    git clone https://github.com/tarjoilija/zgen.git $HOME/.zgen
fi

# Install patched fonts
if [ ! -d $HOME/.fonts ]; then
    echo "Installing patched fonts..."
    git clone https://github.com/powerline/fonts.git $HOME/.fonts
    fc-cache -vf
fi

# Install git-hooks
if [ ! -d $HOME/.git-hooks ]; then
    echo "Installing git-hooks..."
    git clone https://github.com/dhellmann/git-hooks.git $HOME/.git-hooks
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\|README.md\)/d"`
for file in $files; do
    if [ $file != "LICENSE" ] && [ ! -f $HOME/.$file ] && [ ! -d $HOME/.$file ]; then
        echo "Symlinking $file..."
        ln -s $PWD/$file $HOME/.$file
    fi
done;

# Set permissions for git_hooks
chmod -R 755 $HOME/.git_hooks

# Custom links for neovim
if type nvim > /dev/null 2>&1; then
    if [ ! -d $HOME/.config/nvim ]; then
        echo "Symlinking $HOME/.config/nvim..."
        ln -s $HOME/.vim $HOME/.config/nvim
    fi

    if [ ! -f $HOME/.config/nvim/init.vim ]; then
        echo "Symlinking $HOME/.config/nvim/init.vim..."
        ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
    fi
fi

# Install vim-plug
if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install vim plugins
echo "Installing vim plugins..."
vim -c PlugInstall -c q -c q

# Install neovim plugins
if type nvim > /dev/null 2>&1; then
    echo "Installing neovim plugins..."
    nvim -c PlugInstall -c q -c q
fi

# Ask for user and email for gitconfig
if [ "`grep user $HOME/.gitconfig`" == "" ]; then
    read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "Name: " username
        read -e -p "Email: " email

        echo "[user]" >> $HOME/.gitconfig
        echo "    name = " $username >> $HOME/.gitconfig
        echo "    email = " $email >> $HOME/.gitconfig
    fi
fi
