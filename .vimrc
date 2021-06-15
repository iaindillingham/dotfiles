"With thanks to Doug Black for 'A Good Vimrc':
"https://dougblack.io/words/a-good-vimrc.html

"Spaces and tabs
set expandtab "convert tabs to spaces
set tabstop=4 "number of spaces per tab
set shiftwidth=4 "number of spaces to apply when using the reindent operations
set softtabstop=4 "number of spaces per tab when editing

"User interface
set background=dark
set t_Co=256 "256 colour mode
syntax enable "highlight syntax
set colorcolumn=89 "highlight the given column
set cursorline "highlight current line
set showmatch "highlight matching braces
set number "show line numbers
set relativenumber "show relative line numbers
set wildmenu "autocomplete command menu

"Spelling
set spell spelllang=en_gb
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline

"Search
set incsearch "incremental search
set hlsearch "highlight matches
set path=$PWD/**

"Minpac, a minimal package manager
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
command! PacClean call minpac#clean()
command! PacUpdate call minpac#update()

"Plugins
call minpac#add('cespare/vim-toml')
call minpac#add('tpope/vim-surround')

"Miscellaneous
filetype plugin on
filetype indent on
