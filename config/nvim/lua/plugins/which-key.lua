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
  config = function(_, opts)
    local wk = require('which-key')
    wk.setup(opts)

    local keyMaps = {
      h = { name = 'diagnostics' },
      r = { name = 'Notes' },
      c = { name = 'config' },
      s = { name = 'search' },
      f = { name = 'Files' },
      m = { name = 'misc' },
      w = { name = 'wiki' },
      n = { name = 'neovim core' },
      g = { name = 'Git' },
      ['.'] = { name = 'messages' },
      l = {
        name = 'LSP',
        -- A = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', 'Add Workspace Folder' },
        -- W = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', 'Remove Workspace Folder' },
        -- d = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go To Declaration' },
        m = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Show implementations' },
        h = { '<cmd>lua vim.lsp.buf.hover()<cr>', 'Hover Commands' },
        -- L = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'List Workspace Folders' },
        -- S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
        i = { '<cmd>LspInfo<cr>', 'Connected Language Servers' },
        k = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature Help' },
        -- s = { '<cmd>Telescope lsp_document_symbols<CR>', 'Document Symbols' },
        t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition' },
      },
    }
    local default_options = { noremap = true, silent = true }
    -- Register all leader based mappings
    wk.register(keyMaps, { prefix = '<leader>', mode = 'n', default_options })
  end,
}

return M
