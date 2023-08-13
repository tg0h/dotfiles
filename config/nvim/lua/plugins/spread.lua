return {
  'aarondiel/spread.nvim',
  -- event = { 'BufReadPre', 'BufNewFile' },
  event = 'VeryLazy',
  keys = {
    {
      '<M-C-a>',
      function() require('spread').combine() end,
      desc = 'spread combine',
    },
    {
      '<M-C-i>',
      function() require('spread').out() end,
      desc = 'spread split',
    },
  },
  config = function()
    local spread = require('spread')
    local wk = require('which-key')
    local default_options = { silent = true }
    wk.register({
      ['-'] = {
        name = 'Spread',
        c = { spread.combine, 'Combine' },
        s = { spread.out, 'Split' },
      },
    }, { prefix = '<leader>', mode = 'n', default_options })
  end,
}
