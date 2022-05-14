local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Resizing panes
map("n", "<Left>", ":vertical resize +5<CR>", default_options)
map("n", "<Right>", ":vertical resize -5<CR>", default_options)
map("n", "<A-Up>", ":resize -1<CR>", default_options) -- do not use Up/Down so that mousewheel scroll can be used to navigate
map("n", "<A-Down>", ":resize +1<CR>", default_options)
