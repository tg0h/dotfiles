local M = {
  {
    'mfussenegger/nvim-dap',
    lazy = false,
    dependencies = {
      -- "mfussenegger/nvim-dap-python",
      -- "leoluz/nvim-dap-go",
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'jbyuki/one-small-step-for-vimkind',
    },
    init = function()
      vim.keymap.set('n', '<F12>', ":lua require'dapui'.toggle()<CR>", { desc = 'dap toggle' })
      vim.keymap.set('n', '<F2>', ":lua require'dap'.toggle_breakpoint()<CR>", { desc = 'dap toggle breakpoint' })
      vim.keymap.set('n', '<F7>', ":lua require'dap'.continue()<CR>", { desc = 'dap continue' })
      vim.keymap.set('n', '<F6>', ":lua require'dap'.step_into()<CR>", { desc = 'dap step into' })
      -- vim.keymap.set("n", "<F5>", ":lua require'dap'.step_out()<CR>", {desc=''})
      vim.keymap.set('n', '<F9>', ":lua require'dap'.step_over()<CR>", { desc = 'dap step over' })
      vim.keymap.set('n', '<F8>', ":lua require'dap'.run_to_cursor()<CR>", { desc = 'dap run to cursor' })
      vim.keymap.set('n', '<F10>', ":lua require'dap'.up()<CR>", { desc = 'dap up' })
      vim.keymap.set('n', '<F4>', ":lua require'dap'.down()<CR>", { desc = 'dap down' })
    end,
  },
}

return M
