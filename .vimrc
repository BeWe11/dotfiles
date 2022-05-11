call plug#begin('~/.vim/plugged')
" IDE stuff
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'onsails/lspkind-nvim'
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
Plug 'hashivim/vim-terraform'
" Snippets
Plug 'sirver/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

" completion
set updatetime=750

lua <<EOF
-- Setup nvim-cmp.
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        preset = 'default',
        maxwidth = 50,
      })
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              else
                  cmp.complete()
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                  vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
              else
                  fallback()
              end
          end,
          s = function(fallback)
              if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                  vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
              else
                  fallback()
              end
          end
      }),
      ["<S-Tab>"] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                  cmp.complete()
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                  return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
              else
                  fallback()
              end
          end,
          s = function(fallback)
              if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                  return vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
              else
                  fallback()
              end
          end
      }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.tsserver.setup{capabilities=capabilities}
require'lspconfig'.vuels.setup{capabilities=capabilities}
require'lspconfig'.pyright.setup{
  capabilities = capabilities;
  settings = {
    python = {
      analysis = {
        autoSearchPaths = false,
        autoImportCompletions = false,
        completeFunctionParens = true,
        typeCheckingMode = "off"
      }
    }
  }
}
require'lspconfig'.efm.setup{
    filetypes = {"python"};
    capabilities = capabilities;
}
require'callbacks'

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})
EOF

" Set completeopt to have a better completion experience
set completeopt=menu,menuone,noselect

call sign_define("DiagnosticSignError", {"text" : "", "texthl" : "DiagnosticSignError"})
call sign_define("DiagnosticSignWarn", {"text" : "", "texthl" : "DiagnosticSignWarn"})
call sign_define("DiagnosticSignInfo", {"text" : "", "texthl" : "DiagnosticSignInfo"})
call sign_define("DiagnosticSignHint", {"text" : "", "texthl" : "DiagnosticSignHint"})
autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus = false})
nnoremap <silent> gd        <cmd> lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         <cmd> lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>r <cmd> lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <c-]>     <cmd> lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>     <cmd> lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD       <cmd> lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd> lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0        <cmd> lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW        <cmd> lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gD        <cmd> lua vim.lsp.buf.declaration()<CR>

" Activate python-syntax extra highlighting
let g:python_highlight_all = 1


" Use global python as neovim internal python
let g:python3_host_prog = '/Users/ben/.pyenv/versions/neovim/bin/python'

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
colo base16-one-light
let $BAT_THEME = 'base16'

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


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
let g:neoformat_htmldjango_jsbeautify = {
            \ 'exe': 'js-beautify',
            \ 'args': [
            \    '--type html',
            \    '--indent-size 2',
            \    '--templating django',
            \],
            \ 'stdin': 1,
            \ }
let g:neoformat_enabled_htmldjango = ['jsbeautify']
let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-assume-filename=file.cpp', '-style=google'],
            \ 'stdin': 1,
            \ }
" XXX: This format command does not work reliably right now
let g:neoformat_enabled_sql = ['sqlfluff']
let g:neoformat_sql_sqlfluff = {
            \ 'exe': 'sqlfluff',
            \ 'args': ['fix', '--force', '--nocolor', '-'],
            \ 'stdin': 1,
            \ }
let g:neoformat_run_all_formatters = 1

" NERDTree settings
let NERDTreeMapOpenVSplit='v'
let NERDTreeWinSize=50

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


" Set completion colors
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" light blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#0184bc
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#0184bc
" light blue
highlight! CmpItemKindInterface guibg=NONE guifg=#4078f2
highlight! CmpItemKindText guibg=NONE guifg=#4078f2
" blue
highlight! CmpItemKindFunction guibg=NONE guifg=#4078f2
highlight! CmpItemKindMethod guibg=NONE guifg=#4078f2
" purple
highlight! CmpItemKindClass guibg=NONE guifg=#a626a4
" orange
highlight! CmpItemKindConstant guibg=NONE guifg=#d75f00
" yellow
highlight! CmpItemKindModule guibg=NONE guifg=#c18401
" red
highlight! CmpItemKindVariable guibg=NONE guifg=#ca1243
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4


" use ripgrep instead of ag in fzf
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --exact'}, 'right:50%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. --exact'}, 'right:50%:hidden', '?'),
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

" Override fzf commit commands to make more space for side-by-side diffs
command! -bar -bang -range=% Commits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#commits(fzf#vim#with_preview({ "placeholder": "", 'options': '--preview-window=right,70%' }), <bang>0)
command! -bar -bang -range=% BCommits let b:fzf_winview = winsaveview() | <line1>,<line2>call fzf#vim#buffer_commits(fzf#vim#with_preview({ "placeholder": "", 'options': '--preview-window=right,70%' }), <bang>0)


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
nmap cp :let @+ = expand("%:p")<CR>

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
nnoremap <leader>fi :Find<CR>
nnoremap <leader>fI :Find!<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fC :Commits!<CR>
noremap <leader>fl :BCommits<CR>
noremap <leader>fL :BCommits!<CR>
vnoremap <leader>fi y :Find <C-R>"<CR>
vnoremap <leader>fI y :Find! <C-R>"<CR>
nnoremap <leader>fn :NERDTreeToggle<CR>

" fugitive mappings
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gE :Gvsplit<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gD :Gvdiffsplit HEAD^<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gS :Git<CR><C-w>T
nnoremap <leader>gl :silent! 0Gclog<CR>
vnoremap <leader>gb :Git blame<CR>

function! FormatFile()
    let save_pos = getpos(".")
    exec 'Neoformat'
    call setpos('.', save_pos)
endfunction
nnoremap <leader>F :call FormatFile()<CR>

function OpenDiagnostics()
    lua vim.diagnostic.setloclist()
endfunction
nnoremap <leader>D :call OpenDiagnostics()<CR>
nnoremap ]d <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap [d <cmd>lua vim.diagnostic.goto_prev()<CR>

nnoremap [c [czz
nnoremap ]c ]czz
nmap <silent> [t <Plug>(ale_previous_wrap)
nmap <silent> ]t <Plug>(ale_next_wrap)
