vim.cmd.colorscheme('sonokai')
-- increase contrast
-- set this after setting the colorscheme
-- https://github.com/sainnhe/sonokai/issues/26
vim.cmd('highlight Normal guifg=#ffffff guibg=#000000')

vim.api.nvim_exec(
  [[
  " less intrusive colorcolumn
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%121v', 100)
]],
  true
)
