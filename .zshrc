eval "$(/opt/homebrew/bin/brew shellenv)"

printf '\n%.0s' {1..100}

autoload -U compinit; compinit

# prevent zsh from catching `CTRL-X` keys
bindkey -e

if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="$PATH:/Users/ben/bin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
export PATH=/usr/local/opt/ruby/bin:$PATH
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export EDITOR=nvim

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --smart-case --color=never --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export HISTFILE=~/.zsh_history
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Git branch in prompt.
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=%{$'\e[0m'%}
COLOR_USR=%{$'\e[38;5;243m'%}
COLOR_DIR=%{$'\e[38;5;197m'%}
COLOR_GIT=%{$'\e[38;5;39m'%}
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

# Setup GPG
GPG_TTY=$(tty)
export GPG_TTY

# Setup Poetry and pyenv
export PATH="$HOME/.local/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Setup for rust
export PATH="$HOME/.cargo/bin:$PATH"
