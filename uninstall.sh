########## Variables

dir=~/dotfiles                             # dotfiles directory
olddir=~/dotfiles_old                      # old dotfiles backup directory
files=".tmux.conf .gitconfig .vimrc .vim"  # list of files/folders to symlink in homedir

##########

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# delete symlinks, then move files in old directory to home directory
for file in $files; do
    echo "Removing symlink for $file"
    rm ~/$file
    echo "Moving files in $olddir to home directory"
    mv $olddir/$file ~/file
done

# remove olddir directory
echo "Removing $oldir directory"
rm -rf $olddir
echo "...done"

source ~/.bashrc
source ~/.vimrc
