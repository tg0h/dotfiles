local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map("n", "<A-a>", ":lua vim.lsp.buf.definition()<CR>", default_options)
map("n", "<A-u>", ":lua vim.lsp.buf.references()<CR>", default_options)
map("n", "<C-A-g>", ":lua vim.diagnostic.goto_prev()<CR>", default_options) -- prev diagnostic
map("n", "<C-A-r>", ":lua vim.diagnostic.goto_next()<CR>", default_options) -- next diagnostic
