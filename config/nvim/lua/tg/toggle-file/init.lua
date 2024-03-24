local utils = require('tg.utils')

local M = {}

M.get_potential_match = function(dirname, filename, offset)
  -- local f = utils.get_files_in_dir(dirname)
  local files = utils.get_files_in_dir(dirname)

  local currentFileIndex
  for index, value in ipairs(files) do
    if value == (dirname .. '/' .. filename) then
      currentFileIndex = index
      break
    end
  end

  local targetIndex = currentFileIndex + offset

  if targetIndex == 0 then
    return files[#files] -- ring arithmetic
  elseif targetIndex > #files then
    return files[targetIndex % #files]
  else
    return files[targetIndex]
  end
end

M.find_target_file = function(dirname, basename, offset)
  local potential_match_path = M.get_potential_match(dirname, basename, offset)

  local is_match = utils.is_file_exist(potential_match_path)
  if is_match then return potential_match_path end
end

M.Toggle = function(offset)
  local location = utils.get_current_location()

  local targetFile = M.find_target_file(location.dirname, location.basename, offset)

  if targetFile then
    local bufnr = vim.fn.bufnr(targetFile, true)
    utils.open_buf(bufnr)
  end
end

return M
