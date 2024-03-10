local utils = require('tg.utils')

local M = {}

local packageFolders = {
  'packages/api/api',
  'packages/frontend',
  'packages/frontend%-wonka',
}

local packageMap = {
  ['frontend/lib/api'] = 'api/api/lambda/serveApi/routes',
  ['api/api/lambda/serveApi/routes'] = 'frontend/lib/api',
  ['frontend%-wonka/lib/api'] = 'api/api/wonkaApi',
  ['api/api/wonkaApi'] = 'frontend%-wonka/lib/api',
}

local function getPackageFolder(currentDirName)
  for i, packageFolder in ipairs(packageFolders) do
    if string.find(currentDirName, packageFolder) then return packageFolder end
  end
end

-- packages/frontend-wonka/lib/api/admin/getAdmins.ts -> packages/api/api/wonkaApi/admin/getAdmins.ts
local FILE_MATCHERS = {
  -- order matters
  function(to_dir, filename) return to_dir .. '/' .. filename end, -- happy path
  --
  function(to_dir, filename) return to_dir .. 's' .. '/' .. filename end, -- pluralize directory
  function(to_dir, filename) return to_dir:sub(1, -2) .. '/' .. filename end, -- remove s from directory (remove last char of dir string)
  -- 4
  function(to_dir, filename) return to_dir.gsub(to_dir, 'client', 'merchant') .. '/' .. filename end,
  function(to_dir, filename) return to_dir.gsub(to_dir, 'merchant', 'client') .. '/' .. filename end,
  -- 6
  function(to_dir, filename) return to_dir.gsub(to_dir, 'merchant', 'client') .. '/' .. utils.add_suffix_to_filename(filename, 's') end,
  function(to_dir, filename) return to_dir.gsub(to_dir, 'client', 'merchant') .. '/' .. utils.remove_last_char_from_filename(filename) end,
  -- 8
  function(to_dir, filename) return to_dir.gsub(to_dir, 'merchant', 'client') .. '/' .. utils.remove_last_char_from_filename(filename) end,
  function(to_dir, filename) return to_dir.gsub(to_dir, 'client', 'merchant') .. '/' .. utils.add_suffix_to_filename(filename, 's') end,
  -- 10
  function(to_dir, filename) return to_dir.gsub(to_dir, 'merchant/client', 'client/campaign') .. '/' .. filename end,
  function(to_dir, filename) return to_dir.gsub(to_dir, 'client/campaign', 'merchant/client') .. '/' .. filename end,
  -- 12
  function(to_dir, _) return to_dir .. 's' .. '/' .. 'index.ts' end,
  function(to_dir, _) return to_dir:sub(1, -2) .. '/' .. 'index.ts' end,
  -- 14
  -- function(to_dir, _) return to_dir.gsub(to_dir, 'client', 'merchant') .. '/' .. 'index.ts' end,
  -- function(to_dir, _) return to_dir.gsub(to_dir, 'merchant', 'client') .. '/' .. 'index.ts' end,
  -- 14
  function(to_dir, _) return to_dir .. '/' .. 'index.ts' end, -- search for index.ts
  -- 15
  function(to_dir, _) return utils.get_first_file_in_path(to_dir) end,
  -- 16
  function(to_dir, _)
    local dir = to_dir.gsub(to_dir, 'client', 'merchant')
    return utils.get_first_file_in_path(dir)
  end,
  function(to_dir, _)
    local dir = to_dir.gsub(to_dir, 'merchant', 'client')
    return utils.get_first_file_in_path(dir)
  end,
  --
  function(to_dir, _)
    local parent = utils.get_parent(to_dir)
    return utils.get_first_file_in_path(parent)
  end,
}

M.get_potential_match = function(dirname, filename)
  local packageFolder = getPackageFolder(dirname)
  if not packageFolder then return end

  -- get package match
  for from_path, to_path in pairs(packageMap) do
    to_dir, count = string.gsub(dirname, from_path, to_path)
    if count == 1 then break end
  end

  -- get file match
  local i = 0
  for _, f in ipairs(FILE_MATCHERS) do
    i = i + 1
    local to_file = f(to_dir, filename)
    -- print('to_file is ' .. i .. to_dir .. '->' .. (to_file or ''))
    if utils.is_file_exist(to_file) then return to_file end
  end
end

M.find_target_file = function(dirname, basename)
  local potential_match_path = M.get_potential_match(dirname, basename)

  local is_match = utils.is_file_exist(potential_match_path)
  if is_match then return potential_match_path end
end

function M.Toggle()
  local location = utils.get_current_location()
  local targetFile = M.find_target_file(location.dirname, location.basename)

  if targetFile then
    local buf_id = vim.fn.bufnr(targetFile, true)
    utils.open_buf(buf_id)
  end
end

return M
