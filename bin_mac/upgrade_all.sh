#!/bin/bash

echo "Checking password expiry"
~/bin/db_accountpw.secret.sh

echo "BREW update"
brew update
brew upgrade

echo "BREW CASK upgrade"
brew cask upgrade

echo "BREW cleaning"
brew cleanup --prune=all
brew doctor

echo "NPM upgrade"
npm upgrade -g
npm doctor

echo "PIP upgrade"
for i in  $(pip list --outdated --format=columns |tail -n +3|cut -d" " -f1); do pip install $i --upgrade; done

echo "PIP3 upgrade"
for i in  $(pip3 list --outdated --format=columns |tail -n +3|cut -d" " -f1); do pip3 install $i --upgrade; done

echo "tldr; update"
tldr --update
