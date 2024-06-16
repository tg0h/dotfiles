-- vim.api.nvim_buf_set_keymap(0, 'n', '<C-Bslash>', '<CMD>Rest run<CR>', { desc = 'rest run' }) -- C--
vim.keymap.set('n', '<C-h>', '<CMD>Rest run<CR>', { desc = 'rest run', buffer = true })
vim.keymap.set('n', '<C-g>', '<CMD>Rest result prev<CR>', { desc = 'rest result next', buffer = true })
vim.keymap.set('n', '<C-r>', '<CMD>Rest result next<CR>', { desc = 'rest result prev', buffer = true })
vim.keymap.set('n', '<C-p>', '<CMD>Rest run last<CR>', { desc = 'rest run last', buffer = true })

vim.keymap.set('n', '<C-e>', function()
  -- first load extension
  require('telescope').load_extension('rest')
  -- then use it, you can also use the `:Telescope rest select_env` command
  require('telescope').extensions.rest.select_env()
end, { buffer = true })

-- buffer = true means local buffer mapping
vim.keymap.set('n', '<C-;>', function() require('tg.candy-sign-in').set_env_candy_id_token() end, {
  desc = 'set candy id token in env',
  buffer = true,
})
