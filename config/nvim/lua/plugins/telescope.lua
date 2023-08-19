local M = {
  'nvim-telescope/telescope.nvim',
  dependencies = {

    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'crispgm/telescope-heading.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-symbols.nvim' }, -- add emojis
    { 'nvim-telescope/telescope-frecency.nvim' },
  },
  keys = {
    -- MAPS ----------------------------------------------------------------------------------------
    -- project
    -- {
    --   '<C-p>',
    --   function()
    --     require('telescope.builtin').git_files({
    --       hidden = false,
    --       layout_strategy = 'vertical',
    --       layout_config = {
    --         height = 0.99,
    --         -- anchor = 'E',
    --         width = 0.9,
    --         prompt_position = 'top',
    --         preview_height = 0.5,
    --         mirror = true,
    --       },
    --     })
    --   end,
    --   desc = 'git files',
    -- },
    {
      '<S-C-->',
      '<CMD>Telescope commands<CR>',
      desc = 'Telescope commands',
    },

    -- files #########################################################################################
    { '<LEADER>ff', '<CMD>Telescope find_files<CR>', desc = 'Open file (ignore git)' },
    {
      '<LEADER>fh',
      function()
        require('telescope.builtin').find_files({
          find_command = { 'fd', '--hidden', '--type', 'file', '--follow' },
        })
      end,
      desc = 'find files --hidden',
    },
    {
      '<LEADER>f.',
      function() require('telescope').load_extension('file_browser').file_browser() end,
      desc = 'file_browser()',
    },
    -- { '<LEADER>fr', '<CMD>Telescope oldfiles<CR>', desc = 'old files (Recent files)' },
    {
      '<LEADER>fe',
      function()
        require('telescope')
          .load_extension('frecency')
          .frecency({ layout_strategy = 'vertical', layout_config = { mirror = true, width = 0.9, height = 0.9 } })
      end,
      desc = 'find frecent files',
    },

    -- neovim #########################################################################################
    { '<LEADER>na', '<CMD>Telescope autocommands<CR>', desc = 'autocommands' },
    {
      '<LEADER>nb',
      function() require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true }) end,
      desc = 'search open buffers (ignore current buffer)',
    },
    { '<LEADER>nc', '<CMD>Telescope commands<CR>', desc = 'commands' },
    { '<LEADER>nC', '<CMD>Telescope command_history<CR>', desc = 'command history' },
    { '<LEADER>nh', '<CMD>Telescope help_tags<CR>', desc = 'neovim help tags' },
    { '<LEADER>nf', '<CMD>Telescope filetypes<CR>', desc = 'filetypes' },
    {
      '<LEADER>nd',
      function()
        telescope.load_extension('heading') -- markdown, help headings
        vim.cmd.Telescope('heading')
      end,
      desc = 'headings',
    },
    { '<LEADER>ni', '<CMD>Telescope highlights<CR>', desc = 'highlights' },
    { '<LEADER>nu', '<CMD>Telescope builtin<CR>', desc = 'telescope builtin' },
    {
      '<LEADER>nj',
      function()
        require('telescope.builtin').jumplist({
          fname_width = 100,
          layout_strategy = 'vertical',
          layout_config = { preview_height = 0.4 },
        })
      end,
      desc = 'jumplist',
    },
    { '<LEADER>nk', '<CMD>Telescope keymaps<CR>', desc = 'keymaps' },
    { '<LEADER>nm', '<CMD>Telescope marks<CR>', desc = 'marks' },
    { '<LEADER>no', '<CMD>Telescope vim_options<CR>', desc = 'vim options' },
    { '<LEADER>nr', '<CMD>Telescope registers<CR>', desc = 'registers' },
    { '<LEADER>nwt', '<C-w>T', desc = 'move window to new tab' }, -- needs 2 windows eg S-M-b before it works
    { '<LEADER>nwx', '<C-w>x', desc = 'swap windows' },
    { '<LEADER>nw=', '<C-w>=', desc = 'equally size windows' },
    { '<LEADER>ns', '<CMD>Telescope search_history<CR>', desc = 'search history' },
    { '<LEADER>n:', '<CMD>Telescope loclist<CR>', desc = 'loclist' },
    {
      '<LEADER>nq',
      function()
        require('telescope.builtin').quickfix({
          fname_width = 60,
          layout_strategy = 'vertical',
          layout_config = { preview_height = 0.5 },
        })
      end,
      desc = 'quickfix',
    },
    {
      '<LEADER>nQ',
      function()
        require('telescope.builtin').quickfixhistory({
          fname_width = 60,
          layout_strategy = 'vertical',
        })
      end,
      desc = 'quickfix history',
    },
    {
      '<LEADER>n.',
      function() require('telescope.').load_extension('neoclip').default() end,
      desc = 'neoclip',
    },
    -- telescope #########################################################################################
    { '<LEADER>hr', '<CMD>Telescope resume<CR>', desc = 'telescope resume' },
    { '<LEADER>hh', '<CMD>Telescope pickers<CR>', desc = 'telescope previous pickers' },

    -- telescope lsp ####################################################################################
    { '<LEADER>hf', '<CMD>Telescope lsp_references<CR>', desc = 'telescope lsp references' },
    { '<LEADER>hd', '<CMD>Telescope lsp_definitions<CR>', desc = 'telescope lsp type definitions' },
    { '<LEADER>hm', '<CMD>Telescope lsp_implementations<CR>', desc = 'telescope lsp implementations' },
    { '<LEADER>hi', '<CMD>Telescope lsp_incoming_calls<CR>', desc = 'telescope lsp incoming calls' },
    { '<LEADER>ho', '<CMD>Telescope lsp_outgoing_calls<CR>', desc = 'telescope lsp outgoing calls' },
    { '<LEADER>hsd', '<CMD>Telescope lsp_document_symbols<CR>', desc = 'telescope lsp document symbols' },
    { '<LEADER>hsw', '<CMD>Telescope lsp_workspace_symbols<CR>', desc = 'telescope lsp workspace symbols' },
    {
      '<LEADER>hsn',
      '<CMD>Telescope lsp_dynamic_workspace_symbols<CR>',
      desc = 'telescope lsp dynamic workspace symbols',
    },
    {
      '<LEADER>ht',
      '<CMD>Telescope treesitter<CR>',
      desc = 'telescope treesitter',
    },

    -- telescope git ####################################################################################
    {
      '<LEADER>gs',
      function() require('telescope.builtin').git_status({ layout_config = { width = 0.99, preview_width = 0.5 } }) end,
      desc = 'telescope git status',
    },
    { '<LEADER>gt', '<CMD>Telescope git_stash<CR>', desc = 'telescope git stash' },
    { '<LEADER>gc', '<CMD>Telescope git_commits<CR>', desc = 'telescope git commits' },
    { '<LEADER>gh', '<CMD>Telescope git_bcommits<CR>', desc = 'telescope git buffer commits (history)' },
    { '<LEADER>gB', '<CMD>Telescope git_branches<CR>', desc = 'telescope git branches' }, -- use leader gb for toggle blame
    -- vim.keymap.set('n', '<LEADER>gg', ':Telescope gitdiffer diff<CR>', { desc = 'git diff since main' })

    -- search ####################################################################################
    -- { '<LEADER>st', '<CMD>Telescope live_grep<CR>', desc = 'telescope live_grep' },
    {
      '<LEADER>ss',
      function()
        require('telescope.builtin').grep_string({
          hidden = false,
          layout_strategy = 'vertical',
          layout_config = {
            height = 0.99,
            -- anchor = 'E',
            width = 0.9,
            prompt_position = 'top',
            preview_height = 0.5,
            mirror = true,
          },
        })
      end,
      desc = 'telescope grep string no input',
    },
    {
      '<LEADER>sp',
      function()
        require('telescope.builtin').grep_string({
          search = vim.fn.input('Grep > '),
          hidden = false,
          layout_strategy = 'vertical',
          layout_config = {
            height = 0.99,
            -- anchor = 'E',
            width = 0.9,
            prompt_position = 'top',
            preview_height = 0.5,
            mirror = true,
          },
        })
      end,
      desc = 'telescope grep string with input',
    },
    { '<LEADER>sb', '<CMD>Telescope current_buffer_fuzzy_find<CR>', desc = 'telescope current buffer fuzzy find' },
    {
      '<LEADER>sg',
      function() require('tg.telescope-multi-rg')() end,
      desc = 'tj multi rg',
    },
    {
      '<LEADER>sh',
      function() require('telescope').load_extension('harpoon').marks() end,
      desc = 'harpoon marks',
    },

    -- diagnostics ####################################################################################
    {
      '<S-M-f>',
      function() require('telescope.builtin').diagnostics({ layout_strategy = 'horizontal', layout_config = { width = 0.9 } }) end,
      desc = 'telescope diagnostics',
    },
    {
      '<LEADER>en',
      function() require('telescope.builtin').diagnostics({ layout_strategy = 'vertical', layout_config = { width = 0.9 } }) end,
      desc = 'telescope diagnostics',
    },
    {
      '<LEADER>et',
      function()
        require('telescope.builtin').diagnostics({
          layout_strategy = 'vertical',
          layout_config = { width = 0.9 },
          bufnr = 0,
        })
      end,
      desc = 'telescope diagnostics current buffer',
    },

    -- config ####################################################################################
    {
      '<LEADER>cd',
      function()
        require('telescope.builtin').find_files({
          -- prompt_title = "< Dotfiles >",
          cwd = vim.env.DOTFILES,
          hidden = true,
        })
      end,
      desc = 'search dotfiles',
    },
    {
      '<LEADER>cn',
      function() require('telescope.builtin').find_files({ cwd = vim.env.DOTFILES .. '/config/nvim', hidden = true }) end,
      desc = 'search nvim config',
    },
    { '<LEADER>cr', '<CMD>Telescope reloader<CR>', desc = 'telescope reloader' },

    -- wiki ####################################################################################
    {
      '<LEADER>wh',
      function() require('telescope.builtin').find_files({ cwd = vim.env.HOME .. '/src/me/wiki', hidden = false }) end,
      desc = 'search wiki',
    },
    {
      '<LEADER>wm',
      function()
        require('telescope.builtin').find_files({
          cwd = vim.env.XDG_DOCUMENTS_DIR .. '/candy/wiki',
          hidden = false,
          layout_strategy = 'vertical',
          layout_config = {
            height = 0.99,
            anchor = 'E',
            width = 0.5,
            prompt_position = 'top',
            preview_height = 0.85,
            mirror = true,
          },
        })
      end,
      desc = 'search candy wiki',
    },
  },

  config = function()
    -- local pickers = require('telescope.pickers')
    -- local finders = require('telescope.finders')
    -- local previewers = require("telescope.previewers")
    -- local action_state = require('telescope.actions.state')
    local actions_layout = require('telescope.actions.layout')
    -- local conf = require('telescope.config').values
    local actions = require('telescope.actions')
    local telescope = require('telescope')

    -- telescope.load_extension('fzy_native')
    -- local file_browser = telescope.load_extension('file_browser')
    -- telescope.load_extension('heading') -- markdown, help headings
    -- telescope.load_extension "projects" -- recent projects
    -- local harpoon = telescope.load_extension('harpoon')
    -- telescope.load_extension('git_worktree')
    -- local neoclip = telescope.load_extension('neoclip')
    -- telescope.load_extension('frecency')
    telescope.load_extension('ui-select')
    -- local frecency = telescope.load_extension('frecency')

    telescope.setup({
      defaults = {
        sorting_strategy = 'descending', -- the direction better results are sorted towards
        selection_strategy = 'reset', -- how the cursor acts after each sort iteration
        scroll_strategy = 'cycle', -- what happens if you scroll past the view of the picker
        layout_strategy = 'horizontal',
        layout_config = {
          bottom_pane = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = 'top',
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
            prompt_position = 'top',
            width = 0.5,
          },
          cursor = {
            height = 0.9,
            preview_cutoff = 40,
            width = 0.8,
          },
          horizontal = {
            height = 0.9,
            preview_cutoff = 120,
            prompt_position = 'bottom',
            width = 0.8,
          },
          vertical = {
            height = 0.9,
            preview_cutoff = 40,
            prompt_position = 'bottom',
            width = 0.8,
          },
        },

        --- layouts to cycle through when using actions.layout.cycle_layout_next/prev
        -- can be string[] or {layout_strategy, layout_config, previewer}[]
        cycle_layout_list = { 'horizontal', 'vertical' },
        winblend = 0, -- winblend for telescope floating windows
        wrap_results = false, -- word wrap search results
        prompt_prefix = ' >',
        selection_caret = ' >', -- character(s) shown in front of current selection
        entry_prefix = '  ', -- prefix in front of each result entry
        multi_icon = '+', -- symbol to add in front of a multi-selected result entry, replaces final char of telescope.defaults.selection_caret and telescope.defaults.entry_prefix as appropriate
        initial_mode = 'insert',
        border = true,
        path_display = {}, -- array with hidden | tail | absolute | smart | shorten | truncate
        borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
        -- get_status_text = -- a function that determines what the virtual text looks like - default shows current count / all
        hl_result_eol = true,
        dynamic_preview_title = false,
        results_title = 'Results',
        prompt_title = 'Prompt',
        history = {
          -- path = stdpath("data")/telescope_history',
          limit = 100,
          handler = require('telescope.actions.history').get_simple_history,
          cycle_wrap = false,
        },
        cache_picker = {
          num_pickers = 1,
          limit_entries = 1000,
        },

        -- global previewer config
        preview = {
          check_mime_type = true, -- if plenary's filetype detection fails, use `file` if available to infer if binary
          filesize_limit = 25, -- max filesize in MB to try to preview. set to false to preview any file size
          timeout = 250, -- in ms, preview timeout
          -- filetype_hook = ...
          -- mime_hook = ...
          -- filesize_hook = ...
          -- timeout_hook = ...

          -- 1) Do not show previewer for certain files
          -- filetype_hook = function(filepath, bufnr, opts)
          --   -- you could analogously check opts.ft for filetypes
          --   local excluded = vim.tbl_filter(function(ending)
          --     return filepath:match(ending)
          --   end, {
          --     '.*%.csv',
          --     '.*%.toml',
          --   })
          --   if not vim.tbl_isempty(excluded) then
          --     putils.set_preview_message(bufnr, opts.winid, string.format("I don't like %s files!", excluded[1]:sub(5, -1)))
          --     return false
          --   end
          --   return true
          -- end,

          -- 2) Truncate lines to preview window for too large files
          -- filesize_hook = function(filepath, bufnr, opts)
          --   local path = require('plenary.path'):new(filepath)
          --   -- opts exposes winid
          --   local height = vim.api.nvim_win_get_height(opts.winid)
          --   local lines = vim.split(path:head(height), '[\r]?\n')
          --   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          -- end,
          treesitter = true,
          msg_bg_fillchar = '╱', -- character to fill background of unpreviewable buffers
          hide_on_startup = false, -- hide previewer when picker starts
        },

        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
        },
        -- use_less = true, --if less should be enabled in term_previewer (deprecated and no longer used in builtin pickers)
        -- set environment for term_previewer - a table
        set_env = {
          BAT_THEME = 'Monokai Extended',
          -- BAT_STYLE = ' numbers', --not sure why this isn't working
        },
        color_devicons = true, -- if devicons should be used. if false, use text highlight group
        file_sorter = require('telescope.sorters').get_fzy_sorter, -- used for find_files, git_files and similar. if native sorter used, this will be overriden
        generic_sorter = require('telescope.sorters').get_fzy_sorter, -- used for everything that is not a file. overriden if native sorter is used.
        prefilter_sorter = require('telescope.sorters').get_fzy_sorter, -- wrapper sorter around generic sorter. used for lsp_*_symbols and lsp_*_diagnostics
        -- tiebreak = ... -- how to break tie when two entries have the same score
        file_ignore_patterns = nil, -- lua regex that defines files that should be ignored. eg { "^scratch/" } ignores all files in scratch directory. used by all pickers that have a file associated.
        get_selection_window = function() return 0 end, -- function that takes function(picker,entry) and returns window id. window id used to decide which window to open chosen file in
        file_previewer = require('telescope.previewers').cat.new, -- mostly used for find_files, git_files and similar.
        grep_previewer = require('telescope.previewers').vimgrep.new, -- used for live_grep, grep_string and similar.
        qflist_previewer = require('telescope.previewers').qflist.new,
        buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker, -- developer option for underlining functionality of buffer previewer

        -- see list for actions https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
        mappings = {
          i = {
            -- ['<C-x>'] = false,
            -- ['<C-q>'] = actions.send_to_qflist,
            ['<S-C-;>'] = actions.send_to_loclist, -- aka C-:
            -- ['<C-l>'] = actions.add_selected_to_loclist,
            -- ["<esc>"] = actions.close

            ['<C-z>'] = actions_layout.toggle_preview,
            ['<S-C-z>'] = actions_layout.toggle_mirror,

            ['<C-n>'] = actions.move_selection_next,
            ['<C-p>'] = actions.move_selection_previous,

            ['<C-c>'] = actions.close,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,

            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,

            ['<PageUp>'] = actions.results_scrolling_up,
            ['<PageDown>'] = actions.results_scrolling_down,

            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            ['<C-l>'] = actions.complete_tag,
            ['<C-/>'] = actions.which_key,
            ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>

            -- https://github.com/nvim-telescope/telescope.nvim/pull/1650
            ['<C-w>'] = { '<c-s-w>', type = 'command' }, --delete word before cursor

            -- disable c-j because we dont want to allow new lines #2123
            ['<C-j>'] = actions.nop,
          },

          n = {
            ['<esc>'] = actions.close,
            ['<CR>'] = actions.select_default,
            ['<C-x>'] = actions.select_horizontal,
            ['<C-v>'] = actions.select_vertical,
            ['<C-t>'] = actions.select_tab,

            ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
            ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

            -- TODO: This would be weird if we switch the ordering.
            ['j'] = actions.move_selection_next,
            ['k'] = actions.move_selection_previous,
            ['H'] = actions.move_to_top,
            ['M'] = actions.move_to_middle,
            ['L'] = actions.move_to_bottom,

            ['<Down>'] = actions.move_selection_next,
            ['<Up>'] = actions.move_selection_previous,
            ['gg'] = actions.move_to_top,
            ['G'] = actions.move_to_bottom,

            ['<C-u>'] = actions.preview_scrolling_up,
            ['<C-d>'] = actions.preview_scrolling_down,

            ['<C-Down>'] = require('telescope.actions').cycle_history_next,
            ['<C-Up>'] = require('telescope.actions').cycle_history_prev,

            ['<PageUp>'] = actions.results_scrolling_up,
            ['<PageDown>'] = actions.results_scrolling_down,

            ['?'] = actions.which_key,
          },
        },
      },

      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({
            -- even more opts
          }),

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        },
        -- fzy_native = { override_generic_sorter = false, override_file_sorter = true },
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        frecency = {
          default_workspace = 'CWD',
          show_scores = true,
          show_unindexed = false,
          ignore_patterns = { '*.git/*', '*/tmp/*' },
          disable_devicons = false,
          workspaces = {
            ['conf'] = vim.fn.expand('~/.config'),
            ['candy'] = vim.fn.expand('~/src/candy/referralcandy-main'),
          },
        },
      },
    })
    -- telescope.load_extension('fzy_native')
    -- telescope.load_extension('fzf')
  end,
}

return M
