require('neoclip').setup({
  history = 1000,
  enable_persistent_history = true, -- use sqlite.lua, history stored on VimLeavePre, lazy loaded when querying
  length_limit = 1048576,
  continuous_sync = false,
  db_path = vim.fn.stdpath('data') .. '/databases/neoclip.sqlite3',
  filter = nil,
  preview = true,
  prompt = nil,
  default_register = { '"', 'c' },
  default_register_macros = 'q',
  enable_macro_history = true,
  content_spec_column = false,
  on_select = {
    move_to_front = true,
    close_telescope = true,
  },
  on_paste = {
    set_reg = false,
    move_to_front = true,
    close_telescope = true,
  },
  on_replay = {
    set_reg = false,
    move_to_front = true,
    close_telescope = true,
  },
  on_custom_action = {
    close_telescope = true,
  },
  keys = {
    telescope = {
      i = {
        select = '<TAB>',
        paste = '<CR>',
        paste_behind = '<C-H>',
        replay = '<C-q>', -- replay a macro
        delete = '<C-d>', -- delete an entry
        custom = {},
      },
      n = {
        select = '<TAB>',
        paste = 'p',
        paste_behind = 'P',
        replay = 'q',
        delete = 'd',
        edit = 'e',
        custom = {},
      },
    },
  },
})
