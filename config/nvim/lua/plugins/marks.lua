return {
  'chentoast/marks.nvim',
  event = 'VeryLazy',
  config = function()
    local marks = require('marks')

    marks.setup({
      -- whether to map keybinds or not. default true
      default_mappings = true,
      -- which builtin marks to show. default {}
      builtin_marks = { '.', '<', '>', '^' },
      -- whether movements cycle back to the beginning/end of buffer. default true
      cyclic = true,
      -- whether the shada file is updated after modifying uppercase marks. default false
      force_write_shada = false,
      -- how often (in ms) to redraw signs/recompute mark positions.
      -- higher values will have better performance but may cause visual lag,
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 250,
      -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
      -- marks, and bookmarks.
      -- can be either a table with all/none of the keys, or a single number, in which case
      -- the priority applies to all marks.
      -- default 10.
      sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
      -- disables mark tracking for specific filetypes. default {}
      excluded_filetypes = {},
      -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
      -- sign/virttext. Bookmarks can be used to group together positions and quickly move
      -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
      -- default virt_text is "".
      bookmark_0 = {
        sign = '⚑',
        virt_text = 'hello world',
        -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
        -- defaults to false.
        annotate = false,
      },
      mappings = {
        set_next = 'm,',
        toggle = 'm;',
        delete_line = 'dm-', -- delete all marks on the current line
        delete_buf = 'dm<SPACE>', -- delete all marks in the current buff
        next = 'm]',
        prev = 'm[',
        preview = 'm:',
        set = 'm',
        delete = 'dm',
        next_bookmark = 'm}', -- go to next bookmark in the bookmark group (assumes cursor currently on a bookmark )
        prev_bookmark = 'm{',
        -- bookmark groups work across files but do not persist between sessions
        -- use m[0-9] to set bookmarks 0-9
        -- use dm[0-9] to delete all marks in bookmark group 0-9
        -- set_bookmark0 = 'n0',
        -- next_bookmark0 = 'n,',
        -- prev_bookmark0 = 'n,',
        -- delete_bookmark0  = 'n,',
      },
    })
  end,
}
