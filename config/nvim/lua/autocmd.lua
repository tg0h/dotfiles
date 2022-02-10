-- -- automatically rebalance windows on vim resize (when tmux panes are added/removed)
-- vim.api.nvim_exec([[
-- autocmd VimResized * wincmd =
-- ]], true)
vim.api.nvim_exec([[
augroup numbertoggle
" turn off relative number when entering insert mode or buffer loses focus
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END
]], true)

vim.api.nvim_exec([[
augroup remember_folds
"save your folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]], true)

vim.api.nvim_exec([[
"yaml tab spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
]], true)

vim.api.nvim_exec([[
" go to last edit position
" https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]], true)
