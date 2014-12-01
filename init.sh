#!/bin/bash

echo '...'
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile;
echo '.bash_profile done'

echo '...'
ln -sf ~/dotfiles/.bashrc ~/.bashrc;
echo '.bashrc done'

echo '...'
if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings ]; then
  echo "Install sublime text 3 to get generic sublime preferences settings from dotfiles"
else
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings;
  ln -s ~/dotfiles/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  echo 'Sublime Text 3 preferences done'
fi
echo '...'

