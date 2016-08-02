[[ -s ~/.bashrc  ]] && source ~/.bashrc

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export PATH="$PATH:/Users/Ben/miniconda3/bin"
export PATH="$PATH:/Users/Ben/bin"
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=vim
