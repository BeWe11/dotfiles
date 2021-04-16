if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export PATH="/Users/ben/miniconda3/bin:$PATH"
export PATH="$PATH:/Users/ben/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH=/usr/local/opt/ruby/bin:$PATH
export PATH=/Users/ben/.dotnet:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --smart-case --color=never --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ben/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ben/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ben/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ben/google-cloud-sdk/completion.bash.inc'; fi

# Git branch in prompt.
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Setup GPG
GPG_TTY=$(tty)
export GPG_TTY

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/ben/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/ben/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/ben/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/ben/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Setup Poetry and pyenv
export PATH="$HOME/.poetry/bin:$PATH"
eval "$(pyenv init -)"

# Setup for rust
export PATH="$HOME/.cargo/bin:$PATH"
