return {
  {
    'famiu/bufdelete.nvim',
    -- event = 'BufReadPre',
    keys = {
      { '<A-c>', ':Bdelete!<CR>', desc = 'go to last buffer' },
    },
  },
  { 'hiphish/rainbow-delimiters.nvim', event = 'VeryLazy' },
  { 'fladson/vim-kitty' },
  { 'dkarter/bullets.vim', event = 'VeryLazy' },
  { 'rhysd/committia.vim', init = function() vim.g.committia_edit_window_width = 100 end },
}
