set path+=**
set wildignore+=**/.git/*
set wildignore+=**/node_modules/*
" Manage plugins with vim-plug.
" => Plugins ======================================================================================================
call plug#begin("$XDG_DATA_HOME/nvim/plugged")
Plug 'nvim-lua/plenary.nvim'
" Theme
Plug 'phanviet/vim-monokai-pro'
" Language Server Protocol
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'glepnir/lspsaga.nvim'
Plug 'folke/trouble.nvim'
" File Management
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
" Status Line
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
" Neovim Tree shitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'ThePrimeagen/git-worktree.nvim'
" Git
Plug 'tpope/vim-fugitive' "git support
Plug 'tpope/vim-unimpaired' "git mappings for :Glo, January 9 2021 Sundayg
" Utils
" Plug '/usr/local/opt/fzf' "reference homebrew path
" Plug 'junegunn/fzf.vim',
Plug 'tpope/vim-repeat' "20200502 - repeat plugin actions
Plug 'tpope/vim-surround' "surround text with '
Plug 'tpope/vim-commentary' "comment with gc, uncomment with gc again (it toggles)
" Plug 'mbbill/undotree' "July 16 2021 Friday
Plug 'junegunn/vim-peekaboo' "view contents of registers
Plug 'kassio/neoterm'
" Misc
Plug 'vimwiki/vimwiki' "20190628
" Plug 'michal-h21/vim-zettel' "20211127
call plug#end()
" => Plugins ======================================================================================================

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
