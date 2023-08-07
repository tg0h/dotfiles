local M = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'b0o/schemastore.nvim' },
    { 'hrsh7th/nvim-cmp' },
    { 'folke/lua-dev.nvim' },
    { 'onsails/lspkind-nvim' },
    -- { "folke/neodev.nvim", config = true, lazy = true, ft = "lua" },
  },
  config = function()
    require('core.plugins.lsp.lsp')
  end,
}

return M
