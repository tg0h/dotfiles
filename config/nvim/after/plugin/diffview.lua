vim.keymap.set('n', '<LEADER>gf', function()
  vim.cmd.DiffviewFileHistory('%')
end, { desc = 'diffview file history' })
