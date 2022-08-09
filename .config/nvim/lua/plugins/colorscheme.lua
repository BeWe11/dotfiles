vim.cmd [[
let g:solarized_extra_hi_groups=1

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set t_ut= "fix background redrawing in tmux

let base16colorspace=256
let $BAT_THEME = 'base16'
let g:airline_theme = 'base16'

let s:DARK_THEME = 'base16-onedark'
let s:LIGHT_THEME = 'base16-one-light'

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

let s:PROFILE_NAME_PATH = expand("~/.vimprofilename")

function! s:WriteProfileName(profile_name)
  call writefile([a:profile_name], s:PROFILE_NAME_PATH)
endfunction
    
function! s:ReadProfileName()
  if filereadable(s:PROFILE_NAME_PATH)
    return readfile(fnameescape(s:PROFILE_NAME_PATH))[0]
  endif
  call s:WriteProfileName("dark")
  return "dark"
endfunction

function! s:LoadProfile(profile_name)
  call chansend(v:stderr, "\033Ptmux;\033\033]1337;SetProfile=" . a:profile_name . "\033\033\\\\\033\\")

  if a:profile_name == 'dark'
    execute "colo " . s:DARK_THEME
    " silent !osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to True'
  elseif a:profile_name == 'light'
    execute "colo " . s:LIGHT_THEME
    " silent !osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to False'
  endif

  call s:WriteProfileName(a:profile_name)
endfunction

call s:LoadProfile(s:ReadProfileName())

function! s:SwitchProfile()
  let profile_name = s:ReadProfileName()
  if profile_name == "dark"
    call s:LoadProfile("light")
  elseif profile_name == 'light'
    call s:LoadProfile("dark")
  endif
endfunction
map <silent> <F6> :call <SID>SwitchProfile()<CR>

]]
