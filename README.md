# Setup

## Dotfiles

- Clone this repo into your homefolder and `cd` into it
- Run `./install.sh` to create symlinks from the dotfiles in this repo to your home directory, backups of your old dotfiles will be placed into `~/dotfiles_old`

## Terminal

- Download [iTerm2](https://iterm2.com/), then
  - Download and activate [this colorscheme](https://github.com/chriskempson/base16-iterm2/blob/master/base16-ocean.dark.256.itermcolors)
  - Download and activate [this font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip), set font size to 13px and vertical line spacing to 120%
  - Configure iTerm2 to use the `com.googlecode.iterm2.plist` file as its settings file

- Download and install [Homebrew](https://brew.sh/), then install the following brew packages:
  - fzf
  - htop
  - neovim
  - npm
  - ripgrep
  - tmux
  - tmuxinator
  - wget

- Add the `tmux-256color` terminfo to the system ncurses, otherwise colors will be off when using system programs like `ls` while using tmux:
```bash
curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
/usr/bin/tic -x tmux-256color
rm tmux-256color
```

## Python

- Download and install [pyenv](https://github.com/pyenv/pyenv) with `brew install pyenv`
- Run `pyenv install 3.X.X` and `pyenv global 3.X.X` to replace the default python2 with pythonX.X.X (choose the most recent version).

- Run `pip install black isort flake8 neovim` to allow basic autoformatting and linting without activating an environment and to add neovim integration

## Vim

- Install vim-plug with `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`

- Run ":PlugInstall" in Vim to install Vim plugins.

- Install Language Servers:
  - Typescript: `npm install -g typescript typescript-language-server`
  - Python (Pyright): `npm install -g pyright`
  - Vue.js: `npm install -g vls`
  - efm (for flake8): `brew install efm-langserver`

## MacOS

- In `Keyboard` setttings, increase `Key Repeat` to max and `Delay Until Repeat` to one before `short`
- Replace `Capslock` with `Escape`
- Install
  - [Docker](https://docs.docker.com/docker-for-mac/install/)
  - [Hidden](https://github.com/dwarvesf/hidden) to hide menu bar items
  - [Karabiner Elements](https://karabiner-elements.pqrs.org/) for keyboard customization
  - [Postgres](https://www.postgresql.org/download/macosx/) for macOS
  - [Typora](https://typora.io/) for markdown editing
  - [Scroll Reverser](https://pilotmoon.com/scrollreverser/) if using an external mouse
  - [SensibleSideButtons](https://sensible-side-buttons.archagon.net/) if using an external mouse (add this to login items for autostart)
  - [Magnet](https://apps.apple.com/us/app/magnet/id441258766) or [Rectangle](https://rectangleapp.com/) for window tiling
  - [Alfred](https://www.alfredapp.com/) or [Raycast](https://www.raycast.com/) as a spotlight replacement
  - [TablePlus](https://tableplus.com/) as a database viewer
  - [LICEcap](https://www.cockos.com/licecap/) to record screen sessions as GIFs
