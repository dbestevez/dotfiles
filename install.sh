# Install oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh-my-zsh..."
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

# Install patched fonts
if [ ! -d ~/.fonts ]; then
    echo "Installing patched fonts..."
    git clone https://github.com/powerline/fonts.git ~/.fonts
    fc-cache -vf
fi

# Install powerline
if [ "`pip list | grep powerline`" == "" ]; then
    echo "Installing powerline..."
    sudo pip install powerline-status
fi

# Create symlinks
files=`ls | sed -e "/\(install.sh\|powerline\)/d"`
for file in $files; do
    if [ ! -f ~/.$file ] && [ ! -d ~/.$file ]; then
        echo "Symlinking $file..."
        ln -s $PWD/$file ~/.$file
    fi
done;

# Install Vundle and vim plugins
if [ ! -d ~/.vim/bundle/vundle ]; then
    echo "Installing Vundle for vim.."
    git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/vundle

    echo "Installing vim plugins..."
    vim -c BundleInstall -c q
fi;

# Install custom powerline
if [ ! -d ~/.config/powerline ]; then
    echo "Installing custom powerline..."
    ln -s $PWD/powerline ~/.config/powerline
fi

# Ask for user and email for gitconfig
if [ "`cat ~/.gitconfig | grep user`" == "" ]; then
    read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "Name: " username
        read -e -p "Email: " email

        echo "[user]" >> ~/.gitconfig
        echo "    name = " $username >> ~/.gitconfig
        echo "    email = " $email >> ~/.gitconfig
    fi
fi
