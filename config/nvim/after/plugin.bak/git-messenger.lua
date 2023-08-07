vim.keymap.set('n', '<S-C-b>', ':GitMessenger<CR>')

-- only show changes for current file
-- none | current | all
vim.g.git_messenger_include_diff = 'current'
