local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}
expr_options = {noremap = true, expr = true, silent = true}

map("n", "<S-C-A-d>", ":DBUIToggle<CR>", default_options)
-- go to the db result window and then activate this plug to toggle the layout

-- map("n", "<A-r>", "<Plug>(DBUI_ToggleResultLayout)", {noremap=false })
-- map("n", "<A-g>", "<Plug>(DBUI_ExecuteQuery)", {noremap=false, silent=true})
