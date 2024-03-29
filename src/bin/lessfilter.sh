#!/bin/sh

case "$1" in
    *.awk|*.groff|*.java|*.js|*.m4|*.php|*.pl|*.pm|*.pod|*.sh|\
    *.ad[asb]|*.asm|*.inc|*.[ch]|*.[ch]pp|*.[ch]xx|*.cc|*.hh|\
    *.lsp|*.l|*.pas|*.p|*.xml|*.xps|*.xsl|*.axp|*.ppd|*.pov|\
    *.diff|*.patch|*.py|*.rb|*.sql|*.ebuild|*.eclass)
        pygmentize "$1";;

    *.json)
        cat "$1" | json_reformat | pygmentize -l json;;

    .aliases|.bashrc|.bash_environment|.zshrc)
        pygmentize -l sh "$1" ;;

    *)
        grep "#\!/bin/bash" "$1" > /dev/null
        if [ "$?" -eq "0" ]; then
            pygmentize -l sh "$1"
        else
            exit 1
        fi
esac

exit 0
