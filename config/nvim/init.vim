" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin("~/.config/nvim/plugged")
Plug 'phanviet/vim-monokai-pro'

" FZF
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" reference homebrew path
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim',

" Code Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot' "2021-07-04

Plug 'junegunn/vim-plug' "help file for vim-plug
Plug 'junegunn/vim-peekaboo' "view contents of registers

" Git
Plug 'tpope/vim-fugitive' "git support
Plug 'tpope/vim-unimpaired' "git mappings for :Glo, January 9 2021 Sundayg
Plug 'airblade/vim-gitgutter' "git gutter, show +/- in gutter January 9 2021 Sunday 
Plug 'shumphrey/fugitive-gitlab.vim' "enable Gbrowse for gitlab
Plug 'stsewd/fzf-checkout.vim' "fzf git checkout

" Utils
Plug 'tpope/vim-repeat' "20200502 - repeat plugin actions
Plug 'tpope/vim-surround' "surround text with '
Plug 'tpope/vim-commentary' "comment with gc, uncomment with gc again (it toggles)

" Movement
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/vim-easyoperator-line' "easy motion for line operations

" Status
" Plug 'vim-airline/vim-airline' "20190630 status bar
" Plug 'vim-airline/vim-airline-themes' "20190630 airline themes
Plug 'itchyny/lightline.vim' "July 16 2021 Friday

" Files
Plug 'scrooloose/nerdtree' "file explorer
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin' 
Plug 'ryanoasis/vim-devicons'
" Plug 'sjl/gundo.vim' "undo tree
Plug 'mbbill/undotree' "July 16 2021 Friday
Plug 'chiel92/vim-autoformat' "20200222

" CSS
Plug 'ap/vim-css-color' "July 16 2021 Friday

" Misc
Plug 'christoomey/vim-run-interactive' "January 10 2021 Sunday
Plug 'vimwiki/vimwiki' "20190628

call plug#end()
" => Plugins ======================================================================================================


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
" turn off relative number when entering insert mode or buffer loses focus
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" show whitespace chars in VIM
set list listchars=tab:»\ ,trail:·,nbsp:⎵,precedes:<,extends:>

" set backspace=2            " Fix backspace behavior on most terminals.
" set cursorline             " show where the cursor is

"save your folds
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview 
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


" " Line moving
" " " Normal mode
nnoremap <Esc>^[[1;5B> :m .+1<CR>==
nnoremap <Esc>^[[1;5A> :m .-2<CR>==
" " Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" " Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"WINDOW MANAGEMENT ====================================================================================================
" Quicker window movement
"not sure why ctrl j does not work
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
""need to change fzf ctrl h mapping
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" see the ANSI key code by running sed -n l
" alt arrow keys go to window
" nmap <silent> <Esc>[1;9C :wincmd l<CR>
" nmap <silent> <Esc>[1;9B :wincmd j<CR>
" nmap <silent> <Esc>[1;9D :wincmd h<CR>
" nmap <silent> <Esc>[1;9A :wincmd k<CR>

noremap <BS> :bprevious<cr>  " backspace is previous buffer
noremap <S-BS> :bnext<cr>  " next buffer

" ========== fzf vim January 10 2021 Sunday =============================
" rip grep
nnoremap <C-J> :Rg<CR> 

" open files in git only
nnoremap <C-K> :GFiles<CR> 
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

nnoremap <C-H> :History<cr>
nnoremap <C-T> :Files<cr>
nnoremap <C-B> :Buffers<cr>
nmap <C-L> :Lines<cr>
nmap <LEADER>sbl :BLines<cr>

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
noremap <F10> :term<CR>
noremap <F1> :NERDTreeToggle<CR>
" even in insert mode, F2 means save
" ctrl o escapes insert mode so we can send :w
inoremap <F2> <C-O>:w <CR>
noremap <F2> :w <CR>
noremap <F3> :e ~/dotfiles/config/nvim/init.vim<CR>
nmap <F4> i<C-R>=strftime("%B %d %Y %A")<CR><Esc>
noremap <f5> :UndotreeShow<CR>
noremap <F6> :setlocal spell! spelllang=en_gb<CR> " Toggle Spellcheck
noremap <F7> :VimwikiTable<CR>
noremap <F9> :Autoformat<CR>
" map <S-Space> <Plug>VimwikiToggleListItem

"if fileType is vimwiki -- also, see ToggleCalendar function defined above
:autocmd FileType vimwiki map <localleader>d :VimwikiMakeDiaryNote<CR>
:autocmd FileType vimwiki map <localleader>c :call ToggleCalendar()<CR> 

"yaml tab spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


"SNIPPETS ====================================================================================================
nnoremap \html :-1read $HOME/dotfiles/vim/snippets/skeleton.html<CR>3jwf>a


"====================================================================================================

" Plug Settings ====================================================================================================
" undotree
set undodir=~/.config/nvim/undodir " set undotree file directory
set undofile " set undotree to save to file

"NETRW ---------------------------------------------------
let g:netrw_banner=0       "disable annoying banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     "tree view

"  vim easy motion ---------------------------------------------------
"display target labels an upper case
" map <Leader> <Plug>(easymotion-prefix)

let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
" match 3 and # with 3
let g:EasyMotion_use_smartsign_us = 1
" when searching, use smart case: v matches both v and V, V only matches V
let g:EasyMotion_smartcase = 1

"bidirectional (bid) and within line t motion, eg ct<char> change "to" char
" omap t <Plug>(easymotion-bd-tl)

" motion hjkl motion
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>h <Plug>(easymotion-linebackward)

" use easy motion's / instead of vim's /
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

"use easy motion's 2 character search
" nmap s <Plug>(easymotion-s2)
" nmap t <Plug>(easymotion-t2)

" nmap s <Plug>(easymotion-s)

"  vim easy operator line ---------------------------------------------------
" let g:EasyOperator_line_do_mapping = 0

" omap <silent>  <Plug>(easymotion-prefix)i <Plug>(easyoperator-line-select)
" xmap <silent>  <Plug>(easymotion-prefix)i <Plug>(easyoperator-line-select)
" nmap <silent> d<Plug>(easymotion-prefix)i <Plug>(easyoperator-line-delete)
" nmap <silent> y<Plug>(easymotion-prefix)i <Plug>(easyoperator-line-yank)

" omap <Leader>L  <Plug>(easyoperator-line-select)
" xmap <Leader>L  <Plug>(easyoperator-line-select)
" nmap d<Leader>L <Plug>(easyoperator-line-delete)
" nmap p<Leader>L <Plug>(easyoperator-line-yank) "this slows down the p command

"  vim notational velocity ----------------------------------------------------------
let g:nv_search_paths = ['~/certis/wiki']"
let g:nv_use_short_pathnames = 0 "show full paths
let g:nv_default_extension = ''

"vimwiki ----------------------------------------------------------
let wiki_1 = {}
let wiki_1.path = '~/src/certis/argus/argus-apps/argus-cc-test/docs/website/docs'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let wiki_1.list_margin = 0 "set the list indent to 0 when generating the diary index or TOC, this prevents markdown from treating the list as indented text
let wiki_1.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let wiki_1.custom_wiki2html = 'C:\users\timothy_goh\Desktop\vimwiki\timTest.ps1'

let g:vimwiki_list = [
                    \ {'path': '~/certis/docs/wiki', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path': 'diary/'},
                    \ wiki_1,
                    \]
let g:vimwiki_folding = 'expr' "but this setting does not fold headers
let g:vimwiki_global_ext = 0    "this setting turns off the association of the vimwiki file type to markdown files outside of the vimwiki folder

"Nerdtree settings ---------------------------------------------------------------------->
let NERDTreeShowBookmarks = 1  " Display bookmarks on startup.
let g:NERDTreeMinimalUI = 1 " hide helper
let g:NERDTreeIgnore = ['^node_modules$'] " ignore node_modules to increase load speed 
let g:NERDTreeStatusline = '' " set to empty to use lightline
" " Close window if NERDTree is the last one
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" " Map to open current file in NERDTree and set size
nnoremap <leader>pv :NERDTreeFind<bar> :vertical resize 45<CR>

" NERDTree Syntax Highlight
" " Enables folder icon highlighting using exact match
let g:NERDTreeHighlightFolders = 1 
" " Highlights the folder name
let g:NERDTreeHighlightFoldersFullName = 1 
" " Color customization
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
" " This line is needed to avoid error
let g:NERDTreeExtensionHighlightColor = {} 
" " Sets the colo of css files to blue
let g:NERDTreeExtensionHighlightColor['css'] = s:blue 
" " This line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor = {} 
" " Sets the color for .gitignore files
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange 
" " This line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor = {} 
" " Sets the color for files ending with _spec.rb
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red 
" " Sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFolderSymbolColor = s:beige 
" " Sets the color for files that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue 

" NERDTree Git Plugin
" let g:NERDTreeIndicatorMapCustom = {
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"airline settings---------------------------------------------------------------------->
" let g:airline_powerline_fonts = 1 "enable arrow separator
" let g:airline_theme='jellybeans'
" set encoding=utf-8 "to allow powerline fonts to work
" Lightline
let g:lightline = {
  \     'colorscheme': 'powerlineish',
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

"git gutter---------------------------------------------------------------------->
set updatetime=250 "show git diff markers in git gutter immediately
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"fugitive ---------------------------------------------------------------------->
let g:fugitive_gitlab_domains = ['https://git.ads.certis.site']
" Fugitive mapping
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>go :Gdiff<CR>
nmap <leader>gg :Ggrep
nmap <leader>gl :Gclog<CR>
nmap <leader>gp :Git pull<CR>
nmap <leader>gP :Git push<CR>
nmap <leader>gs :Git<CR>
nmap <leader>gw :Gbrowse<CR>

"conflict resolution
nmap <leader>gh :diffget //3<CR> "get right side, h is on the right in dvorak
nmap <leader>gu :diffget //2<CR> "get left side, h is on the left in dvorak

"Git
nmap <leader>gr :GBranches<CR>
"---------------------------------------------------------------------->

" fzf checkout? ------------------------------------------------------>
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = "--date=human --graph --color=always --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset %C(yellow)%ar%Creset'"

" let g:fzf_layout = { 'window': {'width': 0.95, 'height': 0.95} }

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

 " set a column line in vim
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Code Completion for ALE, COC and ------------------------------------>
" ALE (Asynchronous Lint Engine)
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_sign_error = '?'
let g:ale_sign_warning = '??'
let g:ale_fix_on_save = 1
" COC
" " COC extension
set shortmess+=c " for CoC plugin
let g:coc_user_config = {}
let g:coc_global_extensions = [
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-snippets', 
      \ 'coc-eslint']
" " To go back to previous state use Ctrl+O
nmap <silent><leader>gd <Plug>(coc-definition)
nmap <silent><leader>gy <Plug>(coc-type-definition)
nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" " Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh() 

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" " position. Coc only does snippet and additional edit on confirm.
" " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" " Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected

augroup mygroup
  autocmd!
  " " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" " Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" " Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
