# ---------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------
alias gs='git status;'
alias gc='git add -A; git commit -a;'
alias gcm='git commit -m'
alias ga='git add -A;'
alias gp='git push;'
alias gch="git checkout"
alias gm="git merge --no-ff"
alias gb='git branch -a'
alias gfr='git fetch; git rebase;'
alias gf='git fetch'
alias gr='git rebase'
alias gl='git log --abbrev-commit;'
alias gd='git diff'
alias gdc='git diff --cached'
alias gsi='git submodule init; git submodule update'
alias gsu='git submodule sync; git submodule update'
alias gss='git submodule sync'
alias grh='git reset --hard'

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
dot_sublime_preferences() {
  sudo rm -R ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings;
  ln -s ~/.preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User/Preferences.sublime-settings
}
apply_nanorc() {
  sudo mkdir /usr/local/share/nano;
  sudo rm -R /usr/local/share/nano/*;
  sudo ln -s ~/nanorc/* /usr/local/share/nano/;
  sudo cat /dev/null > ~/.nanorc;
  for file in /usr/local/share/nano/*
  do
    echo "include \"$file\";" >> ~/.nanorc;
  done
}

# ---------------------------------------------------------------------
# Path
# ---------------------------------------------------------------------
export PATH=/usr/local/php5/bin:$PATH

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




