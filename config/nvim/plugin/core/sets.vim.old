" FINDING FILES
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Vim Settings  ======================================================================================================
set nocompatible "tell vim not to try to be compatible with legacy features
syntax enable
syntax on "turn on syntax highlighting
set nobackup " set no backup file
set nowritebackup " set to never save backup                                 
set noswapfile " set no swap file 
filetype plugin on
set wildmenu "show menu on tab completion
set hidden
set smartcase " set to be cas sensitive when there is capital letter, this need set incsearch to work
set incsearch " set search to be case insensitive
set scrolloff=8 " don't have to go to the last line before it starts scrolling

set termguicolors "set true color support for gruvbox
"set background=dark " set dark version of gruvb
colorscheme monokai_pro " Change a colorscheme.

" set guifont=Hack:h14 "2019 July 18 Thursday 
set guifont=RobotoMonoForPowerline-Light:h24

set clipboard=unnamed  " Copy into system (*) register.
" vim buffer management, press tab to list buffers
set wildchar=<Tab> wildmenu wildmode=full
set hlsearch               " highlight search patterns

set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=2              " Number of spaces tab is counted for.
set shiftwidth=2           " Number of spaces to use for autoindent.
set nu rnu                 " Hybrid mode (both absolute and relative line numbers turned on)

" show whitespace chars in VIM
set list listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" set backspace=2            " Fix backspace behavior on most terminals.
" set cursorline             " show where the cursor is

" undotree will use this
set undodir=$XDG_CACHE_HOME/nvim/undodir
set undofile " set undotree to save to file

" prefer vertical splits when doing vimdiff
set diffopt+=vertical

" add - as a keyword, so that when you asterisk search "upper-case", it
" selects the whole word
set isk+=-

" turn off intro message
set shortmess=I
