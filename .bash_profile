# ---------------------------------------------------------------------
# Same PATH
# ---------------------------------------------------------------------
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/Master/bin

# ---------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------
alias gs='git status'
alias gc='git add -A; git commit -a;'
alias gcm='git commit -m'
alias ga='git add'
alias gaa='git add -a'
alias gp='git push;'
alias gpu='git push -u'
alias gch="git checkout"
alias gchb="git checkout -b"
alias gm="git merge --no-ff"
alias gb="git branch"
alias gba='git branch -a'
alias gsh='git stash'
alias gshp='git stash pop'
alias gfr='git fetch; git rebase;'
alias gf='git fetch'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias gl='git log --abbrev-commit;'
alias gd='git diff'
alias gdc='git diff --cached'
alias gsi='git submodule init; git submodule update'
alias gsu='git submodule sync; git submodule update'
alias gss='git submodule sync'
alias grh='git reset --hard'
alias sourcebash='source ~/.bash_profile'
alias editbash='sudo nano ~/.bash_profile'
alias cdprojects='cd ~/projects/'
alias sleepnow='pmset sleepnow'
alias bed='sleepnow'
alias ..='cd ..'

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
dot_sublime_preferences() {
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings;
  ln -s ~/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings
}
apply_nanorc() {
  if [ ! -f /usr/local/share ]
  then
    sudo mkdir /usr/local/share;
  fi
  if [ ! -f /usr/local/share/nano ]
  then
    sudo mkdir /usr/local/share/nano;
  fi
  if [ -f /usr/local/share/nano/* ]
  then
    sudo rm -R /usr/local/share/nano/*;
  fi
  sudo ln -s ~/nanorc/* /usr/local/share/nano/;
  sudo cat /dev/null > ~/.nanorc;
  for file in /usr/local/share/nano/*
  do
    echo "include \"$file\";" >> ~/.nanorc;
  done
}

# ---------------------------------------------------------------------
# Source local machine config
# ---------------------------------------------------------------------
if [ -f ~/.env ]; then
  source ~/.env
fi

# ---------------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------------
export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\] \[\033[32m\]\$(parse_git_branch)\[\033[m\] "
export CLICOLOR=1
export LSCOLORS=fxFxBxDxCxegedabagacad

# ---------------------------------------------------------------------
# Default Editor
# ---------------------------------------------------------------------
export EDITOR=/usr/bin/nano

# ---------------------------------------------------------------------
# Default Blocksize for ls etc.
# ---------------------------------------------------------------------
export BLOCKSIZE=1k

# ---------------------------------------------------------------------
# General aliases
# ---------------------------------------------------------------------
alias edit='subl'
alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias rmr='sudo rm -R'
alias flushDNS='dscacheutil -flushcache'
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
alias composer='sudo composer'
alias nano='sudo nano'




