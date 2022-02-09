-- automatically rebalance windows on vim resize (when tmux panes are added/removed)
vim.api.nvim_exec([[
autocmd VimResized * wincmd =
]], true)
