local M = {}

-- packages/common-services/services/contactCampaignSetting/ContactCampaignSettingService.ts
-- packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

local function does_file_exist(filename)
  -- returns filename if filename exists

  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  -- print('finding file ' .. fname)
  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })

  local file = files[1]
  -- print('returing file ' .. vim.inspect(file))
  return file
end

-- need to add % to escape - as - is a special char and interpreted differently in string.gsub
local packageFolders = {
  'packages/common%-services',
  'packages/common%-lib',
  'packages/api/api',
  'packages/daemons',
  'packages/folp/api',
  'packages/referralcorner/api',
  'packages/external%-api',
  'packages/redshift%-services',
}

local function isRepositoryFile(filename)
  -- packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
  -- vim.notify('hello is repo file')
  local is_repository_file = string.match(filename, 'Sequelize.*Repository.ts')
  -- print('is_repository_file ..' .. (is_repository_file or ''))
  return is_repository_file
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

local function getAlternateFile(dirname, filename)
  local packageFolder = getPackageFolder(dirname)
  if not packageFolder then return end

  local folder, file
  if isRepositoryFile(filename) then
    -- warning: if gsub pattern contains special chars, need to escape with %
    folder = string.gsub(dirname, '/repositories/', '/services/')
    -- replace SequelizeBlahRepository.ts with BlahService.ts
    file = filename:gsub('^Sequelize(.*)Repository.ts', '%1Service.ts')
  else
    -- add /tests to the package folder, eg common-services to common-services/tests

    -- from packages/common-services/services/contactCampaignSetting/ContactCampaignSettingService.ts
    -- to   packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
    folder = string.gsub(dirname, '/services/', '/repositories/')
    -- replace BlahService.ts with SequelizeBlahRepository.ts
    file = filename:gsub('(.*)Service.ts', 'Sequelize%1Repository.ts')
  end

  local fullFileName = folder .. '/' .. file
  return fullFileName
end

local function find_alternate_file()
  local filename = vim.api.nvim_buf_get_name(0)
  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  local switch_to_file = getAlternateFile(dirname, fname)

  local fileExists = does_file_exist(switch_to_file)
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

-- vim.keymap.set('n', '<A-.>', ":lua require('tg.toggle-test').Toggle()<CR>", { desc = 'toggle interface file' })

return M
