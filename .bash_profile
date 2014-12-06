# ---------------------------------------------------------------------
# Same PATH
# ---------------------------------------------------------------------
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/Master/bin

# ---------------------------------------------------------------------
# Git
# ---------------------------------------------------------------------
alias gcp='git cherry-pick'
alias gs='git status'
alias gc='git add -A; git commit -a;'
alias gcm='git commit -m'
alias ga='git add'
alias gaa='git add -A .'
alias gp='git push;'
alias gpu='git push -u'
alias gpuo='git push -u origin'
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
alias dotfiles='cd ~/dotfiles'
alias cdprojects='cd ~/projects/'
alias sleepnow='pmset sleepnow'
alias bed='sleepnow'
alias ..='cd ..'
alias la='ls -als'
alias gpt='git push origin --tags'
alias gt='git tag'
alias gts='git tag show'
alias gta='git tag -a'
alias gass='git update-index --assume-unchanged'
alias gassu='git update-index --no-assume-unchanged'
alias gassl='!git ls-files -v | grep ^h | cut -c 3-'

# ---------------------------------------------------------------------
# Functions
# ---------------------------------------------------------------------
sass_example() {
  echo 'sass --watch dev/scss/main.scss:dev/css/main.min.css --style compressed';
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
# General aliases
# ---------------------------------------------------------------------
alias edit='subl'
alias ~="cd ~"
alias c='clear'
alias path='echo -e ${PATH//:/\\n}'
alias rmr='sudo rm -R'
alias flushdns='sudo discoveryutil mdnsflushcache'
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
alias composer='sudo composer'
alias nano='sudo nano'




