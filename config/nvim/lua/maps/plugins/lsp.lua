local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

map('n', '<A-e>', ':lua vim.lsp.buf.rename()<CR>', default_options) -- rename

map('n', '<A-a>', ':lua vim.lsp.buf.definition()<CR>', default_options) -- go to def
map('n', '<A-u>', ':lua vim.lsp.buf.references()<CR>', default_options) -- find references

map('n', '<C-A-g>', ':lua vim.diagnostic.goto_prev()<CR>', default_options) -- prev diagnostic
map('n', '<C-A-r>', ':lua vim.diagnostic.goto_next()<CR>', default_options) -- next diagnostic

map('n', '<C-A-l>', ':lua vim.diagnostic.open_float()<CR>', default_options) -- show diagnostic

-- map('n', '<A-l>', ':lua vim.lsp.buf.signature_help()<CR>', default_options) -- signature help
