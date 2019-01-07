#!/bin/bash

echo "BREW update"
brew update
brew upgrade

echo "BREW CASK upgrade"
brew cask upgrade

echo "NPM upgrade"
npm update

echo "PIP upgrade"
for i in  $(pip list --outdated --format=columns |tail -n +3|cut -d" " -f1); do pip install $i --upgrade; done

