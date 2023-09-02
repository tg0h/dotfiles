return {
  {
    'tg/toggle-interface',
    -- dev = true,
    dir = '~/.config/nvim/lua/tg/toggle-interface',
    dependencies = { 'nvim-treesitter', 'treesitter-utils' },
    keys = {
      {
        '<A-i>',
        function() require('tg.toggle-interface').Toggle() end,
        desc = 'toggle interface file',
      },
    },
  },
  {
    'tg/toggle-repository',
    dir = '~/.config/nvim/lua/tg/toggle-repository',
    keys = {
      {
        '<M-x>',
        function() require('tg.toggle-repository').Toggle() end,
        desc = 'toggle repository file',
      },
    },
  },
  {
    'tg/toggle-model',
    dir = '~/.config/nvim/lua/tg/toggle-model',
    keys = {
      {
        '<M-`>',
        function() require('tg.toggle-model').Toggle() end,
        desc = 'toggle model file',
      },
    },
  },
  {
    'tg/treesitter-utils',
    dir = '~/.config/nvim/lua/tg/treesitter-utils',
  },
  {
    'tg/toggle-test',
    dir = '~/.config/nvim/lua/tg/toggle-test',
    keys = {
      {
        '<A-.>',
        function() require('tg.toggle-test').Toggle() end,
        desc = 'toggle test file',
      },
    },
  },
  {
    'tg/test-runner',
    dir = '~/.config/nvim/lua/tg/test-runner',
    dependencies = { 'nvim-treesitter', 'treesitter-utils', 'toggle-test' },
    keys = {
      {
        '<M-p>',
        function() require('tg.test-runner').run_test() end,
        desc = 'run all tests',
      },
      {
        '<M-y>',
        function() require('tg.test-runner').run_single_test() end,
        desc = 'run single test',
      },
    },
  },
}
