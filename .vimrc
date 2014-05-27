" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()

filetype on  " Automatically detect file types.

syntax on
set background=dark
set viminfo='20,"50

set nocompatible  " Clean out any compat. Necessary? FIXME

set smartindent " try to auto-add indents where they make sense
set autoindent  " copy indent from current line when starting new line
set smarttab    " insert shiftwidth number of blanks in front of a line
set expandtab   " use blanks instead of literal <Tab>s
set sts=4       " number of spaces a <Tab> counts for when editing
set shiftwidth=4  " number of spaces to use for each autoindent
set ts=8        " literal tabs are 8 spaces

set bs=2        " Backspace over everything in insert mode
set nowrap  " Line wrapping off
set nu  " Line numbers on
set ruler  " Ruler on

set cpoptions=$ " Change-word shows deleted chars

set clipboard+=unnamed  " Yanks go on clipboard instead.

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backup " Where backups will go.
set directory=~/.vim/tmp     " Where temporary files will go.

set scrolloff=4


" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
" Show $ at end of line and trailing space as ~
set lcs=tab:\ \ ,eol:Ꞁ,trail:~,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

set foldmethod=indent

set hlsearch   " hilight items found via search
set incsearch  " show matches when typing search cmd

set showcmd " display incomplete commands in laststatus

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
