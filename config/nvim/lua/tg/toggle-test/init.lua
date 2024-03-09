local utils = require('tg.utils')

local M = {}

-- need to add % to escape - as - is a special char and interpreted differently in string.gsub
-- this tells you which part of the path to append a /tests to
local PACKAGE_FOLDERS = {
  'packages/common%-services',
  'packages/common%-lib',
  'packages/api/api',
  'packages/daemons',
  'packages/folp/api',
  'packages/referralcorner/api',
  'packages/external%-api',
  'packages/redshift%-services',
  'packages/frontend',
  'packages/frontend%-referralCorner',
  'packages/frontend%-wonka',
  'lua/tg',
}

M.is_test_file = function(filename)
  local is_test_file = string.find(filename, '%.test')
  return is_test_file
end

local function getPackageFolder(currentDirName)
  for i, packageFolder in ipairs(PACKAGE_FOLDERS) do
    if currentDirName:find(packageFolder) then return packageFolder end
  end
end

M.get_potential_match = function(dirname, filename)
  local packageFolder = getPackageFolder(dirname)
  if not packageFolder then return end

  local folder, file
  if M.is_test_file(filename) then
    folder = string.gsub(dirname, '/tests/', '/') -- warning: if gsub pattern contains special chars, need to escape with %
    file = filename:gsub('%.test%.', '%.') -- replace .test. with .
  else
    folder = string.gsub(dirname, packageFolder, packageFolder .. '/' .. 'tests')
    -- replace .ts with .test.ts
    -- replace .lua with .test.lua
    file = filename:gsub('%.(.*)$', '.test.%1')
  end

  local path = folder .. '/' .. file
  return path
end

M.find_target_file = function(dirname, basename)
  local potential_match_path = M.get_potential_match(dirname, basename)

  local is_match = utils.is_file_exist(potential_match_path)
  if is_match then return potential_match_path end
end

M.create_test_file = function()
  local location = utils.get_current_location()
  local target_file = M.get_potential_match(location.dirname, location.basename)

  if target_file then
    local target_file_dirname = vim.fs.dirname(target_file)
    vim.fn.mkdir(target_file_dirname, 'p') -- make intermediate dirs with p flag

    local bufnr = vim.fn.bufnr(target_file, true)
    utils.open_buf(bufnr)
  end
end

M.Toggle = function()
  local location = utils.get_current_location()

  local targetFile = M.find_target_file(location.dirname, location.basename)

  if targetFile then
    local bufnr = vim.fn.bufnr(targetFile, true)
    utils.open_buf(bufnr)
  end
end

return M
