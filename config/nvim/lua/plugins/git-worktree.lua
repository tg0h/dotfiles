return {
  'ThePrimeagen/git-worktree.nvim',
  dev = 'true',
  event = 'VeryLazy',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    -- { '<LEADER>t', ":lua require('telescope').load_extension('git-worktree')<CR>", desc = 'git worktree' },
    { '<C-/>', ":lua require('git-worktree').switch_worktree('../main')<CR>", desc = 'switch to main' },
    { '<C-S-=>', ":lua require('git-worktree').switch_worktree('../scripts')<CR>", desc = 'switch to scripts' }, -- C-+
    -- kitty maps C-- to C-\
    { '<C-Bslash>', ":lua require('git-worktree').switch_worktree('../feature')<CR>", desc = 'switch to feature' }, -- C--
    -- { '<C-9>', ":lua require('git-worktree').switch_worktree('../review')<CR>", desc = 'switch to review' },
    -- { '<C-8>', ":lua require('git-worktree').switch_worktree('../fix')<CR>", desc = 'switch to fix' },
    { '<LEADER>t.', ":lua require('git-worktree').switch_worktree('../scripts')<CR>", desc = 'switch to scripts' },
    { '<LEADER>tr', ":lua require('git-worktree').switch_worktree('../review')<CR>", desc = 'switch to review' },
    { '<LEADER>tf', ":lua require('git-worktree').switch_worktree('../fix')<CR>", desc = 'switch to fix' },
    { '<LEADER>tm', ":lua require('git-worktree').switch_worktree('../main')<CR>", desc = 'switch to main' },
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

    local wk = require('which-key')
    wk.register({ ['<LEADER>t'] = { name = 'git-worktree' } })
    -- require('telescope').load_extension('git_worktree')
  end,
  -- config = function(_, opts) require('git-worktree').setup(opts) end,
}
