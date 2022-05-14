local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

vim.g.maplocalleader = ","

-- Edit file
map("n", "<localleader>eo", ":e $XDG_CONFIG_HOME/nvim/lua/options.lua<CR>",
    default_options)
map("n", "<localleader>ep", ":e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<CR>",
    default_options)
map("n", "<localleader>et", ":e $XDG_CONFIG_HOME/tmux/tmux.conf<CR>",
    default_options)
map("n", "<localleader>ew",
    ":e $XDG_CONFIG_HOME/nvim/lua/setup/which-key.lua<CR>", default_options)
