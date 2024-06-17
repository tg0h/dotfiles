local M = {}

local id_tokens = {}

-- call this to get a new id token and set it in env
function M.get_env_candy_id_token(environment)
  -- environment is either staging or production

  local id_token = id_tokens[environment]

  if id_token then
    print('using cached id token ' .. string.sub(id_token, -10))
    return id_token
  else
    local one_shot_cmd_template = [[ candy-get-id-token %s ]]
    local one_shot_cmd = string.format(one_shot_cmd_template, environment)

    id_tokens[environment] = vim.fn.system(one_shot_cmd)

    print('using new id token ' .. string.sub(id_tokens[environment], -10))
    return id_tokens[environment]
  end
end

return M
