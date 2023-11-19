return {
  {
    'echasnovski/mini.cursorword',
    opts = { delay = 100 },
    init = function()
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { '*' },
        -- change the current cursor word highlight group to make distinct from visual select
        callback = function()
          vim.api.nvim_set_hl(0, 'MiniCursorwordCurrent', {
            default = false, -- default false overrides the existing highlight group set up by mini
            underline = true,
            -- reverse = true,
          })
        end,
      })
    end,
    event = 'VeryLazy',
    enabled = true,
  },
  {
    'echasnovski/mini.indentscope',
    opts = {
      -- Draw options
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 0,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        animation = function() return 0 end, -- this disables animation

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Textobjects
        object_scope = 'ii',
        object_scope_with_border = 'ai',

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = '[i',
        goto_bottom = ']i',
      },

      -- Options which control scope computation
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = 'both',

        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        indent_at_cursor = true,

        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = false,
      },

      -- Which character to use for drawing scope indicator
      symbol = '│', -- C-k vv inserts a digraph for a good vertical line
    },
    event = 'VeryLazy',
    enabled = true,
  },
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
