set path+=**

set wildignore+=**/.git/*
set wildignore+=**/node_modules/*

" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
" Plug 'onsails/lspkind-nvim'

" Plug 'glepnir/lspsaga.nvim'
" Plug 'simrat39/symbols-outline.nvim'

Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'

" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'ThePrimeagen/git-worktree.nvim'

" " Debugger Plugins
" Plug 'mfussenegger/nvim-dap'
" Plug 'Pocco81/DAPInstall.nvim'
" Plug 'szw/vim-maximizer'

" " Snippets
" Plug 'L3MON4D3/LuaSnip'
" Plug 'rafamadriz/friendly-snippets'

" " telescope requirements...
" Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" " HARPOON!!
" Plug 'mhinz/vim-rfc'

" " prettier
" Plug 'sbdchd/neoformat'

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

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

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
