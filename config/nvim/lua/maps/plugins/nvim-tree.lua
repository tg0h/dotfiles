local api = require('nvim-tree.api')
local map = vim.api.nvim_set_keymap
default_options = { noremap = true, silent = true }
expr_options = { noremap = true, expr = true, silent = true }

-- map("n", "<A-u>", ":NvimTreeFocus<CR>", default_options) -- Focus is better than Toggle

vim.keymap.set('n', '<A-m>', ':NvimTreeToggle<CR>', { desc = 'nvim tree toggle' })
vim.keymap.set('n', '<A-b>', ':NvimTreeFindFile<CR>', { desc = 'nvim tree find file' })

local function openNvimTreeAndKeepOpen()
  if vim.fn.bufname():match('NvimTree_') then
    -- previous window
    vim.cmd.wincmd('p')
  else
    api.tree.open({ find_file = true })
  end
end

vim.keymap.set('n', '<M-CR>', openNvimTreeAndKeepOpen, { desc = 'nvim-tree: toggle' })
vim.keymap.set('n', '<M-Space>', openNvimTreeAndKeepOpen, { desc = 'nvim-tree: toggle' })
