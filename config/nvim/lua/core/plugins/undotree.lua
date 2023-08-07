return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<S-C-A-u>', ':UndotreeToggle<CR>', default_options) -- undotree
    vim.keymap.set('n', '<S-C-z>', ':UndotreeToggle<CR>', default_options) -- undotree
  end,
}
