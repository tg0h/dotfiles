local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- Buffers
-- map("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)
-- map('n', '<A-CR>', ':e#<CR>', default_options) -- edit previously opened buffer (or C-^)

map('n', '<A-1>', ':BufferLineGoToBuffer 1<CR>', default_options) -- Go to Buffer 1
map('n', '<A-2>', ':BufferLineGoToBuffer 2<CR>', default_options) -- Go to Buffer 2
map('n', '<A-3>', ':BufferLineGoToBuffer 3<CR>', default_options) -- Go to Buffer 2
map('n', '<A-4>', ':BufferLineGoToBuffer 4<CR>', default_options) -- Go to Buffer 2
map('n', '<A-5>', ':BufferLineGoToBuffer 5<CR>', default_options) -- Go to Buffer 2
map('n', '<A-6>', ':BufferLineGoToBuffer 6<CR>', default_options) -- Go to Buffer 2
map('n', '<A-7>', ':BufferLineGoToBuffer 7<CR>', default_options) -- Go to Buffer 2
map('n', '<A-8>', ':BufferLineGoToBuffer 8<CR>', default_options) -- Go to Buffer 2
map('n', '<A-9>', ':BufferLineGoToBuffer 9<CR>', default_options) -- Go to Buffer 2

map('n', '<A-g>', ':BufferLineCyclePrev<CR>', default_options) -- Go to left buffer 'tab'
map('n', '<A-r>', ':BufferLineCycleNext<CR>', default_options) -- Go to right buffer 'tab'
map('n', '<A-c>', ':Bdelete!<CR>', default_options) -- close buffer

map('n', '<S-A-7>', ':BufferLineMovePrev<CR>', default_options) -- A-)
map('n', '<S-A-[>', ':BufferLineMoveNext<CR>', default_options)

map('n', '<A-7>', ':BufferLineCloseLeft<CR>', default_options) -- A-* close all buffers to the left
map('n', '<A-8>', ':BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>', default_options) -- A-+ close all but selected buffer
map('n', '<A-[>', ':BufferLineCloseRight<CR>', default_options) -- A-! close all buffers to the right
