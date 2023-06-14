local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local previewers = require("telescope.previewers")
local action_state = require('telescope.actions.state')
local actions_layout = require('telescope.actions.layout')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local telescope = require('telescope')

-- telescope.load_extension('fzy_native')
local file_browser = telescope.load_extension('file_browser')
telescope.load_extension('heading') -- markdown, help headings
-- telescope.load_extension "projects" -- recent projects
local harpoon = telescope.load_extension('harpoon')
telescope.load_extension('git_worktree')
local neoclip = telescope.load_extension('neoclip')
telescope.load_extension('gitdiffer')
telescope.load_extension('frecency')
telescope.load_extension('ui-select')
local frecency = telescope.load_extension('frecency')
telescope.load_extension('fzf')

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
    get_selection_window = function()
      return 0
    end, -- function that takes function(picker,entry) and returns window id. window id used to decide which window to open chosen file in
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
local ext = require('telescope').extensions

local builtin = require('telescope.builtin')

--------------------------------------------------------------------------------------------------
-- MAPS ----------------------------------------------------------------------------------------
-- project
vim.keymap.set('n', '<C-p>', function()
  builtin.git_files({
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
end, { desc = 'git files' })
vim.keymap.set('n', '<S-C-->', builtin.commands)

--------------------------------------------------------------------------------------------------
-- LEADER ----------------------------------------------------------------------------------------
-- files #########################################################################################
vim.keymap.set('n', '<LEADER>ff', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<LEADER>fh', function()
  builtin.find_files({
    find_command = { 'fd', '--hidden', '--type', 'file', '--follow' },
  })
end, { desc = 'find files --hidden' })
vim.keymap.set('n', '<LEADER>f.', function()
  file_browser.file_browser()
end, { desc = 'file browser' })
vim.keymap.set('n', '<LEADER>fr', builtin.oldfiles, { desc = 'old files (recent)' })
vim.keymap.set('n', '<LEADER>fe', function()
  frecency.frecency({ layout_strategy = 'vertical', layout_config = { mirror = true, width = 0.9, height = 0.9 } })
end, { desc = 'find frecent files' })

-- neovim #########################################################################################
vim.keymap.set('n', '<LEADER>na', builtin.autocommands, { desc = 'autocommands' })
vim.keymap.set('n', '<LEADER>nb', function()
  builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = 'search open buffers (ignore current buffer)' })
vim.keymap.set('n', '<LEADER>nc', builtin.commands, { desc = 'commands' })
vim.keymap.set('n', '<LEADER>nC', builtin.command_history, { desc = 'command history' })
vim.keymap.set('n', '<LEADER>nh', builtin.help_tags, { desc = 'neovim help' })
vim.keymap.set('n', '<LEADER>nf', builtin.filetypes, { desc = 'filetypes' })
vim.keymap.set('n', '<LEADER>nd', function()
  vim.cmd.Telescope('heading')
end, { desc = 'headings' })
vim.keymap.set('n', '<LEADER>ni', builtin.highlights, { desc = 'highlights' })
vim.keymap.set('n', '<LEADER>nu', builtin.builtin, { desc = 'telescope builtin' })
vim.keymap.set('n', '<LEADER>nj', function()
  builtin.jumplist({ fname_width = 100, layout_strategy = 'vertical', layout_config = { preview_height = 0.4 } })
end, { desc = 'jumplist' })
vim.keymap.set('n', '<LEADER>nk', builtin.keymaps, { desc = 'keymaps' })
vim.keymap.set('n', '<LEADER>nm', builtin.marks, { desc = 'marks' })
vim.keymap.set('n', '<LEADER>no', builtin.vim_options, { desc = 'vim options' })
vim.keymap.set('n', '<LEADER>nr', builtin.registers, { desc = 'registers' })
vim.keymap.set('n', '<LEADER>nwt', '<C-w>t', { desc = 'move window to new tab' })
vim.keymap.set('n', '<LEADER>nwx', '<C-w>x', { desc = 'swap windows' })
vim.keymap.set('n', '<LEADER>nw=', '<C-w>=', { desc = 'equally size windows' })
vim.keymap.set('n', '<LEADER>ns', builtin.search_history, { desc = 'search history' })
vim.keymap.set('n', '<LEADER>n:', builtin.loclist, { desc = 'loclist' })
vim.keymap.set('n', '<LEADER>nq', function()
  builtin.quickfix({ fname_width = 60, layout_strategy = 'vertical', layout_config = { width = 0.5 } })
end, { desc = 'quickfix' })
vim.keymap.set('n', '<LEADER>nQ', function()
  builtin.quickfixhistory({ fname_width = 60, layout_strategy = 'vertical' })
end, { desc = 'quickfix history' })
vim.keymap.set('n', '<LEADER>n.', function()
  neoclip.default()
end, { desc = 'neoclip' })

-- vim.keymap.set('n', '<LEADER>nC', builtin.colorscheme, { desc = 'colorschemes' })
-- vim.keymap.set('n', '<LEADER>ny', builtin.symbols, { desc = 'emojis' })

-- telescope #########################################################################################
vim.keymap.set('n', '<LEADER>tr', builtin.resume, { desc = 'telescope resume' })
vim.keymap.set('n', '<LEADER>th', builtin.pickers, { desc = 'telescope previous pickers' })
-- telescope lsp ####################################################################################
vim.keymap.set('n', '<LEADER>tf', builtin.lsp_references, { desc = 'telescope lsp references' })
vim.keymap.set('n', '<LEADER>td', builtin.lsp_definitions, { desc = 'telescope lsp definitions' })
vim.keymap.set('n', '<LEADER>ty', builtin.lsp_type_definitions, { desc = 'telescope type definitions' })
vim.keymap.set('n', '<LEADER>tm', builtin.lsp_implementations, { desc = 'telescope lsp implementations' })
vim.keymap.set('n', '<LEADER>ti', builtin.lsp_incoming_calls, { desc = 'telescope lsp incoming calls' })
vim.keymap.set('n', '<LEADER>to', builtin.lsp_outgoing_calls, { desc = 'telescope lsp outgoing calls' })

vim.keymap.set('n', '<LEADER>tsd', builtin.lsp_document_symbols, { desc = 'telescope lsp document symbols' })
vim.keymap.set('n', '<LEADER>tsw', builtin.lsp_workspace_symbols, { desc = 'telescope lsp workspace symbols' })
vim.keymap.set(
  'n',
  '<LEADER>tsn',
  builtin.lsp_dynamic_workspace_symbols,
  { desc = 'telescope lsp dynamic workspace symbols' }
)

vim.keymap.set('n', '<LEADER>tt', builtin.treesitter, { desc = 'telescope treesitter' })

-- telescope git #########################################################################################
vim.keymap.set('n', '<LEADER>gs', function()
  builtin.git_status({ layout_config = { width = 0.99, preview_width = 0.5 } })
end, { desc = 'telescope git status' })
vim.keymap.set('n', '<LEADER>gt', builtin.git_stash, { desc = 'telescope git stash' })
vim.keymap.set('n', '<LEADER>gc', builtin.git_commits, { desc = 'telescope git commits' })
vim.keymap.set('n', '<LEADER>gh', builtin.git_bcommits, { desc = 'telescope git buffer commits (history)' })
vim.keymap.set('n', '<LEADER>gb', builtin.git_branches, { desc = 'telescope git branches' })
vim.keymap.set('n', '<LEADER>gg', ':Telescope gitdiffer diff<CR>', { desc = 'git diff since main' })

-- search #########################################################################################
vim.keymap.set('n', '<LEADER>st', builtin.live_grep, { desc = 'telescope live_grep' })
vim.keymap.set('n', '<LEADER>ss', function() -- search text provided via input
  builtin.grep_string({
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
end, { desc = 'telescope my grep string no input' })

vim.keymap.set('n', '<LEADER>sp', function() -- search text provided via input
  builtin.grep_string({
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
end, { desc = 'telescope my grep string with input' })

vim.keymap.set('n', '<LEADER>sb', builtin.current_buffer_fuzzy_find, { desc = 'telescope current buffer fuzzy find' })
local multi_rg = require('tg.telescope-multi-rg')
vim.keymap.set('n', '<leader>sg', multi_rg, { desc = 'tj multi rg' })

vim.keymap.set('n', '<LEADER>sh', function()
  harpoon.marks()
end, { desc = 'harpoon marks' })

-- vim.keymap.set('n', '<leader>ps', function() -- search text provided via input
--   builtin.grep_string({ search = vim.fn.input('Grep > ') })
-- end)

-- diagnostics ####################################################################################
vim.keymap.set('n', '<S-M-f>', function()
  builtin.diagnostics({ layout_strategy = 'vertical', layout_config = { width = 0.5 } })
end)

vim.keymap.set('n', '<LEADER>ht', function()
  builtin.diagnostics({ layout_strategy = 'vertical', layout_config = { width = 0.5 }, bufnr = 0 })
end, { desc = 'buffer diagnostics' })
vim.keymap.set('n', '<LEADER>hn', function()
  builtin.diagnostics({ layout_strategy = 'vertical', layout_config = { width = 0.5 }, bufnr = 0 })
end, { desc = 'workspace diagnostics' })

-- config #########################################################################################
vim.keymap.set('n', '<LEADER>cg', ':messages<CR>', { desc = 'vim messages' })
vim.keymap.set('n', '<LEADER>cc', function()
  vim.cmd('messages clear')
end, { desc = 'vim messages clear' })

vim.keymap.set('n', '<LEADER>cd', function()
  builtin.find_files({
    -- prompt_title = "< Dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end, { desc = 'search dotfiles' })

vim.keymap.set('n', '<LEADER>cn', function()
  builtin.find_files({ cwd = vim.env.DOTFILES .. '/config/nvim', hidden = true })
end, { desc = 'scarch dotfiles' })

vim.keymap.set('n', '<LEADER>cr', builtin.reloader, { desc = 'telescope reloader' })

-- wiki #########################################################################################
vim.keymap.set('n', '<LEADER>rh', function()
  builtin.find_files({ cwd = vim.env.HOME .. '/src/me/wiki', hidden = false })
end, { desc = 'search wiki' })

vim.keymap.set('n', '<LEADER>rt', function()
  builtin.find_files({
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
end, { desc = 'search candy wiki' })
