-- One line setup. This will create an autocmd for FileType * to change to root directory everytime you switch buffers.
require('nvim-rooter').setup({
  rooter_patterns = { '.git', '.hg', '.svn' },
  trigger_patterns = { '*' },
  manual = false,
})
