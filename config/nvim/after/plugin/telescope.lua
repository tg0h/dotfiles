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
telescope.load_extension('neoclip')
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
        ['<C-x>'] = false,
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-l>'] = actions.send_to_loclist,
        ['<M-l>'] = actions.add_selected_to_loclist,
        -- ["<esc>"] = actions.close
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

-- files
vim.keymap.set('n', '<LEADER>ff', function()
  builtin.find_files({
    find_command = { 'fd', '--hidden', '--type', 'file', '--follow' },
  })
end, { desc = 'find files' })
vim.keymap.set('n', '<LEADER>f.', function()
  file_browser.file_browser()
end, { desc = 'file browser' })
vim.keymap.set('n', '<LEADER>fl', vim.cmd.Lf, { desc = 'find files' })
vim.keymap.set('n', '<LEADER>fr', function()
  frecency.frecency(require('setup/telescope').big_window())
end, { desc = 'find frecent files' })
vim.keymap.set('n', '<LEADER>fo', builtin.oldfiles, { desc = 'old files' })

-- project
vim.keymap.set('n', '<LEADER>pf', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<C-p>', require('setup/telescope').my_git_files, { desc = 'git files' })

-- neovim
vim.keymap.set('n', '<LEADER>na', function()
  vim.cmd.Telescope('heading')
end, { desc = 'headings' })
vim.keymap.set('n', '<LEADER>nh', builtin.highlights, { desc = 'highlights' })
vim.keymap.set('n', '<LEADER>nu', builtin.builtin, { desc = 'telescope builtin' })
vim.keymap.set('n', '<LEADER>nb', function()
  builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
end, { desc = 'buffers' })
vim.keymap.set('n', '<LEADER>nc', builtin.commands, { desc = 'commands' })
vim.keymap.set('n', '<LEADER>nk', builtin.keymaps, { desc = 'keymaps' })
vim.keymap.set('n', '<LEADER>no', builtin.vim_options, { desc = 'vim options' })
vim.keymap.set('n', '<LEADER>nt', builtin.commands, { desc = 'registers' })
vim.keymap.set('n', '<LEADER>nq', builtin.quickfix, { desc = 'quickfix' })
vim.keymap.set('n', '<LEADER>nQ', builtin.quickfixhistory, { desc = 'quickfix history' })

-- vim.keymap.set('n', '<LEADER>nC', builtin.colorscheme, { desc = 'colorschemes' })
-- vim.keymap.set('n', '<LEADER>ny', builtin.symbols, { desc = 'emojis' })

vim.keymap.set('n', '<LEADER>nh', builtin.help_tags, { desc = 'neovim help' })

vim.keymap.set('n', '<LEADER>sM', function()
  harpoon.marks()
end, { desc = 'harpoon marks' })

-- vim.keymap.set('n', '<leader>ps', function() -- search text provided via input
--   builtin.grep_string({ search = vim.fn.input('Grep > ') })
-- end)

vim.keymap.set('n', '<leader>ps', function() -- search text provided via input
  require('setup/telescope').my_grep_string()
end, { desc = 'search for word provided via input' })

vim.keymap.set('n', '<S-C-->', builtin.commands)

-- workspace diagnostics
vim.keymap.set('n', '<S-M-f>', function()
  builtin.diagnostics({ layout_strategy = 'vertical', layout_config = { width = 0.5 } })
end)

local multi_rg = require('tg.telescope-multi-rg')
vim.keymap.set('n', '<leader>sg', multi_rg, { desc = 'tj multi rg' })
