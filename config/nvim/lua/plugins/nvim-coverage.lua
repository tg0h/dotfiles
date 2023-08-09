return {
  'andythigpen/nvim-coverage',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('coverage').setup({
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
    })

    -- vim.cmd('highlight CoverageCovered gui=NONE guifg=green guibg=NONE')
    vim.cmd('highlight CoverageSummaryCursorLine gui=NONE guifg=NoNE guibg=purple')

    vim.keymap.set('n', '<C-M-c>', function()
      require('tg.toggle-coverage').toggle_coverage()
    end, { desc = 'toggle nvim coverage' })

    vim.keymap.set('n', '<C-M-d>', function()
      require('tg.toggle-coverage').toggle_summary()
    end, { desc = 'toggle nvim coverage summary' })

    vim.keymap.set(
      'n',
      '<C-M-n>',
      ":lua require'coverage'.jump_next('uncovered')<CR>",
      { desc = 'coverage next uncovered' }
    )
    vim.keymap.set(
      'n',
      '<C-M-p>',
      ":lua require'coverage'.jump_prev('uncovered')<CR>",
      { desc = 'coverage prev uncovered' }
    )
  end,
}
