vim.api.nvim_exec([[
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%81v', 100)
]], true)
