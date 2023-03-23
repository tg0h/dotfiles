local M = {
  name = "Git Worktree",
  h = { "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", "Create Worktrees" },
  g = { "<CMD>lua require 'telescope'.extensions.git_worktree.git_worktrees()<CR>", "List Worktrees" },
}
return M
