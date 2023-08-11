return {
  'andythigpen/nvim-coverage',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {

    {
      '<C-M-c>',
      function()
        require('tg.toggle-coverage').toggle_coverage()
      end,
      desc = 'toggle nvim coverage',
    },
    {
      '<C-M-d>',
      function()
        require('tg.toggle-coverage').toggle_summary()
      end,
      desc = 'toggle nvim coverage summary',
    },
    {
      '<C-M-n>',
      '<CMD>lua require"coverage".jump_next("uncovered")<CR>',
      desc = 'coverage next uncovered',
    },
    {
      '<C-M-p>',
      '<CMD>lua require"coverage".jump_prev("uncovered")<CR>',
      desc = 'coverage previous uncovered',
    },
  },

  opts = {
    commands = true, -- create commands
    highlights = {
      -- customize highlight groups created by the plugin
      -- covered = { fg = "#C3E88D" },   -- supports style, fg, bg, sp (see :h highlight-gui)
      covered = { fg = 'green' }, -- supports style, fg, bg, sp (see :h highlight-gui)
      uncovered = { fg = '#F07178' },
      -- summary_cursor_line = { fg = 'red', bg = 'purple' },
    },
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = 'CoverageCovered', text = '▎' },
      uncovered = { hl = 'CoverageUncovered', text = '▎' },
    },
    summary = {
      -- customize the summary pop-up
      min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
      width_percentage = 0.7,
      height_percentage = 0.7,
    },
    lang = {
      -- customize language specific settings
      -- javascript = {coverage_file = "packages/api/api/coverage/lcov.info"},
      -- typescript = {coverage_file = "packages/api/api/coverage/lcov.info"},
      -- javascript = {coverage_file = "coverage/lcov.info"},
      javascript = { coverage_file = '/Users/tim/src/candy/main/referralcandy-main/coverage/lcov.info' },
      typescript = { coverage_file = '/Users/tim/src/candy/main/referralcandy-main/coverage/lcov.info' },
    },
  },

  config = function(_, opts)
    require('coverage').setup(opts)
    -- vim.cmd('highlight CoverageCovered gui=NONE guifg=green guibg=NONE')
    vim.cmd('highlight CoverageSummaryCursorLine gui=NONE guifg=NoNE guibg=purple')
  end,
}
