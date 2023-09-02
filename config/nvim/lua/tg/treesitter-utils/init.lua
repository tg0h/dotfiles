local M = {}

-- local typescript_function_query_string = [[
--   (method_signature
--     name: (property identifier) @func_name (#offset! @func_name)
--   )
-- ]]

local typescript_function_query_string = [[
  (method_definition
      name:
      (
          property_identifier
      )
      @func_name
      (
          #offset!
          @func_name
      )
  )
]]

local lua_function_query_string = [[
  (function_declaration
  name: 
    [
      (dot_index_expression) 
      (identifier) 
    ] @func_name (#offset! @func_name) 
  ) 
]]

local func_lookup = {
  typescript = typescript_function_query_string,
  lua = lua_function_query_string,
}

-- local typescript_function_query_string = [[
--   (method_definition
--       name:
--       (
--           property_identifier
--       )
--       @func_name
--       (#eq? @func_name "deleteByClientIdInBatch")
--       (
--           #offset!
--           @func_name
--       )
--   )
-- ]]

local typescript_function_query_string_interpolation = [[
  ( %s
      name:
      (
          property_identifier
      )
      @func_name
      (#eq? @func_name "%s")
      (
          #offset!
          @func_name
      )
  )
]]

local function get_functions(bufnr, lang, query_string)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = parser:parse()[1]
  local root = syntax_tree:root()
  -- local query = vim.treesitter.parse_query(lang, query_string)
  local query = vim.treesitter.query.parse(lang, query_string)
  local func_list = {}

  for _, captures, metadata in query:iter_matches(root, bufnr) do
    local row, col, _ = captures[1]:start()
    local name = vim.treesitter.get_node_text(captures[1], bufnr)
    table.insert(func_list, { name, row, col, metadata[1].range })
  end
  return func_list
end

function M.goto_function_picker(bufnr, lang)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  lang = lang or vim.api.nvim_buf_get_option(bufnr, 'filetype')

  local query_string = func_lookup[lang]
  if not query_string then
    vim.notify(lang .. ' is not supported', vim.log.levels.INFO)
    return
  end
  local func_list = get_functions(bufnr, lang, query_string)
  if vim.tbl_isempty(func_list) then return end
  local funcs = {}
  for _, func in ipairs(func_list) do
    table.insert(funcs, func[1])
  end
  vim.ui.select(funcs, {
    prompt = 'Select a function:',
    format_item = function(item) return 'Function - ' .. item end,
  }, function(_, idx)
    if not idx then return end
    local goto_function = func_list[idx]
    local row, col = goto_function[2] + 1, goto_function[3] + 2
    -- . means current buffer
    vim.fn.setcharpos('.', { bufnr, row, col, 0 })
    vim.cmd([[normal! zz]])
  end)
end

local function find_function(function_name, bufnr, lang) end

function get_query_string(type, function_name)
  -- type is 'method_definition' or 'method_signature'
  return string.format(typescript_function_query_string_interpolation, type, function_name)
end

function get_func_list(lang, bufnr, type, function_name)
  local lang = lang or vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = parser:parse()[1]
  local root = syntax_tree:root()
  local query_string = get_query_string(type, function_name)
  -- local query_string = typescript_function_query_string
  -- local query = vim.treesitter.parse_query(lang, query_string)
  local query = vim.treesitter.query.parse(lang, query_string)
  local func_list = {}

  for _, captures, metadata in query:iter_matches(root, bufnr) do
    -- print(string.format(typescript_function_query_string_interpolation, 'method_definition', 'function_name'))
    local row, col, _ = captures[1]:start()
    local name = vim.treesitter.get_node_text(captures[1], bufnr)
    table.insert(func_list, { name, row, col, metadata[1].range })
  end

  if vim.tbl_isempty(func_list) then return end

  return func_list
end

function M.goto_function(function_name, bufnr, lang)
  local func_list = get_func_list(lang, bufnr, 'method_definition', function_name)
    or get_func_list(lang, bufnr, 'method_signature', function_name)

  -- print('tim func list' .. vim.inspect(func_list))

  -- func_list can be empty if eg switching to alternate file and cursor is not on a function name
  if not func_list or vim.tbl_isempty(func_list) then return end

  local goto_function = func_list[1]
  local row, col = goto_function[2] + 1, goto_function[3] + 2
  -- . means current buffer
  vim.fn.setcharpos('.', { bufnr, row, col, 0 })
  vim.cmd([[normal! zz]])

  return func_list
end

vim.keymap.set('n', '<leader>sf', M.goto_function_picker, { desc = 'find functions' })

return M
