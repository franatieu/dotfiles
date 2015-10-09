# ---------------------------------------------------------------------
# Same PATH
# ---------------------------------------------------------------------
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/Master/bin:~/.composer/vendor/bin
export HOMEBREW_CASK_OPTS="--appdir=/Applications --caskroom=/etc/Caskroom"

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
alias gpldm='git push live dev:master'
alias gplm='git push live master'
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
alias sourcebash='source ~/.bash_profile'
alias editbash='sudo nano ~/.bash_profile'
alias dotfiles='cd ~/dotfiles'
alias projects='cd ~/projects/'
alias ..='cd ..'
alias la='ls -als'
alias edit='subl'
alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias rmr='sudo rm -R'
alias flushdns='sudo discoveryutil mdnsflushcache; sudo discoveryutil udnsflushcaches'
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
alias composer='sudo composer'
alias composerinstall='composer install --prefer-dist'
alias nano='sudo nano'
alias npm='sudo npm'
alias sleepnow='pmset sleepnow'
alias bed='sleepnow'
alias tower='gittower'

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
sass_example() {
  echo 'sass --watch dev/scss/main.scss:dev/css/main.min.css --style compressed';
}
php_server() {
  PHP=$(which php)
  HOST=localhost
  read -e -p "Port:" -i "5000" PORT
  read -e -p "Root:" -i $PWD DOCROOT
  $PHP -S $HOST:$PORT -t $DOCROOT
}
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
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
# Misc
# ---------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
