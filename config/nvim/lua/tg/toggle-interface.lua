local M = {}

local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

local function does_file_exist(dirName, fileName)
  -- returns filename if fileName exists

  -- print('searcrhing for ' .. vim.inspect(fileName))
  local files = vim.fs.find(fileName, { path = dirName, upward = false, type = 'file' })
  -- print('files ' .. vim.inspect(files))
  local file = files[1]
  -- print('returing file ' .. vim.inspect(file))
  return file
end

local function find_alternate_file()
  local f = vim.api.nvim_buf_get_name(0)
  local fname = vim.fs.basename(f)
  local dirname = vim.fs.dirname(f)

  local interfaceFileName = 'I' .. fname
  local serviceFileName = string.sub(fname, 2) -- remove first char of current file name

  local switch_to_file = does_file_exist(dirname, interfaceFileName) or does_file_exist(dirname, serviceFileName)
  return switch_to_file
end

function M.Toggle()
  -- if current file is Service.ts, switch to IService.ts in current dir
  -- if current file is IService.ts, switch to Service.ts in current dir

  local filename = find_alternate_file()
  -- print('filename is ' .. filename)

  if filename then
    local buf_id = vim.fn.bufnr(filename, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(buf_id)
  end
end

vim.keymap.set('n', '<A-i>', ":lua require('tg.toggle-interface').Toggle()<CR>", { desc = 'toggle interface file' })

return M
