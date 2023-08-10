return {
  'dmmulroy/tsc.nvim',
  cmd = 'TSC',
  config = function()
    require('tsc').setup({
      flags = '--build --verbose',
    })
  end,
}
