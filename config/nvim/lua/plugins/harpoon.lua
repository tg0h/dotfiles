local M = {
  'ThePrimeagen/harpoon',
  -- dev = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },
  event = 'VeryLazy',
  config = function()
    local map = vim.api.nvim_set_keymap
    default_options = { noremap = true, silent = true }

    -- vim.g.harpoon_log_level = "debug"

    require('harpoon').setup({
      menu = { width = 120, height = 18 },
      global_settings = {
        -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_toggle = true,
        -- saves the harpoon file upon every change. disabling is unrecommended.
        save_on_change = true,
        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        enter_on_sendcmd = true,
        -- closes any tmux windows that harpoon creates when you close Neovim.
        tmux_autoclose_windows = false,
        -- filetypes that you want to prevent from adding to the harpoon list menu.
        excluded_filetypes = { 'harpoon' },
        -- set marks specific to each git branch inside git repository
        mark_branch = false,

        base_dirs = { '/Users/tim/src/playground/harpoon/monoRepoDeep', '/Users/tim/src/candy/main/referralcandy-main' },
      },
    })

    map('n', '<C-q>', ":lua require('harpoon.ui').toggle_quick_menu()<CR>", default_options)

    map('n', '<C-h>', ":lua require('harpoon.ui').nav_file(1)<CR>", default_options)
    map('n', '<C-t>', ":lua require('harpoon.ui').nav_file(2)<CR>", default_options)
    map('n', '<C-n>', ":lua require('harpoon.ui').nav_file(3)<CR>", default_options)
    map('n', '<C-s>', ":lua require('harpoon.ui').nav_file(4)<CR>", default_options)
    map('n', '<C-4>', ":lua require('harpoon.ui').nav_file(4)<CR>", default_options)
    map('n', '<C-5>', ":lua require('harpoon.ui').nav_file(5)<CR>", default_options)
    map('n', '<C-6>', ":lua require('harpoon.ui').nav_file(6)<CR>", default_options)
    map('n', '<C-7>', ":lua require('harpoon.ui').nav_file(7)<CR>", default_options)
    map('n', '<C-8>', ":lua require('harpoon.ui').nav_file(8)<CR>", default_options)

    -- map("n", "<C-M-h>", ":lua require('harpoon.ui').nav_file(5)<CR>", default_options)
    -- map("n", "<C-M-t>", ":lua require('harpoon.ui').nav_file(6)<CR>", default_options)
    -- map("n", "<C-M-n>", ":lua require('harpoon.ui').nav_file(5)<CR>", default_options)
    -- map("n", "<C-M-s>", ":lua require('harpoon.ui').nav_file(6)<CR>", default_options)

    map('n', '<C-M-q>', ":lua require('harpoon.mark').add_file()<CR>", default_options)
    -- map('n', '<C-M-m>', ":lua require('harpoon.mark').add_file()<CR>", default_options)

    -- <CMD>lua require('harpoon.dev').reload()<CR>
    -- t = { '<CMD>Telescope harpoon marks<CR>', 'Telescope harpoon marks' },
  end,
}

return M
