local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

vim.g.maplocalleader = ','

-- file
map('n', '<localleader>w', ':w<CR>', default_options)
map('n', '<localleader>z', ':qa!<CR>', default_options) -- quit all buffers, splits and tabs
map('n', '<localleader>f', ':Format<CR>', default_options)

-- lsp
map('n', '<localleader>d', ':Telescope diagnostics<CR>', default_options)
-- harpoon
-- map("n", "<localleader>d", ":lua require('harpoon.mark').add_file()<CR>", default_options)
map('n', '<localleader>h', ':Telescope harpoon marks<CR>', default_options)
map('n', '<localleader>t', ':Telescope live_grep<CR>', default_options)
map('n', '<localleader>n', ':Telescope git_files<CR>', default_options)
map('n', '<localleader>s', ':Telescope current_buffer_fuzzy_find<CR>', default_options)
map('n', '<localleader>-', ':Telescope grep_string<CR>', default_options) -- search text under cursor
map('n', '<localleader>m', ':Telescope marks<CR>', default_options) -- search text under cursor

-- map("n", "<localleader>t",
--     ":lua require('harpoon.tmux').sendCommand(2,1)<CR>:lua require('harpoon.tmux').gotoTerminal(2)<CR>",
--     default_options)

-- git
map('n', '<localleader>g', ':Telescope gitdiffer diff<CR>', default_options)
map('n', '<localleader>c', ':Telescope git_status<CR>', default_options)

-- recent
map(
  'n',
  '<localleader>r',
  ":lua require('telescope').extensions.frecency.frecency(require('setup.telescope').big_window())<CR>",
  default_options
)

-- buffers
map(
  'n',
  '<localleader>b',
  ":lua require'telescope.builtin'.buffers({ layout_strategy = 'vertical', sort_mru = true, ignore_current_buffer = true })<CR>",
  default_options
)
