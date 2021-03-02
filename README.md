# Setup

## dotfiles

Run install.sh, then run ":PlugInstall" in Vim to install Vim plugins.

## Installations on a new system

- Homebrew

  - fzf
  - htop
  - neovim --HEAD
  - ripgrep
  - tmux
  - tmuxinator
  - wget

- Language Servers
  - Typescript: `npm install -g typescript typescript-language-server`
  - [Microsoft Python Language Server](https://github.com/microsoft/python-language-server/blob/master/CONTRIBUTING.md#setup)
  - Vue.js: `npm install -g vls`

## Setup tmux colors and italics

Add the `tmux-256color` terminfo to the system ncurses, otherwise colors will be off when using system programs like `ls` while using tmux:

```bash
curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
/usr/bin/tic -x tmux-256color
rm tmux-256color
```
