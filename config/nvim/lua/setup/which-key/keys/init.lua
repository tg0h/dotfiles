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

  w = {
    name = 'Window',
    a = { '<C-w><C-o>', 'Close all other splits' },
    q = { '<cmd>:q<cr>', 'Close' },
    s = { '<cmd>:split<cr>', 'Horizontal Split' },
    t = { '<c-w>t', 'Move to new tab' },
    ['='] = { '<c-w>=', 'Equally size' },
    v = { '<cmd>:vsplit<cr>', 'Vertical Split' },
    w = { '<c-w>x', 'Swap' },
    z = { '<C-w>_<C-w>|<CR>', 'Zoom Split' },
  },
  z = require('setup.which-key.keys.vim-dadbod-ui'),
}
return M
