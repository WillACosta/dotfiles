# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export LC_ALL=en_US.UTF-8
export EDITOR=vim

## python
export PATH=$PATH:/Users/will/Library/Python/3.9/bin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.13/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=$ZSH:$PATH
# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

## sonar
export PATH=$PATH:~/workspace/Library/sonar-scanner/bin

## Android & Java Environment
export JAVA_HOME=~/Library/Java/JavaVirtualMachines/openjdk-18.0.2.1/Contents/Home

export ANDROID_HOME=/Users/will/Library/Android/sdk
# export ANDROID_SDK_ROOT=~/workspace/Library/Android/SDK

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

## pnpm path
export PNPM_HOME="/Users/will/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

### Node
export PATH=$PATH:/usr/local/opt/node@14/bin

## Flutter/Dart binary path
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$PATH":"/Users/will/fvm/default/bin"
# export PATH="$PATH":"/Users/will/fvm/versions/3.19.3/bin"
# export PATH="$PATH":"$HOME/.pub-cache/bin"

## ruby
export PATH=/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/2.7/bin:$PATH
export PATH=/opt/homebrew/lib/ruby/gems/3.0.0/bin/pod:$PATH

## ffmpeg
export PATH=~/audio-orchestrator-ffmpeg/bin:$PATH

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Spaceship config

SPACESHIP_TIME_SHOW=false
SPACESHIP_USER_SHOW=false
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="▲"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PACKAGE_SHOW=false

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Aliases

alias c="clear"
alias la=tree
alias cat=bat

alias clogs='grc -c ~/.grc/logs.conf $1 2>&1'

alias alw='aerospace list windows'
alias alm='aerospace list monitors'

# git
alias gcm="git commit -m"
alias gcam="git commit --amend -m"
alias ga='git add'
alias gaa='git add .'
alias gp="git pull"
alias gs="git status -s"
alias gps="git push"
alias gc="git checkout"
alias gb='git branch'
alias gsts='git stash'

alias gl="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gd="git diff"
alias gcall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# docker
alias dcb="docker compose up --build -d"
alias dcu="docker compose up -d"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

alias dsa="docker stop $(docker ps -q)"
alias drma="docker rm $(docker ps -a -q)"
alias dpra="docker system prune -a --volumes"
alias dpr="docker system prune"

# Run grc for stdout from a command execution
alias clogs='grc -c ~/.grc/logs.conf $1 2>&1'

alias pi="pip install -r requirements.txt"
alias psv='source .venv/bin/activate'
alias pd='deactivate'
alias pcv='python -m venv .venv'

alias pyrun='poetry run python main.py'

alias lproc='sudo lsof -i'
alias kproc='kill'

# Load Angular CLI autocompletion.
# source <(ng completion script)

## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/will/.dart-cli-completion/zsh-config.zsh ]] && . /Users/will/.dart-cli-completion/zsh-config.zsh || true

PATH=~/.console-ninja/.bin:$PATH
PATH=/opt/homebrew/bin/python3:$PATH

## python rye env
# source "$HOME/.rye/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Load aliases for GRC
[[ -s "/etc/.grc.zsh" ]] && source /etc/.grc.zsh

## Deactivate conda when starting shell env
conda deactivate
export PATH="$HOME/.local/bin:$PATH"

# Init Zoxide CLI
eval "$(zoxide init zsh)"
