#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters, first is title, second is notification, both as strings."
else
    # Solution from https://stackoverflow.com/questions/23923017/osascript-using-bash-variable-with-a-space
    osascript -e 'display notification "'"${2//\"/\\\"}"'" with title "'"${1//\"/\\\"}"'"'
fi
