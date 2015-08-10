# Startup files for bash *login* shells: /etc/profile, then .bash_profile OR
# .bash_login OR .profile, NOT .bashrc (hence, source .bashrc in .bash_profile)
# SSH shells are usually like login shells.
# A non-login interactive shell reads .bashrc (and inherits login variables)
# A non-interative shell (e.g. running a shell script) reads only the file
# given in $BASH_ENV, if defined.
umask 027

export PREFIX=$HOME/local
export SCRATCH_ROOT=$HOME/.scratch
export EDITOR=vim
export PATH=$HOME/bin:$PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$PREFIX/lib:$LD_LIBRARY_PATH
export MANPATH=$PREFIX/man:$MANPATH

source /usr/local/Modules/current/init/bash
#module purge
if [ -d $HOME/.modules ];
then
    module use --append $HOME/.modules
    module load ifort
fi
#module load texlive/2013
#module load prefix/loct

alias ..='cd ..'
alias ...='cd ../..'
alias -- +='pushd .'
alias -- -='popd'
alias cd..='cd ..'
alias dir='ls -l'
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls='ls --color -h'
alias ls-l='ls -l'
alias md='mkdir -p'
alias rd='rmdir'
alias less='less -R'
alias tm='tmux new-window'
alias vimpure='vim --noplugin -u /dev/null -n'
alias open='xdg-open'

if [ ! -z "$PS1" ]; then # interactive terminal

    #source $HOME/.git-completion.sh
    #source $HOME/.tmux-completion.sh
    # Fix bug where completion of $PREFIX -> \$PREFIX
    #complete -F _cd $nospace $filenames cd

    # interactive shell
    shopt -s checkwinsize
    export PS1="\u@\h:\w> "
    if [ "\$(type -t __git_ps1)" ]; then
        PS1="\u@\h\$(__git_ps1 ' %s'):\w> "
    fi

    # Add loaded envirnomnent modules to prompt
    __module_ps1(){
        # Loaded modules should add a short version of their name to the
        # $PS1_LOADEDMODULES list environment variable if they want this name
        # to appear in the prompt
        if [[ $PS1_LOADEDMODULES && ${PS1_LOADEDMODULES-_} ]]
        then
            printf "[%s] " $PS1_LOADEDMODULES
        else
            printf ""
        fi
    }
    PS1="\$(__module_ps1)$PS1"

fi

# make tmux work with 256 colors
alias tmux="TERM=screen-256color-bce tmux"

# added by Miniconda 3.10.1 installer
export PATH="/home/users/0005/uk008467/miniconda/bin:$PATH"
