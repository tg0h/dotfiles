local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local previewers = require("telescope.previewers")
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.load_extension('fzy_native')
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

telescope.setup({
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    prompt_prefix = ' >',
    color_devicons = true,

    -- see list for actions https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua
    mappings = {
      i = {
        -- ['<C-x>'] = false,
        -- ['<C-q>'] = actions.send_to_qflist,
        ['<S-C-;>'] = actions.send_to_loclist, -- aka C-:
        -- ['<C-l>'] = actions.add_selected_to_loclist,
        -- ["<esc>"] = actions.close

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
    fzy_native = { override_generic_sorter = false, override_file_sorter = true },
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

local ext = require('telescope').extensions

local builtin = require('telescope.builtin')

--------------------------------------------------------------------------------------------------
-- MAPS ----------------------------------------------------------------------------------------
-- project
vim.keymap.set('n', '<C-p>', require('setup/telescope').my_git_files, { desc = 'git files' })
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
vim.keymap.set('n', '<LEADER>fr', function()
  frecency.frecency(require('setup/telescope').big_window())
end, { desc = 'find frecent files' })
vim.keymap.set('n', '<LEADER>fo', builtin.oldfiles, { desc = 'old files' })

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
vim.keymap.set('n', '<LEADER>gs', builtin.git_status, { desc = 'telescope git status' })
vim.keymap.set('n', '<LEADER>gt', builtin.git_stash, { desc = 'telescope git stash' })
vim.keymap.set('n', '<LEADER>gc', builtin.git_commits, { desc = 'telescope git commits' })
vim.keymap.set('n', '<LEADER>gh', builtin.git_bcommits, { desc = 'telescope git buffer commits (history)' })
vim.keymap.set('n', '<LEADER>gb', builtin.git_branches, { desc = 'telescope git branches' })
vim.keymap.set('n', '<LEADER>gg', ':Telescope gitdiffer diff<CR>', { desc = 'git diff since main' })

-- search #########################################################################################
vim.keymap.set('n', '<LEADER>st', builtin.live_grep, { desc = 'telescope live_grep' })
vim.keymap.set('n', '<LEADER>ss', function() -- search text provided via input
  require('setup/telescope').my_grep_string_no_input()
end, { desc = 'telescope my grep string no input' })
vim.keymap.set('n', '<LEADER>sp', function() -- search text provided via input
  require('setup/telescope').my_grep_string()
end, { desc = 'telescope my grep string with input' })
vim.keymap.set('n', '<LEADER>sb', builtin.current_buffer_fuzzy_find, { desc = 'telescope current buffer fuzzy find' })
local multi_rg = require('tg.telescope-multi-rg')
vim.keymap.set('n', '<leader>sg', multi_rg, { desc = 'tj multi rg' })

vim.keymap.set('n', '<LEADER>sM', function()
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
  require('setup/telescope').search_dotfiles()
end, { desc = 'search dotfiles' })
vim.keymap.set('n', '<LEADER>cn', function()
  require('setup/telescope').search_neovim_dotfiles()
end, { desc = 'search dotfiles' })

vim.keymap.set('n', '<LEADER>cr', builtin.reloader, { desc = 'telescope reloader' })
