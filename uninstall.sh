########## Variables

dir=~/dotfiles                                           # dotfiles directory
olddir=~/dotfiles_old                                    # old dotfiles backup directory
files=".bash_aliases .tmux.conf .gitconfig .vimrc .vim"  # list of files/folders to symlink in homedir

##########

for file in $files; do
    if [ -h ~/$file ]
    then
        echo "Removing symlink from ~/$file to $dir/$file..."
        rm ~/$file
        echo "...done!"
    fi
    if [ -d "$olddir" ]
    then
        if [ -e "$olddir/$file" ]
        then
            echo "Moving $olddir/$file to ~/$file..."
            mv $olddir/$file ~/file
	    echo "...done!"
        fi
    fi
done

# remove olddir directory
if [ -d "$olddir" ]
then
    echo "Removing $olddir..."
    rm -rf $olddir
    echo "...done!"
fi

# source .bash_profile if it exists (OSX), else source .bashrc
if [ -f ~/.bash_profile ]
then
    source ~/.bash_profile
elif [ -f ~/.bashrc ]
then
    source ~/.bashrc 
fi
