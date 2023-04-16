local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- vim.g.maplocalleader = '<BS>'

-- file
map('n', '<BS>w', ':w<CR>', default_options)
map('n', '<BS>w', ':lua print "hello"<CR>', default_options)
map('n', '<BS>z', ':qa!<CR>', default_options) -- quit all buffers, splits and tabs
map('n', '<BS>f', ':Format<CR>', default_options)

-- lsp
map('n', '<BS>d', ':Telescope diagnostics<CR>', default_options)
-- harpoon
-- map("n", "<BS>d", ":lua require('harpoon.mark').add_file()<CR>", default_options)
map('n', '<BS>h', ':Telescope harpoon marks<CR>', default_options)
map('n', '<BS>t', ':Telescope live_grep<CR>', default_options)
map('n', '<BS>n', ':Telescope git_files<CR>', default_options)
map('n', '<BS>s', ':Telescope current_buffer_fuzzy_find<CR>', default_options)

map('n', '<BS>-', ':Telescope grep_string<CR>', default_options) -- search text under cursor

map('n', '<BS>m', ':Telescope marks<CR>', default_options)

-- map("n", "<BS>t",
--     ":lua require('harpoon.tmux').sendCommand(2,1)<CR>:lua require('harpoon.tmux').gotoTerminal(2)<CR>",
--     default_options)

-- git
map('n', '<BS>g', ':Telescope gitdiffer diff<CR>', default_options)
map('n', '<BS>c', ':Telescope git_status<CR>', default_options)

-- recent
map(
  'n',
  '<BS>r',
  ":lua require('telescope').extensions.frecency.frecency(require('setup.telescope').big_window())<CR>",
  default_options
)

-- buffers
map(
  'n',
  '<BS>b',
  ":lua require'telescope.builtin'.buffers({ layout_strategy = 'vertical', sort_mru = true, ignore_current_buffer = true })<CR>",
  default_options
)
