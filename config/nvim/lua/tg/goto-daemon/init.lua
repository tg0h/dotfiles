local M = {}
-- packages/daemons/tasks/UnfreezeInvoiceTask.ts
local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

local function find_file(filename)
  -- returns filename if filename exists

  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  -- print('finding dirname ' .. dirname)
  -- print('finding file ' .. fname)
  local files = vim.fs.find(fname, { path = dirname, upward = false, type = 'file' })

  local file = files[1]
  -- print('returing file 🚀' .. vim.inspect(file))
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

local function isServiceFile(filename)
  -- packages/common-services/repositories/contactCampaignSetting/SequelizeContactCampaignSettingRepository.ts
  -- vim.notify('hello is repo file')
  local is_service_file = string.match(filename, '.*Service.ts$')
  -- print('is_repository_file ..' .. (is_repository_file or ''))
  return is_service_file
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

-- receive FREEZE_INVOICE_BLAH, convert to FreezeInvoiceBlah
local function convertToPascalCase(inputString)
  local resultString = inputString:gsub('([^_])([^_]*)', function(firstLetter, otherLettersBeforeUnderscore)
    -- print('first is' .. firstLetter)
    -- print('rest is' .. otherLettersBeforeUnderscore)
    return firstLetter .. otherLettersBeforeUnderscore:lower()
  end)

  local resultWithoutUnderscores = resultString:gsub('_', '')

  return resultWithoutUnderscores
end

local function gotoDaemonFile(dirname, daemon_task_name)
  -- local packageFolder = getPackageFolder(dirname)
  -- if not packageFolder then return end

  -- s = string.gsub(from_dir, '/packages/.*/', '/packages/daemons/')
  local to_dir = string.gsub(dirname, '/packages/.*', '/packages/daemons/tasks')
  local taskName = convertToPascalCase(daemon_task_name)

  -- print('search same file : to_file is ' .. (to_file or ''))
  -- if does_file_exist(to_file) then return to_file end
  local to_file, found_file
  to_file = to_dir .. '/' .. taskName .. '.ts'
  -- print('🔴search same file : to_file is ' .. (to_file or ''))
  found_file = find_file(to_file)
  if found_file then return found_file end

  local lowercaseTaskName = taskName:sub(1, 1):lower() .. taskName:sub(2)
  to_file = to_dir .. '/' .. lowercaseTaskName .. '.ts'
  -- print('🔴search same file : to_file is ' .. (to_file or ''))
  found_file = find_file(to_file)
  if found_file then return found_file end

  to_file = to_dir .. '/' .. taskName .. 'Task' .. '.ts'
  -- print('🔴search same file : to_file is ' .. (to_file or ''))
  found_file = find_file(to_file)
  if found_file then return found_file end
end

local function get_cursor_word() return vim.fn.escape(vim.fn.expand('<cword>'), [[\/]]) end

local function find_alternate_file()
  local daemon_task_name = get_cursor_word()

  local filename = vim.api.nvim_buf_get_name(0)
  local fname = vim.fs.basename(filename)
  local dirname = vim.fs.dirname(filename)

  -- print('daemon task name' .. (daemon_task_name or ''))
  -- print('dirname' .. (dirname or ''))

  local switch_to_file = gotoDaemonFile(dirname, daemon_task_name)
  -- local switch_to_file = gotoDaemonFile(dirname, daemon_task_name)

  -- local fileExists = does_file_exist(switch_to_file)
  if switch_to_file then return switch_to_file end
end

M.find_alternate_file = find_alternate_file
M.is_test_file = isTestFile

function M.goTo()
  -- if current file is Service.ts, switch to its Service.test.ts file
  -- if current file is Service.test.ts, switch to its Service.ts file

  local filename = find_alternate_file()
  -- print('🟢 filename is ' .. (filename or ''))

  if filename then
    local buf_id = vim.fn.bufnr(filename, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(buf_id)
  end
end

-- vim.keymap.set('n', '<A-.>', ":lua require('tg.toggle-test').Toggle()<CR>", { desc = 'toggle interface file' })

return M
