local M = {
  'knubie/vim-kitty-navigator',
  build = 'cp ./*.py ~/.config/kitty/',
  event = 'VeryLazy',
  init = function() vim.g.kitty_navigator_no_mappings = 1 end,
  config = function()
    vim.g.kitty_navigator_no_mappings = 1
    vim.keymap.set('n', '<A-h>', ':KittyNavigateLeft<CR>', { desc = 'vim kitty navigator left' })
    vim.keymap.set('n', '<A-t>', ':KittyNavigateDown<CR>', { desc = 'vim kitty navigator down' })
    vim.keymap.set('n', '<A-n>', ':KittyNavigateUp<CR>', { desc = 'vim kitty navigator up' })
    vim.keymap.set('n', '<A-s>', ':KittyNavigateRight<CR>', { desc = 'vim kitty navigator right' })
  end,
}
return M
