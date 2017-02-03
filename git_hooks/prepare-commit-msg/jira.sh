#!/bin/bash

# This hook checks if the current branch includes a JIRA issue in its name and
# adds it to the commit message.

id=`git rev-parse --abbrev-ref HEAD | grep -e "^\(feature\|hotfix\)\{1\}" | sed "s/\(feature\|hotfix\)\///g"`

if [[ "$id" != "" ]]; then
    sed -i "1s/^/$id:/" $1
fi;
