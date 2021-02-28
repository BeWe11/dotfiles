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

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --color=never --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# In every new tmux pane, we want to automatically load the conda env that was
# active before starting tmux. We need to save the current CONDA_DEFAULT_ENV
# in a temp variable because the conda.sh init script sets the env to 'base'
if [[ -n "$TMUX" ]]; then
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        # We first deactivate the environment, otherwise it will not load
        # correctly
        env=$CONDA_DEFAULT_ENV
    fi
fi

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

if [[ -n "$env" ]]; then
    conda deactivate
    conda activate $env
fi

export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Set virtual env variable to conda prefix so that jedi-vim can load the
# correct env. This becomes obsolete as soon as issue
# https://github.com/davidhalter/jedi-vim/issues/907 is resolved
export VIRTUAL_ENV=$CONDA_PREFIX

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ben/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ben/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ben/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ben/google-cloud-sdk/completion.bash.inc'; fi

# # Set colorscheme depending on whether dark mode is active
# darkmode=$(defaults read -g AppleInterfaceStyle 2> /dev/null)
# if [ "$darkmode" = 'Dark' ]; then
#     kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_dark.conf" 
# else
#     kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_light.conf" 
# fi
