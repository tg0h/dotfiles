local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- my own vim function!
-- quicker shortcuts since lsp goto def is called with A-i
map('n', '<A-q>', ":lua require('tg.quickfix').ToggleQFList(1)<CR>", { desc = 'toggle quickfix list' })
map('n', '<S-A-;>', ":lua require('tg.quickfix').ToggleQFList(0)<CR>", { desc = 'toggle loclist' })
map('n', '<A-j>', ':cnext<CR>', default_options)
map('n', '<A-k>', ':cprev<CR>', default_options)

map('n', '<C-j>', ':lnext<CR>', default_options)
map('n', '<C-k>', ':lprev<CR>', default_options)
