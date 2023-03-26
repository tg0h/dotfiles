local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

map('n', '<F11>', ':UndotreeToggle<CR>', default_options) -- undotree
