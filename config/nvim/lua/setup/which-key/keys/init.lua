local M = {
  q = { "<cmd>lua require'tg.quickfix'.ToggleQFList(0)<CR>", 'Toggle Location List' },
  j = { '<cmd>lnext<CR>', 'Location List next' },
  k = { '<cmd>lprev<CR>', 'Location List prev' },

  r = require('setup.which-key.keys.notes'),

  h = require('setup.which-key.keys.harpoon'),
  t = require('setup.which-key.keys.trouble'),
  s = require('setup.which-key.keys.search'),

  b = require('setup.which-key.keys.buffers'),
  c = require('setup.which-key.keys.coverage'),
  f = { name = 'Files' },
  g = require('setup.which-key.keys.git'),
  l = require('setup.which-key.keys.lsp'),

  m = require('setup.which-key.keys.misc'),
  w = require('setup.which-key.keys.window'),
  z = require('setup.which-key.keys.vim-dadbod-ui'),
}
return M
