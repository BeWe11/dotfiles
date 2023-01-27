vim.cmd [[
call plug#begin('~/.config/nvim/plugged')
" IDE stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
Plug 'vim-test/vim-test'
Plug 'editorconfig/editorconfig-vim'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Tmux integration
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
" Editor
Plug 'kien/rainbow_parentheses.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/EnhancedJumps'
Plug 'ggandor/lightspeed.nvim'
Plug 'godlygeek/tabular'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-unimpaired'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-eunuch'
" Extras
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-fugitive'
Plug 'chriskempson/base16-vim'
" Languages
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'derekwyatt/vim-scala'
Plug 'hashivim/vim-terraform'
" Snippets
Plug 'sirver/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
]]
