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
        desc = 'timtoggle interface file',
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
        desc = 'timtoggle repository file',
      },
    },
  },
  {
    'tg/toggle-model',
    dir = '~/.config/nvim/lua/tg/toggle-model',
    keys = {
      {
        '<M-S-4>', --M-$
        function() require('tg.toggle-model').Toggle() end,
        desc = 'timtoggle model file',
      },
    },
  },
  {
    'tg/toggle-make',
    dir = '~/.config/nvim/lua/tg/toggle-make',
    keys = {
      {
        "<M-'>",
        function() require('tg.toggle-make').Toggle() end,
        desc = 'timtoggle make file',
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
        '<M-.>',
        function() require('tg.toggle-test').Toggle() end,
        desc = 'timtoggle test file',
      },
    },
  },
  {
    'tg/toggle-front',
    dir = '~/.config/nvim/lua/tg/toggle-front',
    keys = {
      {
        '<M-Esc>',
        function() require('tg.toggle-front').Toggle() end,
        desc = 'timtoggle frontend file',
      },
    },
  },
  {
    'tg/toggle-front-api',
    dir = '~/.config/nvim/lua/tg/toggle-front-api',
    keys = {
      {
        '<M-,>',
        function() require('tg.toggle-front-api').Toggle() end,
        desc = 'timtoggle frontend page/component to frontend api file',
      },
    },
  },
  {
    'tg/toggle-api',
    dir = '~/.config/nvim/lua/tg/toggle-api',
    keys = {
      {
        '<M-;>',
        function() require('tg.toggle-api').Toggle() end,
        desc = 'timtoggle api file',
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
