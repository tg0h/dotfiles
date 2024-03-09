local M = {}

M.get_current_location = function()
  local path = vim.api.nvim_buf_get_name(0)
  local dirname = vim.fs.dirname(path)
  local basename = vim.fs.basename(path)

  return { dirname = dirname, basename = basename }
end

M.open_buf = function(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

return M
