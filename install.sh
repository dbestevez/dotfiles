#!/bin/bash

# ---
# Displays a message with a bold font.
#
# @param $1 The message to display.
# ---
echo_bold() {
    message=$1
    shift
    echo -e $@ "\033[1m$message\033[0m"
}

# ---
# Displays an info message.
#
# @param $1 The message to display.
# @param $@ Extra parameters for echo command.
# ---
echo_info() {
    message="SKIP"
    [ ! -z "$1" ] && message="$1"; shift;

    echo -e $@ "\033[34;1m$message\033[0m"
}

# ---
# Displays a warning message.
#
# @param $1 The message to display.
# ---
echo_failure() {
    message="FAIL"
    [ ! -z "$1" ] && message="$1"; shift;

    echo -e $@ "\033[31;1m$message\033[0m"
}

# ---
# Displays a message and adds extra characters at the end until a specified
# string length is reached.
#
# @param $1 The message to display.
# @param $2 The character to add at the end.
# @param $3 The maximum string length.
# @param $4 The string to show after extra characters.
# ---
echo_pad() {
    local string=$1
    local char=$2
    local spaces=""
    local size=80
    local i=0

    [[ "$2" != "" ]] && char="$2"
    [[ "$3" != "" ]] && size=$3

    for (( i = 0; i < $size; i++ )); do
        spaces="$spaces$char"
    done

    echo -e -n "$string"
    printf '%*.*s' 0 $(($size - ${#string} )) "$spaces"
    echo -n -e "$4"
}

# ---
# Displays a warning message.
#
# @param $1 The message to display.
# ---
echo_success() {
    message="DONE"
    [ ! -z "$1" ] && message="$1"; shift;

    echo -e $@ "\E[32;1m$message\033[0m"
}

# ---
# Displays a warning message.
#
# @param $1 The message to display.
# ---
echo_warning() {
    message="SKIP"
    [ ! -z "$1" ] && message="$1"; shift;

    echo -e $@ "\033[33;1m$message\033[0m"
}

# ---
# Check if the application is already installed.
#
# @param $1 The path to the source.
# ---
is_installed() {
    [ -f $1 ] && return 0
    [ -d $1 ] && return 0
    [ -h $1 ] && return 0

    return 1
}

# ---
# Installs configurations.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_configs() {
    dotfiles=`ls src/config`

    echo_bold "==> Installing configs..."

    i=1
    total=$(echo "$dotfiles" | wc -w)

    for dotfile in $dotfiles; do
        sPath="src/config/$dotfile"
        tPath="$HOME/.config/$dotfile"

        echo_pad "$(printf "(%02d/%02d) Installing %s..." $i $total $dotfile)" "." 50

        is_installed $tPath && { echo_warning "SKIP" -n; echo_info " (INSTALLED)"; continue; }

        install_local $dotfile $sPath $tPath

        i=$(($i+1))
    done;
}

# ---
# Installs dotfiles.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_dotfiles() {
    dotfiles=`ls src --hide config`

    echo_bold "==> Installing dotfiles..."

    i=1
    total=$(echo "$dotfiles" | wc -w)

    for dotfile in $dotfiles; do
        sPath="$PWD/src/$dotfile"
        tPath="$HOME/.$dotfile"

        echo_pad "$(printf "(%02d/%02d) Installing %s..." $i $total $dotfile)" "." 50

        is_installed $tPath && { echo_warning "SKIP" -n; echo_info " (INSTALLED)"; continue; }

        install_local $dotfile $sPath $tPath

        i=$(($i+1))
    done;
}

# ---
# Installs $1 into $2 and executes post-install function, if exists.
#
# @param $1 The name of the item to install.
# @param $2 The source of the symlink.
# @param $3 The target of the symlink.
# ---
install_local() {
    ln -s $2 $3 > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo_failure && return;
    fi

    echo_success

    # Execute post_install function if exists
    name=$(echo $1 | sed -e "s/config\///g")
    type "post_install_$name" > /dev/null 2>&1 && post_install_$name
}

# ---
# Installs a library from a remote repository in $HOME or $HOME/.config.
#
# @param $1 The library to install.
# @param $2 The URL of the remote repository.
# @param $3 The target path to install the library to.
# ---
install_remote() {
    git clone $2 $3 > /dev/null 2>&1

    if [ $? -ne 0 ]; then
        echo -e "\E[31;5mFAIL\033[0m"
        return
    fi

    echo -e "\E[37;32mDONE\033[0m"
}

# ---
# Installs external applications.
#
# @param $1 The list of applications to install.
# @param $2 The list of applications to ignore.
# ---
install_tools() {
    tools="https://github.com/dhellmann/git-hooks https://github.com/tarjoilija/zgen"

    echo_bold "==> Installing tools..."

    i=1
    total=$(echo "$tools" | wc -w)

    for tool in $tools; do
        name=$(echo $tool | sed -e "s/.*\/\([^\/]\)/\1/g")
        tPath="$HOME/.config/$name"

        echo_pad "$(printf "(%02d/%02d) Installing %s..." $i $total $name)" "." 50

        is_installed $tPath && { echo_warning "SKIP" -n; echo_info " (INSTALLED)"; continue; }

        install_remote $name $tool $tPath

        i=$(($i+1))
    done;

}

# ---
# Executes post-installation commands after installing fonts.
# ---
post_install_fonts() {
    if [ -d $HOME/.fonts ]; then
        fc-cache -vf
    fi
}

# ---
# Executes post-installation commands after symlinking gitconfig file.
# ---
post_install_gitconfig() {
    if [ "`grep user $HOME/.gitconfig`" != "" ]; then
        return
    fi

    read -e -p "Do you want to add your credentials to your .gitconfig? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "  Name: " username
        read -e -p "  Email: " email

        echo "[user]" >> $HOME/.gitconfig
        echo "    name = " $username >> $HOME/.gitconfig
        echo "    email = " $email >> $HOME/.gitconfig
    fi
}

# ---
# Sets permissions for git_hooks after symlinking git_hooks folder.
# ---
post_install_githooks() {
    chmod -R 755 $HOME/.config/githooks
}

# ---
# Executes post-installation commands after symlinking muttrc file.
# ---
post_install_muttrc() {
    # Ask for user and email for mutt
    if [ "`grep -e '<email>' $HOME/.muttrc`" == "" ] \
            && [ "`grep -e '<email>' $HOME/.config/mutt/mapping`" == "" ]; then
        return
    fi

    read -e -p "Do you want to add your email to your .muttrc? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p "  Account: " account
        read -e -p "  Email: " email

        sed --follow-symlinks -i -e "s/<account>/$account/g" $HOME/.muttrc
        sed --follow-symlinks -i -e "s/<email>/$email/g"     $HOME/.muttrc
        sed --follow-symlinks -i -e "s/<email>/$email/g"     $HOME/.config/mutt/mapping
    fi
}

# ---
# Executes post-installation commands after symlinking basic vim configuration.
# ---
post_install_nvim() {
    # Custom links for vim
    if [ ! -d $HOME/.vim ]; then
        echo "  Installing $HOME/.vim..."
        ln -s $HOME/.config/nvim $HOME/.vim
    fi

    if [ ! -f $HOME/.vimrc ]; then
        echo "  Installing $HOME/.config/nvim/init.vim..."
        ln -s $HOME/.config/nvim/init.vim $HOME/.vimrc
    fi

    # Install vim-plug
    if [ ! -f $HOME/.config/nvim/autoload/plug.vim ]; then
        curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install neovim plugins
    if type /usr/bin/nvim > /dev/null 2>&1; then
        echo "  Installing neovim plugins..."
        /usr/bin/nvim -c PlugInstall -c q -c q
    fi

    # Install vim plugins
    echo "  Installing vim plugins..."
    if type /usr/bin/vim > /dev/null 2>&1; then
        /usr/bin/vim -c PlugInstall -c q -c q
    fi
}

# ---
# Executes post-installation commands after symlinking offlineimaprc file.
# ---
post_install_offlineimaprc() {
    if [ "`grep -e '<email>' $HOME/.offlineimaprc`" == "" ]; then
        return
    fi

    read -e -p "Do you want to add your email to your .offlineimaprc? (Y/n) " q

    if [ "$q" == "Y" ] || [ "$q" == "y" ] || [ "$q" == "" ]; then
        read -e -p " Account: " account
        read -e -p " Email: " email
        read -s -e -p " Password: " password

        sed --follow-symlinks -i -e "s/<account>/$account/g"   $HOME/.offlineimaprc
        sed --follow-symlinks -i -e "s/<email>/$email/g"       $HOME/.offlineimaprc
        sed --follow-symlinks -i -e "s/<password>/$password/g" $HOME/.offlineimaprc
    fi
}

main() {
    configs=true
    dotfiles=true
    tools=true
    ignore=false
    ignoring=false
    toinstall=""
    toignore=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h | --help )        usage ;;

            -d | --no-dotfiles ) ignoring=false; dotfiles=false ;;

            -i | --ignore )      ignoring=true ;;
            --ignore=*    )      toignore=`echo $1 | sed -e "s/--ignore=//g"` ;;

            -t | --no-tools )    ignoring=false; tools=false ;;

            -*)                  usage "Unknown option '$1'" ;;
            * )                  usage "Invalid argument '$1'" ;;
        esac

        shift;
    done

    [ $dotfiles == true ] && install_dotfiles "$toinstall" "$toignore"
    [ $configs == true ]  && install_configs  "$toinstall" "$toignore"
    [ $tools == true ]    && install_tools    "$toinstall" "$toignore"
}

# ---
# Displays the command help and an error message if parameter provided.
#
# @param $1 The error message.
# ---
usage() {
    if [ "$*" != "" ] ; then
        echo -e "\E[31;5minstall.sh: $*\033[0m"
        echo "";
    fi

    echo "Usage: install.sh [OPTION]"
    echo "Installs all dotfiles and tools or the list of selected tools"
    echo ""
    echo "  -c, --no-configs     The script does not install configurations"
    echo "  -d, --no-dotfiles    The script does not install dotfiles"
    echo "  -t, --no-tools       The script does not install tools"

    exit 0;
}

main "$@"
