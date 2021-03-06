local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Buffers
-- map("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)
map("n", "<A-Space>", ":e#<CR>", default_options) -- edit previously opened buffer (or C-^)

map("n", "<A-[>", ":BufferLineGoToBuffer 1<CR>", default_options) -- Go to Buffer 1
map("n", "<A-S-[>", ":BufferLineGoToBuffer 2<CR>", default_options) -- A-{
map("n", "<A-S-]>", ":BufferLineGoToBuffer 3<CR>", default_options) -- A-}
map("n", "<A-S-9>", ":BufferLineGoToBuffer 4<CR>", default_options) -- A-(
map("n", "<A-=>", ":BufferLineGoToBuffer 5<CR>", default_options)

map("n", "<A-g>", ":BufferLineCyclePrev<CR>", default_options) -- Go to left buffer 'tab'
map("n", "<A-r>", ":BufferLineCycleNext<CR>", default_options) -- Go to right buffer 'tab'
map("n", "<A-c>", ":Bdelete!<CR>", default_options) -- close buffer

map("n", "<A-S-0>", ":BufferLineMovePrev<CR>", default_options) -- A-)
map("n", "<A-]>", ":BufferLineMoveNext<CR>", default_options)

map("n", "<A-S-8>", ":BufferLineCloseLeft<CR>", default_options) -- A-* close all buffers to the left
map("n", "<A-S-=>", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>",
    default_options) -- A-+ close all but selected buffer
map("n", "<A-S-1>", ":BufferLineCloseRight<CR>", default_options) -- A-! close all buffers to the right

