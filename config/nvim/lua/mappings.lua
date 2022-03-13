local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Map the leader key
map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Help
map("n", "<F1>", ":WhichKey<CR>", default_options) -- show all mappings

-- Dap
map("n", "<F12>", ":lua require'dapui'.toggle()<CR>", default_options)
map("n", "<F2>", ":lua require'dap'.toggle_breakpoint()<CR>", default_options)
map("n", "<F7>", ":lua require'dap'.continue()<CR>", default_options)
map("n", "<F6>", ":lua require'dap'.step_into()<CR>", default_options)
map("n", "<F5>", ":lua require'dap'.step_out()<CR>", default_options)
map("n", "<F9>", ":lua require'dap'.step_over()<CR>", default_options)
map("n", "<F8>", ":lua require'dap'.run_to_cursor()<CR>", default_options)
map("n", "<F10>", ":lua require'dap'.up()<CR>", default_options)
map("n", "<F4>", ":lua require'dap'.down()<CR>", default_options)

-- Nvim Tree
map("n", "<A-u>", ":NvimTreeFocus<CR>", default_options) -- Focus is better than Toggle
map("n", "<A-e>", ":NvimTreeToggle<CR>", default_options)
map("n", "<A-b>", ":NvimTreeFindFile<CR>", default_options)

-- window movement
map("n", "<A-d>", ":wincmd q<CR>", default_options) -- close window
map("n", "<A-v>", ":wincmd v<CR>", default_options) -- vertical split
-- map("n", "<A-s>", ":wincmd s<CR>", default_options) -- horizontal split
map("n", "<A-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>", default_options)
map("n", "<A-t>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>", default_options)
map("n", "<A-n>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>", default_options)
map("n", "<A-s>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>", default_options)
map("n", "<A-->", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>", default_options)
map("n", "<A-Enter>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>", default_options)

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>", default_options)
map("n", "<Right>", ":vertical resize -1<CR>", default_options)
map("n", "<A-Up>", ":resize -1<CR>", default_options)
map("n", "<A-Down>", ":resize +1<CR>", default_options)

-- Buffers
map("n", "<A-a>", ":e#<CR>", default_options) -- edit previously opened buffer
map("n", "<A-g>", ":BufferLineCyclePrev<CR>", default_options) -- Go to left buffer 'tab'
map("n", "<A-r>", ":BufferLineCycleNext<CR>", default_options) -- Go to right buffer 'tab'
map("n", "<A-c>", ":Bdelete!<CR>", default_options) -- close buffer

map("n", "<A-)>", ":BufferLineMovePrev<CR>", default_options)
map("n", "<A-]>", ":BufferLineMoveNext<CR>", default_options)

map("n", "<A-*>", ":BufferLineCloseLeft<CR>", default_options) -- close all buffers to the left
map("n", "<A-!>", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", default_options) -- close all but selected buffer
map("n", "<A-(>", ":BufferLineCloseRight<CR>", default_options) -- close all buffers to the right

-- Save file
map("n", "<localleader>w", ":w<CR>", default_options)

-- Undo
map("n", "<F11>", ":UndotreeToggle<CR>", default_options) -- undotree
