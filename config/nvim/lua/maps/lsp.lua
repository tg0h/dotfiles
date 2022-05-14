local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map("n", "<A-a>", ":lua vim.lsp.buf.definition()<CR>", default_options)
-- map("n", "<S-A-c>", ":lua vim.diagnostic.goto_next()<CR>", default_options) -- next diagnostic
-- map("n", "<S-A-r>", ":lua vim.diagnostic.goto_prev()<CR>", default_options) -- prev diagnostic
map("n", "<A-i>", ":lua vim.lsp.buf.references()<CR>", default_options) -- prev diagnostic
