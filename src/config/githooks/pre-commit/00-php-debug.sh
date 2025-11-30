#!/bin/bash

# This hook checks debug messages in staged PHP files and aborts the action
# when one or more debug messages are found.

staged=$(git diff --diff-filter=AM --cached --name-only | grep "\.php$")

# Nothing to do
if [[ $staged = '' ]]; then
    exit 0
fi

echo -e -n "\033[1m==> Checking debug messages in staged PHP files..........\033[0m"

pattern="^\s*var_dump"

files=()
counter=0
for file in $staged; do
    if [[ -f $file && $(rg $pattern $file) != '' ]]; then
        counter=$((counter + 1))
        files+=($file)
    fi
done

if [[ $counter = 0 ]]; then
    echo -e "\E[37;32mDONE\033[0m"
    exit 0
fi

echo -e "\E[31mFAIL\033[0m"
echo -e "\E[93mDebug messages found in:\033[0m"

for file in "${files[@]}"; do
    echo -e " - \E[34;5m$file\033[0m"
done;

echo -e "\033[1m\E[47;41mABORTING ACTION\033[0m"
exit -1
