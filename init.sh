#!/bin/bash

echo '...'
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile;
echo '.bash_profile link done'

echo '...'
ln -sf ~/dotfiles/.bashrc ~/.bashrc;
echo '.bashrc link done'

if ! type "brew" > /dev/null; then
  echo 'Homebrew is not installed'
  echo 'Installing...'
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo 'Homebrew is installed'
fi

if ! type "wget" > /dev/null; then
  echo 'wget is not installed'
  echo 'Installing...'
  brew install wget
else
  echo 'wget is installed'
fi

if command -v "brew cask" >/dev/null 2>&1; then
  echo 'Homebrew cask is not installed'
  echo 'Installing...'
  brew install caskroom/cask/brew-cask
else
  echo 'Homebrew cask is installed'
fi

echo '...'
if [ ! -f /Applications/Sublime\ Text.app ]; then
    echo "Sublime text 3 is not installed"
else
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings;
  ln -s ~/dotfiles/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  echo 'Sublime Text 3 preferences link done'
  sudo ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/bin/subl
  echo 'subl link done'
fi

echo '...'
if [ ! -f /Applications/MAMP/bin/php/php5.6.7/bin/php ]; then
    echo "MAMP Pro is not installed"
else
  sudo cp -f /Applications/MAMP/bin/php/php5.6.7/bin/php /usr/bin/php
  echo 'MAMP is installed'
  echo 'php 5.6.2 link done'
fi

echo '...'
if ! type "git" > /dev/null; then
    echo 'Git is not installed'
else
  echo 'Git is installed'
fi

echo '...'
if ! type "composer" > /dev/null; then
    echo 'Composer is not installed'
    echo 'Installing...'
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/bin/composer
else
    echo 'Composer is installed'
fi

echo '...'
if ! type "bower" > /dev/null; then
    echo 'Bower not installed'
    echo 'Installing...'
    sudo npm install -g bower
else
    echo 'Bower is installed'
fi

echo '...'
if [ ! -f ~/.ssh/id_rsa.pub ]; then
    echo 'No SSH key found.'
    echo 'Generating...'
    echo "Please enter your email address:" 
    read -e GITEMAIL
    ssh-keygen -t rsa -C $GITEMAIL
else
    echo 'SSH key found'
fi


echo '...'
