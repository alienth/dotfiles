syntax on
set background=dark
set viminfo='20,"50

set softtabstop=2
set smartindent
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent

set nocompatible  " Clean out any compat. Necessary? FIXME
set cpoptions=$ " Change-word shows deleted chars

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backup " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.

filetype on  " Automatically detect file types.

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:Ꞁ,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

