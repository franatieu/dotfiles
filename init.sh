#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

source src/functions

echo -e "..."
echo -e "Checking finder showing hidden files..."
defaults write com.apple.finder AppleShowAllFiles YES
echo -e "${GREEN}Showing hidden files done${NC}"

echo -e "..."
echo -e "Checking .zshrc..."
sleep 1
ln -sf ~/dotfiles/src/.zshrc ~/.zshrc;
mkdir -p /usr/local/bin;
echo -e "${GREEN}.zshrc link done${NC}"

echo -e "..."
echo -e "Checking .gitconfig..."
sleep 1
if [ ! -f ~/.gitconfig ]; then
  echo -e "${RED}.gitconfig is missing${NC}"
  echo -e "Creating .gitconfig..."
  creategitconfig
else
  read -r -p "Do you want to overwrite your .gitconfig? [y/N] " OVERWRITEGIT
  case $OVERWRITEGIT in
    [yY][eE][sS]|[yY])
      echo -e "Recreating .gitconfig..."
      creategitconfig
      ;;
    *)
      echo -e "${GREEN}.gitconfig skipped${NC}"
      ;;
  esac
fi

echo -e "..."
echo -e "Checking projects folder..."
sleep 1
if [ ! -d ~/Projects ]; then
  echo -e "${RED}Projects folder is missing${NC}"
  echo -e "Creating Projects folder..."
  mkdir ~/Projects
  echo -e "${GREEN}Projects folder done${NC}"
else
  echo -e "${GREEN}Projects folder already exists${NC}"
fi

echo -e "..."
echo -e "Checking git..."
sleep 1
if ! command -v "git" > /dev/null; then
  echo -e "${RED}Git is not installed${NC}"
else
  echo -e "${GREEN}Git is installed${NC}"
fi

echo -e "..."
echo -e "Checking «ren» command..."
sleep 1
if ! command -v "ren" > /dev/null; then
  echo -e "${RED}Ren is not installed${NC}"
  ln -sf ~/dotfiles/libs/ren /usr/local/bin/ren
  echo -e "${GREEN}Ren installation done${NC}"
else
  echo -e "${GREEN}Ren is installed${NC}"
fi

echo -e "..."
echo -e "Checking brew..."
sleep 1
if ! command -v "brew" > /dev/null; then
  echo -e "${RED}Brew is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo -e "====================================================================="
  echo -e "${GREEN}Brew installation done${NC}"
else
  echo -e "${GREEN}Brew already installed${NC}"
fi

echo -e "..."
echo -e "Checking node and npm..."
sleep 1
if ! command -v "npm" > /dev/null; then
  echo -e "${RED}Node is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install node
  echo -e "====================================================================="
  echo -e "${GREEN}Node installation done${NC}"
else
  echo -e "${GREEN}Node already installed${NC}"
fi

echo -e "..."
echo -e "Checking gulp..."
sleep 1
if ! command -v "gulp" > /dev/null; then
  echo -e "${RED}Gulp is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  sudo chown $USER /usr/local/lib/node_modules
  npm install gulp-cli -g
  echo -e "====================================================================="
  echo -e "${GREEN}Gulp installation done${NC}"
else
  echo -e "${GREEN}Gulp already installed${NC}"
fi

echo -e "..."
echo -e "Checking bash version..."
sleep 1
echo -e "${RED}Cannot verify bash version${NC}"
echo -e "Updating..."
echo -e "====================================================================="
brew install bash
chsh -s /usr/local/bin/bash
echo -e "====================================================================="
echo -e "${GREEN}Bash update done${NC}"

echo -e "..."
echo -e "Checking ghostscript..."
sleep 1
if ! command -v "ghostscript" > /dev/null; then
  echo -e "${RED}Ghostscript is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install ghostscript
  echo -e "====================================================================="
  echo -e "${GREEN}Ghostcript installation done${NC}"
else
  echo -e "${GREEN}Ghostcript already installed${NC}"
fi

echo -e "..."
echo -e "Checking wget..."
sleep 1
if ! command -v "wget" > /dev/null; then
  echo -e "${RED}wget is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install wget
  echo -e "====================================================================="
  echo -e "${GREEN}wget installation done${NC}"
else
  echo -e "${GREEN}wget already installed${NC}"
fi

echo -e "..."
echo -e "Checking phpunit..."
sleep 1
if ! command -v "phpunit" > /dev/null; then
  echo -e "${RED}phpunit is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  rm -rf /usr/local/bin/phpunit
  wget https://phar.phpunit.de/phpunit.phar
  chmod +x phpunit.phar
  mv phpunit.phar /usr/local/bin/phpunit
  echo -e "====================================================================="
  echo -e "${GREEN}phpunit installation done${NC}"
else
  echo -e "${GREEN}phpunit already installed${NC}"
fi

echo -e "..."
echo -e "Checking cask..."
sleep 1
if ! brew info cask &>/dev/null; then
  echo -e "${RED}Cask is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew tap caskroom/cask
  echo -e "====================================================================="
  echo -e "${GREEN}Cask installation done${NC}"
else
  echo -e "${GREEN}Cask already installed${NC}"
fi

echo -e "..."
echo -e "Checking mongodb..."
sleep 1
if ! command -v "mongo" > /dev/null; then
  echo -e "${RED}Mongodb is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install mongodb
  sleep 1
  brew tap mongodb/brew
  sudo mkdir -p /usr/local/var/mongodb/data/db
  sudo chown $USER /usr/local/var/mongodb/data/db
  sleep 1
  brew install mongodb-community@4.4
  echo -e "====================================================================="
  echo -e "${GREEN}Mongodb installation done${NC}"
else
  echo -e "${GREEN}Mongodb already installed${NC}"
fi

echo -e "..."
echo -e "Checking ssh keys"
sleep 1
if [ ! -d ~/.ssh ]; then
  echo -e "${RED}SSH folder is missing${NC}"
  echo -e "Creating SSH folder..."
  mkdir ~/.ssh
  echo -e "${GREEN}SSH folder done${NC}"
else
  echo -e "${GREEN}SSH folder already exists${NC}"
fi
sleep 2

if [ ! -f ~/.ssh/id_rsa.pub ]; then
  echo -e "${RED}SSH file is missing${NC}"
  echo -e "Generating..."
  ssh-keygen -t rsa
  sshfiles
  cp ~/dotfiles/src/ssh_config ~/.ssh/config
  echo -e "${GREEN}SSH file done${NC}"
else
  echo -e "${GREEN}SSH file already exists${NC}"
fi

echo -e "..."
echo -e "Checking php..."
sleep 1
if ! command -v "php" > /dev/null; then
  echo -e "${RED}Php is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install php
  echo -e "====================================================================="
  echo -e "${GREEN}php installation done${NC}"
else
  echo -e "${GREEN}php already installed${NC}"
fi

echo -e "..."
echo -e "Checking composer..."
sleep 1
if ! command -v "composer" > /dev/null; then
  echo -e "${RED}Composer is not installed${NC}"
  echo -e "====================================================================="
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  sudo chown $USER /usr/local/bin/composer
  echo -e "====================================================================="
  echo -e "${GREEN}Composer installation done${NC}"
else
  echo -e "${GREEN}Composer is installed${NC}"
  if [ ! -f /usr/local/bin/composer ]; then
    echo -e "${RED}Composer is installed as root and shouldn't be${NC}"
    echo -e "====================================================================="
    sleep 1
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
    echo -e "====================================================================="
    echo -e "${GREEN}Composer installation done${NC}"
  fi
fi

if [ ! -d ~/.composer ]; then
  echo -e "${RED}composer folder is missing${NC}"
  echo -e "Creating composer folder..."
  mkdir ~/.composer
  echo -e "${GREEN}composer folder done${NC}"
else
  sudo chown $USER ~/.composer
fi

read -r -p "Want laravel valet instead of MAMP? [y/N] " INSTALLVALET
case $INSTALLVALET in
  [yY][eE][sS]|[yY])
    echo -e "${GREEN}Good choice${NC}"
    echo -e "${GREEN}Installing valet${NC}"
    composer global require laravel/valet
    sleep 1
    valet install
    sleep 1
    valet tld loc
    sleep 1
    valet use php@7.4
    sleep 1
    composer global update
    sleep 1
    brew install mysql@5.7
    sleep 1
    brew services start mysql@5.7
    ;;
  *)
    echo -e "${RED}lol...${NC}"
    ;;
esac

echo -e "..."
echo -e "Checking pyenv..."
sleep 1
if ! command -v "pyenv" > /dev/null; then
  echo -e "${RED}pyenv is not installed${NC}"
  echo -e "====================================================================="
  brew install pyenv
  echo -e "====================================================================="
  echo -e "${GREEN}pyenv installation done${NC}"
else
  echo -e "${GREEN}pyenv is installed${NC}"
fi

echo -e "..."
echo -e "Checking Sublime Text..."
sleep 1
if [ ! -e /Applications/Sublime\ Text.app ]; then
  echo -e "${RED}Sublime Text is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask sublime-text
  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
  ln -sf ~/dotfiles/src/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
  echo -e "====================================================================="
  echo -e "${GREEN}Sublime Text installation done${NC}"
else
  echo -e "${GREEN}Sublime Text is installed${NC}"
fi

echo -e "..."
echo -e "Checking AppCleaner..."
sleep 1
if [ ! -e /Applications/AppCleaner.app ]; then
  echo -e "${RED}AppCleaner is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask appcleaner
  echo -e "====================================================================="
  echo -e "${GREEN}AppCleaner installation done${NC}"
else
  echo -e "${GREEN}AppCleaner is installed${NC}"
fi

echo -e "..."
echo -e "Checking ImageOptim..."
sleep 1
if [ ! -e /Applications/ImageOptim.app ]; then
  echo -e "${RED}ImageOptim is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask imageoptim
  echo -e "====================================================================="
  echo -e "${GREEN}ImageOptim installation done${NC}"
else
  echo -e "${GREEN}ImageOptim is installed${NC}"
fi

echo -e "..."
echo -e "Checking Spotify..."
sleep 1
if [ ! -e /Applications/Spotify.app ]; then
  echo -e "${RED}Spotify is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask spotify
  echo -e "====================================================================="
  echo -e "${GREEN}Spotify installation done${NC}"
else
  echo -e "${GREEN}Spotify is installed${NC}"
fi

echo -e "..."
echo -e "Checking Teamviewer..."
sleep 1
if [ ! -e /Applications/Teamviewer.app ]; then
  echo -e "${RED}Teamviewer is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask teamviewer
  echo -e "====================================================================="
  echo -e "${GREEN}Teamviewer installation done${NC}"
else
  echo -e "${GREEN}Teamviewer is installed${NC}"
fi

echo -e "..."
echo -e "Checking The Unarchiver..."
sleep 1
if [ ! -e /Applications/The\ Unarchiver.app ]; then
  echo -e "${RED}The Unarchiver is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask the-unarchiver
  echo -e "====================================================================="
  echo -e "${GREEN}The Unarchiver installation done${NC}"
else
  echo -e "${GREEN}The Unarchiver is installed${NC}"
fi

echo -e "..."
echo -e "Checking VLC..."
sleep 1
if [ ! -e /Applications/VLC.app ]; then
  echo -e "${RED}VLC is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask vlc
  echo -e "====================================================================="
  echo -e "${GREEN}VLC installation done${NC}"
else
  echo -e "${GREEN}VLC is installed${NC}"
fi

echo -e "..."
echo -e "Checking Sequel Pro..."
sleep 1
if [ ! -e /Applications/Sequel\ Pro.app ]; then
  echo -e "${RED}Sequel Pro is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew install --cask sequel-pro
  echo -e "====================================================================="
  echo -e "${GREEN}Sequel Pro installation done${NC}"
else
  echo -e "${GREEN}Sequel Pro is installed${NC}"
fi
