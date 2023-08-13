local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- window movement
map('n', '<A-w>', ':wincmd q<CR>', default_options) -- close window

map('n', '<S-A-c>', ':wincmd o<CR>', default_options) -- close all other splits

map('n', '<S-A-n>', ':wincmd v<CR>', default_options) -- vertical split
map('n', '<S-A-b>', ':wincmd s<CR>', default_options) -- horizontal split

-- map("n", "<S-A-z>", ":wincmd _<CR>:wincmd |<CR>", default_options) -- zoom
map('n', '<S-A-z>', ":lua require'tg.toggle-window-zoom'.toggle()<CR>", default_options) -- zoom
map('n', '<S-M-h>', ':wincmd w<CR>', default_options) -- switch to next window ie C-W C-W
-- map("n", "<S-A-e>", ":wincmd =<CR>", default_options) -- equal splits

-- map("n", "+", ":res +5<CR>", default_options)
-- map("n", "-", ":res -5<CR>", default_options)

-- map('n', '<A-d>', ":lua require'utils'.close_floating_windows()<CR>", default_options) -- close all floating windows (eg lsp hover windows)

vim.keymap.set('n', '<A-d>', function() require('core.utils.functions').close_floating_windows() end, { desc = 'close floating windows' })

-- Resizing windows
map('n', '<Left>', ':vertical resize +5<CR>', default_options)
map('n', '<Right>', ':vertical resize -5<CR>', default_options)
map('n', '<Up>', ':resize -5<CR>', default_options) -- do not use Up/Down so that mousewheel scroll can be used to navigate
map('n', '<Down>', ':resize +5<CR>', default_options)
