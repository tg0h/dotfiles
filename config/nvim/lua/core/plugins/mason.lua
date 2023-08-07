local M = {
  'williamboman/mason.nvim',
  -- run = ':MasonUpdate', -- :MasonUpdate updates registry contents
  event = 'VeryLazy',
  -- event = 'VeryLazy',
  config = function()
    require('mason').setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })
  end,
}
return M
