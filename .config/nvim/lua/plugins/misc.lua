vim.cmd [[
" Activate python-syntax extra highlighting
let g:python_highlight_all = 1

" Split settings
set splitright
set fillchars+=vert:\ |
autocmd ColorScheme * highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE

" Misc
set nocompatible
syntax on
highlight Comment gui=italic cterm=italic
set lazyredraw
set ttyfast
set wildmenu
set laststatus=2
filetype plugin indent on
au BufRead,BufNewFile,BufFilePre *.mmd set filetype=markdown
set showmatch
set backspace=indent,eol,start
set number

set mouse=a


" Autosave
set hidden
set autowrite

" Keep the cursor on the same column
set nostartofline

" set cursorline
set encoding=utf8
set termencoding=utf-8

" Disable bell
set noerrorbells
set novisualbell

" Tab settings
set expandtab
set tabstop=4
set shiftwidth=4
" set smarttab

set timeoutlen=1000
set ttimeoutlen=0

" inc search and search highligthing
set incsearch
set hlsearch

" color column
set colorcolumn=80
set textwidth=79
set nowrap           " do not automatically wrap on load
set formatoptions-=t " do not automatically wrap text when typing

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" key remaps
nnoremap <leader>bw :bp\|bd #<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>lv :source $MYVIMRC<CR>
nnoremap <silent> <S-l> :nohl<CR><C-l>
nmap <Leader>f10 <F10>
nmap cp :let @+ = expand("%:p")<CR>
]]
