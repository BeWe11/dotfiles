platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias -- +='pushd .'
alias -- -='popd'
alias cd..='cd ..'
alias dir='ls -l'
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls-l='ls -l'
alias md='mkdir -p'
alias rd='rmdir'
alias less='less -R'
alias tm='tmux new-window'
alias vimpure='vim --noplugin -u /dev/null -n'

if [[ $platform == 'linux' ]]; then
   alias ls='ls --color=always -h'
   alias open='xdg-open'
elif [[ $platform == 'osx' ]]; then
   alias ls='ls -G'
fi

alias g++='g++ --std=c++11'
