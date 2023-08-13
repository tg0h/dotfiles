return {
  'opdavies/toggle-checkbox.nvim',
  config = function() vim.keymap.set('n', '<leader>rc', ":lua require('toggle-checkbox').toggle()<CR>", { desc = 'toggle checkbox' }) end,
}
