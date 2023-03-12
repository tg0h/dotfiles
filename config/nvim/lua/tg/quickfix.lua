local g = vim.g
local cmd = vim.api.nvim_command

-- used by maps/core/quick-fix.lua
g.tg_quickfix_local = 0
g.tg_quickfix_global = 0

local M = {}

function M.ToggleQFList(global)
    if global == 1 then
        if vim.g.tg_quickfix_global == 1 then
            g.tg_quickfix_global = 0
            cmd 'cclose'
        else
            g.tg_quickfix_global = 1
            cmd 'copen'
        end
    else
        if vim.g.tg_quickfix_local == 1 then
            g.tg_quickfix_local = 0
            cmd 'lclose'
        else
            g.tg_quickfix_local = 1
            cmd 'lopen'
        end
    end
end

return M
