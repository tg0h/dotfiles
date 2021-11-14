set wildignore+=**/.git/*
set wildignore+=**/node_modules/*

" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'kassio/neoterm'
Plug 'phanviet/vim-monokai-pro'

" reference homebrew path
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim',

" Code Completion
Plug 'sheerun/vim-polyglot' "2021-07-04

Plug 'junegunn/vim-plug' "help file for vim-plug
Plug 'junegunn/vim-peekaboo' "view contents of registers

" Git
Plug 'tpope/vim-fugitive' "git support
Plug 'tpope/vim-unimpaired' "git mappings for :Glo, January 9 2021 Sundayg
Plug 'shumphrey/fugitive-gitlab.vim' "enable Gbrowse for gitlab

" Utils
Plug 'tpope/vim-repeat' "20200502 - repeat plugin actions
Plug 'tpope/vim-surround' "surround text with '
Plug 'tpope/vim-commentary' "comment with gc, uncomment with gc again (it toggles)

" Files
Plug 'scrooloose/nerdtree' "file explorer

Plug 'mbbill/undotree' "July 16 2021 Friday

" Misc
Plug 'vimwiki/vimwiki' "20190628

" ICEBOX
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin' 
Plug 'ryanoasis/vim-devicons'
Plug 'chiel92/vim-autoformat' "20200222
Plug 'airblade/vim-gitgutter' "git gutter, show +/- in gutter January 9 2021 Sunday 
Plug 'itchyny/lightline.vim' "July 16 2021 Friday

call plug#end()
" => Plugins ======================================================================================================

" " CSS
" Plug 'ap/vim-css-color' "July 16 2021 Friday
" Plug 'christoomey/vim-run-interactive' "January 10 2021 Sunday
" Plug 'stsewd/fzf-checkout.vim' "fzf git checkout
" " Movement
" Plug 'easymotion/vim-easymotion'
" Plug 'haya14busa/vim-easyoperator-line' "easy motion for line operations
" Status
" Plug 'vim-airline/vim-airline' "20190630 status bar
" Plug 'vim-airline/vim-airline-themes' "20190630 airline themes
" Plug 'itchyny/lightline.vim' "July 16 2021 Friday
