-- local icons = require('core.utils.icons')
local M = {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = 'Comments' },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      -- For example:
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<C-d>', -- binding to scroll down inside the popup
      scroll_up = '<C-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'none', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      -- margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      -- padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 10,
    },
    layout = {
      -- increase height for eg which key builtin registers plugin
      height = { min = 4, max = 100 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    -- list of triggers, where WhichKey should not wait for timeoutlen and show immediately
    triggers_nowait = {
      -- marks
      '`',
      "'",
      'g`',
      "g'",
      -- registers
      '"',
      '<c-r>',
      -- spelling
      'z=',
    },
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  },
  -- opts = {
  --   icons = {
  --     breadcrumb = icons.arrows.DoubleArrowRight, -- symbol used in the command line area that shows your active key combo
  --     separator = icons.arrows.SmallArrowRight, -- symbol used between a key and it's label
  --     group = icons.ui.Plus, -- symbol prepended to a group
  --   },
  --   window = {
  --     border = 'none', -- none, single, double, shadow
  --     position = 'bottom', -- bottom, top
  --     margin = { 0, 10, 3, 10 }, -- extra window margin [top, right, bottom, left]
  --     padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  --   },
  --   layout = {
  --     height = { min = 3, max = 25 }, -- min and max height of the columns
  --     width = { min = 5, max = 50 }, -- min and max width of the columns
  --     spacing = 10, -- spacing between columns
  --     align = 'center', -- align columns left, center or right
  --   },
  --   groups = {
  --     mode = { 'n', 'v' },
  --     ['<leader>b'] = { name = 'Buffers' },
  --     ['<leader>f'] = { name = 'Files' },
  --     ['<leader>l'] = { name = 'LSP' },
  --     ['<leader>m'] = { name = 'Misc' },
  --     ['<leader>q'] = { name = 'Quickfix' },
  --     ['<leader>s'] = { name = 'Search' },
  --     ['<leader>t'] = { name = 'Toggles' },
  --     ['<leader>w'] = { name = 'Windows' },
  --     ['<leader>z'] = { name = 'Spelling' },
  --   },
  -- },
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    wk.register({
      -- x is visual mode
      ga = { '<Plug>(EasyAlign)', 'Align', mode = 'x' },
    })

    local keyMaps = require('setup.which-key/keys')
    default_options = { noremap = true, silent = true }
    -- Register all leader based mappings
    wk.register(keyMaps, { prefix = '<leader>', mode = 'n', default_options })
    -- wk.register(opts.groups)
  end,
}

return M
