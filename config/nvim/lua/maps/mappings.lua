local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Map the leader key
map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "

map("n", "<C-CR>", ":echo 'hello c cr'<CR>", default_options)
map("n", "<D-CR>", ":echo 'hello D cr'<CR>", default_options)
map("n", "<C-S-h>", ":echo 'hello csh cr'<CR>", default_options)
map("n", "<C-m>", ":echo 'test m'<CR>", default_options)

map("n", "<F5>", ":luafile %<CR>", default_options)

-- Trouble
-- map("n", "<S-A-c>",
--     ":lua require'trouble'.next({skip_groups = true, jump = true})<CR>",
--     default_options) -- next
-- map("n", "<S-A-r>",
--     ":lua require'trouble'.previous({skip_groups = true, jump = true})<CR>",
--     default_options) -- previous
