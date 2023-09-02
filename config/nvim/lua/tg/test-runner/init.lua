local M = {}
local ts_utils = require('nvim-treesitter.ts_utils')
local ts = vim.treesitter
local tsu = require('tg.treesitter-utils')

local tsu = require('tg.toggle-test')

local function print_duration(start_time)
  local end_time = vim.loop.hrtime()
  -- duration in nanoseconds
  local duration = (end_time - start_time) / 1e9
  duration = string.format('%.2f', duration)
  print('duration is ' .. duration .. 's')
  -- vim.notify(duration)
end

local function get_test_function_query(testType)
  local query, query_text
  if testType == 'serial' then
    -- search for the test name in ava test.serial('test name 1', async (t) => { ...
    query_text = [[
    (expression_statement
      (call_expression
        function: (member_expression
                    object: (identifier) @top_level_test
                    property: (property_identifier) @top_level_test_dot_method
                    )
          (#eq? @top_level_test "test")
          (#eq? @top_level_test_dot_method "serial")
        arguments: (arguments (string (string_fragment) @test_name))
      )
    )
    ]]
  else
    -- search for the test name in ava test('test name 1', async (t) => { ...
    query_text = [[
    (expression_statement
      (call_expression
        function: (identifier) @top_level_test
          (#eq? @top_level_test "test")
        arguments: (arguments
                     (string
                       (string_fragment) @test_name))
      )
    )
    ]]
  end

  query = vim.treesitter.query.parse('typescript', query_text)
  return query
end

local function capture_test_name_from_query(query, node, bufnr)
  for id, node, metadata in query:iter_captures(node, bufnr) do
    local name = query.captures[id] -- name of the capture in the query
    -- print('name is ', name)
    if name == 'test_name' then
      test_name = vim.treesitter.get_node_text(node, bufnr)
      return test_name
    end
    -- typically useful info about the node:
    -- local type = node:type() -- type of the captured node
    -- local row1, col1, row2, col2 = node:range() -- range of the capture
    -- ... use the info here ...
  end
end

local function get_top_level_test(node, bufnr)
  return capture_test_name_from_query(get_test_function_query('serial'), node, bufnr) -- search for test.serial
    or capture_test_name_from_query(get_test_function_query(), node, bufnr) -- search for test
end

local function get_current_test_name()
  local current_node = ts_utils.get_node_at_cursor()
  if not current_node then return '' end
  local expr = current_node
  local test_name

  local bufnr = vim.fn.bufnr()
  while expr do
    if expr:type() == 'expression_statement' then
      -- if the top level test is test.serial, the structure is: expression_statement > call_expression > function: member_expression > object: identifier
      -- if the top level test is test,  the structure is: expression_statement > call_expression > function: identifier
      test_name = get_top_level_test(expr, bufnr)
      if test_name then
        -- print('test_name issss ', test_name or '')
        break
      end
    end
    expr = expr:parent()
  end

  if not expr then return '' end
  -- print('tim expr sexpr is ' .. expr:sexpr())
  -- local test_args_node = vim.treesitter.get_node_text(expr:named_child(0):named_child(1):named_child(0), bufnr)
  -- print('sexpr' .. expr:sexpr())
  -- local test_args_node = vim.treesitter.get_node_text(expr:named_child(1):named_child(0), bufnr)

  return test_name
end

function M.run_test()
  local testname = get_current_test_name()
  -- print('test name is ' .. (testname or ''))

  local filename = vim.api.nvim_buf_get_name(0)
  -- local tt = tsu.is_test_file(filename)
  -- print('tt tim' .. (tt or ''))
  local test_file
  if tsu.is_test_file(filename) then
    test_file = filename
  else
    test_file = tsu.find_alternate_file()
  end

  if test_file then
    local cmd_template = [[ kitty @ launch --type=window --cwd=current --keep-focus zsh -c 'nt . npx ava %s' ]]
    local cmd = string.format(cmd_template, test_file)
    os.execute(cmd)

    local one_shot_cmd_template = [[ npx ava %s ]]
    local one_shot_cmd = string.format(one_shot_cmd_template, test_file)

    local start_time = vim.loop.hrtime()

    local job = vim.fn.jobstart(one_shot_cmd, {
      -- cwd = '/path/to/working/dir',
      on_exit = function() print_duration(start_time) end,
      -- on_stdout = some_other_function,
      -- on_stderr = some_third_function
    })
  end
end

-- current file must be a test file
-- this runs the single test the cursor is on
function M.run_single_test()
  local filename = vim.api.nvim_buf_get_name(0)
  local test_file
  if tsu.is_test_file(filename) then
    test_file = filename
  else
    -- test_file = tsu.find_alternate_file()
    return
  end

  local testname = get_current_test_name()
  -- print('test name is ' .. (testname or ''))

  if test_file and testname then
    local cmd_template = [[ kitty @ launch --type=window --cwd=current --keep-focus zsh -c "nt-run-single-candy-test . %s '%s'" ]]
    local cmd = string.format(cmd_template, test_file, testname)
    -- print('cmd is ', cmd or '')
    os.execute(cmd)

    local one_shot_cmd_template = [[ npx ava %s ]]
    local one_shot_cmd = string.format(one_shot_cmd_template, test_file)

    local start_time = vim.loop.hrtime()

    local job = vim.fn.jobstart(one_shot_cmd, {
      -- cwd = '/path/to/working/dir',
      on_exit = function() print_duration(start_time) end,
      -- on_stdout = some_other_function,
      -- on_stderr = some_third_function
    })
  end
end

vim.keymap.set('n', '<M-p>', M.run_test, { desc = 'run test' })
vim.keymap.set('n', '<M-y>', M.run_single_test, { desc = 'run single test' })
return M
