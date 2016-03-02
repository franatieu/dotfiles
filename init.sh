#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "..."
echo -e "Checking finder showing hidden files..."
defaults write com.apple.finder AppleShowAllFiles YES
echo -e "${GREEN}Showing hidden files done${NC}"

echo -e "..."
echo -e "Checking .bash_profile..."
sleep 1
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile;
echo -e "${GREEN}.bash_profile link done${NC}"

echo -e "..."
echo -e "Checking .gitconfig..."
sleep 1
rm -rf ~/dotfiles/.gitconfig
rm -rf ~/.gitconfig
cp .gitconfig_default .gitconfig
read -e -p "Please enter your desired git name: " GITNAME
read -e -p "Please enter your git email: " GITEMAIL
while read a ; do echo ${a//:name/$GITNAME} ; done < .gitconfig > .gitconfig.t ; mv .gitconfig{.t,}
while read a ; do echo ${a//:email/$GITEMAIL} ; done < .gitconfig > .gitconfig.t ; mv .gitconfig{.t,}
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig;
echo -e "${GREEN}.gitconfig link done${NC}"

echo -e "..."
echo -e "Checking .bashrc..."
sleep 1
ln -sf ~/dotfiles/.bashrc ~/.bashrc;
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
LATESTPHP=$(ls -t /Applications/MAMP/bin/php/ | sed -n 2p)
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

sshfiles() {
  source .bash_history
  rm -rf ~/.ssh/known_hosts
  rm -rf ~/.ssh/authorized_keys
  echo "" > ~/.ssh/known_hosts
  echo $init > ~/.ssh/authorized_keys
}

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
  mv temp_key.pub ~/.ssh/id_rs.pub
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
  echo -e "======================================================================"
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
  echo -e "======================================================================"
  echo -e "${GREEN}Composer installation done${NC}"
else
  echo -e "${GREEN}Composer is installed${NC}"
  if [ ! -f /usr/local/bin/composer ]; then
    echo -e "${RED}Composer is installed as root and shouldn't be${NC}"
    echo -e "======================================================================"
    sleep 1
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
    echo -e "======================================================================"
    echo -e "${GREEN}Composer installation done${NC}"
  fi
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

  sleep 1

  echo -e "Installing Atom packages..."
  while read p; do
    apm install $p
  done < ~/.atom/packages.txt
  echo -e "${GREEN}Atom packages installation done${NC}"
fi

echo -e "..."
#sudo chown -R $(whoami)
# echo -e "..."
# if [ ! -f ~/.ssh/id_rsa.pub ]; then
#  echo -e "No SSH key found."
#  echo -e "Generating..."
#  echo -e "Please enter your email address:"
#  read -e GITEMAIL
#  ssh-keygen -t rsa -C $GITEMAIL
#  echo -e "."
# else
#  echo -e "SSH key found"
# fi

# echo -e "..."
# if ! command -v "rvm" >/dev/null; then
#   echo -e "rvm is not installed"
#   echo -e "installing..."
#   echo -e "."
#   \curl -sSL https://get.rvm.io | bash -s stable --ruby
#   echo -e "."
# else
#   echo -e "rvm is installed"
# fi

# echo -e "..."
# if ! command -v "brew" > /dev/null; then
#   echo -e "Homebrew is not installed"
#   echo -e "Installing..."
#   echo -e "."
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#   echo -e "."
# else
#   echo -e "Homebrew is installed"
# fi

# echo -e "..."
# if ! command -v "wget" > /dev/null; then
#   echo -e "wget is not installed"
#   echo -e "Installing..."
#   echo -e "."
#   brew install wget
#   echo -e "."
# else
#   echo -e "wget is installed"
# fi

# echo -e "..."
# if command -v "brew cask" >/dev/null 2>&1; then
#   echo -e "Homebrew cask is not installed"
#   echo -e "Installing..."
#   echo -e "."
#   brew install caskroom/cask/brew-cask
#   echo -e "."
# else
#   echo -e "Homebrew cask is installed"
# fi

# echo -e "..."
# if ! command -v "bower" > /dev/null; then
#   echo -e "Bower not installed"
#   echo -e "Installing..."
#   echo -e "."
#   sudo npm install -g bower
#   echo -e "."
# else
#     echo -e "Bower is installed"
# fi

# echo -e "..."
# if ! command -v "bower-installer" >/dev/null; then
#   echo -e "bower-installer is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo npm install -g bower-installer
#   echo -e "."
# else
#   echo -e "bower-installer is installed"
# fi

# echo -e "..."
# if ! command -v "mongod" >/dev/null; then
#   echo -e "mongodb is not installed"
#   echo -e "installing..."
#   echo -e "."
#   brew install mongodb
#   sudo mkdir -p /data/db
#   echo -e "."
# else
#   echo -e "mongod is installed"
# fi

# echo -e "..."
# if ! command -v "gulp" >/dev/null; then
#   echo -e "gulp is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo npm install --global gulp
#   echo -e "."
# else
#   echo -e "gulp is installed"
# fi

# echo -e "..."
# if ! command -v "nodemon" >/dev/null; then
#   echo -e "nodemon is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo npm install -g nodemon
#   echo -e "."
# else
#   echo -e "nodemon is installed"
# fi

# echo -e "..."
# if ! command -v "sass" >/dev/null; then
#   echo -e "sass is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo gem install sass
#   echo -e "."
# else
#   echo -e "sass is installed"
# fi

# echo -e "..."
# if ! command -v "bundler" >/dev/null; then
#   echo -e "bundler is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo gem install bundler
#   echo -e "."
# else
#   echo -e "bundler is installed"
# fi

# echo -e "..."
# if ! command -v "middleman" >/dev/null; then
#   echo -e "middleman is not installed"
#   echo -e "installing..."
#   echo -e "."
#   sudo gem install middleman
#   echo -e "."
# else
#   echo -e "middleman is installed"
# fi
