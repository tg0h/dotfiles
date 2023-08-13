local M = {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  -- the typescript lang server is installed in the mason bin directory
  -- when opening nvim from the kitty tab switcher, need to set the bin folder in the kitty env.conf
  -- env PATH=$PATH:/Users/tim/.local/share/nvim/mason/bin
  -- set lazy to false to avoid Spawning language server with cmd: `typescript-language-server` failed. The language
  -- server is either not installed, missing from PATH, or not executable. error when running tab switcher from kitty
  -- hmm event = VeryLazy also works
  -- lazy = 'false',
  -- event = 'VeryLazy',
  dependencies = {
    { 'b0o/schemastore.nvim' },
    -- { 'hrsh7th/nvim-cmp' },
    { 'folke/lua-dev.nvim' },
    { 'onsails/lspkind-nvim' },
    -- { "folke/neodev.nvim", config = true, lazy = true, ft = "lua" },
  },
  config = function() require('plugins.lsp.lsp') end,
}

return M
