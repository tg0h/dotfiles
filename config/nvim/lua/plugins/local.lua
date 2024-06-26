return {
  {
    'tg/toggle-file',
    dir = '~/.config/nvim/lua/tg/toggle-file',
    keys = {
      {
        '<M-]>',
        -- toggle to files in same folder
        function() require('tg.toggle-file').Toggle(1) end,
        desc = 'timtoggle next file in directory',
      },
      {
        -- '<C-[>', -- esc is ^[ so this doesn't work
        '<M-[>', -- esc is ^[ so this doesn't work
        -- toggle to files in same folder
        function() require('tg.toggle-file').Toggle(-1) end,
        desc = 'timtoggle previous file in directory',
      },
    },
  },
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
      {
        '<M-D-.>',
        function() require('tg.toggle-test').create_test_file() end,
        desc = 'timtoggle create test file if not found',
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
        desc = 'timtoggle frontend file to component file',
      },
    },
  },
  {
    'tg/toggle-route-service',
    dir = '~/.config/nvim/lua/tg/toggle-route-service',
    keys = {
      {
        '<M-2>',
        function() require('tg.toggle-route-service').Toggle() end,
        desc = 'timtoggle route handler to service',
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
        desc = 'timtoggle frontend api to router file',
      },
    },
  },
  {
    'tg/goto-daemon',
    dir = '~/.config/nvim/lua/tg/goto-daemon',
    keys = {
      {
        '<M-1>',
        function() require('tg.goto-daemon').goTo() end,
        desc = 'go to daemon task file',
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
        function() require('tg.test-runner').run_test('window') end,
        desc = 'run all tests in kitty window (tab)',
      },
      {
        '<M-C-p>',
        function() require('tg.test-runner').run_test('os-window') end,
        desc = 'run all tests in kitty os window (new kitty window)',
      },
      {
        '<M-y>',
        function() require('tg.test-runner').run_single_test('window') end,
        desc = 'run single test in kitty window (tab)',
      },
      {
        '<M-C-y>',
        function() require('tg.test-runner').run_single_test('os-window') end,
        desc = 'run single test in kitty os window',
      },
    },
  },
  {
    'tg/kitty-window-opener',
    dir = '~/.config/nvim/lua/tg/kitty-window-opener',
    keys = {
      {
        '<M-C-o>',
        function() require('tg.kitty-window-opener').open_current_file('window') end,
        desc = 'open current file in new kitty window',
      },
      {
        '<M-C-S-D-o>', -- hyper o
        function() require('tg.kitty-window-opener').open_current_file('os-window') end,
        desc = 'open current file in new kitty window',
      },
    },
  },
}
