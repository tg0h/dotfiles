local g = vim.g
local cmd = vim.api.nvim_command

g.tg_toggle_window_zoom = 0

local M = {}

function M.toggle()
    if vim.g.tg_toggle_window_zoom == 0 then
        g.tg_toggle_window_zoom = 1
        cmd 'wincmd _'
        cmd 'wincmd |'
    else
        g.tg_toggle_window_zoom = 0
        cmd 'wincmd ='
    end
end

return M
