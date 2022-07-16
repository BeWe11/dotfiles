vim.cmd [[
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
]]
