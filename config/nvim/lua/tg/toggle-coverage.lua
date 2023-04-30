local coverage = require('coverage')

M = {}

local toggle = false

function M.toggle_coverage()
  toggle = not toggle
  -- load true shows signs
  -- load false does not show signs
  coverage.load(toggle)

  --unfortunately the below does not work
  -- coverage.load(true)
  -- coverage.toggle() -- does not work
end

function M.toggle_summary()
  -- print('hello')
  local ft = vim.bo.filetype
  print('ft is ' .. (ft or 'nope'))
  if ft and ft ~= '' then
    print('loading')
    coverage.load(false) -- false means do not show coverage signs
    coverage.summary()
  else
    -- close nvim coverage floating window
    vim.cmd.close()
    -- coverage.toggle() -- turn off coverage signs
  end
  -- local tim = vim.api.nvim_win_get_config(0)
  -- print(tim.inspect)
end

return M
