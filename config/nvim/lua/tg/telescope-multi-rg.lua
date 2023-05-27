local conf = require('telescope.config').values
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')

local flatten = vim.tbl_flatten

-- https://www.reddit.com/r/neovim/comments/11ukbgn/how_to_includeexclude_files_in_telescope_live_grep/
-- https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/telescope/custom/multi_rg.lua

-- i would like to be able to do telescope
-- and have telescope do some filtering on files and some grepping

return function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()
  opts.shortcuts = opts.shortcuts
    or {
      ['l'] = '*.lua',
      ['v'] = '*.vim',
      ['n'] = '*.{vim,lua}',
      ['c'] = '*.c',
    }
  opts.pattern = opts.pattern or '%s'

  local custom_grep = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == '' then
        return nil
      end

      -- add 2 spaces to pass a glob to rg
      local prompt_split = vim.split(prompt, '  ')

      local args = { 'rg' }
      for i, v in ipairs(prompt_split) do
        if i == 1 then
          -- the first arg in the telescope prompt can be separated by a single space
          -- eg search for this string  !*.yml  !spec is passed as rg -e 'search for this string' -g '!*.yml' -g '!spec'
          table.insert(args, '-e')
          table.insert(args, v)
        else
          table.insert(args, '-g')

          local pattern
          if opts.shortcuts[v] then
            pattern = opts.shortcuts[v]
          else
            pattern = v
          end

          table.insert(args, string.format(opts.pattern, pattern))
        end
      end

      -- print('args is ' .. vim.inspect(args))
      -- print('prompt splits is ' .. vim.inspect(prompt_split))

      return flatten({
        args,
        { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = 'Live Grep (with shortcuts)',
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = require('telescope.sorters').empty(),
      layout_config = { width = 0.99 },
    })
    :find()
end
