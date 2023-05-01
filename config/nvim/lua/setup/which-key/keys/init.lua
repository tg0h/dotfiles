local M = {
  -- q = { "<cmd>lua require'tg.quickfix'.ToggleQFList(0)<CR>", 'Toggle Location List' },
  j = { '<cmd>lnext<CR>', 'Location List next' },
  k = { '<cmd>lprev<CR>', 'Location List prev' },

  r = require('setup.which-key.keys.notes'),

  t = require('setup.which-key.keys.trouble'),
  s = require('setup.which-key.keys.search'),

  b = { name = 'Buffers' },
  f = { name = 'Files' },
  g = require('setup.which-key.keys.git'),
  l = require('setup.which-key.keys.lsp'),

  w = require('setup.which-key.keys.window'),
  z = require('setup.which-key.keys.vim-dadbod-ui'),
}
return M
