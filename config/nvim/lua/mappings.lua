local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- map the leader key
map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Nvim Tree
map("n", "<A-u>", ":NvimTreeToggle<CR>", default_options) -- Toggle Nvim Tree

-- window movement
map("n", "<A-Up>", ":wincmd k<CR>", default_options)
map("n", "<A-Down>", ":wincmd j<CR>", default_options)
map("n", "<A-Left>", ":wincmd h<CR>", default_options)
map("n", "<A-Right>", ":wincmd l<CR>", default_options)
map("n", "<A-->", ":wincmd w<CR>", default_options) -- previous window

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_options)
map("n", "<Right>", ":vertical resize -1<CR>", default_options)
map("n", "<Up>", ":resize -1<CR>", default_options)
map("n", "<Down>", ":resize +1<CR>", default_options)

-- save file
map("n", "<localleader>w", ":w<CR>", default_options)

-- buffers
map("n", "<A-a>", ":e#<CR>", default_options) -- edit previously opened buffer
map("n", "<A-g>", ":BufferLineCyclePrev<CR>", default_options) -- Go to left buffer 'tab'
map("n", "<A-r>", ":BufferLineCycleNext<CR>", default_options) -- Go to right buffer 'tab'
map("n", "<A-c>", ":Bdelete!<CR>", default_options) -- Close buffer

map("n", "<leader>ev", ":e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<CR>",
    default_options)
