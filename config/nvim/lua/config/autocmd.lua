local numberToggleGroup = vim.api.nvim_create_augroup('NumberToggle', { clear = true })
-- " turn off relative number when entering insert mode or buffer loses focus
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  pattern = '*',
  callback = function()
    buftype = vim.bo.buftype
    -- print('buftype is' .. buftype)
    -- print('filetype is' .. vim.o.filetype)
    if vim.o.filetype ~= 'toggleterm' then vim.opt.relativenumber = true end
  end,
  group = numberToggleGroup,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  pattern = '*',
  callback = function()
    buftype = vim.bo.buftype
    -- print('buftype is' .. buftype)
    -- print('filetype is' .. vim.o.filetype)
    if vim.o.filetype ~= 'toggleterm' then vim.opt.relativenumber = false end
  end,
  group = numberToggleGroup,
})

vim.api.nvim_exec(
  [[
augroup remember_folds
"save your folds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
]],
  true
)

vim.api.nvim_exec(
  [[
"yaml tab spacing
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
]],
  true
)

vim.api.nvim_exec(
  [[
" go to last edit position
" https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]],
  true
)

vim.api.nvim_exec(
  [[
" automatically rebalance windows on vim resize
" helps when creating tmux panes
autocmd VimResized * :wincmd =
]],
  true
)

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
" TODO: throws an error when running Y in nvim tree
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

-- vim.cmd([[
-- autocmd Filetype harpoon setlocal cursorline
-- ]])

-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--   pattern = { 'harpoon' },
--   callback = function()
--     -- wo - window specific option
--     vim.wo.cursorline = true
--     -- show absolute line numbers for easier reference
--     vim.wo.relativenumber = false
--   end,
-- })

-- https://github.com/neovim/neovim/issues/17867#issuecomment-1079934289
-- doesn't work with tmux :|
if vim.env.TERM == 'xterm-kitty' then
  vim.cmd([[autocmd UIEnter * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[>1u") | endif]])
  vim.cmd([[autocmd UILeave * if v:event.chan ==# 0 | call chansend(v:stderr, "\x1b[<1u") | endif]])
end

vim.api.nvim_create_autocmd({ 'BufWritePre' }, { pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' }, command = 'EslintFixAll' })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { '*' },
  callback = function()
    -- https://www.reddit.com/r/neovim/comments/mmhwgc/lua_equivalent_of_and/
    -- https://vim.fandom.com/wiki/Disable_automatic_comment_insertion
    -- :help fo-table
    vim.opt.formatoptions:remove('c')
    vim.opt.formatoptions:remove('r')
    vim.opt.formatoptions:remove('o')
  end,
})
