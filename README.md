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

Add the `tmux-256color` terminfo to the system ncurses, otherwise colors will be of when using system programs like `ls` while using tmux:

```bash
infocmp -x tmux-256color > xyz
/use/bin/tic -x xyz
rm xyz
```
