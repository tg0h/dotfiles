-- window movement
vim.keymap.set('n', '<A-w>', ':wincmd q<CR>', { desc = 'close window' })
vim.keymap.set('n', '<S-A-c>', ':wincmd o<CR>', { desc = 'close all other windows' })
vim.keymap.set('n', '<S-A-n>', ':wincmd v<CR>', { desc = 'vertical window' })
vim.keymap.set('n', '<S-A-b>', ':wincmd s<CR>', { desc = 'horizontal window' })

-- vim.keymap.set("n", "<S-A-z>", ":wincmd _<CR>:wincmd |<CR>", {desc=''}) -- zoom
vim.keymap.set('n', '<S-A-z>', ":lua require'tg.toggle-window-zoom'.toggle()<CR>", { desc = 'toggle window zoom' }) -- zoom
vim.keymap.set('n', '<S-M-h>', ':wincmd w<CR>', { desc = 'switch to next window' }) -- switch to next window ie C-W C-W
-- vim.keymap.set("n", "<S-A-e>", ":wincmd =<CR>", {desc=''}) -- equal splits

-- vim.keymap.set('n', '<A-d>', ":lua require'utils'.close_floating_windows()<CR>", {desc=''}) -- close all floating windows (eg lsp hover windows)
vim.keymap.set('n', '<A-d>', function() require('core.utils.functions').close_floating_windows() end, { desc = 'close floating windows' })

-- Resizing windows
vim.keymap.set('n', '<C-Left>', ':vertical resize +5<CR>', { desc = 'resize left window' })
vim.keymap.set('n', '<C-Right>', ':vertical resize -5<CR>', { desc = 'resize right window' })
vim.keymap.set('n', '<C-Up>', ':resize -5<CR>', { desc = 'resize up window' }) -- do not use Up/Down so that mousewheel scroll can be used to navigate
vim.keymap.set('n', '<C-Down>', ':resize +5<CR>', { desc = 'resize down window' })
