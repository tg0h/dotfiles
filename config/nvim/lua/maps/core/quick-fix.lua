local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- my own vim function!
-- quicker shortcuts since lsp goto def is called with A-i
map('n', '<A-q>', ':lua require(\'tg.quickfix\').ToggleQFList(1)<CR>', default_options)
-- map("n", "<C-j>", ":cnext<CR>", default_options)
-- map("n", "<C-k>", ":cprev<CR>", default_options)
map('n', '<A-j>', ':cnext<CR>', default_options)
map('n', '<A-k>', ':cprev<CR>', default_options)
