local g = vim.g
local cmd = vim.api.nvim_command

-- used by maps/core/quick-fix.lua
g.tg_quickfix_local = 0
g.tg_quickfix_global = 0

local M = {}

-- local OUICKFIX_HEIGHT = 20

function M.ToggleQFList(global)
  if global == 1 then
    -- quickfix list
    if vim.g.tg_quickfix_global == 1 then
      g.tg_quickfix_global = 0
      cmd('cclose')
    else
      g.tg_quickfix_global = 1
      cmd('copen 20') -- open with height of 20
      -- vim.api.nvim_cmd({ cmd = 'copen', args = { 20 }, nargs = 1 }, {})
      -- vim.api.nvim_cmd.copen(20)
      -- vim.cmd.copen(OUICKFIX_HEIGHT)
      -- vim.api.nvim_cmd({ cmd = 'copen' }, {})
    end
  else
    -- loclist
    if vim.g.tg_quickfix_local == 1 then
      g.tg_quickfix_local = 0
      cmd('lclose')
    else
      g.tg_quickfix_local = 1
      cmd('lopen')
    end
  end
end

return M
