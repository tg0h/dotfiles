vim.api.nvim_exec([[
  " less intrusive colorcolumn
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%121v', 100)
]], true)
