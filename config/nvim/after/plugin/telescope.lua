local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local previewers = require("telescope.previewers")
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.load_extension('fzy_native')
telescope.load_extension('file_browser')
-- telescope.load_extension "heading" -- markdown headings
-- telescope.load_extension "projects" -- recent projects
telescope.load_extension('harpoon')
telescope.load_extension('git_worktree')
telescope.load_extension('neoclip')
telescope.load_extension('gitdiffer')

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

local M = {}
M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    -- prompt_title = "< Dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

M.search_neovim_dotfiles = function()
  require('telescope.builtin').find_files({ cwd = vim.env.DOTFILES .. '/config/nvim', hidden = true })
end

M.search_wiki = function()
  require('telescope.builtin').find_files({ cwd = vim.env.HOME .. '/src/me/wiki', hidden = false })
end

M.search_wiki_candy = function()
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
end

local bookmarks = {}

-- get .bookmarks file if it exists in the current directory
local test = vim.fn.glob('.bookmarks')
if test ~= '' then
  local cwd = vim.fn.getcwd()
  print(vim.inspect(cwd))
  for line in io.lines('.bookmarks') do
    -- add the absolute path as the second entry
    table.insert(bookmarks, { line, cwd .. '/' .. line })
  end
  -- print(vim.inspect(bookmarks))
end

M.bookmarks = function(opts)
  -- list bookmarks in .bookmarks
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = string.format('bookmarks(%s)', vim.loop.cwd()),
      -- prompt_title = "bookmarks",
      finder = finders.new_table({
        results = bookmarks,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[1],
            path = entry[2], -- provide the absolute path here
          }
        end,
      }),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

M.big_window = function()
  return { layout_strategy = 'vertical', layout_config = { mirror = true, width = 0.9, height = 0.9 } }
end

telescope.load_extension('frecency')
telescope.load_extension('ui-select')

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'find files' })
-- vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'git files' })
vim.keymap.set('n', '<C-p>', require('setup/telescope').my_git_files, { desc = 'git files' })

-- vim.keymap.set('n', '<leader>ps', function() -- search text provided via input
--   builtin.grep_string({ search = vim.fn.input('Grep > ') })
-- end)

vim.keymap.set('n', '<leader>ps', function() -- search text provided via input
  require('setup/telescope').my_grep_string({ search = vim.fn.input('Grep > ') })
end, { desc = 'search for word provided via input' })

vim.keymap.set('n', '<S-C-s>', builtin.commands)

return M
