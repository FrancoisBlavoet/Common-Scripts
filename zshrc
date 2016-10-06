# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="My-Zsh-Prompt"


# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export ANDROID_HOME=/Users/francois/dev/AndroidSdk
export HOME=/Users/francois
 
#export PATH=/usr/local/git/bin:$PATH -> should not be necessary, git places a symlink in usr/local and in el capitan local has the priority over usr/bin

#Android
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/platform-tools/systrace

#scripts
export PATH=$PATH:$HOME/config

#local dir
export PATH=$PATH:.

alias exa="exa-osx-x86-64"
alias ll="exa -lh"
alias llg= "ll --git"
#alias ls="gls --color=auto"
alias lla="exa -lha"
alias llag="lla --git"


#eval `gdircolors /Users/francois/Config-Perso/dircolors.ansi-dark.txt`

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



export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
