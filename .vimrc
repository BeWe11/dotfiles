call plug#begin('~/.vim/plugged')

Plug 'hdima/python-syntax/'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'bling/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
" Plug 'altercation/vim-colors-solarized'
" Plug 'davidhalter/jedi-vim'
Plug 'Valloric/YouCompleteMe'
" Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdcommenter'
" Plug 'godlygeek/csapprox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/EnhancedJumps'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/TeX-PDF'

" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

" longer timeout for ycm
let g:plug_timeout = 1000


" latex settings
let g:tex_flavor = "latex"
let g:tex_indent_brace = 0
let g:tex_noindent_env = ''

" Autoremove trailing whitespaces
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l, c)
endfun
autocmd BufWritePost * :call <SID>StripTrailingWhitespaces()

" Rainbow parantheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" Keep CtrlP cache for faster loading times
" let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'


" let g:flake8_show_in_file=1
" let g:jedi#popup_on_dot = 0
let g:ctrlp_show_hidden = 1
let NERDSpaceDelims = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#fnamemod = ':t'

" Color settings
set background=dark
colo PaperColor
set t_Co=256
set t_ut= "fix background redrawing in tmux
let g:airline_powerline_fonts = 1
let g:airline_theme='papercolor'


" Misc
set lazyredraw
set ttyfast
set wildmenu
set laststatus=2
syntax on
filetype plugin indent on
" set autoindent
set showmatch
":match Error /\s\+$/
set backspace=indent,eol,start


" Autosave
set hidden
set autowrite

" Keep the cursor on the same column
set nostartofline

set cursorline
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

set number
set timeoutlen=1000
set ttimeoutlen=0

" inc search and search highligthing
set incsearch
set hlsearch

" color column
set colorcolumn=81
" hi ColorColumn ctermbg=0

" EnhancedJumps delay time to switch buffers
let g:stopFirstAndNotifyTimeoutLen = 1

" Remove conflict between YouCompleteMe and UltiSnips
function! g:UltiSnips_Complete()
  call UltiSnips#JumpForwards()
  if g:ulti_jump_forwards_res == 0
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
      if pumvisible()
        return "\<C-N>"
      else
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

" Goyo settings
let g:goyo_width=81
let g:goyo_height=100

function! s:goyo_enter()
  set colorcolumn=0
  " hi ColorColumn ctermbg=0
  silent !tmux set status off
  " set noshowmode
  " set noshowcmd
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  " set showmode
  " set showcmd
  " set scrolloff=5
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" vim-sneak EasyMotion mode
let g:sneak#s_next = 1
let g:sneak#streak = 1

" youcompleteme settings
let g:ycm_autoclose_preview_window_after_insertion = 1

" helper function for editing filetype specific config files
function! <SID>open_type_conf()
  execute 'vsplit '.'~/.vim/ftplugin/'.&filetype.'.vim'
endfunction

function! <SID>source_type_conf()
  execute 'source '.'~/.vim/ftplugin/'.&filetype.'.vim'
endfunction

" key remaps
let mapleader = ";"
set pastetoggle=<F9>
nnoremap <F10> :Goyo<CR>
nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>bj :bnext<CR>
nmap <leader>bk :bprevious<CR>
nnoremap <leader>bw :bd<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>ef :call <SID>open_type_conf()<CR>
nnoremap <leader>et :vsplit ~/.todo.txt<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sf :call <SID>source_type_conf()<CR>
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>
nnoremap <leader>l :ccl<CR>
nnoremap <leader>e :!python %<CR>
nnoremap <leader>s :wincmd r<CR>
nnoremap <C-j> <C-d>zz
nnoremap <C-k> <C-u>zz
nmap <C-O>         <Plug>EnhancedJumpsOlder zz
nmap <C-I>         <Plug>EnhancedJumpsNewer zz
nmap g<C-O>        <Plug>EnhancedJumpsLocalOlder zz
nmap g<C-I>        <Plug>EnhancedJumpsLocalNewer zz
nmap <Leader><C-O> <Plug>EnhancedJumpsRemoteOlder zz
nmap <Leader><C-I> <Plug>EnhancedJumpsRemoteNewer zz
nmap g; <Plug>EnhancedJumpsFarFallbackChangeOlder zz
nmap g, <Plug>EnhancedJumpsFarFallbackChangeNewer zz
nnoremap <silent> <S-l> :nohl<CR><C-l>
nmap <Leader>f10 <F10>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

" make movement keys consider wrapped lines as new ones
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" disable arrow keys
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
