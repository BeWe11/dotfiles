" Vim compiler file
" Compiler:        Python
" Maintainer:   Christoph Herzog <ccf.herzog@gmx.net>
" Last Change:  2002 Nov 9

if exists("current_compiler")
  finish
endif
let current_compiler = "python"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=python\ %

"the last line: \%-G%.%# is meant to suppress some
"late error messages that I found could occur e.g.
"with wxPython and that prevent one from using :clast
"to go to the relevant file and line of the traceback.

" FIXME: Add (+=) the format instead of setting it to not override the standard
" format. Mainly here to allow AsyncRun to correctly parse input from ack
" search. There should be a better way to do this.
" See
" https://flukus.github.io/2015/07/03/2015_07_03-Vim-errorformat-Demystified/
" for a good explanation of the vim errorformat.
CompilerSet errorformat+=
    \%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
    \%C\ \ \ \ %.%#,
    \%+Z%.%#Error\:\ %.%#,
    \%A\ \ File\ \"%f\"\\\,\ line\ %l,
    \%+C\ \ %.%#,
    \%-C%p^,
    \%Z%m,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

"vim: ft=vim
