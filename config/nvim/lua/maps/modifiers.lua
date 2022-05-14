local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- go to next ) and then a
-- map("i", "<C-S-n>", "<Esc>])a", default_options)
map("i", "<C-S-n>", "<Esc>%%a", default_options)

map("n", "<C-CR>", ":echo 'hello c cr'<CR>", default_options)
map("n", "<D-CR>", ":echo 'hello D cr'<CR>", default_options)
map("n", "<C-S-h>", ":echo 'hello csh cr'<CR>", default_options)
map("n", "<C-m>", ":echo 'test m'<CR>", default_options)

map("n", "<F5>", ":luafile %<CR>", default_options)
