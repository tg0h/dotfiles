return {
  'ThePrimeagen/git-worktree.nvim',
  dev = 'true',
  event = 'VeryLazy',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    -- { '<LEADER>t', ":lua require('telescope').load_extension('git-worktree')<CR>", desc = 'git worktree' },
    { '<C-Esc>', ":lua require('git-worktree').switch_worktree('main')<CR>", desc = 'switch to main' },
    { '<C-S-=>', ":lua require('git-worktree').switch_worktree('scripts')<CR>", desc = 'switch to scripts' }, -- C-+
    { '<LEADER>t.', ":lua require('git-worktree').switch_worktree('scripts')<CR>", desc = 'switch to scripts' },
    { '<LEADER>tt', ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", desc = 'git worktrees' },
    { '<C-b>', ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", desc = 'git worktrees' },
    { '<LEADER>th', ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", desc = 'create git worktrees' },
  },
  opts = {
    change_directory_command = 'cd',
    update_on_change = true,
    update_on_change_command = 'e .',
    clearjumps_on_change = true,
    autopush = true,
  },
  init = function()
    vim.g.git_worktree_log_level = 'error'
    -- require('telescope').load_extension('git_worktree')
  end,
  -- config = function(_, opts) require('git-worktree').setup(opts) end,
}
