local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

vim.g.maplocalleader = ","

-- file
map("n", "<localleader>w", ":w<CR>", default_options)
map("n", "<localleader>z", ":qa!<CR>", default_options) -- quit all buffers, splits and tabs
map("n", "<localleader>f", ":Format<CR>", default_options)

-- harpoon
map("n", "<localleader>h", ":Telescope harpoon marks<CR>", default_options)
map("n", "<localleader>t",
    ":lua require('harpoon.tmux').sendCommand(2,1)<CR>:lua require('harpoon.tmux').gotoTerminal(2)<CR>",
    default_options)

-- git
map("n", "<localleader>g", ":Telescope gitdiffer diff<CR>", default_options)
map("n", "<localleader>s", ":Telescope git_status<CR>", default_options)
