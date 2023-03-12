local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

-- Dap
map('n', '<F12>', ':lua require\'dapui\'.toggle()<CR>', default_options)
map('n', '<F2>', ':lua require\'dap\'.toggle_breakpoint()<CR>', default_options)
map('n', '<F7>', ':lua require\'dap\'.continue()<CR>', default_options)
map('n', '<F6>', ':lua require\'dap\'.step_into()<CR>', default_options)
-- map("n", "<F5>", ":lua require'dap'.step_out()<CR>", default_options)
map('n', '<F9>', ':lua require\'dap\'.step_over()<CR>', default_options)
map('n', '<F8>', ':lua require\'dap\'.run_to_cursor()<CR>', default_options)
map('n', '<F10>', ':lua require\'dap\'.up()<CR>', default_options)
map('n', '<F4>', ':lua require\'dap\'.down()<CR>', default_options)
