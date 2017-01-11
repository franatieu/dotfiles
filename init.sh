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
echo -e "Checking .bash_profile..."
sleep 1
ln -sf ~/dotfiles/src/.bash_profile ~/.bash_profile;
echo -e "${GREEN}.bash_profile link done${NC}"

echo -e "..."
echo -e "Checking .gitconfig..."
sleep 1
if [ ! -f ~/dotfiles/src/.gitconfig ]; then
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
echo -e "Checking .bashrc..."
sleep 1
ln -sf ~/dotfiles/src/.bashrc ~/.bashrc;
echo -e "${GREEN}.bashrc link done${NC}"

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
echo -e "Checking php..."
sleep 1
LATESTPHP=$(ls -t /Applications/MAMP/bin/php/ | sed -n 1p)
if [ ! -f /Applications/MAMP/bin/php/$LATESTPHP/bin/php ]; then
  echo -e "${RED}MAMP Pro is not installed${NC}"
else
  ln -sf /Applications/MAMP/bin/php/$LATESTPHP/bin/php /usr/local/bin/php
  echo -e "${GREEN}MAMP is installed${NC}"
  echo -e "${GREEN}$LATESTPHP link done${NC}"
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
  npm install gulp-cli -g
  echo -e "====================================================================="
  echo -e "${GREEN}Gulp installation done${NC}"
else
  echo -e "${GREEN}Gulp already installed${NC}"
fi

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
echo -e "Checking Atom..."
sleep 1
if [ ! -e /Applications/Atom.app ]; then
  echo -e "${RED}Atom is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install atom
  ln -sf ~/dotfiles/.atom/config.cson ~/.atom/config.cson
  ln -sf ~/dotfiles/.atom/init.coffee ~/.atom/init.coffee
  ln -sf ~/dotfiles/.atom/keymap.cson ~/.atom/keymap.cson
  ln -sf ~/dotfiles/.atom/snippets.cson ~/.atom/snippets.cson
  ln -sf ~/dotfiles/.atom/projects.cson ~/.atom/projects.cson
  ln -sf ~/dotfiles/.atom/styles.less ~/.atom/styles.less
  echo -e "====================================================================="
  echo -e "${GREEN}Atom installation done${NC}"
else
  echo -e "${GREEN}Atom is installed${NC}"
fi

echo -e "..."
echo -e "Checking Atom configurations..."
sleep 1
echo -e "Configuring..."
echo -e "====================================================================="
ln -sf ~/dotfiles/.atom/config.cson ~/.atom/config.cson
ln -sf ~/dotfiles/.atom/init.coffee ~/.atom/init.coffee
ln -sf ~/dotfiles/.atom/keymap.cson ~/.atom/keymap.cson
ln -sf ~/dotfiles/.atom/snippets.cson ~/.atom/snippets.cson
ln -sf ~/dotfiles/.atom/projects.cson ~/.atom/projects.cson
ln -sf ~/dotfiles/.atom/styles.less ~/.atom/styles.less
while read p; do
  apm install $p
done < ~/dotfiles/.atom/packages.txt
echo -e "====================================================================="
echo -e "${GREEN}Atom configuration done${NC}"

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
  read -e -p "Please enter your desired SSH passphrase (leave blank for none): " sshpassphrase
  ssh-keygen -t rsa -N sshpassphrase -f temp_key
  mv temp_key ~/.ssh/id_rsa
  mv temp_key.pub ~/.ssh/id_rsa.pub
  echo -e "${GREEN}SSH file done${NC}"
else
  echo -e "${GREEN}SSH file already exists${NC}"
fi
sshfiles

echo -e "..."
echo -e "Checking composer..."
sleep 1
if ! command -v "composer" > /dev/null; then
  echo -e "${RED}Composer is not installed${NC}"
  echo -e "====================================================================="
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
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

echo -e "..."
echo -e "Checking Google Chrome..."
sleep 1
if [ ! -e /Applications/Google\ Chrome.app ]; then
  echo -e "${RED}Google Chrome is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install google-chrome
  echo -e "====================================================================="
  echo -e "${GREEN}Google Chrome installation done${NC}"
else
  echo -e "${GREEN}Google Chrome is installed${NC}"
fi

echo -e "..."
echo -e "Checking Firefox..."
sleep 1
if [ ! -e /Applications/Firefox.app ]; then
  echo -e "${RED}Firefox is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install firefox
  echo -e "====================================================================="
  echo -e "${GREEN}Firefox installation done${NC}"
else
  echo -e "${GREEN}Firefox is installed${NC}"
fi

echo -e "..."
echo -e "Checking AppCleaner..."
sleep 1
if [ ! -e /Applications/AppCleaner.app ]; then
  echo -e "${RED}AppCleaner is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install appcleaner
  echo -e "====================================================================="
  echo -e "${GREEN}AppCleaner installation done${NC}"
else
  echo -e "${GREEN}AppCleaner is installed${NC}"
fi

echo -e "..."
echo -e "Checking SizeUp..."
sleep 1
if [ ! -e /Applications/SizeUp.app ]; then
  echo -e "${RED}SizeUp is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install sizeup
  echo -e "====================================================================="
  echo -e "${GREEN}SizeUp installation done${NC}"
else
  echo -e "${GREEN}SizeUp is installed${NC}"
fi

echo -e "..."
echo -e "Checking ImageOptim..."
sleep 1
if [ ! -e /Applications/ImageOptim.app ]; then
  echo -e "${RED}ImageOptim is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install imageoptim
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
  brew cask install spotify
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
  brew cask install teamviewer
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
  brew cask install the-unarchiver
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
  brew cask install vlc
  echo -e "====================================================================="
  echo -e "${GREEN}VLC installation done${NC}"
else
  echo -e "${GREEN}VLC is installed${NC}"
fi

echo -e "..."
echo -e "Checking Steam..."
sleep 1
if [ ! -e /Applications/Steam.app ]; then
  echo -e "${RED}Steam is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install steam
  echo -e "====================================================================="
  echo -e "${GREEN}Steam installation done${NC}"
else
  echo -e "${GREEN}Steam is installed${NC}"
fi

echo -e "..."
echo -e "Checking Battle.net..."
sleep 1
if [ ! -e /Applications/Battle.net.app ]; then
  echo -e "${RED}Battle.net is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install battle-net
  open ~/Casks/battle-net/latest/Battle.net-Setup.app
  echo -e "====================================================================="
  echo -e "${GREEN}Battle.net installation done${NC}"
else
  echo -e "${GREEN}Battle.net is installed${NC}"
fi

echo -e "..."
echo -e "Checking Filezilla..."
sleep 1
if [ ! -e /Applications/Filezilla.app ]; then
  echo -e "${RED}Filezilla is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install filezilla
  echo -e "====================================================================="
  echo -e "${GREEN}Filezilla installation done${NC}"
else
  echo -e "${GREEN}Filezilla is installed${NC}"
fi

echo -e "..."
echo -e "Checking Sequel Pro..."
sleep 1
if [ ! -e /Applications/Sequel\ Pro.app ]; then
  echo -e "${RED}Sequel Pro is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install sequel-pro
  echo -e "====================================================================="
  echo -e "${GREEN}Sequel Pro installation done${NC}"
else
  echo -e "${GREEN}Sequel Pro is installed${NC}"
fi

echo -e "..."
echo -e "Checking Adobe Reader..."
sleep 1
if [ ! -e /Applications/Adobe\ Acrobat\ Reader\ DC.app ]; then
  echo -e "${RED}Adobe Reader is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install adobe-reader
  echo -e "====================================================================="
  echo -e "${GREEN}Adobe Reader installation done${NC}"
else
  echo -e "${GREEN}Adobe Reader is installed${NC}"
fi

echo -e "..."
echo -e "Checking Handbrake..."
sleep 1
if [ ! -e /Applications/handbrake.app ]; then
  echo -e "${RED}Handbrake is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install handbrake
  echo -e "====================================================================="
  echo -e "${GREEN}Handbrake installation done${NC}"
else
  echo -e "${GREEN}Handbrake is installed${NC}"
fi

echo -e "..."
echo -e "Checking ExpressVPN..."
sleep 1
if [ ! -e /Applications/ExpressVPN.app ]; then
  echo -e "${RED}ExpressVPN is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install expressvpn
  echo -e "====================================================================="
  echo -e "${GREEN}ExpressVPN installation done${NC}"
else
  echo -e "${GREEN}ExpressVPN is installed${NC}"
fi
fi

echo -e "..."
echo -e "Checking uTorrent..."
sleep 1
if [ ! -e /Applications/uTorrent.app ]; then
  echo -e "${RED}uTorrent is not installed${NC}"
  echo -e "Installing..."
  echo -e "====================================================================="
  brew cask install utorrent
  open ~/Casks/utorrent/latest/uTorrent.app
  echo -e "====================================================================="
  echo -e "${GREEN}uTorrent installation done${NC}"
else
  echo -e "${GREEN}uTorrent is installed${NC}"
fi

echo -e "..."
echo -e "Checking Atom preferences..."
sleep 1
if [ ! -d /Applications/Atom.app ]; then
  echo -e "${RED}Atom is not installed${NC}"
else
  rm -rf ~/.atom
  ln -s ~/dotfiles/.atom ~/.atom
  echo -e "${GREEN}Atom configurations aliases done${NC}"
  sleep 2
  echo -e "Installing/updating Atom packages..."
  while read p; do
    apm install $p
  done < ~/.atom/packages.txt
  echo -e "${GREEN}Atom packages installation done${NC}"
fi
