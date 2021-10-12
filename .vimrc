call plug#begin('~/.vim/plugged')
" IDE stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
" FZF
Plug '/usr/local/opt/fzf'
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
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tpope/vim-unimpaired'
Plug 'preservim/nerdtree'
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
" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

" completion
set updatetime=750
lua <<EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
end
require'lspconfig'.tsserver.setup{on_attach=on_attach_vim}
require'lspconfig'.vuels.setup{on_attach=on_attach_vim}
require'lspconfig'.pyright.setup{
    on_attach = on_attach_vim;
}
require'lspconfig'.efm.setup{
    filetypes = {"python"};
    on_attach = on_attach_vim;
}
require'callbacks'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- This will disable virtual text, like doing:
    -- let g:diagnostic_enable_virtual_text = 0
    virtual_text = false,

    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)
EOF
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
let g:completion_trigger_on_delete = 1
let g:completion_enable_snippet = 'UltiSnips'
call sign_define("LspDiagnosticsSignError", {"text" : "", "texthl" : "LspDiagnosticsDefaultError"})
call sign_define("LspDiagnosticsSignWarning", {"text" : "", "texthl" : "LspDiagnosticsDefaultWarning"})
call sign_define("LspDiagnosticsSignInformation", {"text" : "", "texthl" : "LspDiagnosticsDefaultInformation"})
call sign_define("LspDiagnosticsSignHint", {"text" : "", "texthl" : "LspDiagnosticsDefaultHint"})
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable = false})
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-]>    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.declaration()<CR>
let g:completion_confirm_key = ""
imap <expr> <cr>  pumvisible() ? complete_info()["selected"] != "-1" ?
                 \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

" Activate python-syntax extra highlighting
let g:python_highlight_all = 1


" Use neovim conda environment for neovim internal python
let g:python3_host_prog = '/Users/ben/miniconda3/envs/neovim/bin/python'

" latex settings
let g:tex_flavor = "latex"
let g:tex_indent_brace = 0
let g:tex_noindent_env = ''

" Activate rainbow parantheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let NERDSpaceDelims = 1

" Color settings
function! SetBackground()
    " let darkmode=!defaults read -g AppleInterfaceStyle
    let darkmode=system('defaults read -g AppleInterfaceStyle')[:-2]
    if darkmode == 'Dark'
        let &background='dark'
        silent !kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_dark.conf"
    else
        let &background='light'
        silent !kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_light.conf"
    endif
endfunction
" :call SetBackground()
let g:solarized_extra_hi_groups=1
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
" set t_ut= "fix background redrawing in tmux
let base16colorspace=256
colo base16-ocean


" Vim-Airline settings
function! LspStatus() abort
    if luaeval('#vim.lsp.buf_get_clients() > 0')
        return luaeval("require('lsp-status').status()")
    endif
    return ''
endfunction
let g:airline_powerline_fonts = 1
call airline#parts#define_function('lsp', 'LspStatus')
let g:airline_section_y = airline#section#create_right(['ffenc', 'lsp'])

" Ale options
let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0

" Neoformat options
let g:neoformat_python_black = {
                \ 'exe': 'black',
                \ 'stdin': 1,
                \ 'args': ['-q', '-'],
                \ }
let g:neoformat_enabled_python = ['isort', 'black']
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_html = ['prettier']
let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-assume-filename=file.cpp', '-style=google'],
            \ 'stdin': 1,
            \ }
let g:neoformat_run_all_formatters = 1

" NERDTree settings
let NERDTreeMapOpenVSplit='v'

" vim-closetag settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'

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


" set vim-projectroot root signifiers
let g:rootmarkers = ['.svn', '.git', 'DONE', '.hg', '.bzr', '_darcs', 'build.xml']

let g:gutentags_cache_dir = '~/.tags'


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
        if executable('ack')
            exec 'Ack! --ignore-file=is:DONE --ignore-file=ext:ipynb --ignore-dir=.ipynb_checkpoints ' . s:codetags . ' ' . ProjectRootGuess()
        else
            exec 'Grep! -nIr --exclude=DONE --exclude="*.ipynb" --exclude-dir=.git --exclude-dir=.ipynb_checkpoints "' . s:codetags . '" ' . ProjectRootGuess() . '/*'
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

" switch between solarized dark and light, iterm2 escape codes are wrapped
" by tmux codes so that tmux sends them to iterm unchanged
function! s:SwitchSolarized()
    if &background == 'dark'
      let &background = 'light'
      silent !kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_light.conf"
      silent !osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to False'
    elseif &background == 'light'
      let &background = 'dark'
      silent !kitty @ --to "unix:/tmp/mykitty" set-colors "/Users/ben/.config/kitty/kitty_solarized_dark.conf"
      silent !osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to True'

    endif
endfunction
map <silent> <F6> :call <SID>SwitchSolarized()<CR>

" use ripgrep instead of ag in fzf
" Using colors in interactive mode will slow down vim tremendously, there we
" set colors of for 'Rg'. We define another 'Find' function with colors that is
" supposed to be called with a starting query
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Redefine fzf functions to use preview windows in vertical split when
" fullscreen ist activated
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(
  \   <q-args>,
  \   <bang>0 ? fzf#vim#with_preview('right:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(
  \   <q-args>,
  \   <bang>0 ? fzf#vim#with_preview('right:50%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" vim-sneak EasyMotion mode
let g:sneak#s_next = 1
let g:sneak#streak = 1

" helper function for editing filetype specific config files
function! <SID>open_type_conf()
  execute 'vsplit '.'~/.vim/ftplugin/'.&filetype.'.vim'
endfunction

function! <SID>source_type_conf()
  execute 'source '.'~/.vim/ftplugin/'.&filetype.'.vim'
endfunction

function! s:init()
    nmap [q <Plug>unimpairedQPreviouszz
    nmap ]q <Plug>unimpairedQNextzz
endfunction
augroup vimrc_enter
    au!
    au VimEnter * call s:init()
augroup END

" key remaps
let mapleader = ";"
" set pastetoggle=<F9>
" nnoremap <F10> :Goyo<CR>
" nmap <leader>bb :CtrlPBuffer<CR>
nmap <leader>bj :bnext<CR>
nmap <leader>bk :bprevious<CR>
nnoremap <leader>bw :bp\|bd #<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>ef :call <SID>open_type_conf()<CR>
nnoremap <leader>et :vsplit ~/.todo.txt<CR>
nnoremap <leader>lv :source $MYVIMRC<CR>
nnoremap <leader>sf :call <SID>source_type_conf()<CR>
" nnoremap <leader>j :cn<CR>
" nnoremap <leader>k :cp<CR>
" nnoremap <leader>l :ccl<CR>
nnoremap <leader>s :wincmd r<CR>
nnoremap <leader>sv :vsplit<CR>
nnoremap <leader>sh :split<CR>
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

" command! Cnext try | cnext | catch | cfirst | catch | endtry
" command! Cprevious try | cprevious | catch | clast | catch | endtry
" nnoremap ]q :Cnext<CR>
" nnoremap [q :Cprevious<CR>
" nnoremap ]Q :clast<CR>
" nnoremap [Q :cfirst<CR>

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

" FZF mappings
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files!<CR>
nnoremap <leader>fgf :GFiles<CR>
nnoremap <leader>fgF :GFiles!<CR>
nnoremap <leader>fbb :Buffers<CR>
nnoremap <leader>fbB :Buffers!<CR>
nnoremap <leader>fi :Rg<CR>
nnoremap <leader>fI :Rg!<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fL :Lines!<CR>
nnoremap <leader>fbl :BLines<CR>
nnoremap <leader>fbL :BLines!<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fC :Commits!<CR>
nnoremap <leader>fbc :BCommits<CR>
nnoremap <leader>fbC :BCommits!<CR>
vnoremap <leader>f y :Find <C-R>"<CR>
vnoremap <leader>F y :Find! <C-R>"<CR>
nnoremap <leader>fn :NERDTreeToggle<CR>

" fugitive mappings
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gE :Gvsplit<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gD :Gvdiff HEAD^<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gS :Gstatus<CR><C-w>T
nnoremap <leader>gl :silent! Glog<CR>
vnoremap <leader>gb :Git blame<CR>

function! FormatFile()
    let save_pos = getpos(".")
    exec 'Neoformat'
    call setpos('.', save_pos)
endfunction
nnoremap <leader>F :call FormatFile()<CR>

function OpenDiagnostics()
    lua vim.lsp.diagnostic.set_loclist()
endfunction
nnoremap <leader>D :call OpenDiagnostics()<CR>

nnoremap [c [czz
nnoremap ]c ]czz
nmap <silent> [t <Plug>(ale_previous_wrap)
nmap <silent> ]t <Plug>(ale_next_wrap)

" nerdcommenter, taken from https://gist.github.com/xream/c474a1adffeb6f70daa6a7ddc22386e0
" This allows different comment styles in vue files, where html and javascript
" is mixed in a single file.
imap <leader>ci <SPACE><BS><ESC>:call Comment('Insert')<cr>
map <leader>ca :call Comment('AltDelims')<cr>
xmap <leader>c$ :call Comment('ToEOL', 'x')<cr>
nmap <leader>c$ :call Comment('ToEOL', 'n')<cr>
xmap <leader>cA :call Comment('Append', 'x')<cr>
nmap <leader>cA :call Comment('Append', 'n')<cr>
xmap <leader>cs :call Comment('Sexy', 'x')<cr>
nmap <leader>cs :call Comment('Sexy', 'n')<cr>
xmap <leader>ci :call Comment('Invert', 'x')<cr>
nmap <leader>ci :call Comment('Invert', 'n')<cr>
xmap <leader>cm :call Comment('Minimal', 'x')<cr>
nmap <leader>cm :call Comment('Minimal', 'n')<cr>
xnoremap <leader>c<space> :call Comment('Toggle', 'x')<CR>
nnoremap <leader>c<space> :call Comment('Toggle', 'n')<CR>
xmap <leader>cl :call Comment('AlignLeft', 'x')<cr>
nmap <leader>cl :call Comment('AlignLeft', 'n')<cr>
xmap <leader>cb :call Comment('AlignBoth', 'x')<cr>
nmap <leader>cb :call Comment('AlignBoth', 'n')<cr>
xmap <leader>cc :call Comment('Comment', 'x')<cr>
nmap <leader>cc :call Comment('Comment', 'n')<cr>
xmap <leader>cn :call Comment('Nested', 'x')<cr>
nmap <leader>cn :call Comment('Nested', 'n')<cr>
xmap <leader>cu :call Comment('Uncomment', 'x')<cr>
nmap <leader>cu :call Comment('Uncomment', 'n')<cr>
xmap <leader>cy :call Comment('Yank', 'x')<cr>
nmap <leader>cy :call Comment('Yank', 'n')<cr>
let g:NERDCreateDefaultMappings=0
let g:NERDSpaceDelims=1
let g:NERDCustomDelimiters = {'pug': { 'left': '//-', 'leftAlt': '//' }}
function! Comment(...) range
  let mode = a:0
  let type = a:1
  let ft = &ft
  let stack = synstack(line('.'), col('.'))
  if ft == 'vue'
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        " let syn = substitute(tolower(syn), 'vuetemplate', '', '')
        let syn = tolower(syn)
        exe 'setf '.syn
      endif
    endif
  endif
  if type == 'AltDelims'
    exe "normal \<plug>NERDCommenterAltDelims"
  elseif type == 'Insert'
    call NERDComment('i', "insert")
  else
    exe 'silent '.a:firstline.','.a:lastline.'call NERDComment(mode, type)'
  endif
  exe "setf ".ft
endfunction
