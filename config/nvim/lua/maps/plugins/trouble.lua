local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Trouble
-- map("n", "<S-A-c>",
--     ":lua require'trouble'.next({skip_groups = true, jump = true})<CR>",
--     default_options) -- next
-- map("n", "<S-A-r>",
--     ":lua require'trouble'.previous({skip_groups = true, jump = true})<CR>",
--     default_options) -- previous
