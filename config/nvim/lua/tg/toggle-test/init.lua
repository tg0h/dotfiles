local M = {}

local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

M.is_match = function(filename)
  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })
  local file = files[1]

  return file ~= nil
end

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
    -- turn off pattern matching with a 4th arg of true
    -- the third arg specifies where to start searching in the string
    -- if not - is interpreted as a special char
    -- if string.find(currentDirName, packageFolder, nil, true) then
    -- if string.find(currentDirName, packageFolder) then return packageFolder end
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

  local is_match = M.is_match(potential_match_path)
  if is_match then return potential_match_path end
end

M.get_current_location = function()
  local path = vim.api.nvim_buf_get_name(0)
  local dirname = vim.fs.dirname(path)
  local basename = vim.fs.basename(path)

  return { dirname = dirname, basename = basename }
end

function M.Toggle()
  local location = M.get_current_location()

  local targetFile = M.find_target_file(location.dirname, location.basename)

  if targetFile then
    local bufnr = vim.fn.bufnr(targetFile, true)
    open_buf(bufnr)
  end
end

return M
