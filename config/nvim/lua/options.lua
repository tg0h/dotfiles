local o = vim.opt -- set
local wo = vim.wo -- setlocal for window-local options
local bo = vim.bo -- setlocal for buffer-local options
local go = vim.go -- setglobal
local fn = vim.fn

-- vim.cmd "filetype indent plugin on"

o.swapfile = false -- enable/disable swap file creation
o.termguicolors = true -- set term gui colors (most terminals support this)
o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
o.number = true -- set numbered lines
o.relativenumber = true -- set relative numbered lines
o.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard

o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- how many columns a tab counts for

o.foldenable = false -- do not fold by default
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
o.list = true
o.listchars = {trail = '·', tab = '» ', nbsp = '⎵', precedes = '<', extends = '>'} -- tab needs to be specified as 2 chars!

o.shortmess = 'Iat' -- turn off intro message, abbreviate, truncate
o.undofile = true -- enable undofile creation
o.undodir = fn.stdpath('cache') .. '/undodir'
-- o.cursorline = true
o.ignorecase = true -- ignore case in search patterns
o.smartcase = true -- smart case - only works if ignorecase is true
o.cmdheight = 1 -- space for displaying messages/commands
o.grepprg = 'rg --hidden --vimgrep --smart-case --' -- use rg instead of grep
