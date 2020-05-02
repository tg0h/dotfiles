" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin()
Plug 'junegunn/vim-plug' "help file for vim-plug

Plug 'scrooloose/nerdtree' "file explorer
Plug 'ctrlpvim/ctrlp.vim'

Plug 'easymotion/vim-easymotion'

"Plug 'junegunn/fzf', { 'dir': '~/fzf', 'do': './install --all' }
"Plug 'alok/notational-fzf-vim' "june gunn vim plug :( not working
Plug 'vimwiki/vimwiki' "20190628
" Plug 'mattn/calendar-vim' "20190704

Plug 'tpope/vim-surround' "surround text with '
Plug 'tpope/vim-commentary' "comment with gc, uncomment with gc again (it toggles)
Plug 'sjl/gundo.vim' "undo tree
"Plug 'morhetz/gruvbox' "color scheme
Plug 'vim-airline/vim-airline' "20190630 status bar
Plug 'vim-airline/vim-airline-themes' "20190630 airline themes
"Plug 'dbeniamine/todo.txt-vim' "20190630
Plug 'chiel92/vim-autoformat' "20200222

call plug#end()
"Plug 'majutsushi/tagbar' "20190718 a navigation menu of tags, need to install ctags as well? For vimwiki navigation 
" Plug 'christoomey/vim-tmux-navigator' "20191117 use the same window keymappings for tmux and vim

" Vim Settings  ======================================================================================================
"set termguicolors "set true color support for gruvbox
"set background=dark " set dark version of gruvb
colorscheme darkblue " Change a colorscheme.

" set guifont=Hack:h14 "2019 July 18 Thursday 
set guifont=RobotoMonoForPowerline-Light:h18

set clipboard=unnamed  " Copy into system (*) register.
" vim buffer management, press tab to list buffers
set wildchar=<Tab> wildmenu wildmode=full
set hlsearch               " highlight search patterns

set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=2              " Number of spaces tab is counted for.
set shiftwidth=2           " Number of spaces to use for autoindent.
set nu                     " show line numbers
" set backspace=2            " Fix backspace behavior on most terminals.
" set cursorline             " show where the cursor is

"save your folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview 

set incsearch              " highlight search pattern as you typek

" Vim mappings ====================================================================================================
" n                 normal mode map
" i                 insert
" v                 visual and select mode
" x                 visual mode map
" s                 select mode map - mode that mimics selection in windows, 
" c                 command line mode map
" o                 operator pending mode map
" :map or :noremap  normal, visual, and operator pending mode map
let mapleader = " "
let maplocalleader = ","

" the map commands cannot be followed by an end of line comment because the " is interpreted as part of the rhs

noremap <F2> :w <cr>
noremap <F3> :e $MYVIMRC<cr>
nmap <F4> i<C-R>=strftime("%B %d %Y %A")<CR><Esc>
noremap <f5> :GundoToggle<cr>  " Map Gundo to <F5>.
noremap <F6> :setlocal spell! spelllang=en_gb<CR> " Toggle Spellcheck
noremap <F7> :VimwikiTable<CR>
noremap <F9> :Autoformat<CR>
noremap <BS> :bprevious<cr>  " backspace is previous buffer
noremap <S-BS> :bnext<cr>  " next buffer
nmap <leader>ne :NERDTreeToggle<cr> " NERD Tree
:map <S-Space> <Plug>VimwikiToggleListItem
"notational fzf vim
nnoremap <leader>a :NV<CR>
"CtrlP mappings
nnoremap <C-b> :CtrlPBuffer<cr>  " Map CtrlP buffer mode to Ctrl + b
nnoremap <C-j> :CtrlPMRU<cr>  " Map CtrlP MRU mode to Ctrl + j

"if fileType is vimwiki -- also, see ToggleCalendar function defined above
:autocmd FileType vimwiki map <localleader>d :VimwikiMakeDiaryNote<CR>
:autocmd FileType vimwiki map <localleader>c :call ToggleCalendar()<CR> 
map <S-Space> <Plug>VimwikiToggleListItem

"yaml tab spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" Plug Settings ====================================================================================================
"  vim notational velocity
let g:nv_search_paths = ['~/certis/wiki']"
let g:nv_use_short_pathnames = 0 "show full paths
let g:nv_default_extension = ''

"vimwiki ----------------------------------------------------------
let wiki_1 = {}
let wiki_1.path = '~/wiki'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.list_margin = 0 "set the list indent to 0 when generating the diary index or TOC, this prevents markdown from treating the list as indented text
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let wiki_1.custom_wiki2html = 'C:\users\timothy_goh\Desktop\vimwiki\timTest.ps1'

let g:vimwiki_list = [
                    \ {'path': '~/certis/wiki', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path': 'diary/'},
                    \ wiki_1,
                    \]
let g:vimwiki_folding = 'expr' "but this setting does not fold headers
let g:vimwiki_global_ext = 0    "this setting turns off the association of the vimwiki file type to markdown files outside of the vimwiki folder

"Nerdtree settings ---------------------------------------------------------------------->
let NERDTreeShowBookmarks = 1  " Display bookmarks on startup.

"airline settings---------------------------------------------------------------------->
let g:airline_powerline_fonts = 1 "enable arrow separator
let g:airline_theme='badwolf'
set encoding=utf-8 "to allow powerline fonts to work


" add - as a keyword, so that when you asterisk search "upper-case", it
" selects the whole word
set isk+=-
