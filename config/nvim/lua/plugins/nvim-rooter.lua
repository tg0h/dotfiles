return {
  'notjedi/nvim-rooter.lua',
  enabled = false,
  config = function()
    require('nvim-rooter').setup({
      rooter_patterns = { '.git', '.hg', '.svn' },
      trigger_patterns = { '*' },
      manual = false,
    })
  end,
}
