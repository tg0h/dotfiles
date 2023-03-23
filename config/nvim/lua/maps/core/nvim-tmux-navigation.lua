local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- map("n", "<A-h>",
--     ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<CR>",
--     default_options)
-- map("n", "<A-t>",
--     ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<CR>",
--     default_options)
-- map("n", "<A-n>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<CR>",
--     default_options)
-- map("n", "<A-s>",
--     ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<CR>",
--     default_options)

-- map("n", "<A-->",
--     ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<CR>",
--     default_options)
-- map("n", "<A-Enter>",
--     ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<CR>",
--     default_options)
