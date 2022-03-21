local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Map the leader key
map("n", "<Space>", "<NOP>", default_options)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

map("v", "J", ":m '>+1<CR>gv=gv", default_options)
map("v", "K", ":m '<-2<CR>gv=gv", default_options)
-- keep it centred
map("n", "n", "nzzzv", default_options) -- zv opens folds
map("n", "N", "Nzzzv", default_options)
map("n", "J", "mzJ`z", default_options)
-- granular undo break points
map("i", ",", ",<C-g>u", default_options)
map("i", ".", ".<C-g>u", default_options)
map("i", "!", "!<C-g>u", default_options)
map("i", "?", "?<C-g>u", default_options)
-- vimscript . concats strings
-- m' adds a context mark which also adds to the jump list as a side effect
map("n", "j", [[ (v:count > 5 ? "m'" . v:count : "") . 'j' ]], expr_options)
map("n", "k", [[ (v:count > 5 ? "m'" . v:count : "") . 'k' ]], expr_options)

-- Edit file
map("n", "<localleader>em", ":e $XDG_CONFIG_HOME/nvim/lua/mappings.lua<CR>",
    default_options)
map("n", "<localleader>eo", ":e $XDG_CONFIG_HOME/nvim/lua/options.lua<CR>",
    default_options)
map("n", "<localleader>ep", ":e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<CR>",
    default_options)
map("n", "<localleader>et", ":e $XDG_CONFIG_HOME/tmux/tmux.conf<CR>",
    default_options)
map("n", "<localleader>ew",
    ":e $XDG_CONFIG_HOME/nvim/lua/setup/which-key.lua<CR>", default_options)

-- Quick Fix
map("n", "<C-q>", ":lua require('tg.quickfix').ToggleQFList(1)<CR>",
    default_options)
map("n", "<C-j>", ":cnext<CR>", default_options)
map("n", "<C-k>", ":cprev<CR>", default_options)

-- Help
map("n", "<F1>", ":WhichKey<CR>", default_options) -- show all mappings

-- Trouble
map("n", "<S-A-c>",
    ":lua require'trouble'.next({skip_groups = true, jump = true})<CR>",
    default_options) -- next
map("n", "<S-A-r>",
    ":lua require'trouble'.previous({skip_groups = true, jump = true})<CR>",
    default_options) -- previous

-- LSP
map("n", "<A-a>", ":lua vim.lsp.buf.definition()<CR>", default_options)
-- map("n", "<S-A-c>", ":lua vim.diagnostic.goto_next()<CR>", default_options) -- next diagnostic
-- map("n", "<S-A-r>", ":lua vim.diagnostic.goto_prev()<CR>", default_options) -- prev diagnostic
map("n", "<A-i>", ":lua vim.lsp.buf.references()<CR>", default_options) -- prev diagnostic

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
map("n", "<A-m>", ":NvimTreeToggle<CR>", default_options)
map("n", "<A-b>", ":NvimTreeFindFile<CR>", default_options)

-- window movement
map("n", "<A-w>", ":wincmd q<CR>", default_options) -- close window
map("n", "<S-A-d>", ":wincmd o<CR>", default_options) -- close all other splits
map("n", "<S-A-h>", ":wincmd s<CR>", default_options) -- horizontal split
map("n", "<S-A-t>", ":wincmd v<CR>", default_options) -- vertical split
map("n", "<S-A-z>", ":wincmd _<CR>:wincmd |<CR>", default_options) -- zoom
map("n", "<S-A-e>", ":wincmd =<CR>", default_options) -- equal splits

map("n", "<A-h>",
    ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>",
    default_options)
map("n", "<A-t>",
    ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>",
    default_options)
map("n", "<A-n>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>",
    default_options)
map("n", "<A-s>",
    ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>",
    default_options)
map("n", "<A-->",
    ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>",
    default_options)
map("n", "<A-Enter>",
    ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>",
    default_options)

-- Resizing panes
map("n", "<Left>", ":vertical resize +5<CR>", default_options)
map("n", "<Right>", ":vertical resize -5<CR>", default_options)
map("n", "<A-Up>", ":resize -1<CR>", default_options) -- do not use Up/Down so that mousewheel scroll can be used to navigate
map("n", "<A-Down>", ":resize +1<CR>", default_options)

-- Buffers
map("n", "<A-Esc>", ":e#<CR>", default_options) -- edit previously opened buffer
map("n", "<A-g>", ":BufferLineCyclePrev<CR>", default_options) -- Go to left buffer 'tab'
map("n", "<A-r>", ":BufferLineCycleNext<CR>", default_options) -- Go to right buffer 'tab'
map("n", "<A-c>", ":Bdelete!<CR>", default_options) -- close buffer

map("n", "<A-)>", ":BufferLineMovePrev<CR>", default_options)
map("n", "<A-]>", ":BufferLineMoveNext<CR>", default_options)

map("n", "<A-*>", ":BufferLineCloseLeft<CR>", default_options) -- close all buffers to the left
map("n", "<A-+>", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>",
    default_options) -- close all but selected buffer
map("n", "<A-!>", ":BufferLineCloseRight<CR>", default_options) -- close all buffers to the right

-- Save file
map("n", "<localleader>w", ":w<CR>", default_options)

-- Undo
map("n", "<F11>", ":UndotreeToggle<CR>", default_options) -- undotree
