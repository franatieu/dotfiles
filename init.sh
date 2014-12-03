#!/bin/bash

tput sgr0; echo '...'
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile;
tput setaf 2; echo '.bash_profile done'

tput sgr0; echo '...'
ln -sf ~/dotfiles/.bashrc ~/.bashrc;
tput setaf 2; echo '.bashrc done'

tput sgr0; echo '...'
if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings ]; then
    tput setaf 1; echo "Install sublime text 3 to get generic sublime preferences settings from dotfiles"
else
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings;
  ln -s ~/dotfiles/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  tput setaf 2; echo 'Sublime Text 3 preferences done'
  sudo ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl
  tput setaf 2; echo 'subl alias has been added to sublime'
fi

tput sgr0; echo '...'
if [ ! -f /Applications/MAMP/bin/php/php5.6.2/bin/php ]; then
    tput setaf 1; echo "Install MAMP because it's the best evar"
else
  sudo cp -f /Applications/MAMP/bin/php/php5.6.2/bin/php /usr/bin/php
  tput setaf 2; echo 'MAMP is installed'
  tput setaf 2; echo 'php alias has been modified'
fi

tput sgr0; echo '...'
if [ ! -f /usr/bin/git ]; then
    tput setaf 1; echo 'Install GIT now'
else
  tput setaf 2; echo 'Git is installed'
fi

tput sgr0; echo '...'
if [ ! -f /usr/bin/composer ]; then
    tput setaf 1; echo 'Composer is not installed'
else
    tput setaf 2; echo 'Composer is installed'
fi

tput sgr0; echo '...'
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    tput setaf 1; echo 'No SSH key found. You should generate a ssh key for security reason.'
else
    tput setaf 2; echo 'SSH key found'
fi
tput sgr0; echo '...'
