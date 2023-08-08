return {
  {
    'tg/toggle-interface',
    dev = true,
    dependencies = { 'nvim-treesitter', 'treesitter-utils' },
    keys = {
      {
        '<A-i>',
        function()
          require('toggle-interface').Toggle()
        end,
        desc = 'toggle interface file',
      },
    },
  },
  { 'tg/treesitter-utils', dev = true },
  {
    'tg/toggle-test',
    dev = true,
    keys = {
      {
        '<A-.>',
        function()
          require('toggle-test').Toggle()
        end,
        desc = 'toggle test file',
      },
    },
  },
  {
    'tg/test-runner',
    dev = true,
    dependencies = { 'nvim-treesitter', 'treesitter-utils', 'toggle-test' },
    keys = {
      {
        '<M-p>',
        function()
          require('test-runner').run_test()
        end,
        desc = 'run all tests',
      },
      {
        '<M-y>',
        function()
          require('test-runner').run_single_test()
        end,
        desc = 'run single test',
      },
    },
  },
}
