local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Map the leader key
-- map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "

-- Help
map("n", "<F1>", ":WhichKey<CR>", default_options) -- show all mappings

-- nice defaults
-- move lines
map("v", "J", ":m '>+1<CR>gv=gv", default_options)
map("v", "K", ":m '<-2<CR>gv=gv", default_options)
-- keep it centred
map("n", "n", "nzzzv", default_options) -- zv opens folds
map("n", "N", "Nzzzv", default_options)
map("n", "J", "mzJ`z", default_options)
-- granular undo break points
map("i", ",", ",<C-g>u", default_options)
map("i", ".", ".<C-g>u", default_options)
map("i", "!", "!<C-g>u", default_options)
map("i", "?", "?<C-g>u", default_options)
-- vimscript . concats strings
-- m' adds a context mark which also adds to the jump list as a side effect
map("n", "j", [[ (v:count > 5 ? "m'" . v:count : "") . 'j' ]], expr_options)
map("n", "k", [[ (v:count > 5 ? "m'" . v:count : "") . 'k' ]], expr_options)

-- map("n", "gx", ":!open <C-R><C-A><CR>", expr_options)
