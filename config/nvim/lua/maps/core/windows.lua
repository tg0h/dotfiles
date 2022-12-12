local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- window movement
map("n", "<A-w>", ":wincmd q<CR>", default_options) -- close window
map("n", "<S-A-d>", ":wincmd o<CR>", default_options) -- close all other splits
map("n", "<S-A-h>", ":wincmd s<CR>", default_options) -- horizontal split
map("n", "<S-A-t>", ":wincmd v<CR>", default_options) -- vertical split
map("n", "<S-A-z>", ":wincmd _<CR>:wincmd |<CR>", default_options) -- zoom
map("n", "<S-A-e>", ":wincmd =<CR>", default_options) -- equal splits
map("n", "<S-A-e>", ":wincmd =<CR>", default_options) -- equal splits
map("n", "+", ":res +5<CR>", default_options) -- equal splits
map("n", "-", ":res -5<CR>", default_options) -- equal splits
