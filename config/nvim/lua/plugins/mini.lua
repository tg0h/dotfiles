return {
  { 'echasnovski/mini.cursorword', opts = { delay = 100 }, event = 'VeryLazy' },
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    -- No need to copy this inside `setup()`. Will be used automatically.
    opts = {
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = nil,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = 'a',
        inside = 'i',

        -- Next/last variants
        around_next = 'an',
        inside_next = 'in',
        around_last = 'al',
        inside_last = 'il',

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = 'g[',
        goto_right = 'g]',
      },

      -- Number of lines within which textobject is searched
      n_lines = 50,

      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = 'cover_or_next',

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },

  {
    'echasnovski/mini.surround',
    -- enabled = false,
    -- event = { 'BufReadPre', 'BufNewFile' },
    event = 'VeryLazy',
    opts = {
      -- Number of lines within which surrounding is searched
      n_lines = 150,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'sa', -- Add surrounding
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
    },
  },
  {
    'echasnovski/mini.align',
    -- event = { 'BufReadPre', 'BufNewFile' },
    event = 'VeryLazy',
    -- is not loaded without explicitly saying it
    config = true,
    -- Press s to enter split Lua pattern.
    -- Press j to choose justification side from available ones ("left", "center", "right", "none").
    -- Press m to enter merge delimiter.
    -- Press f to enter filter Lua expression to configure which parts will be affected (like "align only first column").
    -- Press i to ignore some commonly unwanted split matches.
    -- Press p to pair neighboring parts so they be aligned together.
    -- Press t to trim whitespace from parts.
    -- Press <BS> (backspace) to delete some last pre-step.
  },
}
