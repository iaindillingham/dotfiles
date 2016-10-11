:set colorcolumn=80
:set spell spelllang=en_gb

hi clear SpellBad
hi SpellBad cterm=underline

hi clear SpellCap
hi SpellCap cterm=underline

hi clear SpellRare
hi SpellRare cterm=underline

hi clear SpellLocal
hi SpellLocal cterm=underline

:set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

set path=$PWD/**

filetype plugin on

syntax enable

set background=dark

colorscheme solarized
