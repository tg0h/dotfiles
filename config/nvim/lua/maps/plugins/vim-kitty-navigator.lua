local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

vim.g.kitty_navigator_no_mappings = 1

map('n', '<A-h>', ':KittyNavigateLeft<CR>', default_options)
map('n', '<A-t>', ':KittyNavigateDown<CR>', default_options)
map('n', '<A-n>', ':KittyNavigateUp<CR>', default_options)
map('n', '<A-s>', ':KittyNavigateRight<CR>', default_options)
