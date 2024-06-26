return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'powerline_dark',
      -- theme = 'auto',
      -- section eg 'lualine_a' can contain many components
      section_separators = { left = '', right = '' },
      -- a component is an element in a section
      component_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'NvimTree' },
        winbar = { 'NvimTree', 'httpResult' }, -- rest.nvim uses winbar so disable winbar for httpResult
      },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { 'mode' }, -- Vim normal, etc mode
      lualine_b = { { 'b:gitsigns_head', icon = '' }, 'diff' }, -- display the gitsigns plugin buffer variable
      lualine_c = {},
      lualine_x = {
        { 'diagnostics', sources = { 'nvim_diagnostic' } }, -- LSP diagnostics
        'encoding',
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' }, -- percentage of file shown
      lualine_z = { 'location' }, -- which file line and column
    },
    inactive_sections = { -- what to show if window is not active
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},

    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          file_status = true, -- show readonly/modified status
          path = 1, -- show relative path
          -- shorting_target = 40,
          symbols = { modified = '[+]', readonly = ' ' }, -- copied icon from https://www.nerdfonts.com/cheat-sheet
          padding = { left = 5 },
        },
      },
      lualine_x = {
        {
          function()
            local path = vim.api.nvim_buf_get_name(0)
            local dirname = vim.fs.dirname(path)

            local count = 0
            for name, type in vim.fs.dir(dirname) do
              if type == 'file' then count = count + 1 end
            end
            return count
          end,
        },
      },
      lualine_y = {
        {
          function()
            local file = require('tg.utils').get_file_in_dir(-1)
            return file
          end,
          fmt = function(file) return vim.fs.basename(file) end,
        },
      },
      lualine_z = {
        {
          function()
            local file = require('tg.utils').get_file_in_dir(1)
            return file
          end,
          fmt = function(file) return vim.fs.basename(file) end,
        },
      },
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    -- extensions = {"nvim-tree", "toggleterm", "quickfix", "symbols-outline"}
    extensions = { 'nvim-tree' },
  },
  config = true,
}
