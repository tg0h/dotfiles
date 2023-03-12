local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map('n', '<S-A-g>', ':lua require(\'gitsigns\').prev_hunk()<CR>', default_options) -- prev git hunk
map('n', '<S-A-r>', ':lua require(\'gitsigns\').next_hunk()<CR>', default_options) -- next git hunk
