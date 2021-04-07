" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin()
" Plug 'bluz71/vim-nightfly-guicolors'
Plug 'agude/vim-eldar' "vim color scheme - courtesy alexgude.com/blog/vim-eldar/

Plug 'tpope/vim-fugitive' "git support
Plug 'tpope/vim-unimpaired' "git mappings for :Glo, January 9 2021 Sundayg
Plug 'shumphrey/fugitive-gitlab.vim' "enable Gbrowse for gitlab
Plug 'stsewd/fzf-checkout.vim' "fzf git checkout

Plug 'christoomey/vim-run-interactive' "January 10 2021 Sunday

Plug 'airblade/vim-gitgutter' "git gutter, show +/- in gutter January 9 2021 Sunday 
" Plug 'wikitopian/hardmode' "vim hard mode
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode() "enable hard mode by default:v

Plug 'junegunn/vim-plug' "help file for vim-plug

Plug 'junegunn/vim-peekaboo' "view contents of registers

Plug 'scrooloose/nerdtree' "file explorer
" Plug 'ctrlpvim/ctrlp.vim'

Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-easyoperator-line' "easy motion for line operations
" Plug 'haya14busa/vim-easyoperator-phrase' "easy motion for line operations

Plug 'junegunn/fzf', { 'dir': '~/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim', 
"Plug 'alok/notational-fzf-vim' "june gunn vim plug :( not working
Plug 'vimwiki/vimwiki' "20190628
" Plug 'mattn/calendar-vim' "20190704

Plug 'tpope/vim-surround' "surround text with '
Plug 'tpope/vim-commentary' "comment with gc, uncomment with gc again (it toggles)
Plug 'sjl/gundo.vim' "undo tree
"Plug 'morhetz/gruvbox' "color scheme
Plug 'vim-airline/vim-airline' "20190630 status bar
Plug 'vim-airline/vim-airline-themes' "20190630 airline themes
Plug 'gosukiwi/vim-atom-dark' "theme
Plug 'nanotech/jellybeans.vim' "theme
"Plug 'dbeniamine/todo.txt-vim' "20190630
Plug 'chiel92/vim-autoformat' "20200222
Plug 'tpope/vim-repeat' "20200502 - repeat plugin actions

" Plug 'kana/vim-textobj-function' "20200508 - vim function as textobj use daf etc
call plug#end()
"Plug 'majutsushi/tagbar' "20190718 a navigation menu of tags, need to install ctags as well? For vimwiki navigation 
" Plug 'christoomey/vim-tmux-navigator' "20191117 use the same window keymappings for tmux and vim
" => Plugins ======================================================================================================


" Vim Settings  ======================================================================================================
set nocompatible "tell vim not to try to be compatible with legacy features
syntax enable
filetype plugin on
set wildmenu "show menu on tab completion

" FINDING FILES
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" TAG JUMPING
" Create the `tags` file (may need to install ctags first)
" ! means run shell command, -R means recursive, dot means dot
" After this you can use ctrl ] to jum to tag under cursor
" g ctrl ] for ambiguous tags
" ctrl t to jump back up the tag stack
command! MakeTags !ctags -R .



set termguicolors "set true color support for gruvbox
"set background=dark " set dark version of gruvb
colorscheme eldar " Change a colorscheme.

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
set nu rnu                 " Hybird mode (both absolute and relative line numbers turned on)

" turn off relative number when entering insert mode or buffer loses focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

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

map <Leader> <Plug>(easymotion-prefix)

" the map commands cannot be followed by an end of line comment because the " is interpreted as part of the rhs

"WINDOW MANAGEMENT ====================================================================================================
" Quicker window movement
"not sure why ctrl j does not work
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
"need to change fzf ctrl h mapping
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap <BS> :bprevious<cr>  " backspace is previous buffer
noremap <S-BS> :bnext<cr>  " next buffer
"CtrlP mappings - kill ctrlp, January 10 2021 Sunday, use fzf instead
" nnoremap <C-b> :CtrlPBuffer<cr>  " Map CtrlP buffer mode to Ctrl + b
" nnoremap <C-j> :CtrlPMRU<cr>  " Map CtrlP MRU mode to Ctrl + j

" Map Ctrl + p to open fuzzy find (FZF)
" ========== fzf vim January 10 2021 Sunday 
nmap <leader>sr :Rg<cr>
nnoremap <c-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>
nmap <leader>sl :Lines<cr>
nmap <leader>sbl :BLines<cr>

"History
nnoremap <c-h> :History<cr>
"Command History
nmap <leader>sh :History:<cr>
"Search History
nmap <leader>ss :History/<cr>

"Actions
nmap <leader>sc :Commands<cr>
nmap <leader>sm :Maps<cr>
nmap <leader>sk :Marks<cr>


" Git ---------------------------------
nmap <leader>sgc :Commits<cr>
nmap <leader>sbc :BCommits<cr>
"git ls-files
nmap <leader>sgf :GFiles<cr>
"git status
nmap <leader>sgs :GFiles?<cr>
" ---------------------------------

nmap <leader>st :Tags<cr>
nmap <leader>sbt :BTags<cr>
" ========== fzf vim January 10 2021 Sunday - END


"quickfix
nnoremap n :cn<cr> " map alt n to next in quickfix list (this only works in iterm, not in mvim) 
" nnoremap ˜ :cn<cr> " map alt n to next in quickfix list (this only works in mvim) 
nnoremap p :cp<cr> " map alt p to next in quickfix list (this only works in iterm, not in mvim)
nnoremap π :cp<cr> " map alt n to next in quickfix list (this only works in mvim) 
"buffers
:nnoremap <Leader>q :Bdelete<CR> " close the current buffer
"====================================================================================================

" Run commands that require an interactive shell
nnoremap <Leader>r :RunInInteractiveShell<Space> "January 10 2021 Sunday 

"uses fzf vim :Helptags
noremap <F1> :Helptags <cr>
noremap <F2> :w <cr>
noremap <F3> :e ~/dotfiles/vimrc<cr>
nmap <F4> i<C-R>=strftime("%B %d %Y %A")<CR><Esc>
noremap <f5> :GundoToggle<cr>  " Map Gundo to <F5>.
noremap <F6> :setlocal spell! spelllang=en_gb<CR> " Toggle Spellcheck
noremap <F7> :VimwikiTable<CR>
noremap <F9> :Autoformat<CR>
nmap <leader>ne :NERDTreeToggle<cr> " NERD Tree
:map <S-Space> <Plug>VimwikiToggleListItem
"notational fzf vim
nnoremap <leader>a :NV<CR>

"if fileType is vimwiki -- also, see ToggleCalendar function defined above
:autocmd FileType vimwiki map <localleader>d :VimwikiMakeDiaryNote<CR>
:autocmd FileType vimwiki map <localleader>c :call ToggleCalendar()<CR> 
map <S-Space> <Plug>VimwikiToggleListItem

"yaml tab spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


"SNIPPETS ====================================================================================================
nnoremap \html :-1read $HOME/dotfiles/vim/snippets/skeleton.html<CR>3jwf>a


"====================================================================================================

" Plug Settings ====================================================================================================
"NETRW ---------------------------------------------------
let g:netrw_banner=0       "disable annoying banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     "tree view

"  vim easy motion ---------------------------------------------------
"display target labels an upper case
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" match 3 and # with 3
let g:EasyMotion_use_smartsign_us = 1
" when searching, use smart case: v matches both v and V, V only matches V
let g:EasyMotion_smartcase = 1

"bidirectional (bid) and within line t motion, eg ct<char> change "to" char
omap t <Plug>(easymotion-bd-tl)

" motion hjkl motion
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)

" use easy motion's / instead of vim's /
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

"use easy motion's 2 character search
" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)

" nmap s <Plug>(easymotion-s)

"  vim easy operator line ---------------------------------------------------
let g:EasyOperator_line_do_mapping = 0

omap <silent>  <Plug>(easymotion-prefix)i <Plug>(easyoperator-line-select)
xmap <silent>  <Plug>(easymotion-prefix)i <Plug>(easyoperator-line-select)
nmap <silent> d<Plug>(easymotion-prefix)i <Plug>(easyoperator-line-delete)
nmap <silent> y<Plug>(easymotion-prefix)i <Plug>(easyoperator-line-yank)

omap <Leader>L  <Plug>(easyoperator-line-select)
xmap <Leader>L  <Plug>(easyoperator-line-select)
nmap d<Leader>L <Plug>(easyoperator-line-delete)
" nmap p<Leader>L <Plug>(easyoperator-line-yank) "this slows down the p command

"  vim notational velocity ----------------------------------------------------------
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
let g:airline_theme='jellybeans'
set encoding=utf-8 "to allow powerline fonts to work

"git gutter---------------------------------------------------------------------->
set updatetime=10 "show git diff markers in git gutter immediately
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"fugitive ---------------------------------------------------------------------->
let g:fugitive_gitlab_domains = ['https://git.ads.certis.site']
" Fugitive mapping
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>gg :Ggrep
nmap <leader>gl :Glog<cr>
nmap <leader>gp :Git pull<cr>
nmap <leader>gP :Git push<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gw :Gbrowse<cr>

"conflict resolution
nmap <leader>gh :diffget //3<CR> "get right side, h is on the right in dvorak
nmap <leader>gu :diffget //2<CR> "get left side, h is on the left in dvorak

"Git
nmap <leader>gr :GBranches<CR>
"---------------------------------------------------------------------->

" fzf checkout? ------------------------------------------------------>
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = "--date=human --graph --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset %C(yellow)%ar%Creset'"

let g:fzf_layout = { 'window': {'width': 0.95, 'height': 0.95} }

"ctrl t to checkout remote branch
let g:fzf_branch_actions = {
      \ 'track': {'keymap': 'ctrl-t'},
      \}
" ------------------------------------------------------>


" add - as a keyword, so that when you asterisk search "upper-case", it
" selects the whole word
set isk+=-

" prefer vertical splits when doing vimdiff
set diffopt+=vertical
