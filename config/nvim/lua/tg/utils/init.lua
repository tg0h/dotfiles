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
  if not filename then return false end

  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })
  local file = files[1]

  return file ~= nil
end

M.get_first_file_in_path = function(absoluteDir)
  local function searchWildCard(name) return name:match('.*') end

  -- vim.fs.find does not support globs with strings, must provide a search function
  local files = vim.fs.find(searchWildCard, { path = absoluteDir, upward = false, type = 'file', limit = 1 })

  local file = files[1]
  return file
end

-- gets files recursively
M.get_files_in_path_recursive = function(absoluteDir)
  local function searchWildCard(name) return name:match('.*') end

  -- vim.fs.find does not support globs with strings, must provide a search function
  -- this searches downwards recursively! :(
  local files = vim.fs.find(searchWildCard, { path = absoluteDir, upward = false, type = 'file', limit = math.huge })

  return files
end

-- get all files in a directory, does not search recursively
M.get_files_in_dir = function(absoluteDir)
  local files = {}
  for name, type in vim.fs.dir(absoluteDir) do
    if type == 'file' then
      local fullpath = absoluteDir .. '/' .. name
      table.insert(files, fullpath)
    end
  end
  return files
end

M.get_file_in_dir = function(offset)
  local location = M.get_current_location()
  local dirname = location.dirname
  local filename = location.basename

  local files = {}
  for name, type in vim.fs.dir(location.dirname) do
    if type == 'file' then
      local fullpath = dirname .. '/' .. name
      -- print('inserting file ' .. fullpath)
      table.insert(files, fullpath)
    end
  end

  for index, value in ipairs(files) do
    if value == (dirname .. '/' .. filename) then
      currentFileIndex = index
      break
    end
  end

  local targetIndex = currentFileIndex + offset
  -- print('targetIndex: ' .. targetIndex)

  if #files == 1 then
    return files[#files]
  elseif targetIndex == 0 then
    return files[#files] -- ring arithmetic
  elseif targetIndex > #files then
    -- print('outside file length' .. #files)
    -- print('targetIndex ' .. targetIndex)
    -- print('outside modulo ' .. targetIndex % #files)
    local f = files[targetIndex % #files]
    -- print(' f is ' .. f)
    return files[targetIndex % #files]
  else
    return files[targetIndex]
  end
end

M.get_parent = function(to_dir)
  local parent = vim.fs.dirname(to_dir)
  return parent
end

-- test.ts becomes tests.ts
M.add_suffix_to_filename = function(filename, suffix)
  local name, extension = filename:match('(.+)(%..+)$')

  if name and extension then
    return name .. suffix .. extension
  else
    return filename .. suffix
  end
end

M.remove_last_char_from_filename = function(filename)
  local name, extension = filename:match('(.+)(%..+)$')

  if name and extension then
    return name:sub(1, -2) .. extension
  else
    return filename:sub(1, -2)
  end
end

-- local function does_dir_exist(absoluteDir)
--   local baseName = vim.fs.basename(absoluteDir) -- the last segment
--   local parentDir = vim.fs.dirname(absoluteDir)
--
--   local dirs = vim.fs.find(baseName, { path = parentDir, upward = false, type = 'directory' })
--
--   local dir = dirs[1]
--   return dir
-- end

return M
