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
