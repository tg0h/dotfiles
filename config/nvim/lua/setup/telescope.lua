local M = {}

M.my_grep_string = function()
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
end

M.my_grep_string_no_input = function()
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
end

M.my_git_files = function()
  require('telescope.builtin').git_files({
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
-- "<CMD>lua require('setup/telescope').bookmarks(require('telescope.themes').get_dropdown {})<CR>",
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

M.search_dotfiles = function()
  require('telescope.builtin').find_files({
    -- prompt_title = "< Dotfiles >",
    cwd = vim.env.DOTFILES,
    hidden = true,
  })
end

M.big_window = function()
  return { layout_strategy = 'vertical', layout_config = { mirror = true, width = 0.9, height = 0.9 } }
end
return M
