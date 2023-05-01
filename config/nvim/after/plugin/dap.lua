local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath('data') .. '/dapinstall/jsnode/' .. '/vscode-node-debug2/out/src/nodeDebug.js' },
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
}

vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🚀' }) -- note that the linehl is specified by dap. we do not override it

-- open integrated terminal in a smaller split window
dap.defaults.fallback.terminal_win_cmd = 'below 20split new'

-- require('dap').adapters['pwa-node'] = {
--   type = 'server',
--   host = 'localhost',
--   port = '${port}',
--   executable = {
--     command = 'node',
--     -- 💀 Make sure to update this path to point to your installation
--     args = { '/path/to/js-debug/src/dapDebugServer.js', '${port}' },
--   },
-- }
-- require('dap').configurations.javascript = {
--   {
--     type = 'pwa-node',
--     request = 'launch',
--     name = 'Launch file',
--     program = '${file}',
--     cwd = '${workspaceFolder}',
--   },
--   {
--     -- For this to work you need to make sure the node process is started with the `--inspect` flag.
--     name = 'Attach to process',
--     type = 'pwa-node',
--     request = 'attach',
--     processId = require('dap.utils').pick_process,
--   },
-- }

-- vim.keymap.set('n', '<F12>', ":lua require'dapui'.toggle()<CR>", { desc = 'dap toggle' })
-- vim.keymap.set('n', '<F2>', ":lua require'dap'.toggle_breakpoint()<CR>", { desc = 'dap toggle breakpoint' })
-- vim.keymap.set('n', '<F7>', ":lua require'dap'.continue()<CR>", { desc = 'dap continue' })
-- vim.keymap.set('n', '<F6>', ":lua require'dap'.step_into()<CR>", { desc = 'dap step into' })
-- -- vim.keymap.set("n", "<F5>", ":lua require'dap'.step_out()<CR>", {desc=''})
-- vim.keymap.set('n', '<F9>', ":lua require'dap'.step_over()<CR>", { desc = 'dap step over' })
-- vim.keymap.set('n', '<F8>', ":lua require'dap'.run_to_cursor()<CR>", { desc = 'dap run to cursor' })
-- vim.keymap.set('n', '<F10>', ":lua require'dap'.up()<CR>", { desc = 'dap up' })
-- vim.keymap.set('n', '<F4>', ":lua require'dap'.down()<CR>", { desc = 'dap down' })
