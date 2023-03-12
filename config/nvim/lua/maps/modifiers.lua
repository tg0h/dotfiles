local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- go to next ) and then a
map('i', '<C-S-n>', '<Esc>%%a', default_options)

-- only works in kitty without tmux and using autocmd to send csi u
-- map("i", "<tab>", "a", default_options)
-- map("i", "<C-m>", "m", default_options)

map('n', '<F5>', ':luafile %<CR>', default_options)
