local M = {}

local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

local function does_file_exist(filename)
  if not filename then return end
  -- returns filename if filename exists

  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })

  local file = files[1]
  return file
end

local function does_dir_exist(absoluteDir)
  local baseName = vim.fs.basename(absoluteDir) -- the last segment
  local parentDir = vim.fs.dirname(absoluteDir)

  local dirs = vim.fs.find(baseName, { path = parentDir, upward = false, type = 'directory' })

  local dir = dirs[1]
  return dir
end

-- need to add % to escape - as - is a special char and interpreted differently in string.gsub
local packageFolders = {
  -- 'packages/common%-services',
  -- 'packages/common%-lib',
  'packages/api/api',
  -- 'packages/daemons',
  -- 'packages/folp/api',
  -- 'packages/referralcorner/api',
  -- 'packages/external%-api',
  -- 'packages/redshift%-services',
  'packages/frontend',
  -- 'packages/frontend%-referralCorner',
  'packages/frontend%-wonka',
}

-- from packages/frontend/lib/api/bigcommerce/bigCommerceAuth.ts
-- jump to
-- packages/api/api/lambda/serveApi/routes/bigcommerce/index.ts

-- from packages/frontend-wonka/lib/api/admin/addAdmin.ts
-- jump to
-- packages/api/api/wonkaApi/admin/addAdmin.ts -- fallback to index.ts if not found

local packageMap = {
  ['frontend/lib/api'] = 'api/api/lambda/serveApi/routes',
  ['api/api/lambda/serveApi/routes'] = 'frontend/lib/api',
  ['frontend%-wonka/lib/api'] = 'api/api/wonkaApi',
  ['api/api/wonkaApi'] = 'frontend%-wonka/lib/api',
}

local function isPageFile(dirname) -- is file in frontend/pages
  local is_page_file = string.match(dirname, 'pages')
  -- print('is_page_file ' .. (is_page_file or ''))
  return is_page_file
end

local function getPackageFolder(currentDirName)
  for i, packageFolder in ipairs(packageFolders) do
    -- turn off pattern matching with a 4th arg of true
    -- the third arg specifies where to start searching in the string
    -- if not - is interpreted as a special char
    -- if string.find(currentDirName, packageFolder, nil, true) then
    if string.find(currentDirName, packageFolder) then return packageFolder end
  end
end

local function getSegmentName(path)
  vim.fs.basename(paath)
  -- .- is non greedy, while .* is greedy
  local segment = string.match(path, '.*/packages/frontend/.-/(.*)$')
  return segment
end

local function getAlternateFile(dirname, filename)
  local packageFolder = getPackageFolder(dirname)
  if not packageFolder then return end

  -- local segmentName = getSegmentName(dirname)
  -- print(' dirname ' .. dirname)
  local segmentName = getSegmentName(dirname)
  -- print(' segmentName ' .. segmentName)
  local folder, file

  local to_dir, count
  for from_path, to_path in pairs(packageMap) do
    to_dir, count = string.gsub(dirname, from_path, to_path)
    if count == 1 then break end
  end

  local to_file = to_dir .. '/' .. filename
  if does_file_exist(to_file) then return to_file end

  to_file = to_dir .. '/' .. 'index.ts'
  if does_file_exist(to_file) then return to_file end

  -- print('to_dir is ' .. to_dir)
  to_file = utils.get_first_file_in_path(to_dir)
  if does_file_exist(to_file) then return to_file end

  local parent = vim.fs.dirname(to_dir)
  to_file = utils.get_first_file_in_path(parent)
  if does_file_exist(to_file) then return to_file end

  return to_file
end

local function find_alternate_file()
  local filename = vim.api.nvim_buf_get_name(0)
  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local switch_to_file = getAlternateFile(dirname, fname)

  local fileExists = switch_to_file and does_file_exist(switch_to_file)
  if fileExists then return switch_to_file end
end

M.find_alternate_file = find_alternate_file
M.is_test_file = isTestFile

function M.Toggle()
  -- if current file is Service.ts, switch to its Service.test.ts file
  -- if current file is Service.test.ts, switch to its Service.ts file

  local filename = find_alternate_file()
  -- print('filename is ' .. (filename or ''))

  if filename then
    local buf_id = vim.fn.bufnr(filename, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(buf_id)
  end
end

return M
