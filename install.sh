#!/bin/bash

# Install oh-my-zsh
if [ ! -d ~/.zgen ]; then
    echo "Installing zgen..."
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

# Install patched fonts
if [ ! -d ~/.fonts ]; then
    echo "Installing patched fonts..."
    git clone https://github.com/powerline/fonts.git ~/.fonts
    fc-cache -vf
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\)/d"`
for file in $files; do
    if [ $file != "LICENSE" ] && [ ! -f ~/.$file ] && [ ! -d ~/.$file ]; then
        echo "Symlinking $file..."
        ln -s $PWD/$file ~/.$file
    fi
done;

# Custom links for neovim
if type nvim > /dev/null; then
    if [ ! -d ~/.config/nvim ]; then
        echo "Symlinking ~/.config/nvim..."
        ln -s ~/.vim ~/.config/nvim
    fi

    if [ ! -f ~/.config/nvim/init.vim ]; then
        echo "Symlinking ~/.config/nvim/init.vim..."
        ln -s ~/.vimrc ~/.config/nvim/init.vim
    fi
fi

# Install vim plugins
echo "Installing vim plugins..."
vim -c PlugInstall -c q -c q

# Install neovim plugins
if type nvim > /dev/null; then
    echo "Installing neovim plugins..."
    nvim -c PlugInstall -c q -c q
fi

# Ask for user and email for gitconfig
if [ "`grep user ~/.gitconfig`" == "" ]; then
    read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "Name: " username
        read -e -p "Email: " email

        echo "[user]" >> ~/.gitconfig
        echo "    name = " $username >> ~/.gitconfig
        echo "    email = " $email >> ~/.gitconfig
    fi
fi
