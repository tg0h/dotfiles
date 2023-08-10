return {
  { 'junegunn/vim-easy-align' }, -- no lua alternative
  { 'famiu/bufdelete.nvim', event = 'BufReadPre' },
  {
    'f-person/git-blame.nvim',
    event = 'VeryLazy',
    config = function()
      local g = vim.g
      g.gitblame_enabled = 0

      g.gitblame_message_template = '<author> • <summary> • <date> • <sha>'

      g.gitblame_date_format = '%r - %a %d %b %y %X'

      vim.keymap.set('n', '<M-x>', '<CMD>GitBlameToggle<CR>', { desc = 'git blame toggle' })
    end,
  },
  -- { 'ggandor/leap.nvim', dependencies = { 'tpope/vim-repeat' } },
  { 'hiphish/rainbow-delimiters.nvim', event = 'VeryLazy' },
  { 'fladson/vim-kitty' },
  -- { 'vito-c/jq.vim', },
  { 'dkarter/bullets.vim', event = 'VeryLazy' },
  { 'rhysd/committia.vim' },
}
