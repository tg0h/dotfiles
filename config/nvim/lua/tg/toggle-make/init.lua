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

local function isMakeFile(filename)
  -- packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
  -- vim.notify('hello is repo file')
  local is_make_file = string.match(filename, '^make')
  -- print('is_repository_file ..' .. (is_repository_file or ''))
  return is_make_file
end

local function getAlternateFile(dirname, filename)
  local file
  if isMakeFile(filename) then
    file = filename:gsub('^make(.*)', '%1')
  else
    file = filename:gsub('^(.*)', 'make%1')
  end

  local fullFileName = dirname .. '/' .. file
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

function M.Toggle()
  local filename = find_alternate_file()
  if filename then
    local buf_id = vim.fn.bufnr(filename, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(buf_id)
  end
end

return M
