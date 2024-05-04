local M = {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  -- dev = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
  },
  event = 'VeryLazy',
  config = function()
    -- vim.g.harpoon_log_level = "debug"
    local harpoon = require('harpoon')
    -- https://github.com/ThePrimeagen/harpoon/issues/502
    harpoon:setup({
      settings = {
        save_on_toggle = true, -- so that we can rearrange the list
        sync_on_ui_close = false,
        key = function() return vim.loop.cwd() end,
      },
    })

    -- require('harpoon').setup({
    --   menu = { width = 120, height = 30 },
    --   global_settings = {
    --     -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    --     save_on_toggle = true,
    --     -- saves the harpoon file upon every change. disabling is unrecommended.
    --     save_on_change = true,
    --     -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    --     enter_on_sendcmd = true,
    --     -- closes any tmux windows that harpoon creates when you close Neovim.
    --     tmux_autoclose_windows = false,
    --     -- filetypes that you want to prevent from adding to the harpoon list menu.
    --     excluded_filetypes = { 'harpoon' },
    --     -- set marks specific to each git branch inside git repository
    --     mark_branch = false,
    --
    --     base_dirs = { '/Users/tim/src/playground/harpoon/monoRepoDeep', '/Users/tim/src/candy/main/referralcandy-main' },
    --   },
    -- })

    vim.keymap.set('n', '<M-C-q>', function() harpoon:list():add() end)
    -- vim.keymap.set('n', '<leader>a', function() harpoon:list():append() end)
    -- vim.keymap.set('n', '<leader>d', function() harpoon:list():remove() end)
    vim.keymap.set('n', '<M-Space>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end)
    vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end)
    vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end)
    vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
    vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    vim.keymap.set('n', '<Leader>sh', function() toggle_telescope(harpoon:list()) end, { desc = 'Open harpoon window' })
  end,
}

return M
