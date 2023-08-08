local M = {
  'sainnhe/sonokai',
  version = '*',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  -- priority is important, the colorscheme might set highlight clear, undoing all your highlight groups?
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme sonokai]])
    vim.cmd('highlight Normal guifg=#ffffff guibg=#000000')

    vim.api.nvim_exec(
      [[
  " less intrusive colorcolumn (column 120)
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%121v', 100)
]],
      true
    )
  end,
}
return M
