local M = {}

-- copied from https://github.com/mawkler/nvim/blob/fc218645433f03995916f9e1c032bda7956fcb6e/lua/utils.lua
-- Close every floating window
M.close_floating_windows = function()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == 'win' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- unused
function print_ex_command(command)
  -- Get the current buffer
  local bufnr = vim.api.nvim_get_current_buf()
  -- Append the command to the buffer
  vim.api.nvim_buf_set_lines(bufnr, -1, -1, false, { vim.cmd.highlight })
end

return M
