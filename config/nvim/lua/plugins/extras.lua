return {
  {
    'famiu/bufdelete.nvim',
    -- event = 'BufReadPre',
    keys = {
      { '<A-c>', ':Bdelete!<CR>', desc = 'go to last buffer' },
    },
  },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    keys = {
      { '<LEADER>gz', '<CMD>GitBlameToggle<CR>', desc = 'git blame toggle' },
    },
    init = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = '<author> • <summary> • <date> • <sha>'
      vim.g.gitblame_date_format = '%r - %a %d %b %y %X'
    end,
  },
  { 'hiphish/rainbow-delimiters.nvim', event = 'VeryLazy' },
  { 'fladson/vim-kitty' },
  { 'dkarter/bullets.vim', event = 'VeryLazy' },
  { 'rhysd/committia.vim', init = function() vim.g.committia_edit_window_width = 100 end },
}
