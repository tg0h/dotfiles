return {
  'mbbill/undotree',
  config = function()
    -- S-C-z in taken up by treesitter text object
    vim.keymap.set('n', '<M-C-u>', ':UndotreeToggle<CR>', default_options) -- undotree
  end,
}
