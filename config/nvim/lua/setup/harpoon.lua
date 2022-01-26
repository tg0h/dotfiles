local map = vim.api.nvim_set_keymap
default_options = {noremap = true, silent = true}


require("harpoon").setup({
    global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false
    }
})

map("n", "<C-e>", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", default_options)

map("n", "<C-h>", ":lua require('harpoon.ui').nav_file(1)<CR>", default_options)
map("n", "<C-t>", ":lua require('harpoon.ui').nav_file(2)<CR>", default_options)
map("n", "<C-n>", ":lua require('harpoon.ui').nav_file(3)<CR>", default_options)
map("n", "<C-s>", ":lua require('harpoon.ui').nav_file(4)<CR>", default_options)
