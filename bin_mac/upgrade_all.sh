#!/bin/bash

echo "BREW update"
brew update
brew upgrade

echo "BREW CASK upgrade"
brew cask upgrade
brew cleanup

echo "NPM upgrade"
npm upgrade -g

echo "PIP upgrade"
for i in  $(pip list --outdated --format=columns |tail -n +3|cut -d" " -f1); do pip install $i --upgrade; done

