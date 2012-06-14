set nocompatible

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on
set autoindent

" allow hidding of modified buffers
set hidden

" map leader
let mapleader=","

set background=dark

" colorscheme peachpuff
colorscheme default
" colorscheme morning

" make backup files
set backup
" backup file directory
set backupdir=~/.vim/backup

" swap file directory
set directory=~/.vim/tmp


" no noise
set noerrorbells

" comand line completion
set wildmenu
" ignored files from completion
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.dll
" type of completion list
set wildmode=full


" highlight current line
"set cursorline

" always show status line
set laststatus=2

" show current position
set ruler

" show tabs and trailing spaces
set listchars=tab:>-,trail:-

" line number
set number
" number of digits
set numberwidth=4

" min lines above/below
set scrolloff=5

" show command as typed
set showcmd

" show matching brackets
set showmatch

" tabs to spaces
set expandtab
" width of tab
set softtabstop=4
" auto indent amount
set shiftwidth=4

" auto insert comments
set formatoptions=rq

" case insensitive
set ignorecase

" incremental search
set incsearch
" highlight search results
set hlsearch

" no wrap by default
set nowrap

" Backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" hide seach results
nnoremap <leader><space> :nohlsearch<cr>

" show CommandT
map <leader>f :CommandT<cr>

set tags=/home/ost/.ctags

" Python mode settings

let g:pymode_folding = 0
let g:pymode_breakpoint = 0

let g:pymode_lint_checker = "pylint"
let g:pymode_lint_ignore = "C0324"

let g:pymode_syntax_slow_sync = 1
