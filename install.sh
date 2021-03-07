dir=~/dotfiles                     # dotfiles directory
olddir=~/dotfiles_old              # old dotfiles backup directory
files=".bash_aliases \
       .bash_profile \
       .bashrc \
       .config/nvim \
       .gitconfig \
       .tmux.conf \
       .vimrc \
       .vim"                       # list of files/folders to symlink in homedir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    if [[ -e ~/$file && ! -h ~/$file ]]
    then
        if [ ! -d $olddir ]
        then
        echo "Creating $olddir to backup existing dotfiles in the home folder..."
        mkdir -p $olddir
        echo "...done!"
        fi
        echo "Moving ~/$file to $olddir/$file..."
        if [ -d $file ]
        then
            mv ~/$file/ $olddir
        else
            mv ~/$file $olddir
        fi
    echo "...done!"
    fi
    if [ -h ~/$file ]
    then
        echo "Symlink from ~/$file to $dir/$file already exists!"
    else
        echo "Creating symlink from ~/$file to $dir/$file..."
        mkdir -p `dirname $dir/$file`
        ln -s $dir/$file ~/$file
        echo "...done!"
    fi
done

# source .bash_profile if it exists (OSX), else source .bashrc
if [ -f ~/.bash_profile ]
then
    source ~/.bash_profile
elif [ -f ~/.bashrc ]
then
    source ~/.bashrc
fi
