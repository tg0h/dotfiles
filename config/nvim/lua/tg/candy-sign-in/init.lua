local M = {}

local id_token
-- this seems to be called twice
-- first time returns { 'id_token',''} which seems to mean id_token and newline?
-- second time returns { ''} ... which seems to mean EOF
local function append_data(data)
  -- print('append')
  for i, v in ipairs(data) do
    -- print('data is ' .. tostring(i) .. ' ' .. v)
    id_token = id_token .. v
  end
end

-- call this to get a new id token and set it in env
function M.set_env_candy_id_token()
  local one_shot_cmd_template = [[ candy-get-id-token]]
  local one_shot_cmd = string.format(one_shot_cmd_template)

  -- reset id token
  id_token = ''
  local job = vim.fn.jobstart(one_shot_cmd, {
    -- cwd = '/path/to/working/dir',
    on_stdout = function(channel_id, data)
      -- table concat joins all values in a table into a string
      append_data(data)
    end,
    on_exit = function()
      -- print('id_token' .. id_token)
      print('setting candy id token in env ' .. string.sub(id_token, -10))

      -- if vim.env.CANDY_ID_TOKEN ~= '' then
      -- print('setting env')
      vim.env.CANDY_BEARER_ID_TOKEN = 'Bearer ' .. id_token
      -- end

      -- print('EXIT candy id token is ' .. (vim.env.CANDY_BEARER_ID_TOKEN or ''))
    end,
    -- on_stderr = some_third_function
  })
end

return M
