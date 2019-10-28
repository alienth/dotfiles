" Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on  " Automatically detect file types.

" Auto-load the man ftplugin
source $VIMRUNTIME/ftplugin/man.vim

set notitle
" Disable window titling in X-aware vim.
set noicon

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

set smartindent   " try to auto-add indents where they make sense
set autoindent    " copy indent from current line when starting new line
set smarttab      " shiftwidth blanks at line start, softtabstop elsewhere
set expandtab     " use blanks instead of literal <Tab>s
set softtabstop=4 " number of spaces a soft-<Tab> inserts when editing
set shiftwidth=4  " number of spaces to use for each autoindent
set shiftround    " Round indent to multiple of shiftwidth.
set tabstop=8     " literal tabs are 8 spaces

setglobal commentstring=#\ %s " Default to # for comments.

set backspace=2   " Backspace over everything (indents, EOL, start of line) in insert mode
set nowrap        " Line wrapping off
set nu            " Line numbers on
set ruler         " Ruler on (line number info in lower right)

set signcolumn=yes " Always enable the sign column.
                   " Without this, we get weird jumpiness when signs are added
                   " and removed by gitgutter.

set cpoptions+=$  " Change-word shows deleted chars

if exists('+clipboard')
  set clipboard=unnamedplus  " Yanks go to the ctrl-c '+' clipboard register
endif

set wildmenu
set wildmode=list:longest,full

set mouse=nvi " Allow mouse in normal, visual, insert mode.

" Backups & Files
set backup                    " Enable creation of backup files.
set backupdir=~/.vim/backup/  " Where backups will go.
set directory=~/.vim/tmp      " Where temporary files will go.
if exists('+undofile')
  set undofile                  " Use a persistent undofile
  set undodir=~/.vim/undo/
endif

" Visual stuff
set showmatch  " When a bracket is inserted, jump to the matching bracket.
set mat=5      " How long to jump to the matching bracket in tenths of a second.
set list       " Enable 'list mode', which visually displays certain characters
               " upon listchars rules.
set listchars=tab:\ \ ,eol:Ꞁ,trail:~,extends:>,precedes:<
set novisualbell  " No blinking the screen upon bells.
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set scrolloff=4   " Minimal number of screen lines to keep above and below cursor.
set breakindent   " When long lines are visually wrapped, maintain indentations.
set showbreak=\ + " Add a visual indicator of breakindent.
set linebreak     " Don't visually break in the middle of words.
set virtualedit=block   " Allow out-of-bounds cursor in visual block mode.

set foldmethod=indent
set foldlevelstart=20

set hlsearch   " hilight items found via search
set incsearch  " show matches when typing search cmd
set smartcase  " Case insensitive searches become sensitive with capitals.

set showcmd " display incomplete commands in laststatus.
            " For example, typing the start of a multi-key binding will
            " show each successive key typed in the lower right. Useful
            " for identifying when you're starting a command.

set hidden  " When you 'abandon' a buffer (i.e., when you no longer have a
            " buffer displayed), simply hide it rather than unloading it.
            " Without this, hiding a modified buffer would error due to that
            " buffer not being saved.

set lazyredraw " don't update screen when in the middle of executing macros

" How quickly swapfile is written after nothing being typed.
" Impacts git-gutter update times.
set updatetime=100

" Mappings
let mapleader = " "
let g:mapleader = " "

" Window movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nmap <C-n> :bnext<cr>
nmap <C-p> :bprev<cr>

" 'Edit nearby' - edit command prefilled with the dir of the file currently
" being edited.
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
nmap <leader>ew :e %%

set timeoutlen=500 " The time in milliseconds that is waited for a key code or
                   " mapped key sequence to complete.

" Use a darker red background for diff'd text.
hi DiffText term=reverse cterm=bold ctermbg=52

" autocommands

au FileType python syn match dangerZone /\%79v.\+/ display
au FileType python hi def link dangerZone error

" Preserve folding when a file is reopened
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview

" Return to last edit position when opening files, except on git commit
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft != 'gitcommit' |
     \   exe "normal! g`\"" |
     \ endif

"------------------------------------------------------------------------------
" neocomplete
"------------------------------------------------------------------------------

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1 " When matching for completion, ignore
                                        " case *unless* input includes a
                                        " capital letter.

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" This disables neocomplete in *ku* buffers, for the `ku` plugin.
" I don't use this so commenting it out.
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionaries for certain filetypes.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Initialize keyword_patterns.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
" A keyword is something that is a candidate for completion. neocomplete
" automatically caches keywords matching the defined pattern. In this case,
" we're matching words which are fully word-characters.
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Undo any pending completion and seek back to where we started.
inoremap <expr><C-g>     neocomplete#undo_completion()

" Complete the candidates up to the longest-common-string present.
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" Map <CR> to an expression evaluation (see <C-R> for '=' case)
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " If the popupmenu is visible, use <C-y> to close the popup menu, and press
  " enter. (see copmlete_CTRL-Y)
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction


" <TAB>: completion.
" If the popupmenu is visible, hit Ctrl-n to iterate to next kw.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" Automatically select the first candidate.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
" Omnicomplete allows vim to guess what type of item we are completing.
" The functions referred to here come default with vim, and can be found in
" /usr/share/vim/vim80/autoload
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"if has('python3')
"  autocmd FileType python setlocal omnifunc=python3complete#Complete
"elseif has('python')
"  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"endif
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

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'


"------------------------------------------------------------------------------
" tagbar
"------------------------------------------------------------------------------

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


"------------------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------------------

" Make sure that when NT root is changed, Vim's pwd is also updated
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
" Toggle on/off
nmap <leader>o :NERDTreeToggle<cr>


"------------------------------------------------------------------------------
" ctrlp
"------------------------------------------------------------------------------

" Have ctrlp ignore a bunch of shit we don't want to search
let g:ctrlp_custom_ignore = '\v/(\.config|\.cache|\.local|\.npm|\.minecraft|\.git|\.svn|\.oh-my-zsh|env)$'
let g:ctrlp_map = '<leader>p'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

"------------------------------------------------------------------------------
" Fugitive
"------------------------------------------------------------------------------
map <leader>gdi :Gdiff<cr>
map <leader>gst :Gstatus<cr>
map <leader>dup :diffupdate<cr>
map <leader>gc :w<cr>:Gcom -v<cr>
map <leader>wip :Gwr<cr>:Gcom -m wip<cr>
map <leader>gg :Gg 

"------------------------------------------------------------------------------
" gitgutter
"------------------------------------------------------------------------------
nmap <leader>hr <Plug>GitGutterUndoHunk

"------------------------------------------------------------------------------
" vim-go
"------------------------------------------------------------------------------

" By default syntax-highlighting for Functions, Methods and Structs is
" disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)

"------------------------------------------------------------------------------
" python-mode
"------------------------------------------------------------------------------
let g:pymode = 0
let g:pymode_options = 1
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
let g:pymode_doc = 1

let g:pymode_lint = 0
let g:pymode_lint_checkers = ['pep8', 'pep257']
let g:pymode_trim_whitespaces = 0

let g:pymode_rope = 0
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_goto_definition_bind = 'gd'
let g:pymode_rope_goto_definition_cmd = 'e'

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
" Disable the vertical red bar at the 80th column.
let g:pymode_options_colorcolumn = 0

"------------------------------------------------------------------------------
" jedi-vim
"------------------------------------------------------------------------------
" We disable this stuff since we're relying upon neocomplete.
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

" Don't automatically close docstring in preview window. Fairly jarring.
let g:jedi#auto_close_doc = 0

let g:jedi#goto_assignments_command = "gd"
let g:jedi#goto_definitions_command = "gD"

" Disable showing call signatures, as it inserts data in the line above the
" edited line, causing weirdness and Ctrl-C to leave garbage (unless you remap
" it).
let g:jedi#show_call_signatures = 0

autocmd FileType python setlocal omnifunc=jedi#completions

"------------------------------------------------------------------------------
" eclim
"------------------------------------------------------------------------------
" TODO: Only load these if eclim is loaded?
au FileType java nmap <leader>gd :<C-u>call eclim#java#doc#Preview()<CR>
au FileType java nnoremap <buffer> <silent> gd :JavaSearchContext<cr>

let g:EclimCompletionMethod = "omnifunc"


"------------------------------------------------------------------------------
" notes stuff
"------------------------------------------------------------------------------

autocmd FileType notes NeoCompleteLock " Disable neocomplete autocomplete in notes.

let g:notes_directories = ['~/notes']
let g:notes_word_boundaries = 1
let g:notes_conceal_url = 0
let g:notes_smart_quotes = 0

hi Title term=bold cterm=bold ctermfg=3 gui=bold guifg=#ffff60

"------------------------------------------------------------------------------
" other
"------------------------------------------------------------------------------

" When I press F10, show hilight info for object under cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

