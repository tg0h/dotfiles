-- wo - window specific option
vim.wo.cursorline = true
-- show absolute line numbers for easier reference
vim.wo.relativenumber = false

-- highlight the 5th line
local bufnr = vim.api.nvim_get_current_buf()
vim.fn.sign_define('my_sign', { text = ' ', texthl = 'Search', linehl = '', numhl = '' })
vim.fn.sign_place(0, 'my_sign', 'my_sign', bufnr, { lnum = 5, priority = 100 })

vim.api.nvim_buf_set_keymap(0, 'n', '<C-j>', ':move +1<CR>', { desc = 'move harpoon menu item down' })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-k>', ':move -2<CR>', { desc = 'move harpoon menu item up' })
