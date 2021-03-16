"With thanks to Doug Black for 'A Good Vimrc':
"https://dougblack.io/words/a-good-vimrc.html

"Vundle
set nocompatible "disable vi compatibility
filetype off "disable file type detection
set rtp+=~/.vim/bundle/Vundle.vim "add Vundle.vim to the runtime path

call vundle#begin() "place Plugin commands after here

Plugin 'cespare/vim-toml'
Plugin 'VundleVim/Vundle.vim'

call vundle#end() "place Plugin commands before here

"Spaces and tabs
set expandtab "convert tabs to spaces
set tabstop=4 "number of spaces per tab
set shiftwidth=4 "number of spaces to apply when using the reindent operations
set softtabstop=4 "number of spaces per tab when editing

"User interface
set background=dark
syntax enable "highlight syntax
set colorcolumn=80 "highlight the given column
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

"Vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

"Miscellaneous
filetype plugin on
filetype indent on
set t_Co=256 "256 colour mode
