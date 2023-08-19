return {
  'opdavies/toggle-checkbox.nvim',
  config = function() vim.keymap.set('n', '<leader>ma', ":lua require('toggle-checkbox').toggle()<CR>", { desc = 'toggle checkbox' }) end,
}
