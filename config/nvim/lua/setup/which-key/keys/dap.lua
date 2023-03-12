local M = {
    name = 'DAP',
    d = {'<Cmd>lua require\'dapui\'.toggle()<CR>', 'Toggle UI'},
    r = {'<Cmd>lua require\'dapui\'.eval()<CR>', 'View dapui cursor expression'},
    R = {'<Cmd>lua require\'dap.ui.widgets\'.hover()<CR>', 'View cursor expression'},
    s = {'<Cmd>lua local widgets=require\'dap.ui.widgets\';widgets.centered_float(widgets.scopes)<CR>', 'View Scopes'},

    C = {'<Cmd>lua require\'dap\'.clear_breakpoints()<CR>', 'Clear breakpoints'},

    p = {'<Cmd>lua require\'dap\'.repl.toggle()<CR>', 'REPL toggle'},
    l = {'<Cmd>lua require\'dap\'.run_last()<CR>', 'Run Last'},

    o = {'<Cmd>lua require"telescope".extensions.dap.commands{}<CR>', 'Commands'},
    c = {'<Cmd>lua require"telescope".extensions.dap.configurations{}<CR>', 'Configurations'},
    b = {'<Cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', 'List breakpoints'},
    v = {'<Cmd>lua require"telescope".extensions.dap.variables{}<CR>', 'Variables'},
    f = {'<Cmd>lua require"telescope".extensions.dap.frames{}<CR>', 'Frames'}
}
return M
