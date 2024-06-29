return {
  'rhysd/git-messenger.vim',
  dev = true, -- download the repo locally to remap the o key to , and  the O key to .
  keys = {
    { '<M-C-b>', '<CMD>GitMessenger<CR>', desc = 'git messenger' },
  },
  init = function()
    vim.g.git_messenger_always_into_popup = true -- always focus the popup window so that i can navigate commit history immediately with , and .
    vim.g.git_messenger_include_diff = 'current' -- show current file's diff
  end,
}
