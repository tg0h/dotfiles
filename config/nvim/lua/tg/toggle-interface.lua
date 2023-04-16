local M = {}
local ts_utils = require('nvim-treesitter.ts_utils')
local ts = vim.treesitter
local tsu = require('tg.treesitter-utils')

local function get_current_function_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then
    return ''
  end
  local expr = current_node

  while expr do
    -- class     - method def
    -- interface - method signature
    if expr:type() == 'method_definition' or expr:type() == 'method_signature' then
      break
    end
    expr = expr:parent()
  end

  if not expr then
    return ''
  end
  -- print('tim expr sexpr is ' .. expr:sexpr())
  local bufnr = vim.fn.bufnr()
  local first_named_child_text = vim.treesitter.query.get_node_text(expr:named_child(0), bufnr)
  return first_named_child_text
end

local function open_buf(buf_id, function_name)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)

  tsu.goto_function(function_name, buf_id)
end

local function get_file_if_exist(dirName, fileName)
  -- returns filename if fileName exists
  if fileName == nil then
    return nil
  end

  -- print('searcrhing for ' .. vim.inspect(fileName))
  local files = vim.fs.find(fileName, { path = dirName, upward = false, type = 'file' })
  -- print('files ' .. vim.inspect(files))
  local file = files[1]
  -- print('returing file ' .. vim.inspect(file))
  return file
end

local function get_alternate_repository_file(f)
  if string.find(f, 'Repository') ~= nil then
    local test = string.sub(f, 1, #'Sequelize')
    if string.sub(f, 1, #'Sequelize') == 'Sequelize' then
      -- convert SequelizeTestRepository.ts to ITestRepository.ts if string beings with Sequelize, remove the Sequelize
      local fileName = string.sub(f, #'Sequelize' + 1)
      return 'I' .. fileName
    else
      -- convert ITestRepository.ts to SequelizeTestRepository.ts
      local fileNameWithoutI = string.sub(f, 2) -- remove I
      return 'Sequelize' .. fileNameWithoutI
    end
    return nil
  end
end

local function find_alternate_file()
  local f = vim.api.nvim_buf_get_name(0)
  local fname = vim.fs.basename(f)
  local dirname = vim.fs.dirname(f)

  local interfaceFileName = 'I' .. fname
  local serviceFileName = string.sub(fname, 2) -- remove first char of current file name
  local alternateRepositoryFileName = get_alternate_repository_file(fname)

  local switch_to_file = get_file_if_exist(dirname, interfaceFileName)
    or get_file_if_exist(dirname, serviceFileName)
    or get_file_if_exist(dirname, alternateRepositoryFileName)
  return switch_to_file
end

function M.Toggle()
  -- if current file is Service.ts, switch to IService.ts in current dir
  -- if current file is IService.ts, switch to Service.ts in current dir
  -- if current file is SequelizeTestRepository.ts, switch to ITestRepository.ts in current dir
  -- if current file is ITestRepository.ts, switch to SequelizeRepository.ts in current dir

  local function_name = get_current_function_name()
  -- print('function name is ' .. function_name)
  local filename = find_alternate_file()
  -- print('filename is ' .. filename)

  if filename then
    local buf_id = vim.fn.bufnr(filename, true)
    -- local isLoaded = vim.api.nvim_buf_is_loaded(buf_id)
    open_buf(buf_id, function_name)
  end
end

vim.keymap.set('n', '<A-i>', ":lua require('tg.toggle-interface').Toggle()<CR>", { desc = 'toggle interface file' })

return M
