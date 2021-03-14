# Setup

## Dotfiles

- Clone this repo into your homefolder and `cd` into it
- Run `./install.sh` to create symlinks from the dotfiles in this repo to your home directory, backups of your old dotfiles will be placed into `~/dotfiles_old`

## Terminal

- Download [iTerm2](https://iterm2.com/), then
  - Download and activate [this colorscheme](https://github.com/chriskempson/base16-iterm2/blob/master/base16-ocean.dark.256.itermcolors)
  - Download and activate [this font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip), set font size to 13px and vertical line spacing to 120%

- Download and install [Homebrew](https://brew.sh/), then install the following brew packages:
  - fzf
  - htop
  - neovim --HEAD
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

- Download and install [miniconda3](https://docs.conda.io/en/latest/miniconda.html)
- Download and install [pyenv](https://github.com/pyenv/pyenv) with `brew install pyenv`
- Run `pyenv install 3.9.1` and `pyenv global 3.9.1` to replace the default python2 with python3.9.1

- Run `pip install black isort flake8` to allow basic autoformatting and linting without activating an environment

## Vim

- Install vim-plug with `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'`

- Run ":PlugInstall" in Vim to install Vim plugins.

- Create a neovim conda env with
```bash
conda create -n neovim python=3.9 pynvim`
```

- Install Language Servers:
  - Typescript: `npm install -g typescript typescript-language-server`
  - Python: [Microsoft Python Language Server](https://github.com/microsoft/python-language-server/blob/master/CONTRIBUTING.md#setup)
  - Vue.js: `npm install -g vls`
  - efm (for flake8): `brew install efm-langserver`

## MacOS

- In `Keyboard` setttings, increase `Key Repeat` to max and `Delay Until Repeat` to one before `short`
- Replace `Capslock` with `Escape`
