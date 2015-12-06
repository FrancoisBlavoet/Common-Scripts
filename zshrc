# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="My-Zsh-Prompt"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git dzr)

source $ZSH/oh-my-zsh.sh




### Global Variables :  

export ANDROID_HOME=~/Developer/android-sdk
export HOME=/Users/francois
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home




### PATH

#export PATH=/usr/local/git/bin:$PATH -> should not be necessary anymore, git places a symlink in usr/local and in el capitan local has the priority over usr/bin

#Android
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/platform-tools/systrace

#scripts
export PATH=$PATH:$HOME/config

#local dir
export PATH=$PATH:.




### exa

alias exa="exa-osx-x86-64"
alias ll="exa -lh"
alias llg= "ll --git"
alias lla="exa -lha"
alias llag="lla --git"
#alias ls="gls --color=auto" need port gls




###functions

func showHiddenFiles() {

		if [ $1 = "true" ]; then
			echo "showing hidden files"
			$(defaults write com.apple.finder AppleShowAllFiles YES;)
			killall Finder /System/Library/CoreServices/Finder.app
		else 
			echo "hidden files are invisible"
			defaults write com.apple.finder AppleShowAllFiles NO;
            killall Finder /System/Library/CoreServices/Finder.
		fi
}


