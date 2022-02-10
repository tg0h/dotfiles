local o = vim.opt
local wo = vim.wo
local fn = vim.fn

-- vim.cmd "filetype indent plugin on"

o.swapfile = false -- enable/disable swap file creation
o.termguicolors = true -- set term gui colors (most terminals support this)
o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
o.number = true -- set numbered lines
o.relativenumber = true -- set relative numbered lines
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- how many columns a tab counts for

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.list = true
o.listchars = {
    trail = "·",
    tab = "» ",
    nbsp = "⎵",
    precedes = "<",
    extends = ">"
} -- tab needs to be specified as 2 chars!

o.shortmess = "I" -- turn off splashscreen message
