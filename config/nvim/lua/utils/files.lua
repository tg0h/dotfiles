local function open_buf(buf_id)
  vim.api.nvim_set_current_buf(buf_id)
  vim.api.nvim_buf_set_option(buf_id, 'buflisted', true)
end

function open_latest_changed_file()
  -- https://www.reddit.com/r/neovim/comments/y2by27/is_there_a_way_to_run_terminal_commands_with_lua/
  -- for some reason, the filenames end with a null character (which shows up as ^@ in neovim)
  -- use gsed to remove this trailing null byte
  -- local cmd = [[ fd --follow --hidden --type f --exec-batch ls -lt | choose 8 | head -n1 | gsed 's/.$//' ]]
  -- ls -lt adds a linefeed char
  -- use hexdump or hexyl
  -- hexdump shows 61 0a or a followed by linefeed
  -- ttps://www.ibm.com/docs/en/aix/7.2?topic=adapters-ascii-decimal-hexadecimal-octal-binary-conversion-table
  -- 0x0a is 10 is linefeed is '\n'

  local cmd = [[ fd --follow --hidden --type f --exec-batch ls -lt | choose 8 | head -n1 | tr -d '\n' ]]
  local handle = io.popen(cmd)
  -- The argument '*a' passed to the read function means it will read the entire output of the process. The '*a' pattern stands for "all," indicating that the function should read everything until the end of the file (in this case, the end of the output stream from the process).
  local latestEditedFile = handle:read('*a')

  -- print('read is ' .. (latestEditedFile or ''))

  if latestEditedFile then
    local buf_id = vim.fn.bufnr(latestEditedFile, true)
    open_buf(buf_id)
  end
end

local M = {}
function M.load_env()
  -- Load environment variables from .env file
  local env_file = os.getenv('XDG_CONFIG_HOME') .. '/secret/env'
  local f = io.open(env_file, 'r')
  if f then
    for line in f:lines() do
      local _, var, val = line:match('(export )([^=]+)=(.*)')
      if var and val then vim.env[var] = val end
    end
    f:close()
  end
end

return M
