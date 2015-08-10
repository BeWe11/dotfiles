########## Variables

dir=~/dotfiles                             # dotfiles directory
olddir=~/dotfiles_old                      # old dotfiles backup directory
files=".tmux.conf .gitconfig .vimrc .vim"  # list of files/folders to symlink in homedir

##########

for file in $files; do
    echo "Removing symlink from ~/$file to $dir/$file..."
    rm ~/$file
    echo "...done!"
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
