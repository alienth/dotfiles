" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on  " Automatically detect file types.

syntax on
set background=dark

" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history
" /20  - remember 20 items in search history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,/20,%

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

set cpoptions+=$ " Change-word shows deleted chars

set clipboard+=unnamed  " Yanks go on clipboard instead.

set wildmenu
set wildmode=list:longest,full

" Backups & Files
set backup                     " Enable creation of backup file.
set backupdir=~/.vim/backup// " Where backups will go.
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
set foldlevelstart=20

set hlsearch   " hilight items found via search
set incsearch  " show matches when typing search cmd

set showcmd " display incomplete commands in laststatus

set hidden " hide buffer when it becomes abandoned

set lazyredraw " don't update screen when executing macros

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Mappings
let mapleader = " "
let g:mapleader = " "

" Window movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Decrease timeoutlen for key sequences
set timeoutlen=500

set pastetoggle=<F2>
map <F3> :set nonu lcs=
map <F5> :DiffOrig<CR>

" autocommands

au FileType python syn match dangerZone /\%79v.\+/ display
au FileType python hi def link dangerZone error

au FileType notes silent! colorscheme slate

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ----- plugin options below
"
" Have ctrlp ignore a bunch of shit we don't want to search
let g:ctrlp_custom_ignore = '\v/(\.config|\.cache|\.local|\.npm|\.minecraft|\.git|\.svn|\.oh-my-zsh|env)$'

let g:notes_directories = ['~/notes']
let g:notes_word_boundaries = 1
let g:notes_conceal_url = 0
let g:notes_smart_quotes = 0

let g:pymode = 1
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
let g:pymode_doc = 1

let g:pymode_lint = 0
let g:pymode_lint_checkers = ['pep8', 'pep257']
let g:pymode_trim_whitespaces = 0

let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_goto_definition_bind = '<C-c>g'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_rope_goto_definition_cmd = 'e'


let g:neocomplete#enable_at_startup = 1

nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
" Toggle on/off
nmap <leader>o :NERDTreeToggle<cr>

autocmd FileType notes NeoCompleteLock

" By default syntax-highlighting for Functions, Methods and Structs is
" disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


" Preserve folding when a file is reopened
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview

let g:ctrlp_map = '<leader>p'
nmap <C-n> :bnext<cr>
nmap <C-p> :bprev<cr>

"------------------------------------------------------------------------------
" Fugitive
"------------------------------------------------------------------------------
map <leader>gdi :Gdiff<cr>
map <leader>gst :Gstatus<cr>
map <leader>dup :diffupdate<cr>
map <leader>gc :Gcom<cr>


"------------------------------------------------------------------------------
" vim-go
"------------------------------------------------------------------------------
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

au FileType go :TagbarOpen
