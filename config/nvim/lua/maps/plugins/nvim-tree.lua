local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- map("n", "<A-u>", ":NvimTreeFocus<CR>", default_options) -- Focus is better than Toggle
map('n', '<A-m>', ':NvimTreeToggle<CR>', default_options)
map('n', '<A-b>', ':NvimTreeFindFile<CR>', default_options)
