local M = {}

local tsu = require('tg.toggle-test')

local function hello(start_time)
  local end_time = vim.loop.hrtime()
  -- duration in nanoseconds
  local duration = (end_time - start_time) / 1e9
  duration = string.format('%.2f', duration)
  print('duration is ' .. duration .. 's')
  -- vim.notify(duration)
end

function M.run_test()
  local test_file = tsu.find_alternate_file()
  -- print('test_file is' .. (test_file or ''))
  if test_file then
    cmd_template = [[ kitty @ launch --type=window --cwd=current --keep-focus zsh -c 'nt . npx ava %s' ]]
    cmd = string.format(cmd_template, test_file)
    os.execute(cmd)

    one_shot_cmd_template = [[ npx ava %s ]]
    one_shot_cmd = string.format(one_shot_cmd_template, test_file)

    local start_time = vim.loop.hrtime()

    local job = vim.fn.jobstart(one_shot_cmd, {
      -- cwd = '/path/to/working/dir',
      on_exit = function()
        hello(start_time)
      end,
      -- on_stdout = some_other_function,
      -- on_stderr = some_third_function
    })
  end
end

vim.keymap.set('n', '<M-p>', M.run_test, { desc = 'run test' })
return M