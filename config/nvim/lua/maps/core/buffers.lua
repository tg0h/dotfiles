-- local vim.keymap.set = vim.api.nvim_set_keymap
-- default_options = { norevim.keymap.set = true, silent = true }
-- expr_options = { norevim.keymap.set = true, expr = true, silent = true }
--
-- Buffers
-- vim.keymap.set("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)
-- vim.keymap.set('n', '<A-CR>', ':e#<CR>', default_options) -- edit previously opened buffer (or C-^)

-- nnorevim.keymap.set <silent><leader>1 <cmd>lua require("bufferline").go_to_buffer(1, true)<cr>

-- go to nth visible buffer, not by absolute position
vim.keymap.set('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', { desc = 'go to buffer 1' })
vim.keymap.set('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', { desc = 'go to buffer 2' })
vim.keymap.set('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', { desc = 'go to buffer 3' })
vim.keymap.set('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', { desc = 'go to buffer 4' })
vim.keymap.set('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', { desc = 'go to buffer 5' })
vim.keymap.set('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', { desc = 'go to buffer 6' })
-- vim.keymap.set('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', default_options)
-- vim.keymap.set('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', default_options)
-- vim.keymap.set('n', '<A-9>', ':BufferLineGoToBuffer 9<CR>', default_options)

vim.keymap.set('n', '<S-A-4>', ':BufferLineGoToBuffer -1<CR>', { desc = 'go to last buffer' }) -- A-$

vim.keymap.set('n', '<A-g>', ':BufferLineCyclePrev<CR>', { desc = 'go to previous buffer' }) -- go to left buffer
vim.keymap.set('n', '<A-r>', ':BufferLineCycleNext<CR>', { desc = 'go to next buffer' }) -- go to right buffer
vim.keymap.set('n', '<A-c>', ':Bdelete!<CR>', { desc = 'go to last buffer' }) -- close

vim.keymap.set('n', '<S-A-9>', ':BufferLineMovePrev<CR>', { desc = 'move to previous buffer' })
vim.keymap.set('n', '<S-A-[>', ':BufferLineMoveNext<CR>', { desc = 'move to next buffer' })

vim.keymap.set('n', '<A-8>', ':BufferLineCloseLeft<CR>', { desc = 'close buffers to the left' })
vim.keymap.set('n', '<A-9>', ':BufferLineCloseRight<CR>', { desc = 'close buffers to the right' })
vim.keymap.set(
  'n',
  '<A-0>',
  ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>',
  { desc = 'close all except current buffer' }
)
