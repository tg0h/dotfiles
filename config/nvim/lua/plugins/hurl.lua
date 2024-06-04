return {
  'jellydn/hurl.nvim',
  enabled = false,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  ft = 'hurl',
  opts = {
    -- Show debugging info
    debug = false,
    -- Show notification on run
    show_notification = false,
    -- Show response in popup or split
    mode = 'split',
    -- Default formatter
    formatters = {
      json = { 'jq' }, -- Make sure you have install jq in your system, e.g: brew install jq
      html = {
        'prettier', -- Make sure you have install prettier in your system, e.g: npm install -g prettier
        '--parser',
        'html',
      },
    },
  },
  keys = {
    -- Run API request
    { '<leader>A', '<cmd>HurlRunner<CR>', desc = 'Run All requests' },
    { '<leader>a', '<cmd>HurlRunnerAt<CR>', desc = 'Run Api request' },
    { '<leader>te', '<cmd>HurlRunnerToEntry<CR>', desc = 'Run Api request to entry' },
    { '<leader>tm', '<cmd>HurlToggleMode<CR>', desc = 'Hurl Toggle Mode' },
    { '<leader>tv', '<cmd>HurlVerbose<CR>', desc = 'Run Api in verbose mode' },
    -- Run Hurl request in visual mode
    { '<leader>h', ':HurlRunner<CR>', desc = 'Hurl Runner', mode = 'v' },
  },
}
