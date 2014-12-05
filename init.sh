#!/bin/bash

tput sgr0; echo '...'
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile;
tput setaf 2; echo '.bash_profile link done'

tput sgr0; echo '...'
ln -sf ~/dotfiles/.bashrc ~/.bashrc;
tput setaf 2; echo '.bashrc link done'

if which brew >/dev/null; then
  tput sgr1; echo 'Brew is not installed'
  tput sgr1; echo 'Installing...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  tput setaf 2; echo 'Brew is installed'
fi

if which wget --help >/dev/null; then
  tput sgr1; echo 'wget is not installed'
  tput sgr1; echo 'Installing...'
  brew install wget
else
  tput setaf 2; echo 'wget is installed'
fi

tput sgr0; echo '...'
if [ ! -f ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings ]; then
    tput setaf 1; echo "Sublime text 3 is not installed"
else
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings;
  ln -s ~/dotfiles/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  tput setaf 2; echo 'Sublime Text 3 preferences link done'
  sudo ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl
  tput setaf 2; echo 'subl link done'
fi

tput sgr0; echo '...'
if [ ! -f /Applications/MAMP/bin/php/php5.6.2/bin/php ]; then
    tput setaf 1; echo "MAMP Pro is not installed"
else
  sudo cp -f /Applications/MAMP/bin/php/php5.6.2/bin/php /usr/bin/php
  tput setaf 2; echo 'MAMP is installed'
  tput setaf 2; echo 'php 5.6.2 link done'
fi

tput sgr0; echo '...'
if which git >/dev/null; then
    tput setaf 1; echo 'Git is not installed'
else
  tput setaf 2; echo 'Git is installed'
fi

tput sgr0; echo '...'
if [ ! -f /usr/bin/composer ]; then
    tput setaf 1; echo 'Composer is not installed'
    tput setaf 1; echo 'Installing...'
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/bin/composer
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
