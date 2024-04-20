vim.api.nvim_buf_set_keymap(0, 'n', '<C-Bslash>', '<CMD>Rest run<CR>', { desc = 'rest run' }) -- C--
vim.api.nvim_buf_set_keymap(0, 'n', '<C-g>', '<CMD>Rest result prev<CR>', { desc = 'rest result next' })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-r>', '<CMD>Rest result next<CR>', { desc = 'rest result prev' })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-p>', '<CMD>Rest run last<CR>', { desc = 'rest run last' })
