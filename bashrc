#!/bin/bash

# #######################################################
# Bashrc file that takes care of my settings independent
#   of macos oder linux (WSL)
# When editing this file, you may watch for results using
#   echo bashrc | entr ./bashrc 
# #######################################################

# Get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# Get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

# Set Terminal to color mode and special handling of git repos
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\`parse_git_branch\`\$ "

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Find directory of current script independent of PWD
# Taken from https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

# Add user bin (independent of os stuff) to path
export PATH=$PATH:$HOME/bin:$DIR/bin


# Check arch and add os dependent stuff to PATH
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Linux-gnu detected"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=$PATH:$DIR/bin_mac 
    . env_go_path_set.sh
elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo "Cygwin detected"
elif [[ "$OSTYPE" == "msys" ]]; then
    echo "MinGW/MSYS detected"
elif [[ "$OSTYPE" == "win32" ]]; then
    echo "Windows detected - should not happen..."
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "FreeBSD detected"
else
    echo "ERROR: Detected OSTYPE ${OSTYPE}"
fi

# Set the local proxy environment. No case yet for not setting the proxy, sadly.
. $HOME/bin/env_proxy_set.sh

# Finishing with a lesson learned from the cow in some random cases, e.g. 33%.
# In some other cases, output system specs using neofetch (e.g. 33%).
RAND=$(( ${RANDOM}%3 ))
if [ $RAND -eq 0 ]; then 
	if [ -x "$(command -v fortune)" ] && [ -x "$(command -v cowsay)" ] && [ -x "$(command -v lolcat)" ]; then
  		fortune | cowsay | lolcat
	else
		echo 'Error: One of more of fortune, cowsay or lolcat is not installed.' >&2
	fi
elif [ $RAND -eq 1 ]; then
	if [ -x "$(command -v neofetch)" ]; then
  		neofetch
	else
		echo 'Error: neofetch is not installed.' >&2
	fi
fi
