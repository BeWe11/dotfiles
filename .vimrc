call plug#begin('~/.vim/plugged')
Plug 'hdima/python-syntax/'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'kien/ctrlp.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
" Plug 'davidhalter/jedi-vim'
Plug 'Valloric/YouCompleteMe'
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
Plug 'godlygeek/tabular'
Plug 'dbakker/vim-projectroot'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'

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

augroup StripWhitespace
    autocmd!
    autocmd BufWritePost * :call <SID>StripTrailingWhitespaces()
augroup END


" Rainbow parantheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


 " Keep CtrlP cache for faster loading times
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'


" " let g:flake8_show_in_file=1
" " let g:jedi#popup_on_dot = 0
let g:ctrlp_show_hidden = 1
let NERDSpaceDelims = 1

" Color settings
set background=dark
colo solarized
set t_Co=256
set t_ut= "fix background redrawing in tmux

" Vim-Airline settings
let g:airline_powerline_fonts = 1
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
let g:airline_theme='solarized'


" Misc
set nocompatible
syntax on
set lazyredraw
set ttyfast
set wildmenu
set laststatus=2
filetype plugin indent on
au BufRead,BufNewFile,BufFilePre *.mmd set filetype=markdown
" set autoindent
set showmatch
":match Error /\s\+$/
set backspace=indent,eol,start


" Autosave
set hidden
set autowrite

" Keep the cursor on the same column
set nostartofline

" use old regexp engine to fix lag with cursorline
" set re=1

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

set number
set timeoutlen=1000
set ttimeoutlen=0

" inc search and search highligthing
set incsearch
set hlsearch

" color column
set colorcolumn=80
" hi ColorColumn ctermbg=0


" set vim-projectroot root signifiers
let g:rootmarkers = ['.svn', '.git', 'DONE', '.hg', '.bzr', '_darcs', 'build.xml']


"------------------------------------------------------------------------------"
"----- todo setup, refer to https://www.python.org/dev/peps/pep-0350/ ---------"
"------------------------------------------------------------------------------"
let s:codetags = 'FIXME\|BUG\|NOBUG\|HACK\|NOTE\|IDEA\|TODO\|XXX'

" Make vim highlight the code tags in every file
augroup HiglightTodo
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', s:codetags, -1)
augroup END

command! -nargs=1 -bang Ack exec 'AsyncRun' . '<bang>' . ' ack ' . <f-args>
command! -nargs=1 -bang Grep exec 'AsyncRun' . '<bang>' . ' grep ' . <f-args>

function! ListTodo(current)
    if a:current
        " Using async search for one file would be overkill, just use vimgrep
        exec 'silent! vimgrep /' . s:codetags . '/j ' . @%
        if len(filter(getqflist(), 'v:val.valid')) == 0
            echo 'Nothing found.'
            return
        endif
    else
        " FIXME: AsyncRun inserts a start and a finish line, try to remove
        " those, while having another way to determine whether it finished
        if executable('ackk')
            exec 'Ack! --ignore-file=is:DONE ' . s:codetags . ' ' . ProjectRootGuess()
        else
            exec 'Grep! -nIr --exclude=DONE --exclude-dir=.git "' . s:codetags . '" ' . ProjectRootGuess() . '/*'
        endif
    endif
    botright copen 8
endfunction

function! s:write_line(line, path)
    new
    setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
    exec 'normal! a' . a:line . "\<ESC>"
    exec 'w >>' a:path
    bd
endfunction

function! FinishTodo() range
    let path = ProjectRootGuess() . '/DONE'
    if filewritable(path)
        for linenumber in range(a:firstline, a:lastline)
            let line = getline(linenumber)
            call s:write_line(line, path)
            exec linenumber . 'd _'
        endfor
        call s:write_line('[' . strftime('%Y-%m-%d') . ']' . "\n", path)
        exec a:firstline
    else
        echo 'No DONE file in root directory'
    endif
endfunction


function! MakeNoEnter()
    " Set cmdheigt two 2 and reset to 1 to avoid the "Press Enter" screen
    set cmdheight=2
    make
    if len(filter(getqflist(), 'v:val.valid')) > 1
        botright cw 8
    endif
    set cmdheight=1
endfunction


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
let g:goyo_width=80
let g:goyo_height=100

function! s:goyo_enter()
  " setlocal formatoptions=ant
  set textwidth=80

  " set colorcolumn=0
  " hi ColorColumn ctermbg=0
  silent !tmux set status off
  " set noshowmode
  " set noshowcmd
endfunction

function! s:goyo_leave()
  set textwidth=0
  " setlocal formatoptions=croql
  silent !tmux set status on
  " set showmode
  " set showcmd
  " set scrolloff=5
endfunction

augroup Goyo
    autocmd!
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

" switch between solarized dark and light, iterm2 escape codes are wrapped
" by tmux codes so that tmux sends them to iterm unchanged
function! s:SwitchSolarized()
    if &background == 'dark'
      let &background = 'light'
      silent !echo -e "\033Ptmux;\033\033]50;SetProfile=solarized_light\a\033\\"
    elseif &background == 'light'
      let &background = 'dark'
      silent !echo -e "\033Ptmux;\033\033]50;SetProfile=solarized_dark\a\033\\"
    endif
endfunction
map <silent> <F6> :call <SID>SwitchSolarized()<CR>

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
nnoremap <leader>bw :bp\|bd #<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>ef :call <SID>open_type_conf()<CR>
nnoremap <leader>et :vsplit ~/.todo.txt<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>sf :call <SID>source_type_conf()<CR>
nnoremap <leader>j :cn<CR>
nnoremap <leader>k :cp<CR>
nnoremap <leader>l :ccl<CR>
nnoremap <leader>s :wincmd r<CR>
nnoremap <leader>r :call MakeNoEnter()<CR>
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
nnoremap <leader>ae :Tab /=<CR>
nnoremap <leader>ac y :Tab /<C-R>"<CR>
xnoremap <leader>ac y :Tab /<C-R>"<CR>
xnoremap <leader>ae :Tab /=<CR>

command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprevious try | cprevious | catch | clast | catch | endtry
nnoremap ]q :Cnext<CR>
nnoremap [q :Cprevious<CR>
nnoremap ]Q :clast<CR>
nnoremap [Q :cfirst<CR>

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
nnoremap <leader>tt :call ListTodo(0)<CR>
nnoremap <leader>tc :call ListTodo(1)<CR>
nnoremap <leader>td :call FinishTodo()<CR>
vnoremap <leader>td :call FinishTodo()<CR>
