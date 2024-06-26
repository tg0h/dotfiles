return {
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
}
