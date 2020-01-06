source ~/.profile
# ---------------------------------------------------------------------
# Welcome
# ---------------------------------------------------------------------
cat ~/dotfiles/src/welcome

# ---------------------------------------------------------------------
# Same PATH
# ---------------------------------------------------------------------
export PATH=/usr/local/bin/:~/.composer/vendor/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# ---------------------------------------------------------------------
# Git aliases
# ---------------------------------------------------------------------
# general
alias gs='git status'
alias gfr='git fetch; git rebase;'
alias gf='git fetch'
alias gr='git rebase'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grh='git reset --hard'
alias ggc='git gc'

# add
alias ga='git add'
alias gaa='git add -A .'

# commit
alias gc='git add -A; git commit -a;'
alias gcm='git commit -m'

# merge
alias gcp='git cherry-pick'
alias gm="git merge --no-ff"
alias gass='git update-index --assume-unchanged'
alias gassu='git update-index --no-assume-unchanged'
alias gassl='!git ls-files -v | grep ^h | cut -c 3-'

# log
alias gl='git log --abbrev-commit;'
alias grl='git reflog;'

# submodule
alias gsi='git submodule init; git submodule update'
alias gsu='git submodule sync; git submodule update'
alias gss='git submodule sync'

# push
alias gp='git push;'
alias gpu='git push -u'
alias gpuo='git push -u origin'
alias gphdm='git push heroku dev:master'
alias gphm='git push heroku master'
alias gplm='git push live master'
alias gpa='git push --all origin'

# branch
alias gch="git checkout"
alias gchb="git checkout -b"
alias gb="git branch"
alias gba='git branch -a'
alias gbd='git branch -D'

# stash
alias gsh='git stash'
alias gshp='git stash pop'

# tags
alias gpt='git push origin --tags'
alias gt='git tag'
alias gts='git tag show'
alias gta='git tag -a'

# diff
alias gd='git diff'
alias gdc='git diff --cached'

# ---------------------------------------------------------------------
# Other aliases
# ---------------------------------------------------------------------
alias ghostscript='/usr/local/bin/gs'
alias dotfiles='cd ~/dotfiles'
alias projects='cd ~/projects/'
alias ..='cd ..'
alias la='ls -Als'
alias edit='subl'
alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias rmr='sudo rm -R'
alias flushdns=' dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias composerinstall='composer install --prefer-dist'
alias ci='composer install'
alias cu='composer update'
alias cda='composer dump-autoload'
alias sleepnow='pmset sleepnow'
alias bed='sleepnow'
alias tower='gittower'
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete; find . -type f -name '*.LCK' -ls -delete; find . -name "_notes" -print0 | xargs -0 rm -rf;"
alias curlrest='curl -v -H "Accept: application/json" -H "Content-type: application/json" -X'

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
sass_example() {
  echo 'sass --watch dev/scss/main.scss:dev/css/main.min.css --style compressed';
}
php_server() {
  PHP=$(which php)
  HOST=localhost
  read -e -p "Port:" PORT
  PORT=${PORT:-5000}
  read -e -p "Root:" DOCROOT
  DOCROOT=${DOCROOT:-$PWD}
  $PHP -S $HOST:$PORT -t $DOCROOT
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
gtu() {
  read -e -p "Please enter the old tag name: " TAGOLD
  read -e -p "Please enter the new tag name: " TAGNEW

  git push origin $TAGOLD:$TAGNEW :$TAGOLD && git tag -d $TAGOLD
  gf
}
gtd() {
  read -e -p "Please enter the tag name to delete: " TAGNAME

  git tag -d $TAGNAME
  git push origin :refs/tags/$TAGNAME
}
gbD() {
  read -e -p "Please enter the branch name to delete: " BNAME

  git branch -D $BNAME
  git push origin --delete $BNAME
  git remote prune origin
}
switchphp() {
  la /Applications/MAMP/bin/php/
  read -e -p "Choose a PHP version: " PHPV
  ln -sf /Applications/MAMP/bin/php/$PHPV/bin/php /usr/local/bin/php
  php -v
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
autoload -U colors && colors
PS1="%{$fg[cyan]%}%n@%m%{$reset_color%} %{$fg[yellow]%}%~%{$reset_color%} %{$fg[green]%}$(parse_git_branch)%{$reset_color%} "
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
# Misc
# ---------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# PYENV
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
