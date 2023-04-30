local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- map("n", "<C-M-c>", ":lua require'coverage'.load(true)<CR> <bar> :lua require'coverage'.toggle()<CR>", default_options)
-- map('n', '<C-M-c>', ":lua require'coverage'.load(true)<CR>", default_options)
-- map('n', '<C-M-d>', ":lua require'coverage'.toggle()<CR>", default_options)
-- map('n', '<C-M-f>', ":lua require'coverage'.summary()<CR>", default_options)

vim.keymap.set('n', '<C-M-c>', function()
  require('tg.toggle-coverage').toggle_coverage()
end, { desc = 'toggle nvim coverage' })

vim.keymap.set('n', '<C-M-d>', function()
  require('tg.toggle-coverage').toggle_summary()
end, { desc = 'toggle nvim coverage summary' })

map('n', '<C-M-n>', ":lua require'coverage'.jump_next('uncovered')<CR>", default_options)
map('n', '<C-M-p>', ":lua require'coverage'.jump_prev('uncovered')<CR>", default_options)

-- S-A-n aka M-N used to open new split
-- map("n", "<S-A-n>", ":lua require'coverage'.jump_next('partial')<CR>", default_options)
-- map("n", "<S-A-p>", ":lua require'coverage'.jump_prev('partial')<CR>", default_options)
