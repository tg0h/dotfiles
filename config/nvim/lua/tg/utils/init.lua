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

M.is_file_exist = function(filename)
  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })
  local file = files[1]

  return file ~= nil
end

M.get_first_file_in_path = function(absoluteDir)
  local function searchWildCard(name) return name:match('.*') end

  -- vim.fs.find does not support globs with strings, must provide a search function
  local files = vim.fs.find(searchWildCard, { path = absoluteDir, upward = false, type = 'file' })

  local file = files[1]
  return file
end

return M
