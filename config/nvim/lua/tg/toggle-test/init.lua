local M = {}

local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

M.is_match = function(filename)
  -- returns filename if filename exists

  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  -- print('finding file ' .. fname)
  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })

  local file = files[1]
  -- print('returing file ' .. vim.inspect(file))
  return file ~= nil
end

-- need to add % to escape - as - is a special char and interpreted differently in string.gsub
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
}

M.is_test_file = function(filename)
  local is_test_file = string.find(filename, '.test')
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
    -- remove tests folder in path
    -- warning: if gsub pattern contains special chars, need to escape with %
    folder = string.gsub(dirname, '/tests/', '/')
    -- replace .test.ts with .ts
    file = filename:gsub('%.test%.ts$', '%.ts')
  else
    -- add /tests to the package folder, eg common-services to common-services/tests
    folder = string.gsub(dirname, packageFolder, packageFolder .. '/' .. 'tests')
    -- folder = string.gsub(dirname, 'a', 'a' .. '/' .. 'tests')
    -- replace .ts with .test.ts
    file = filename:gsub('%.ts$', '.test.ts')
  end

  local path = folder .. '/' .. file
  return path
end

M.find_target_file = function(dirname, basename)
  local potential_match_path = M.get_potential_match(dirname, basename)

  local is_match = M.is_match(potential_match_path)
  -- print('is_match is ' .. is_match)
  if is_match then return potential_match_path end
end

local function get_current_location()
  local path = vim.api.nvim_buf_get_name(0)
  local dirname = vim.fs.dirname(path)
  local basename = vim.fs.basename(path)

  return { dirname = dirname, basename = basename }
end

function M.Toggle()
  -- if current file is Service.ts, switch to its Service.test.ts file
  -- if current file is Service.test.ts, switch to its Service.ts file
  local location = get_current_location()

  local targetFile = M.find_target_file(location.dirname, location.basename)
  -- print('filename is ' .. (filename or ''))

  if targetFile then
    local bufnr = vim.fn.bufnr(targetFile, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(bufnr)
  end
end

return M
