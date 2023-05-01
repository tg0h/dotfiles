local M = {
  -- q = { "<cmd>lua require'tg.quickfix'.ToggleQFList(0)<CR>", 'Toggle Location List' },
  h = { name = 'diagnostics' },

  r = {
    name = 'Notes',
    h = { "<cmd>lua require('setup/telescope').search_wiki_candy()<CR>", 'Search wiki candy' },
    t = { "<cmd>lua require('setup/telescope').search_wiki()<CR>", 'Search wiki' },
  },

  t = require('setup.which-key.keys.trouble'),
  c = { name = 'config' },
  s = { name = 'search' },

  b = { name = 'Buffers' },
  f = { name = 'Files' },
  n = { name = 'neovim core' },
  g = require('setup.which-key.keys.git'),
  l = require('setup.which-key.keys.lsp'),

  w = require('setup.which-key.keys.window'),
  z = require('setup.which-key.keys.vim-dadbod-ui'),
}
return M
