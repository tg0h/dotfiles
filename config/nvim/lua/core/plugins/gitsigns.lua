local M = {
  'lewis6991/gitsigns.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('gitsigns').setup({
      -- no longer supported in gitsigns
      -- keymaps = {
      --   -- Default keymap options
      --   noremap = false,
      -- },
      signs = {
        add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      signcolumn = true, -- Toggle with :Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      -- git-blame provides also the time in contrast to gitsigns
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_formatter_opts = { relative_time = false },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      diff_opts = { internal = true },
      yadm = { enable = false },
    })

    local gitsigns = require('gitsigns')
    vim.keymap.set('n', '<S-A-g>', ":lua require('gitsigns').prev_hunk()<CR>", { desc = 'gitsigns prev hunk' }) -- prev git hunk
    vim.keymap.set('n', '<S-A-r>', ":lua require('gitsigns').next_hunk()<CR>", { desc = 'gitsigns next hunk' }) -- next git hunk
    vim.keymap.set('n', '<LEADER>g.', gitsigns.toggle_linehl, { desc = 'gitsigns toggle line highlight' }) -- prev git hunk
    vim.keymap.set('n', '<LEADER>g,', gitsigns.toggle_word_diff, { desc = 'gitsigns toggle word diff' }) -- prev git hunk
    vim.keymap.set('n', '<LEADER>gp', gitsigns.preview_hunk, { desc = 'gitsigns preview hunk' }) -- prev git hunk

    vim.keymap.set('n', '<LEADER>gs', gitsigns.stage_hunk, { desc = 'gitsigns stage hunk' }) -- prev git hunk
    vim.keymap.set('n', '<LEADER>gr', gitsigns.reset_hunk, { desc = 'gitsigns reset hunk' }) -- prev git hunk
    vim.keymap.set('n', '<LEADER>gu', gitsigns.undo_stage_hunk, { desc = 'gitsigns undo stage hunk' }) -- prev git hunk
    vim.keymap.set('n', '<LEADER>gR', gitsigns.reset_buffer, { desc = 'gitsigns reset buffer' }) -- prev git hunk
  end,
}
return M
