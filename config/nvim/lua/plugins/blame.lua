return {
  'FabijanZulj/blame.nvim',
  -- cmd = 'ToggleBlame',
  keys = { { '<LEADER>gb', '<CMD>ToggleBlame<CR>', desc = 'toggle blame' } },
  opts = {
    width = 40,
    date_format = '%Y-%m-%d %H:%M:%S',
    virtual_style = 'float', -- or right_align
  },
}
