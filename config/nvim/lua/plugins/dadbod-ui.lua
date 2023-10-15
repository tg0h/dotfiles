return {
  'kristijanhusak/vim-dadbod-ui',
  keys = { { '<M-v>', '<CMD>DBUIToggle<CR>', desc = { 'dadbod ui' } } },
  dependencies = {
    'tpope/vim-dadbod',
    'kristijanhusak/vim-dadbod-completion',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = '/Users/tim/dotfiles/config/dadbod'
  end,
}
