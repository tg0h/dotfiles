local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map("n", "<C-q>", ":lua require('tg.quickfix').ToggleQFList(1)<CR>",
    default_options)
map("n", "<C-j>", ":cnext<CR>", default_options)
map("n", "<C-k>", ":cprev<CR>", default_options)
