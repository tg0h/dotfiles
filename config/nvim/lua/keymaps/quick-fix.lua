-- my own vim function!
-- quicker shortcuts since lsp goto def is called with A-i
vim.keymap.set('n', '<M-q>', ":lua require('tg.quickfix').ToggleQFList(1)<CR>", { desc = 'toggle quickfix list' })
vim.keymap.set('n', '<S-A-;>', ":lua require('tg.quickfix').ToggleQFList(0)<CR>", { desc = 'toggle loclist' })
vim.keymap.set('n', '<M-j>', ':cnext<CR>', { desc = 'next quickfix item' })
vim.keymap.set('n', '<M-k>', ':cprev<CR>', { desc = 'previous quickfix item' })

vim.keymap.set('n', '<C-j>', ':lnext<CR>', { desc = 'next loclist item' })
vim.keymap.set('n', '<C-k>', ':lprev<CR>', { desc = 'previous loclist item' })

-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
