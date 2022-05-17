local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Buffers
-- map("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)
map("n", "<A-Space>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)

map("n", "<A-[>", ":BufferLineGoToBuffer 1<CR>", default_options) -- Go to Buffer 1
map("n", "<A-{>", ":BufferLineGoToBuffer 2<CR>", default_options)
map("n", "<A-}>", ":BufferLineGoToBuffer 3<CR>", default_options)
map("n", "<A-(>", ":BufferLineGoToBuffer 4<CR>", default_options)
map("n", "<A-=>", ":BufferLineGoToBuffer 5<CR>", default_options)

map("n", "<A-g>", ":BufferLineCyclePrev<CR>", default_options) -- Go to left buffer 'tab'
map("n", "<A-r>", ":BufferLineCycleNext<CR>", default_options) -- Go to right buffer 'tab'
map("n", "<A-c>", ":Bdelete!<CR>", default_options) -- close buffer

map("n", "<A-)>", ":BufferLineMovePrev<CR>", default_options)
map("n", "<A-]>", ":BufferLineMoveNext<CR>", default_options)

map("n", "<A-*>", ":BufferLineCloseLeft<CR>", default_options) -- close all buffers to the left
map("n", "<A-+>", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>",
    default_options) -- close all but selected buffer
map("n", "<A-!>", ":BufferLineCloseRight<CR>", default_options) -- close all buffers to the right
