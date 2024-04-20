local M = {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    -- 'RRethy/nvim-treesitter-endwise',
    -- 'mfussenegger/nvim-ts-hint-textobject',
    'windwp/nvim-ts-autotag',
    'nvim-treesitter/playground',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        -- 'cmake',
        'clojure',
        'dockerfile',
        'go',
        'http',
        'html',
        'javascript',
        'typescript',
        'json',
        -- 'ledger',
        'lua',
        'python',
        'toml',
        'yaml',
        'markdown',
        'ruby',
        'vimdoc',
        'sql',
        'xml',
        'graphql',
      },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true, -- false will disable the whole extension

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          scope_incremental = '<CR>',
          node_incremental = 'g2',
          node_decremental = 'g1',
        },
      },
      indent = { enable = true }, -- Indentation based on treesitter for the = operator

      -- Custom Modules
      -- autopairs = {{enable = true}},
      autotag = { enable = true },

      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects for the built in text objects for the language
      textobjects = { -- for git nvim-treesitter/nvim-treesitter-textobjects
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['ik'] = '@block.inner',
            ['ak'] = '@block.outer',
            ['ir'] = '@parameter.inner',
            ['ar'] = '@parameter.outer',
            ['ii'] = '@conditional.inner',
            ['ai'] = '@conditional.outer',
            ['at'] = '@comment.outer',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            -- [']]'] = { query = '@class.outer', desc = 'Next class start' },
            -- function.outer can refer to both the start of the function or the end fo the function
            -- goto_next_start means go to the start of the next function
            ['<S-C-r>'] = '@function.outer',
            ['<S-C-l>'] = '@function.inner',
            [']]'] = '@function.*',

            ['<S-C-7>'] = '@assignment.outer',
            ['<S-C-8>'] = '@assignment.inner',
            -- [']o'] = '@assignment.lhs',
            -- [']u'] = '@assignment.rhs',

            -- any {} block
            ['<S-C-v>'] = '@block.outer',
            ['<S-C-z>'] = '@block.inner',

            -- a function call
            ['<S-C-n>'] = '@call.outer',
            ['<S-C-s>'] = '@call.inner',

            ['],'] = '@comment.outer',
            -- [']o'] = '@comment.inner', -- not supported in ts

            -- if
            ['<S-M-C-n>'] = '@conditional.outer',
            ['<S-M-C-s>'] = '@conditional.inner',

            -- [']:'] = '@loop.outer',
            -- [']q'] = '@loop.inner',
            -- [']e'] = '@number.outer',
            -- [']u'] = '@number.inner',
            -- [']j'] = '@parameter.outer',
            -- [']k'] = '@parameter.inner', --more useful

            -- ['<M-]>'] = '@parameter.inner', --more useful

            -- [']j'] = '@regex.outer',
            -- [']k'] = '@regex.inner',

            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
            -- [']o'] = '@loop.*',
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
            [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },

          goto_previous_start = {
            ['[m'] = '@function.outer',
            -- ['[['] = '@class.outer',
            ['[['] = '@function.*',

            ['<S-C-g>'] = '@function.outer',
            ['<S-C-c>'] = '@function.inner',

            ['<S-C-.>'] = '@assignment.outer',
            ['<S-C-p>'] = '@assignment.inner',

            ['<S-C-m>'] = '@block.outer',
            ['<S-C-w>'] = '@block.inner',

            ['<S-C-h>'] = '@call.outer',
            ['<S-C-t>'] = '@call.inner',

            ['[,'] = '@comment.outer',

            ['<S-M-C-h>'] = '@conditional.outer',
            ['<S-M-C-t>'] = '@conditional.inner',

            -- ['<M-[>'] = '@parameter.inner', -- more useful
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            [']d'] = '@conditional.outer',
          },
          goto_previous = {
            ['[d'] = '@conditional.outer',
          },
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>lf'] = '@function.outer',
            ['<M-f>'] = '@function.outer',
            ['<leader>lF'] = '@class.outer',
          },
        },
      },
      rainbow = { -- git nvim-ts-rainbow
        enable = true,
        extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
        max_file_lines = 2000, -- Do not enable for files with more than specified lines
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {

          -- in the editor, write the query below and move the cursor to @capture
          -- this highlights all the if statements
          -- (if_statement) @capture
          toggle_query_editor = 'd',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
    })

    local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

    -- Repeat movement
    -- ensure <PageDown> goes forward and <PageUp> goes backward regardless of the last direction
    -- x is visual mode
    vim.keymap.set({ 'n', 'x', 'o' }, '<PageUp>', ts_repeat_move.repeat_last_move_previous)
    vim.keymap.set({ 'n', 'x', 'o' }, '<PageDown>', ts_repeat_move.repeat_last_move_next)

    -- toggle <Home> and <End> to switch between the start and end of range
    -- This repeats the last query with always previous direction and to the START of the range.
    vim.keymap.set({ 'n', 'x', 'o' }, '<Home>', function() ts_repeat_move.repeat_last_move({ forward = false, start = true }) end)

    -- This repeats the last query with always next direction and to the END of the range.
    vim.keymap.set({ 'n', 'x', 'o' }, '<End>', function() ts_repeat_move.repeat_last_move({ forward = true, start = false }) end)

    vim.keymap.set({ 'n' }, '<S-C-/>', vim.cmd.TSPlaygroundToggle)
  end,
}

return M
